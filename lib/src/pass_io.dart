part of 'pass_core.dart';

class _PassIo {
  Directory _passDirectory;

  static final _PassIo _singleton = _PassIo._internal();

  factory _PassIo() {
    return _singleton;
  }

  _PassIo._internal();

  Future<PassFile> _createOrGetPass({
    String passId,
    String externalPassPath,
  }) async {
    Directory passesDir = await this._getPassesDir();
    if (passId == null) passId = this._generatePassId();

    File passFile = File('${passesDir.path}/$passId.passkit');
    Directory passDirectory = Directory('${passesDir.path}/$passId');

    return PassFile(passId, passFile, passDirectory);
  }

  Future<Directory> _getPassesDir() async {
    if (this._passDirectory != null) return this._passDirectory;
    Directory appDir = await getApplicationDocumentsDirectory();
    this._passDirectory = Directory('${appDir.path}/passes');
    this._passDirectory.createSync(recursive: true);
    return this._passDirectory;
  }

  String _generatePassId() {
    return Uuid().v1();
  }

  Future<PassFile> saveFromPath({@required String path}) async {
    String passId = this._generatePassId();
    Directory passesDir = await this._getPassesDir();
    File externalPassFile = File(path);
    if (externalPassFile.existsSync()) {
      externalPassFile.copySync('${passesDir.path}/$passId.passkit');
      return await this._createOrGetPass(passId: passId);
    }
    throw ('Unable to fetch pass file at specified path');
  }

  Future<PassFile> saveFromUrl({@required String url}) async {
    PassFile passFile = await this._createOrGetPass();
    String pathToSave = passFile.file.path;
    Response responce = await Dio().download(url, pathToSave);
    if (responce.statusCode == 200) {
      return await _PassParser().parse(passFile);
    }
    throw ('Unable to download pass file at specified url');
  }

  Future<List<PassFile>> getAllSaved() async {
    List<PassFile> parsedPasses = [];
    Directory passesDir = await this._getPassesDir();
    List<FileSystemEntity> passesEntities = await passesDir.list().toList();
    Iterable<FileSystemEntity> passFiles = passesEntities.whereType<File>();
    for (FileSystemEntity entity in passFiles) {
      String passId = path.basenameWithoutExtension(entity.path);
      PassFile passFile = await this._createOrGetPass(passId: passId);
      try {
        passFile = await _PassParser().parse(passFile);
        parsedPasses.add(passFile);
      } catch (e) {
        debugPrint('Error parse pass file - ${passFile.file.path}');
        this.delete(passFile.directory, passFile.file);
      }
    }
    return parsedPasses;
  }

  void delete(Directory passDirectory, File passFile) async {
    passFile.deleteSync();
    passDirectory.deleteSync(recursive: true);
  }

  Future unpack(PassFile passFile) async {
    if (!(passFile.file.existsSync())) {
      throw ('Pass file not found!');
    }
    if (passFile.directory.existsSync()) return;
    passFile.directory.createSync();

    try {
      final passArchive = passFile.file.readAsBytesSync();
      final passFiles = ZipDecoder().decodeBytes(passArchive);
      for (var file in passFiles) {
        final filename = '${passFile.directory.path}/${file.name}';
        if (file.isFile) {
          File outFile = await File(filename).create(recursive: true);
          await outFile.writeAsBytes(file.content as List<int>);
        } else {
          await Directory(filename).create(recursive: true);
        }
      }
    } catch (e) {
      this.delete(passFile.directory, passFile.file);
      throw ('Error in unpack passkit file!');
    }
  }
}
