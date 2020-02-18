part of 'passkit.dart';

class _PasskitParser {
  String _passName;
  String _passDir;

  _PasskitParser({String passName, String passDir}) {
    this._passName = passName;
    this._passDir = passDir;
  }

  Future<PasskitPass> _parsePassJson() async {
    String passJson = await File('${this._passDir}/${this._passName}/pass.json').readAsString();
    return PasskitPass.fromJson(json.decode(passJson));
  }

  Future<PassFile> parse() async {
    PassFile passFile = new PassFile();
    passFile.id = this._passName;
    passFile.pass = await this._parsePassJson();
    return passFile;
  }
}
