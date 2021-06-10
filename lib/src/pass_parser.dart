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
  const PassParser({
    required this.passId,
    required this.passFile,
    required this.unpackedPassDirectory,
  });

  Future<PassJson> _parsePassJson() async {
    var pathToPassJson = '${unpackedPassDirectory.path}/pass.json';
    var passJsonFile = File(pathToPassJson);
    if (!passJsonFile.existsSync()) {
      throw ('Pass file is bad! Not find pass.json in pass file!');
    }
    var passJson = await passJsonFile.readAsString();
    var json = jsonDecode(passJson) as Map<String, dynamic>;
    return PassJson.fromJson(json);
  }

  PassImage _getImage({String? name}) {
    var image = File('${unpackedPassDirectory.path}/$name.png');
    var image2x = File('${unpackedPassDirectory.path}/$name@2x.png');
    var image3x = File('${unpackedPassDirectory.path}/$name@3x.png');
    return PassImage(
      image: image.existsSync() ? image : null,
      image2x: image2x.existsSync() ? image2x : null,
      image3x: image3x.existsSync() ? image3x : null,
    );
  }

  /// Parse unpacked pass file
  Future<PassFile> parse() async {
    var passJson = await _parsePassJson();

    var logo = _getImage(name: 'logo');
    var background = _getImage(name: 'background');
    var footer = _getImage(name: 'footer');
    var strip = _getImage(name: 'strip');
    var icon = _getImage(name: 'icon');
    var thumbnail = _getImage(name: 'thumbnail');

    return PassFile(
      id: passId,
      file: passFile,
      directory: unpackedPassDirectory,
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
