part of 'pass_core.dart';

// ignore: public_member_api_docs
class PassFileIO {
  Directory _passDir;
  Directory _previewPassDir;

  final String _passDirName = 'passes';
  final String _previewPassDirName = 'preview_passes';

  static final PassFileIO _singleton = PassFileIO._internal();

  // ignore: public_member_api_docs
  factory PassFileIO() {
    return _singleton;
  }

  PassFileIO._internal();

  String _generatePassId() {
    return Uuid().v1();
  }

  Future<Directory> _createPassesDir({@required String name}) async {
    assert(name != null);
    var appDir = await getApplicationDocumentsDirectory();
    var passDir = Directory('${appDir.path}/$name');
    passDir.createSync(recursive: true);
    return passDir;
  }

  Future<Directory> _getPassesDir() async {
    if (_passDir != null) return _passDir;
    _passDir = await _createPassesDir(name: _passDirName);
    return _passDir;
  }

  Future<Directory> _getPreviewPassesDir() async {
    if (_previewPassDir != null) return _previewPassDir;
    _previewPassDir = await _createPassesDir(name: _previewPassDirName);
    return _previewPassDir;
  }

  Future<File> _createPass({
    @required String passId,
    bool isPreview = false,
  }) async {
    assert(passId != null);
    var passesDir =
        isPreview ? await _getPreviewPassesDir() : await _getPassesDir();
    var passFile = File('${passesDir.path}/$passId.passkit');
    passFile.createSync();
    return passFile;
  }

  Future<void> _unpackPass({@required String passPath}) async {
    assert(passPath != null);

    var passFile = File(passPath);
    var passDirectory = Directory(path.withoutExtension(passPath));

    if (!passFile.existsSync()) {
      throw ('Pass file not found!');
    }
    if (passDirectory.existsSync()) {
      return;
    }

    passDirectory.createSync();
    try {
      final passArchive = passFile.readAsBytesSync();
      final passFiles = ZipDecoder().decodeBytes(passArchive);
      for (var file in passFiles) {
        final filename = '${passDirectory.path}/${file.name}';
        if (file.isFile) {
          var outFile = await File(filename).create(recursive: true);
          await outFile.writeAsBytes(file.content as List<int>);
        } else {
          await Directory(filename).create(recursive: true);
        }
      }
    } catch (e) {
      delete(passDirectory, passFile);
      throw ('Unpack passkit file failed!');
    }
  }

  // ignore: public_member_api_docs
  Future<PassFile> saveFromPath({@required File externalPassFile}) async {
    var passId = _generatePassId();
    var passesDir = await _getPassesDir();
    var passDir = Directory(path.withoutExtension(externalPassFile.path));
    if (passesDir.path == path.dirname(externalPassFile.path)) {
      throw ('This file has already been saved.');
    }
    if (externalPassFile.existsSync()) {
      externalPassFile.copySync('${passesDir.path}/$passId.passkit');
      await _unpackPass(passPath: '${passesDir.path}/$passId.passkit');
      return await PassParser(
        passId: passId,
        unpackedPassDirectory: passDir,
        passFile: externalPassFile,
      ).parse();
    }
    throw ('Unable to fetch pass file at specified path');
  }

  // ignore: public_member_api_docs
  Future<PassFile> saveFromUrl({@required String url}) async {
    var passId = _generatePassId();
    var passFile = await _createPass(passId: passId);
    var passDir = Directory(path.withoutExtension(passFile.path));
    var responce = await Dio().download(url, passFile.path);
    if (responce.statusCode == 200) {
      await _unpackPass(passPath: passFile.path);
      return await PassParser(
        passId: passId,
        unpackedPassDirectory: passDir,
        passFile: passFile,
      ).parse();
    }
    throw ('Unable to download pass file at specified url');
  }

  // ignore: public_member_api_docs
  Future<PassFile> fetchPreviewFromUrl({@required String url}) async {
    var passId = _generatePassId();
    var passFile = await _createPass(passId: passId, isPreview: true);
    var passDir = Directory(path.withoutExtension(passFile.path));
    var responce = await Dio().download(url, passFile.path);
    if (responce.statusCode == 200) {
      await _unpackPass(passPath: passFile.path);
      return await PassParser(
        passId: passId,
        unpackedPassDirectory: passDir,
        passFile: passFile,
      ).parse();
    }
    throw ('Unable to download preview of pass file at specified url');
  }

  // ignore: public_member_api_docs
  Future<List<PassFile>> getAllSaved() async {
    var parsedPasses = <PassFile>[];
    var passesDir = await _getPassesDir();
    var passesEntities = await passesDir.list().toList();

    Iterable<FileSystemEntity> passFiles = passesEntities.whereType<File>();

    for (var entity in passFiles) {
      var passId = path.basenameWithoutExtension(entity.path);
      var passDir = Directory(path.withoutExtension(entity.path));
      try {
        await _unpackPass(passPath: entity.path);
        var parsedPassFile = await PassParser(
          passId: passId,
          unpackedPassDirectory: passDir,
          passFile: entity as File,
        ).parse();
        parsedPasses.add(parsedPassFile);
      } catch (e) {
        debugPrint('Error parse pass file - ${entity.path}');
        delete(passDir, entity as File);
      }
    }
    return parsedPasses;
  }

  // ignore: public_member_api_docs
  void delete(Directory passDirectory, File passFile) async {
    passFile.deleteSync();
    passDirectory.deleteSync(recursive: true);
  }
}
