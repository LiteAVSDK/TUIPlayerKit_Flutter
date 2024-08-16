// Copyright (c) 2024 Tencent. All rights reserved.
/// Pigeon original component, used to generate native communication code for `messages`.
/// The generation command is as follows. When using the generation command,
/// the two import statements above need to be implemented or commented out.
///
/// pigeon原始原件，由此文件生成messages原生通信代码
/// 生成命令如下，使用生成命令的时候，需要实现注释掉以上两个import导入

// import 'package:pigeon/pigeon.dart';
/*
    dart run pigeon \
    --input lib/core/pigeons/ftuiplayer_message.dart \
    --dart_out lib/core/ftuiplayer_message.dart \
    --objc_header_out ios/Classes/messages/FtxMessages.h \
    --objc_source_out ios/Classes/messages/FtxMessages.m \
    --java_out ./android/src/main/java/com/tencent/qcloud/tuiplayer/flutter/ftuiplayer_kit/messages/FtxMessages.java \
    --java_package "com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.messages" \
    --copyright_header lib/core/pigeons/ftuiplayer_copy_right.txt

 */
class LicenseMsg {
  String? licenseUrl;
  String? licenseKey;
}

class FTUIPlayerConfigMsg {
  String? licenseUrl;
  String? licenseKey;
  bool? enableLog;
}

class FTUIVodSourceMsg {
  String? videoURL;
  String? coverPictureUrl;
  int? appId;
  String? fileId;
  String? pSign;
  bool? isAutoPlay;
  Object? extInfo;
}

class FTUIListVodSourceMsg {
  List<FTUIVodSourceMsg?>? listMsg;
}

class FTUIPlayerVodStrategyMsg {
  int? preloadCount;
  double? preDownloadSize;
  double? preloadBufferSizeInMB;
  double? maxBufferSize;
  int? preferredResolution;
  int? progressInterval;
  int? renderMode;
}

@HostApi()
abstract class FTUIPlayerKitPluginAPI {

  void setConfig(FTUIPlayerConfigMsg msg);

  int createShortEngine();
}

@HostApi()
abstract class FTUIPlayerShortAPI {

  int setModels(FTUIListVodSourceMsg msg);

  int appendModels(FTUIListVodSourceMsg msg);

  int startCurrent();

  void setVodStrategy(FTUIPlayerVodStrategyMsg msg);

  FTUIVodSourceMsg getCurrentModel();

  void bindVideoView(int pageViewId, int index);

  void preBindVideo(int pageViewId, int index);

  void release();

}

@HostApi()
abstract class FTUIVodPlayerAPI {

  void startPlay(FTUIVodSourceMsg msg);

  void pause();

  void resume();

  void setRate(double rate);

  void setMute(bool mute);

  void seekTo(double time);

  double getDuration();

  double getCurrentPlayTime();

  bool isPlaying();
}

@FlutterApi()
abstract class FTUIVodPlayerFlutterAPI {
  void onPlayEvent(Map<String, Object> event);

  void onBindVodController();

  void onUnBindVodController();
}
