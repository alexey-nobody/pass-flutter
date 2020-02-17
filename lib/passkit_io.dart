part of 'passkit.dart';

class _PasskitIo {
  final String _passesDirName = 'passes';
  String _pathToPass;

  static final _PasskitIo _singleton = _PasskitIo._internal();

  factory _PasskitIo() {
    return _singleton;
  }

  _PasskitIo._internal();

  Future<String> getPassesDir() async {
    if ((this._pathToPass != null) && (this._pathToPass.length > 0)) {
      return this._pathToPass;
    }

    Directory baseInternalDir = await getApplicationDocumentsDirectory();
    Directory passesDir =
        Directory(baseInternalDir.path + '/' + this._passesDirName);

    bool dirExist = await passesDir.exists();
    if (!dirExist) {
      await passesDir.create();
    }
    this._pathToPass = '${passesDir.path}/';
    return this._pathToPass;
  }

  Future<String> unpackPasskitFile(String pathToPass) async {
    final File passFile = File(pathToPass);
    if (!(await passFile.exists())) {
      throw ('Passkit file not found!');
    }

    final String pathName = basenameWithoutExtension(pathToPass);
    final String path = await this.getPassesDir();
    final String folderToPass = path + '/' + pathName;
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
