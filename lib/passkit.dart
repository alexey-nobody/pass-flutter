library passkit;

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

part 'passkit_io.dart';
part 'passkit_parser.dart';
part 'passkit_utils.dart';

class Passkit {
  static const HTTP_RESPONSE_OK = 200;
  static const String _channelName = 'passkit';
  static const MethodChannel _channel = const MethodChannel(_channelName);

  Future<PassFile> getFromUrl(String url) async {
    String pathToPass = await _PasskitUtils.generatePathToPass();
    Response<ResponseBody> responce = await Dio().download(url, pathToPass);
    if (responce.statusCode == HTTP_RESPONSE_OK) {
      String passName = await _PasskitIo().unpackPasskitFile(pathToPass);

      _PasskitParser passkitParser =
          new _PasskitParser(passDir: pathToPass, passName: passName);
      return await passkitParser.parse();
    }
    throw ('Unable to download pass file at specified url');
  }

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
