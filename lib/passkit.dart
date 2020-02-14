import 'dart:async';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class Passkit {
  static const String _channelName = 'passkit';
  static const MethodChannel _channel = const MethodChannel(_channelName);

  String _passesDirName = 'passes';

  Future<String> _checkPassesDirectory() async {
    Directory baseInternalDir = await getApplicationDocumentsDirectory();
    Directory passesDir =
        Directory(baseInternalDir.path + '/' + this._passesDirName);

    bool dirExist = await passesDir.exists();
    if (!dirExist) {
      await passesDir.create();
    }
    return '${passesDir.path}/';
  }

  Future<String> _generatePathToPass() async {
    String passesDir = await this._checkPassesDirectory();
    String passFileName = Uuid().v1() + '.passkit';
    return '$passesDir$passFileName';
  }

  Future<void> _unpackPass(String pathToPass) async {
    final File passFile = File(pathToPass);
    final String pathName = basenameWithoutExtension(pathToPass);
    final String path = await this._checkPassesDirectory();
    final String folderToPass = path + '/' + pathName;

    final bytes = passFile.readAsBytesSync();
    final passArchive = ZipDecoder().decodeBytes(bytes);
    for (var file in passArchive) {
      final filename = '$folderToPass/${file.name}';
      if (file.isFile) {
        File outFile = await File(filename).create(recursive: true);
        await outFile.writeAsBytes(file.content);
      } else {
        await new Directory(filename).create(recursive: true);
      }
    }
  }

  Future<String> getPassFromUrl(String url) async {
    String pathToPass = await this._generatePathToPass();
    Response<ResponseBody> responce = await Dio().download(url, pathToPass);
    if (responce.statusCode == 200) {
      await this._unpackPass(pathToPass);
    }
    return pathToPass;
  }

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
