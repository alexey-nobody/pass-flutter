library passkit.parser;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:passkit/models/pass_file.dart';
import 'package:passkit/models/passkit/passkit_pass.dart';
import 'package:passkit/passkit_io.dart';
import 'package:passkit/passkit_utils.dart';

class PasskitParser {
  static const String _channelName = 'passkit';
  static const MethodChannel _channel = const MethodChannel(_channelName);

  Future<PasskitPass> _parsePassJson(String passName) async {
    String pathToJson = await PasskitIo().getPassesDir() + passName + '/pass.json';
    String passJson = await File(pathToJson).readAsString();
    return PasskitPass.fromJson(json.decode(passJson));
  }

  Future<PassFile> _parsePasskit(String passName) async {
    PassFile passFile = new PassFile();
    passFile.id = passName;
    passFile.pass = await this._parsePassJson(passName);
    return passFile;
  }

  Future<PassFile> getPasskitFromUrl(String url) async {
    String pathToPassFile = await PasskitUtils.generatePathToPass();
    Response<ResponseBody> responce = await Dio().download(url, pathToPassFile);
    if (responce.statusCode == 200) {
      String passName = await PasskitIo().unpackPasskitFile(pathToPassFile);
      PassFile passFile = await this._parsePasskit(passName);
      return passFile;
    }
    throw ('Unable to download pass at specified url');
  }

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
