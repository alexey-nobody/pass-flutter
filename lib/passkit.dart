import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:passkit/models/pass_file.dart';
import 'package:passkit/models/passkit/passkit_pass.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class Passkit {
  static const String _channelName = 'passkit';
  static const MethodChannel _channel = const MethodChannel(_channelName);

  final String _passesDirName = 'passes';
  String _pathToPass;

  Future<String> _getPassesDirectory() async {
    if ((this._pathToPass != null) || (this._pathToPass.length > 0)) {
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
      return pathName;
    } catch (e) {
      throw ('Error in unpack passkit file!');
    }
  }

  Future<PasskitPass> _parsePassJson(String passName) async {
    String pathToJson = await _getPassesDirectory() + passName + '/pass.json';
    String passJson = await File(pathToJson).readAsString();
    return PasskitPass.fromJson(json.decode(passJson));
  }

  Future<PassFile> _parsePass(String passName) async {
    PassFile passFile = new PassFile();
    passFile.id = passName;
    passFile.pass = await this._parsePassJson(passName);
    return passFile;
  }

  Future<PassFile> getPassFromUrl(String url) async {
    String pathToPassFile = await this._generatePathToPass();
    Response<ResponseBody> responce = await Dio().download(url, pathToPassFile);
    if (responce.statusCode == 200) {
      String passName = await this._unpackPass(pathToPassFile);
      PassFile passFile = await this._parsePass(passName);
      return passFile;
    }
    throw ('Unable to download pass at specified url');
  }

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
