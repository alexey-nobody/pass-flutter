part of 'passkit_core.dart';

class _PasskitParser {
  String _passName;
  Directory _passDir;

  Future<PasskitPass> _parsePassJson() async {
    String pathToPassJson = '${this._passDir.path}/${this._passName}/pass.json';
    File passJsonFile = File(pathToPassJson);
    if (!passJsonFile.existsSync()) {
      throw ('Not find pass.json in pkpass file');
    }
    String passJson = await passJsonFile.readAsString();
    return PasskitPass.fromJson(json.decode(passJson));
  }

  PasskitImage _getImage({String name}) {
    File image = File('${this._passDir.path}/${this._passName}/$name.png');
    File image2x = File('${this._passDir.path}/${this._passName}/$name@2x.png');
    File image3x = File('${this._passDir.path}/${this._passName}/$name@3x.png');
    if (!image.existsSync() || !image2x.existsSync() || !image3x.existsSync()) {
      return null;
    }
    return PasskitImage(image, image2x, image3x);
  }

  Future<PassFile> parse(String pathToPass) async {
    this._passName = basenameWithoutExtension(pathToPass);

    this._passDir = await _PasskitIo().getPassesDir();
    await _PasskitIo().unpack(pathToPass, this._passName);

    PassFile passFile = new PassFile();
    passFile.id = this._passName;
    passFile.pass = await this._parsePassJson();

    passFile.logo = this._getImage(name: 'logo');
    passFile.background = this._getImage(name: 'background');
    passFile.footer = this._getImage(name: 'footer');
    passFile.strip = this._getImage(name: 'strip');
    passFile.icon = this._getImage(name: 'icon');
    passFile.thumbnail = this._getImage(name: 'thumbnail');

    return passFile;
  }
}
