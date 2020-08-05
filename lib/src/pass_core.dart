import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pass_flutter/pass_flutter.dart';
import 'package:pass_flutter/src/utils.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'pass_file_io.dart';
part 'pass_parser.dart';

/// The Android implementation of Apple Passkit.
///
/// This class implements the `package:pass_flutter` functionality for
/// the Android platform.
class Pass {
  static const String _channelName = 'pass_flutter';
  static const MethodChannel _channel = MethodChannel(_channelName);

  /// Return all saved pass files from internal memory in List of [PassFile]
  Future<List<PassFile>> getAllSaved() async {
    return await PassFileIO().getAllSaved();
  }

  /// Save pass file from [urlToPass] to internal memory, parse and return [PassFile]
  Future<PassFile> saveFromUrl({@required String url}) async {
    return await PassFileIO().saveFromUrl(url: url);
  }

  /// Fetch preview of pass file from [urlToPass], parse and return [PassFile]
  Future<PassFile> fetchPreviewFromUrl({@required String url}) async {
    return await PassFileIO().fetchPreviewFromUrl(url: url);
  }

  /// Delete all files and folders for [passFile] from internal memory and return saved passes
  Future<List<PassFile>> delete(PassFile passFile) async {
    PassFileIO().delete(passFile.directory, passFile.file);
    var parsedPasses = await PassFileIO().getAllSaved();
    return parsedPasses;
  }

  /// Platform version
  static Future<String> get platformVersion async {
    var version = await _channel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
