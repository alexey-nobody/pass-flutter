import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:pass_flutter/src/models/pass_image.dart';
import 'package:pass_flutter/src/models/pass_file.dart';
import 'package:pass_flutter/src/models/pass_json/pass_json.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

part 'pass_io.dart';
part 'pass_parser.dart';

class Pass {
  static const HTTP_RESPONSE_OK = 200;
  static const String _channelName = 'pass_flutter';
  static const MethodChannel _channel = const MethodChannel(_channelName);

  ///
  /// Save pass file from [url] to internal memory,
  /// parse and return [PassFile]
  ///
  Future<PassFile> getFromUrl(String url) async {
    PassFile passFile = await _PassIo().createOrGetPass();
    String pathToSave = passFile.file.path;
    Response<ResponseBody> responce = await Dio().download(url, pathToSave);
    if (responce.statusCode == HTTP_RESPONSE_OK) {
      return await _PassParser().parse(passFile);
    }
    throw ('Unable to download pass file at specified url');
  }

  ///
  /// Return all saved pass files in device internal memory
  /// in List of [PassFile]
  ///
  Future<List<PassFile>> getAllSaved() async {
    List<PassFile> parsedPasses = [];
    Directory passesDir = await _PassIo().getPassesDir();
    List<FileSystemEntity> passes = await passesDir.list().toList();
    for (var entity in passes) {
      if (entity is File) {
        try {
          String passId = path.basenameWithoutExtension(entity.path);

          PassFile passFile = await _PassIo().createOrGetPass(passId: passId);
          passFile = await _PassParser().parse(passFile);

          parsedPasses.add(passFile);
        } catch (e) {}
      }
    }
    return parsedPasses;
  }

  ///
  /// Delete all files and folders for [passFile]
  /// in internal memory
  ///
  delete(PassFile passFile) {
    _PassIo().delete(passFile.directory, passFile.file);
  }

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
