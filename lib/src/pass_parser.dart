part of 'pass_core.dart';

// ignore: public_member_api_docs
class PassParser {
  /// Id of pass
  final String passId;

  /// .pkpass [File]
  final File passFile;

  /// Unpacked [Directory] of pass file
  final Directory unpackedPassDirectory;

  /// Creates a new instance of [PassParser]
  PassParser({
    @required this.passId,
    @required this.passFile,
    @required this.unpackedPassDirectory,
  }) : assert(passId != null &&
            unpackedPassDirectory != null &&
            passFile != null);

  Future<PassJson> _parsePassJson() async {
    String pathToPassJson = '${this.unpackedPassDirectory.path}/pass.json';
    File passJsonFile = File(pathToPassJson);
    if (!passJsonFile.existsSync()) {
      throw ('Pass file is bad! Not find pass.json in pass file!');
    }
    String passJson = await passJsonFile.readAsString();
    return PassJson.fromJson(json.decode(passJson) as Map<String, dynamic>);
  }

  PassImage _getImage({String name}) {
    File image = File('${this.unpackedPassDirectory.path}/$name.png');
    File image2x = File('${this.unpackedPassDirectory.path}/$name@2x.png');
    File image3x = File('${this.unpackedPassDirectory.path}/$name@3x.png');
    if (!image.existsSync() || !image2x.existsSync() || !image3x.existsSync()) {
      return null;
    }
    return PassImage(image, image2x, image3x);
  }

  /// Parse unpacked pass file
  Future<PassFile> parse() async {
    PassJson passJson = await this._parsePassJson();

    PassImage logo = this._getImage(name: 'logo');
    PassImage background = this._getImage(name: 'background');
    PassImage footer = this._getImage(name: 'footer');
    PassImage strip = this._getImage(name: 'strip');
    PassImage icon = this._getImage(name: 'icon');
    PassImage thumbnail = this._getImage(name: 'thumbnail');

    return PassFile(
      id: this.passId,
      file: this.passFile,
      directory: this.unpackedPassDirectory,
      pass: passJson,
      logo: logo,
      background: background,
      footer: footer,
      strip: strip,
      icon: icon,
      thumbnail: thumbnail,
    );
  }
}
