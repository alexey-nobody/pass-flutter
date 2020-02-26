import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:pass_flutter/src/models/images/passkit_image.dart';
import 'package:pass_flutter/src/models/pass_file.dart';
import 'package:pass_flutter/src/models/passkit/passkit_pass.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

part 'passkit_io.dart';
part 'passkit_parser.dart';
part 'passkit_utils.dart';

class Passkit {
  static const HTTP_RESPONSE_OK = 200;
  static const String _channelName = 'pass-flutter';
  static const MethodChannel _channel = const MethodChannel(_channelName);

  ///
  /// Save pass file from [url] to internal memory,
  /// parse and return [PassFile]
  ///
  Future<PassFile> getFromUrl(String url) async {
    String pathToPass = await _PasskitUtils.generatePathToPass();
    Response<ResponseBody> responce = await Dio().download(url, pathToPass);
    if (responce.statusCode == HTTP_RESPONSE_OK) {
      return await _PasskitParser().parse(pathToPass);
    }
    throw ('Unable to download pass file at specified url');
  }

  ///
  /// Return all saved pass files in device internal memory
  /// in List of [PassFile]
  ///
  Future<List<PassFile>> getAllSaved() async {
    List<PassFile> parsedPasses = [];
    Directory passesDir = await _PasskitIo().getPassesDir();
    List<FileSystemEntity> passes = await passesDir.list().toList();
    for(var entity in passes) {
      if (entity is File) {
        try {
          PassFile pass = await _PasskitParser().parse(entity.path);
          parsedPasses.add(pass);
        } catch (e) {}
      }
    }
    return parsedPasses;
  }

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
