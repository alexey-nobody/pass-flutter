part of 'passkit.dart';

class _PasskitParser {
  Future<PasskitPass> _parsePassJson(String passName) async {
    String pathToJson =
        await _PasskitIo().getPassesDir() + passName + '/pass.json';
    String passJson = await File(pathToJson).readAsString();
    return PasskitPass.fromJson(json.decode(passJson));
  }

  Future<PassFile> parsePasskit(String passName) async {
    PassFile passFile = new PassFile();
    passFile.id = passName;
    passFile.pass = await this._parsePassJson(passName);
    return passFile;
  }
}
