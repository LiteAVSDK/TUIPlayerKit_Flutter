// Copyright (c) 2024 Tencent. All rights reserved.
part of '../ftuiplayer_kit.dart';

final FTUIPlayerKitPluginAPI _playerKitPluginAPI = FTUIPlayerKitPluginAPI();

class FTUIPlayerKitPlugin {

  static Future<int> createShortController() async {
    return await _playerKitPluginAPI.createShortEngine();
  }

  /// set player global config [FTUIPlayerConfig]
  /// 设置 TUI 短视频全局配置 [FTUIPlayerConfig]
  static Future<void> setTUIPlayerConfig(FTUIPlayerConfig config) async {
    return await _playerKitPluginAPI.setConfig(config.toMsg());
  }

}
