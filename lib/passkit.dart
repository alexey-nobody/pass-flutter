import 'dart:async';

import 'package:flutter/services.dart';

class Passkit {
  static const MethodChannel _channel =
      const MethodChannel('passkit');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
