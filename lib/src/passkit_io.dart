part of 'passkit_core.dart';

class _PasskitIo {
  Directory _pathToPass;

  static final _PasskitIo _singleton = _PasskitIo._internal();

  factory _PasskitIo() {
    return _singleton;
  }

  _PasskitIo._internal();

  Future<PassFile> createOrGetPass({String passId}) async {
    Directory passesDir = await _PasskitIo().getPassesDir();
    if (passId == null) passId = Uuid().v1();
    String passFileName = '$passId.passkit';

    File passFile = File('${passesDir.path}/$passFileName');
    Directory passDirectory = Directory('${passesDir.path}/$passId');

    return PassFile(passId, passFile, passDirectory);
  }

  Future<Directory> getPassesDir() async {
    if (this._pathToPass != null) return this._pathToPass;
    Directory appDir = await getApplicationDocumentsDirectory();
    Directory passesDir = Directory('${appDir.path}/passes');
    this._pathToPass = await passesDir.create(recursive: true);
    return this._pathToPass;
  }

  delete(Directory passDirectory, File passFile) async {
    passFile.deleteSync();
    passDirectory.deleteSync();
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
          await outFile.writeAsBytes(file.content);
        } else {
          await new Directory(filename).create(recursive: true);
        }
      }
    } catch (e) {
      this.delete(passFile.directory, passFile.file);
      throw ('Error in unpack passkit file!');
    }
  }
}
