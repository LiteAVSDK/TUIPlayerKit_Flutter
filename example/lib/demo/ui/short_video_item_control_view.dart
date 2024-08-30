// Copyright (c) 2024 Tencent. All rights reserved.

import 'package:flutter/material.dart';
import 'package:ftuiplayer_kit/ftuiplayer_kit.dart';

import 'short_video_slider.dart';

class ShortVodItemControlView extends StatefulWidget {
  final FTUIPlayerView playerView;
  TUIVodPlayerController? _playerController;
  void Function()? _onPlayControllerGet;
  FTUIVideoSource videoSource;

  ShortVodItemControlView(this.playerView, this.videoSource, {super.key});

  set playerController(TUIVodPlayerController? controller) {
    _playerController = controller;
    _onPlayControllerGet?.call();
  }

  TUIVodPlayerController? get playerController => _playerController;

  @override
  State<StatefulWidget> createState() => ShortVodItemControlViewState();
}

class ShortVodItemControlViewState extends State<ShortVodItemControlView> {
  final GlobalKey<VideoSliderState> _sliderView = GlobalKey();
  double _currentProgress = 0.0;
  bool _sliderOnDrag = false;
  bool _showCover = true;
  bool _isPlaying = false;
  FTUIVodControlListener? _vodControlListener;

  @override
  void initState() {
    super.initState();
    widget._onPlayControllerGet = updateController;
  }

  void updateController() {
    if (null != _vodControlListener) {
      widget.playerController?.removeListener(_vodControlListener!);
    }
    widget.playerController?.addListener(_vodControlListener = FTUIVodControlListener(onVodPlayerEvent: (event) {
      int eventCode = event[TXVodPlayEvent.EVT_EVENT];
      switch (eventCode) {
        case TXVodPlayEvent.PLAY_EVT_PLAY_PROGRESS:
          dynamic progress = event[TXVodPlayEvent.EVT_PLAY_PROGRESS];
          dynamic duration = event[TXVodPlayEvent.EVT_PLAY_DURATION];
          double? currentDuration;
          double? videoDuration;
          if (null != progress) {
            currentDuration = progress.toDouble(); // Current time, converted unit: seconds
          }
          if (null != duration) {
            videoDuration = duration.toDouble(); // Total playback time, converted unit: seconds
          }
          if (null != currentDuration && null != videoDuration && videoDuration != 0) {
            _updateProgress(currentDuration, videoDuration);
          }
          break;
        case TXVodPlayEvent.PLAY_EVT_FIRST_FRAME_RENDERED:
          setState(() {
            _showCover = false;
          });
          break;
        case TXVodPlayEvent.PLAY_EVT_PLAY_BEGIN:
          setState(() {
            _isPlaying = true;
          });
          break;
      }
    }));
    setState(() {
      _isPlaying = widget.playerController?.playerState == TUIPlayerState.PLAYING;
      _showCover = widget.playerController?.playerState == TUIPlayerState.INIT;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.black),
      child: Stack(
        children: [
          widget.playerView,
          InkWell(
            onTap: () async {
              bool isPlaying = await widget.playerController?.isPlaying() ?? false;
              if (isPlaying) {
                widget.playerController?.pause();
                setState(() {
                  _isPlaying = false;
                });
              } else {
                widget.playerController?.resume();
              }
            },
            child: Container(),
          ),
          Positioned(
              bottom: 50,
              left: 10,
              right: 10,
              child: VideoSlider(
                key: _sliderView,
                min: 0.0,
                max: 100.0,
                value: _currentProgress,
                activeColor: Colors.grey,
                inactiveColor: Colors.white,
                sliderColor: Colors.grey,
                sliderOutterColor: Colors.grey,
                progressHeight: 2,
                sliderRadius: 4,
                sliderOutterRadius: 5,
                canDrag: widget.playerController != null,
                onDragUpdate: (value) {
                  _sliderOnDrag = true;
                  _currentProgress = value;
                },
                onDragEnd: (value) async {
                  double? duration = await widget.playerController?.getDuration();
                  _currentProgress = value;
                  if (null != duration) {
                    double seekTime = duration * value;
                    widget.playerController?.seekTo(seekTime);
                  }
                  _sliderOnDrag = false;
                },
              )),
          Visibility(
              visible: _showCover,
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.network(widget.videoSource.coverPictureUrl ?? "", fit: BoxFit.cover),
              )),
          Visibility(
            visible: !_isPlaying,
            child: const Center(
              child: Image(
                width: 40,
                height: 40,
                image: AssetImage("images/tui_ic_play_normal.png"),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _updateProgress(double currentDuration, double videoDuration) {
    if (!_sliderOnDrag) {
      _currentProgress = (currentDuration / videoDuration) * 100.0;
      if (_currentProgress > 100.0) {
        _currentProgress = 100.0;
      } else if (_currentProgress < 0.0) {
        _currentProgress = 0.0;
      }
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (null != _vodControlListener) {
      widget.playerController?.removeListener(_vodControlListener!);
    }
  }
}
