part of 'passkit.dart';

class _PasskitParser {
  Future<PasskitPass> _parsePassJson(String passName) async {
    Directory passesDir = await _PasskitIo().getPassesDir();
    String passJson = await File('${passesDir.path}/$passName/pass.json').readAsString();
    return PasskitPass.fromJson(json.decode(passJson));
  }

  Future<PassFile> parsePasskit(String passName) async {
    PassFile passFile = new PassFile();
    passFile.id = passName;
    passFile.pass = await this._parsePassJson(passName);
    return passFile;
  }
}
