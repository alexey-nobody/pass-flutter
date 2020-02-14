import 'dart:async';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:passkit/models/pass.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class Passkit {
  static const String _channelName = 'passkit';
  static const MethodChannel _channel = const MethodChannel(_channelName);

  String _passesDirName = 'passes';
  String _pathToPass;

  Future<String> _getPassesDirectory() async {
    if ((this._pathToPass is String) || (this._pathToPass.length > 0)) {
      return this._pathToPass;
    }

    Directory baseInternalDir = await getApplicationDocumentsDirectory();
    Directory passesDir =
        Directory(baseInternalDir.path + '/' + this._passesDirName);

    bool dirExist = await passesDir.exists();
    if (!dirExist) {
      await passesDir.create();
    }
    this._pathToPass = '${passesDir.path}/';
    return this._pathToPass;
  }

  Future<String> _generatePathToPass() async {
    String passesDir = await this._getPassesDirectory();
    String passFileName = Uuid().v1() + '.passkit';
    return '$passesDir$passFileName';
  }

  Future<String> _unpackPass(String pathToPass) async {
    final File passFile = File(pathToPass);
    if (!(await passFile.exists())) {
      throw ('Passkit file not found!');
    }

    final String pathName = basenameWithoutExtension(pathToPass);
    final String path = await this._getPassesDirectory();
    final String folderToPass = path + '/' + pathName;

    try {
      final passArchive = passFile.readAsBytesSync();
      final passFiles = ZipDecoder().decodeBytes(passArchive);
      for (var file in passFiles) {
        final filename = '$folderToPass/${file.name}';
        if (file.isFile) {
          File outFile = await File(filename).create(recursive: true);
          await outFile.writeAsBytes(file.content);
        } else {
          await new Directory(filename).create(recursive: true);
        }
      }
      return folderToPass;
    } catch (e) {
      throw ('Error in unpack passkit file!');
    }
  }

  Future<Pass> _parsePass(String pathToPassFile, String pathToPass) async {
    return null;
  }

  Future<Pass> getPassFromUrl(String url) async {
    String pathToPassFile = await this._generatePathToPass();
    Response<ResponseBody> responce = await Dio().download(url, pathToPassFile);
    if (responce.statusCode == 200) {
      String pathToPass = await this._unpackPass(pathToPassFile);
      Pass pass = await this._parsePass(pathToPassFile, pathToPass);
      return pass;
    }
    return null;
  }

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
