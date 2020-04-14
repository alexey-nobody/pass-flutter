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

  Future<Directory> _createPassesDir({@required String name}) async {
    assert(name != null);
    Directory appDir = await getApplicationDocumentsDirectory();
    Directory passDir = Directory('${appDir.path}/$name');
    passDir.createSync(recursive: true);
    return passDir;
  }

  Future<Directory> _getPassesDir() async {
    if (this._passDir != null) return this._passDir;
    this._passDir = await this._createPassesDir(name: this._passDirName);
    return this._passDir;
  }

  Future<Directory> _getPreviewPassesDir() async {
    if (this._previewPassDir != null) return this._previewPassDir;
    this._previewPassDir = await this._createPassesDir(
      name: this._previewPassDirName,
    );
    return this._previewPassDir;
  }

  Future<File> _createPass({
    @required String passId,
    bool isPreview = false,
  }) async {
    assert(passId != null);
    Directory passesDir = isPreview
        ? await this._getPreviewPassesDir()
        : await this._getPassesDir();
    File passFile = File('${passesDir.path}/$passId.passkit');
    passFile.createSync();
    return passFile;
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
    Directory passDir = Directory(path.withoutExtension(externalPassFile.path));
    if (passesDir.path == path.dirname(externalPassFile.path)) {
      throw ('This file has already been saved.');
    }
    if (externalPassFile.existsSync()) {
      externalPassFile.copySync('${passesDir.path}/$passId.passkit');
      await this._unpackPass(passPath: '${passesDir.path}/$passId.passkit');
      return await PassParser(
        passId: passId,
        unpackedPassDirectory: passDir,
        passFile: externalPassFile,
      ).parse();
    }
    throw ('Unable to fetch pass file at specified path');
  }

  // ignore: public_member_api_docs
  Future<PassFile> saveFromUrl({@required String url}) async {
    String passId = Utils.generatePassId();
    File passFile = await this._createPass(passId: passId);
    Directory passDir = Directory(path.withoutExtension(passFile.path));
    Response responce = await Dio().download(url, passFile.path);
    if (responce.statusCode == 200) {
      await this._unpackPass(passPath: passFile.path);
      return await PassParser(
        passId: passId,
        unpackedPassDirectory: passDir,
        passFile: passFile,
      ).parse();
    }
    throw ('Unable to download pass file at specified url');
  }

  // ignore: public_member_api_docs
  Future<PassFile> fetchPreviewFromUrl({@required String url}) async {
    String passId = Utils.generatePassId();
    File passFile = await this._createPass(passId: passId, isPreview: true);
    Directory passDir = Directory(path.withoutExtension(passFile.path));
    Response responce = await Dio().download(url, passFile.path);
    if (responce.statusCode == 200) {
      await this._unpackPass(passPath: passFile.path);
      return await PassParser(
        passId: passId,
        unpackedPassDirectory: passDir,
        passFile: passFile,
      ).parse();
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
      Directory passDir = Directory(path.withoutExtension(entity.path));
      try {
        await this._unpackPass(passPath: entity.path);
        PassFile parsedPassFile = await PassParser(
          passId: passId,
          unpackedPassDirectory: passDir,
          passFile: entity as File,
        ).parse();
        parsedPasses.add(parsedPassFile);
      } catch (e) {
        debugPrint('Error parse pass file - ${entity.path}');
        this.delete(passDir, entity as File);
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
