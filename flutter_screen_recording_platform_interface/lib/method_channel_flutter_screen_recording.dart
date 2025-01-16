import 'dart:async';

import 'package:flutter/services.dart';

import 'flutter_screen_recording_platform_interface.dart';

class MethodChannelFlutterScreenRecording
    extends FlutterScreenRecordingPlatform {
  static const MethodChannel _channel =
      const MethodChannel('flutter_screen_recording');

  Future<String?> startRecordScreen(
    String name, {
    String notificationTitle = "",
    String notificationMessage = "",
  }) async {
    final String? start = await _channel.invokeMethod('startRecordScreen', {
      "name": name,
      "audio": false,
      "title": notificationTitle,
      "message": notificationMessage,
    });
    return start;
  }

  Future<String?> startRecordScreenAndAudio(
    String name, {
    String notificationTitle = "",
    String notificationMessage = "",
  }) async {
    final String? start = await _channel.invokeMethod('startRecordScreen', {
      "name": name,
      "audio": true,
      "title": notificationTitle,
      "message": notificationMessage,
    });
    return start;
  }

  Future<String?> captureImage() async{
    final String? imagePath = await _channel.invokeMethod('captureImage');
    print("ImagePath");
    return imagePath;
  }

  Future<String> get stopRecordScreen async {
    final String path = await _channel.invokeMethod('stopRecordScreen');
    return path;
  }
}
