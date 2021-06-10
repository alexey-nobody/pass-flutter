part of 'pass_core.dart';

// ignore: public_member_api_docs
class PassParser {
  /// Creates a new instance of [PassParser]
  const PassParser({
    required this.passId,
    required this.passFile,
    required this.unpackedPassDirectory,
  });

  /// Id of pass
  final String passId;

  /// .pkpass [File]
  final File passFile;

  /// Unpacked [Directory] of pass file
  final Directory unpackedPassDirectory;

  Future<PassJson> _parsePassJson() async {
    final pathToPassJson = '${unpackedPassDirectory.path}/pass.json';
    final passJsonFile = File(pathToPassJson);
    if (!passJsonFile.existsSync()) {
      throw Exception('Pass file is bad! Not find pass.json in pass file!');
    }
    final passJson = await passJsonFile.readAsString();
    final json = jsonDecode(passJson) as Map<String, dynamic>;
    return PassJson.fromJson(json);
  }

  PassImage _getImage({String? name}) {
    final image = File('${unpackedPassDirectory.path}/$name.png');
    final image2x = File('${unpackedPassDirectory.path}/$name@2x.png');
    final image3x = File('${unpackedPassDirectory.path}/$name@3x.png');
    return PassImage(
      image: image.existsSync() ? image : null,
      image2x: image2x.existsSync() ? image2x : null,
      image3x: image3x.existsSync() ? image3x : null,
    );
  }

  /// Parse unpacked pass file
  Future<PassFile> parse() async {
    final passJson = await _parsePassJson();

    final logo = _getImage(name: 'logo');
    final background = _getImage(name: 'background');
    final footer = _getImage(name: 'footer');
    final strip = _getImage(name: 'strip');
    final icon = _getImage(name: 'icon');
    final thumbnail = _getImage(name: 'thumbnail');

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
