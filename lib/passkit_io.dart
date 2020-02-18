part of 'passkit.dart';

class _PasskitIo {
  final String _passesDirName = 'passes';
  Directory _pathToPass;

  static final _PasskitIo _singleton = _PasskitIo._internal();

  factory _PasskitIo() {
    return _singleton;
  }

  _PasskitIo._internal();

  Future<Directory> getPassesDir() async {
    if (this._pathToPass != null) return this._pathToPass;

    Directory appDir = await getApplicationDocumentsDirectory();
    Directory passesDir = Directory(appDir.path + '/' + this._passesDirName);
    this._pathToPass = await passesDir.create(recursive: true);
    return this._pathToPass;
  }

  Future<String> unpackPasskitFile(String pathToPass) async {
    final File passFile = File(pathToPass);
    if (!(await passFile.exists())) {
      throw ('Passkit file not found!');
    }

    final String pathName = basenameWithoutExtension(pathToPass);
    final Directory passesDir = await this.getPassesDir();
    final String folderToPass = passesDir.path + '/' + pathName;
    final Directory passDirectory = Directory(folderToPass);
    if (!(await passDirectory.exists())) {
      await passDirectory.create();
    }

    try {
      final passArchive = passFile.readAsBytesSync();
      final passFiles = ZipDecoder().decodeBytes(passArchive);
      for (var file in passFiles) {
        final filename = '$folderToPass/${file.name}';
        if (file.isFile) {
          File outFile = await File(filename).create(recursive: true);
          await outFile.writeAsBytes(file.content);
        } else {
          await new Directory(filename).create(recursive: true);
        }
      }
      return pathName;
    } catch (e) {
      await passFile.delete();
      await passDirectory.delete();
      throw ('Error in unpack passkit file!');
    }
  }
}
