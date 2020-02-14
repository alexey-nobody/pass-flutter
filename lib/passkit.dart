import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class Passkit {
  static const String _channelName = 'passkit';
  static const MethodChannel _channel = const MethodChannel(_channelName);

  String _passesDirName = 'passes';

  Future<String> _checkPassesDirectory() async {
    Directory baseInternalDir = await getApplicationDocumentsDirectory();
    Directory passesDir = Directory(baseInternalDir.path + '/' + this._passesDirName);

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

  Future<String> getPassFromUrl(String url) async {
    String pathToPass = await this._generatePathToPass();

    await Dio().download(url, pathToPass);

    return pathToPass;
  }

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
