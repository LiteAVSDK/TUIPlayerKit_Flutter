// Copyright (c) 2022 Tencent. All rights reserved.
part of '../../ftuiplayer_kit.dart';

class TUIVodPlayerController implements FTUIVodPlayerFlutterAPI {
  final FTUIVodPlayerAPI _playerAPI;
  final int playerId;
  final List<FTUIVodControlListener> _listeners = [];
  TUIPlayerState playerState = TUIPlayerState.INIT;

  TUIVodPlayerController(this.playerId) : _playerAPI = FTUIVodPlayerAPI(messageChannelSuffix: playerId.toString()) {
    FTUIVodPlayerFlutterAPI.setUp(this, messageChannelSuffix: playerId.toString());
  }

  Future<void> startPlay(FTUIVideoSource source) async {
    await _playerAPI.startPlay(source.toMsg());
  }

  Future<void> pause() async {
    await _playerAPI.pause();
    _updatePlayerState(TUIPlayerState.PAUSE);
  }

  Future<void> resume() async {
    await _playerAPI.resume();
    _updatePlayerState(TUIPlayerState.PLAYING);
  }

  Future<void> setRate(double rate) async {
    await _playerAPI.setRate(rate);
  }

  Future<void> setMute(bool mute) async {
    await _playerAPI.setMute(mute);
  }

  Future<void> seekTo(double time) async {
    await _playerAPI.seekTo(time);
  }

  Future<double> getDuration() async {
    return _playerAPI.getDuration();
  }

  Future<double> getCurrentPlayTime() async {
    return _playerAPI.getCurrentPlayTime();
  }

  Future<bool> isPlaying() async {
    return _playerAPI.isPlaying();
  }

  void addListener(FTUIVodControlListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  void removeListener(FTUIVodControlListener listener) {
    _listeners.remove(listener);
  }

  void clearListener() {
    _listeners.clear();
  }

  void _updatePlayerState(TUIPlayerState state) {
    playerState = state;
  }

  @override
  void onBindVodController() {
    for (FTUIVodControlListener listener in _listeners) {
      listener.onVodControllerBind?.call();
    }
  }

  @override
  void onUnBindVodController() {
    for (FTUIVodControlListener listener in _listeners) {
      listener.onVodControllerUnBind?.call();
    }
  }

  @override
  void onPlayEvent(Map<String?, Object?> event) {
    int eventCode = int.parse(event[TXVodPlayEvent.EVT_EVENT].toString());
    switch (eventCode) {
      case TXVodPlayEvent.PLAY_EVT_RCV_FIRST_I_FRAME:
        _updatePlayerState(TUIPlayerState.PLAYING);
        break;
      case TXVodPlayEvent.PLAY_EVT_PLAY_BEGIN:
        _updatePlayerState(TUIPlayerState.PLAYING);
        break;
      case TXVodPlayEvent.PLAY_EVT_PLAY_LOADING: // PLAY_EVT_PLAY_LOADING
        if (playerState == TUIPlayerState.PAUSE) {
          _updatePlayerState(TUIPlayerState.PAUSE);
        } else {
          _updatePlayerState(TUIPlayerState.LOADING);
        }
        break;
      case TXVodPlayEvent.PLAY_EVT_VOD_LOADING_END:
        if (playerState == TUIPlayerState.LOADING) {
          _updatePlayerState(TUIPlayerState.PLAYING);
        }
        break;
      case TXVodPlayEvent.PLAY_EVT_PLAY_END:
        _updatePlayerState(TUIPlayerState.END);
        break;
    }
    for (FTUIVodControlListener listener in _listeners) {
      listener.onVodPlayerEvent?.call(event);
    }
  }
}
