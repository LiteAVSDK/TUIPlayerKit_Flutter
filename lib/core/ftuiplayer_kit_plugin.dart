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

  /// Initialize the super-resolution algorithm, applicable to: Online Authorization License.
  /// 初始化超分算法，适用于：在线授权 Licence
  /// @param appId
  ///   Tencent Cloud AppID
  ///   腾讯云appId
  /// @param authId
  ///   Super-resolution Algorithm Authorization ID
  ///   超分算法授权id
  /// @param srAlgorithmType
  ///   Super-resolution algorithm type, refer to [FTXMonetConstant.SR_ALGORITHM_TYPE_STANDARD]
  ///   超分算法类型，参考 [FTXMonetConstant.SR_ALGORITHM_TYPE_STANDARD]
  static Future<void> setMonetAppInfo(int appId, int authId, int srAlgorithmType) async {
    return await _playerKitPluginAPI.setMonetAppInfo(appId, authId, srAlgorithmType);
  }

}
