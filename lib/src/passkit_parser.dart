part of 'passkit_core.dart';

class _PasskitParser {
  PassFile _passFile;

  Future<PassJson> _parsePassJson() async {
    String pathToPassJson = '${this._passFile.directory.path}/pass.json';
    File passJsonFile = File(pathToPassJson);
    if (!passJsonFile.existsSync()) {
      throw ('Pass file is bad! Not find pass.json in pass file!');
    }
    String passJson = await passJsonFile.readAsString();
    return PassJson.fromJson(json.decode(passJson));
  }

  PassImage _getImage({String name}) {
    File image = File('${this._passFile.directory.path}/$name.png');
    File image2x = File('${this._passFile.directory.path}/$name@2x.png');
    File image3x = File('${this._passFile.directory.path}/$name@3x.png');
    if (!image.existsSync() || !image2x.existsSync() || !image3x.existsSync()) {
      return null;
    }
    return PassImage(image, image2x, image3x);
  }

  Future<PassFile> parse(PassFile passFile) async {
    this._passFile = passFile;

    await _PasskitIo().unpack(passFile);

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
