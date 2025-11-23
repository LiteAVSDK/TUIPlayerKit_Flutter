// Copyright (c) 2024 Tencent. All rights reserved.
part of '../../ftuiplayer_kit.dart';

class FTUIPlayerShortController {
  int _controllerId;
  final Completer<int> _viewIdCompleter;
  FTUIPlayerShortAPI? _api;

  FTUIPlayerShortController()
      : _controllerId = -1,
        _viewIdCompleter = Completer() {
    _initController();
  }

  void _initController() async {
    _controllerId = await FTUIPlayerKitPlugin.createShortController();
    _viewIdCompleter.complete(_controllerId);
    _api = FTUIPlayerShortAPI(messageChannelSuffix: _controllerId.toString());
  }

  Future<int?> setModels(List<FTUIVideoSource> sources) async {
    await _viewIdCompleter.future;
    List<FTUIVodSourceMsg> msgList = [];
    for (FTUIVideoSource source in sources) {
      msgList.add(source.toMsg());
    }
    return await _api?.setModels(FTUIListVodSourceMsg()..listMsg = msgList);
  }

  Future<int?> appendModels(List<FTUIVideoSource> sources) async {
    await _viewIdCompleter.future;
    List<FTUIVodSourceMsg> msgList = [];
    for (FTUIVideoSource source in sources) {
      msgList.add(source.toMsg());
    }
    return await _api?.appendModels(FTUIListVodSourceMsg()..listMsg = msgList);
  }

  Future<TUIVodPlayerController> bindVodPlayer(FTUIPlayerView playerView, int curIndex) async {
    await playerView._viewIdCompleter.future;
    await _viewIdCompleter.future;
    await _api?.bindVideoView(playerView._viewId, curIndex);
    return playerView._controller!;
  }

  void setVodStrategy(FTUIPlayerVodStrategy strategy) async {
    await _viewIdCompleter.future;
    await _api?.setVodStrategy(strategy.toMsg());
  }

  void preCreateVodPlayer(FTUIPlayerView playerView, int index) async {
    await playerView._viewIdCompleter.future;
    await _viewIdCompleter.future;
    await _api?.preBindVideo(playerView._viewId, index);
  }

  Future<int?> startCurrent() async {
    await _viewIdCompleter.future;
    return await _api?.startCurrent();
  }

  Future<void> setVideoLoop(bool isLoop) async {
    await _viewIdCompleter.future;
    await _api?.setVideoLoop(isLoop);
  }

  /// release 会释放所有资源、停掉所有相关的预下载进程
  void release() async {
    await _viewIdCompleter.future;
    await _api?.release();
  }
}
