part of 'pass_core.dart';

// ignore: public_member_api_docs
class PassIo {
  Directory _passDir;
  Directory _previewPassDir;

  String _passDirName = 'passes';
  String _previewPassDirName = 'preview_passes';

  static final PassIo _singleton = PassIo._internal();

  // ignore: public_member_api_docs
  factory PassIo() {
    return _singleton;
  }

  PassIo._internal();

  Future<Directory> _createPassesDir({@required String passDir}) async {
    assert(passDir != null);
    Directory appDir = await getApplicationDocumentsDirectory();
    this._passDir = Directory('${appDir.path}/$passDir');
    this._passDir.createSync(recursive: true);
    return this._passDir;
  }

  Future<Directory> _getPassesDir() async {
    if (this._passDir != null) return this._passDir;
    return await this._createPassesDir(passDir: this._passDirName);
  }

  Future<Directory> _getPreviewPassesDir() async {
    if (this._previewPassDir != null) return this._previewPassDir;
    return await this._createPassesDir(passDir: this._previewPassDirName);
  }

  Future<dynamic> _createOrGetPass({
    String passId,
    bool preview = false,
  }) async {
    Directory passesDir = preview
        ? await this._getPreviewPassesDir()
        : await this._getPassesDir();
    passId = passId ?? Utils.generatePassId();

    File passFile = File('${passesDir.path}/$passId.passkit');
    Directory passDirectory = Directory('${passesDir.path}/$passId');

    return preview
        ? PreviewPassFile(passId, passFile, passDirectory)
        : PassFile(passId, passFile, passDirectory);
  }

  Future<void> _unpackPass({@required String passPath}) async {
    assert(passPath != null);

    File passFile = File(passPath);
    Directory passDirectory = Directory(path.withoutExtension(passPath));

    if (!passFile.existsSync()) {
      throw ('Pass file not found!');
    }
    if (passDirectory.existsSync()) {
      return;
    }

    passDirectory.createSync();
    try {
      final passArchive = passFile.readAsBytesSync();
      final passFiles = ZipDecoder().decodeBytes(passArchive);
      for (var file in passFiles) {
        final filename = '${passDirectory.path}/${file.name}';
        if (file.isFile) {
          File outFile = await File(filename).create(recursive: true);
          await outFile.writeAsBytes(file.content as List<int>);
        } else {
          await Directory(filename).create(recursive: true);
        }
      }
    } catch (e) {
      this.delete(passDirectory, passFile);
      throw ('Unpack passkit file failed!');
    }
  }

  // ignore: public_member_api_docs
  Future<PassFile> saveFromPath({@required File externalPassFile}) async {
    String passId = Utils.generatePassId();
    Directory passesDir = await this._getPassesDir();
    if (externalPassFile.existsSync()) {
      externalPassFile.copySync('${passesDir.path}/$passId.passkit');
      PassFile pass = await this._createOrGetPass(passId: passId) as PassFile;
      await this._unpackPass(passPath: '${passesDir.path}/$passId.passkit');
      return await PassParser().parse(pass);
    }
    throw ('Unable to fetch pass file at specified path');
  }

  // ignore: public_member_api_docs
  Future<PassFile> saveFromUrl({@required String url}) async {
    PassFile pass = await this._createOrGetPass() as PassFile;
    Response responce = await Dio().download(url, pass.file.path);
    if (responce.statusCode == 200) {
      await this._unpackPass(passPath: pass.file.path);
      return await PassParser().parse(pass);
    }
    throw ('Unable to download pass file at specified url');
  }

  // ignore: public_member_api_docs
  Future<PreviewPassFile> fetchPreviewFromUrl({@required String url}) async {
    PreviewPassFile pass = await this._createOrGetPass(
      preview: true,
    ) as PreviewPassFile;
    Response responce = await Dio().download(url, pass.file.path);
    if (responce.statusCode == 200) {
      await this._unpackPass(passPath: pass.file.path);
      return await PassParser().parse(pass) as PreviewPassFile;
    }
    throw ('Unable to download preview of pass file at specified url');
  }

  // ignore: public_member_api_docs
  Future<List<PassFile>> getAllSaved() async {
    List<PassFile> parsedPasses = [];
    Directory passesDir = await this._getPassesDir();
    List<FileSystemEntity> passesEntities = await passesDir.list().toList();
    Iterable<FileSystemEntity> passFiles = passesEntities.whereType<File>();
    for (FileSystemEntity entity in passFiles) {
      String passId = path.basenameWithoutExtension(entity.path);
      PassFile passFile =
          await this._createOrGetPass(passId: passId) as PassFile;
      try {
        await this._unpackPass(passPath: entity.path);
        passFile = await PassParser().parse(passFile);
        parsedPasses.add(passFile);
      } catch (e) {
        debugPrint('Error parse pass file - ${passFile.file.path}');
        this.delete(passFile.directory, passFile.file);
      }
    }
    return parsedPasses;
  }

  // ignore: public_member_api_docs
  void delete(Directory passDirectory, File passFile) async {
    passFile.deleteSync();
    passDirectory.deleteSync(recursive: true);
  }
}
