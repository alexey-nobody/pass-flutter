part of 'passkit_core.dart';

class _PasskitIo {
  Directory _pathToPass;

  static final _PasskitIo _singleton = _PasskitIo._internal();

  factory _PasskitIo() {
    return _singleton;
  }

  _PasskitIo._internal();

  Future<Directory> getPassesDir() async {
    if (this._pathToPass != null) return this._pathToPass;
    Directory appDir = await getApplicationDocumentsDirectory();
    Directory passesDir = Directory('${appDir.path}/passes');
    this._pathToPass = await passesDir.create(recursive: true);
    return this._pathToPass;
  }

  Future<Directory> _createPassDirectory(String passName) async {
    Directory passesDir = await this.getPassesDir();
    String pathToUnpackPass = passesDir.path + '/' + passName;
    return Directory(pathToUnpackPass);
  }

  File _getPassFile(pathToPass) {
    final File passFile = File(pathToPass);
    if (!(passFile.existsSync())) {
      throw ('Passkit file not found!');
    }
    return passFile;
  }

  delete(Directory passDirectory, File passFile) async {
    passFile.deleteSync();
    passDirectory.deleteSync();
  }

  Future unpack(String pathToPass, String passName) async {
    File passFile = this._getPassFile(pathToPass);
    Directory passDirectory = await this._createPassDirectory(passName);
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
          await outFile.writeAsBytes(file.content);
        } else {
          await new Directory(filename).create(recursive: true);
        }
      }
    } catch (e) {
      this.delete(passDirectory, passFile);
      throw ('Error in unpack passkit file!');
    }
  }
}
