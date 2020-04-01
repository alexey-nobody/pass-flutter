part of 'pass_core.dart';

class _PassIo {
  Directory _passDirectory;

  static final _PassIo _singleton = _PassIo._internal();

  factory _PassIo() {
    return _singleton;
  }

  _PassIo._internal();

  String _generatePassId() {
    return Uuid().v1();
  }

  Future<PassFile> saveFromPath({@required String path}) async {
    String passId = this._generatePassId();
    Directory passesDir = await this.getPassesDir();
    File externalPassFile = File(path);
    if (File(path).existsSync()) {
      String newPassFilePath = '${passesDir.path}/$passId.passkit';
      String passFileDirectoryPath = '${passesDir.path}/$passId';

      File passFile = externalPassFile.copySync(newPassFilePath);
      Directory passDirectory = Directory(passFileDirectoryPath);

      return PassFile(passId, passFile, passDirectory);
    }
    throw ('Unable to fetch pass file at specified path');
  }

  Future<PassFile> saveFromUrl({@required String url}) async {
    PassFile passFile = await _PassIo().createOrGetPass();
    String pathToSave = passFile.file.path;
    Response responce = await Dio().download(url, pathToSave);
    if (responce.statusCode == 200) {
      return await _PassParser().parse(passFile);
    }
    throw ('Unable to download pass file at specified url');
  }

  Future<PassFile> createOrGetPass({
    String passId,
    String externalPassPath,
  }) async {
    if (externalPassPath != null) {
      return this.saveFromPath(path: externalPassPath);
    }
    Directory passesDir = await this.getPassesDir();
    if (passId == null) passId = this._generatePassId();

    File passFile = File('${passesDir.path}/$passId.passkit');
    Directory passDirectory = Directory('${passesDir.path}/$passId');

    return PassFile(passId, passFile, passDirectory);
  }

  Future<Directory> getPassesDir() async {
    if (this._passDirectory != null) return this._passDirectory;
    Directory appDir = await getApplicationDocumentsDirectory();
    this._passDirectory = Directory('${appDir.path}/passes');
    this._passDirectory.createSync(recursive: true);
    return this._passDirectory;
  }

  void delete(Directory passDirectory, File passFile) async {
    passFile.deleteSync();
    passDirectory.deleteSync(recursive: true);
  }

  Future unpack(PassFile passFile) async {
    if (!(passFile.file.existsSync())) {
      throw ('Pass file not found!');
    }
    if (passFile.directory.existsSync()) {
      return;
    }
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
