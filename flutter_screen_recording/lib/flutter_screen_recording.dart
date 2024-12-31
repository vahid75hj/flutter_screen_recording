//import 'file:D:/Workspace/flutter_screen_recording/flutter_screen_recording_platform_interface/lib/flutter_screen_recording_platform_interface.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_screen_recording_platform_interface/flutter_screen_recording_platform_interface.dart';

class FlutterScreenRecording {
  static Future<String?> startRecordScreen(String name, {String? titleNotification, String? messageNotification}) async {
    try {
      if (titleNotification == null) {
        titleNotification = "";
      }
      if (messageNotification == null) {
        messageNotification = "";
      }

      await _maybeStartFGS(titleNotification, messageNotification);
      final String? start = await FlutterScreenRecordingPlatform.instance.startRecordScreen(
        name,
        notificationTitle: titleNotification,
        notificationMessage: messageNotification,
      );

      return start;
    } catch (err) {
      print("startRecordScreen err");
      print(err);
    }

    return null;
  }

  static Future<String?> startRecordScreenAndAudio(String name,
      {String? titleNotification, String? messageNotification}) async {
    try {
      if (titleNotification == null) {
        titleNotification = "";
      }
      if (messageNotification == null) {
        messageNotification = "";
      }
      await _maybeStartFGS(titleNotification, messageNotification);
      final String? start = await FlutterScreenRecordingPlatform.instance.startRecordScreenAndAudio(
        name,
        notificationTitle: titleNotification,
        notificationMessage: messageNotification,
      );
      return start;
    } catch (err) {
      print("startRecordScreenAndAudio err");
      print(err);
    }
    return null;
  }

  static Future<String> get stopRecordScreen async {
    try {
      final String path = await FlutterScreenRecordingPlatform.instance.stopRecordScreen;
      if (!kIsWeb && Platform.isAndroid) {
        FlutterForegroundTask.stopService();
      }
      return path;
    } catch (err) {
      print("stopRecordScreen err");
      print(err);
    }
    return "";
  }

  static _maybeStartFGS(String titleNotification, String messageNotification) {
    try {
      if (!kIsWeb && Platform.isAndroid) {
        FlutterForegroundTask.init(
          androidNotificationOptions: AndroidNotificationOptions(
            channelId: 'notification_channel_id',
            channelName: titleNotification,
            channelDescription: messageNotification,
            channelImportance: NotificationChannelImportance.LOW,
            priority: NotificationPriority.LOW,
            iconData: const NotificationIconData(
              resType: ResourceType.mipmap,
              resPrefix: ResourcePrefix.ic,
              name: 'launcher',
            ),
          ),
          iosNotificationOptions: const IOSNotificationOptions(
            showNotification: true,
            playSound: false,
          ),
          foregroundTaskOptions: const ForegroundTaskOptions(
            interval: 5000,
            autoRunOnBoot: true,
            allowWifiLock: true,
          ),
        );
      }
    } catch (err) {
      print("_maybeStartFGS err");
      print(err);
    }
  }
}
