part of 'pass_core.dart';

// ignore: public_member_api_docs
class PassFileIO {
  // ignore: public_member_api_docs
  factory PassFileIO() {
    return _singleton;
  }

  PassFileIO._internal();

  Directory? _passDir;
  Directory? _previewPassDir;

  final String _passDirName = 'passes';
  final String _previewPassDirName = 'preview_passes';

  static final PassFileIO _singleton = PassFileIO._internal();

  String _generatePassId() {
    return const Uuid().v1();
  }

  Future<Directory> _createPassesDir({required String name}) async {
    final appDir = await getApplicationDocumentsDirectory();
    return Directory('${appDir.path}/$name')..createSync(recursive: true);
  }

  Future<Directory> _getPassesDir() async {
    if (_passDir == null) {
      return _createPassesDir(name: _passDirName);
    }

    return _passDir as Directory;
  }

  Future<Directory> _getPreviewPassesDir() async {
    if (_previewPassDir != null) return _previewPassDir as Directory;
    _previewPassDir = await _createPassesDir(name: _previewPassDirName);
    return _previewPassDir as Directory;
  }

  Future<File> _createPass({
    required String passId,
    bool isPreview = false,
  }) async {
    final passesDir =
        isPreview ? await _getPreviewPassesDir() : await _getPassesDir();
    return File('${passesDir.path}/$passId.passkit')..createSync();
  }

  Future<void> _unpackPass({required String passPath}) async {
    final passFile = File(passPath);
    final passDirectory = Directory(path.withoutExtension(passPath));

    if (!passFile.existsSync()) {
      throw Exception('Pass file not found!');
    }
    if (passDirectory.existsSync()) {
      return;
    }

    passDirectory.createSync();
    try {
      final passArchive = passFile.readAsBytesSync();
      final passFiles = ZipDecoder().decodeBytes(passArchive);
      for (final file in passFiles) {
        final filename = '${passDirectory.path}/${file.name}';
        if (file.isFile) {
          final outFile = await File(filename).create(recursive: true);
          await outFile.writeAsBytes(file.content as List<int>);
        } else {
          await Directory(filename).create(recursive: true);
        }
      }
    } on Exception {
      delete(passDirectory, passFile);
      throw Exception('Unpack passkit file failed!');
    }
  }

  // ignore: public_member_api_docs
  Future<PassFile> saveFromPath({required File externalPassFile}) async {
    final passId = _generatePassId();
    final Directory passesDir = await _getPassesDir();
    final passDir = Directory(path.withoutExtension(externalPassFile.path));
    if (passesDir.path == path.dirname(externalPassFile.path)) {
      throw Exception('This file has already been saved.');
    }
    if (externalPassFile.existsSync()) {
      externalPassFile.copySync('${passesDir.path}/$passId.passkit');
      await _unpackPass(passPath: '${passesDir.path}/$passId.passkit');
      return PassParser(
        passId: passId,
        unpackedPassDirectory: passDir,
        passFile: externalPassFile,
      ).parse();
    }
    throw Exception('Unable to fetch pass file at specified path');
  }

  // ignore: public_member_api_docs
  Future<PassFile> saveFromUrl({required String url}) async {
    final passId = _generatePassId();
    final passFile = await _createPass(passId: passId);
    final passDir = Directory(path.withoutExtension(passFile.path));
    final response = await Dio().download(url, passFile.path);
    if (response.statusCode == 200) {
      await _unpackPass(passPath: passFile.path);
      return PassParser(
        passId: passId,
        unpackedPassDirectory: passDir,
        passFile: passFile,
      ).parse();
    }
    throw Exception('Unable to download pass file at specified url');
  }

  // ignore: public_member_api_docs
  Future<PassFile> fetchPreviewFromUrl({required String url}) async {
    final passId = _generatePassId();
    final passFile = await _createPass(passId: passId, isPreview: true);
    final passDir = Directory(path.withoutExtension(passFile.path));
    final response = await Dio().download(url, passFile.path);
    if (response.statusCode == 200) {
      await _unpackPass(passPath: passFile.path);
      return PassParser(
        passId: passId,
        unpackedPassDirectory: passDir,
        passFile: passFile,
      ).parse();
    }
    throw Exception('Unable to download preview of pass file at specified url');
  }

  // ignore: public_member_api_docs
  Future<List<PassFile>> getAllSaved() async {
    final parsedPasses = <PassFile>[];
    final passesDir = await _getPassesDir();
    final passesEntities = await passesDir.list().toList();
    final passFiles = passesEntities.whereType<File>();

    for (final entity in passFiles) {
      final passId = path.basenameWithoutExtension(entity.path);
      final passDir = Directory(path.withoutExtension(entity.path));
      try {
        await _unpackPass(passPath: entity.path);
        final parsedPassFile = await PassParser(
          passId: passId,
          unpackedPassDirectory: passDir,
          passFile: entity,
        ).parse();
        parsedPasses.add(parsedPassFile);
      } on Exception {
        debugPrint('Error parse pass file - ${entity.path}');
        delete(passDir, entity);
      }
    }
    return parsedPasses;
  }

  // ignore: public_member_api_docs
  void delete(Directory passDirectory, File passFile) {
    passFile.deleteSync();
    passDirectory.deleteSync(recursive: true);
  }
}
