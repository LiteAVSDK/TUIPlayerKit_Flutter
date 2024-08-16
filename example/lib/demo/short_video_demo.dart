// Copyright (c) 2024 Tencent. All rights reserved.
import 'package:flutter/material.dart';
import 'package:ftuiplayer_kit/ftuiplayer_kit.dart';
import 'package:ftuiplayer_kit_example/demo/data/video_source_factory.dart';
import 'package:ftuiplayer_kit_example/demo/ui/short_video_item_control_view.dart';

class ShortVideoDemo extends StatefulWidget {
  const ShortVideoDemo({super.key});

  @override
  State<StatefulWidget> createState() => _ShortVideoDemoState();
}

class _ShortVideoDemoState extends State<ShortVideoDemo> with WidgetsBindingObserver {
  final FTUIPlayerShortController _shortPlayerController = FTUIPlayerShortController();
  final DemoVideoSourceFactory _videoSourceFactory = DemoVideoSourceFactory();
  final Map<int, WeakReference<ShortVodItemControlView>> _playerViews = {};
  final List<FTUIVideoSource> sources = [];
  TUIVodPlayerController? _currentVodController;
  bool _isSetModeled = false;

  @override
  void initState() {
    super.initState();
    _shortPlayerController.setVodStrategy(FTUIPlayerVodStrategy());
    _fillData(true);
    WidgetsBinding.instance.addObserver(this);
  }

  void _fillData(bool isRefresh) {
    if (isRefresh) {
      sources.clear();
      _isSetModeled = true;
      sources.addAll(_videoSourceFactory.loadData());
      _shortPlayerController.setModels(sources);
    } else {
      sources.addAll(_videoSourceFactory.loadData());
      _shortPlayerController.appendModels(sources);
    }
    setState(() {
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        _currentVodController?.pause();
        break;
      case AppLifecycleState.resumed:
        _currentVodController?.resume();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: PageView.builder(
              scrollDirection: Axis.vertical,
              pageSnapping: true,
              allowImplicitScrolling: true,
              controller: PageController(),
              itemCount: sources.length,
              onPageChanged: (index) {
                onPageChanged(index);
                // Pagination
                if (index >= sources.length - 1) {
                  _fillData(false);
                }
              },
              itemBuilder: (context, index) {
                ShortVodItemControlView itemControlView = getFTUIPlayerView(index);
                if (_isSetModeled && index == 0) {
                  _isSetModeled = false;
                  onPageChanged(index);
                } else {
                  _shortPlayerController.preCreateVodPlayer(itemControlView.playerView, index);
                }
                return itemControlView;
              })),
    );
  }

  void onPageChanged(int index) async {
    ShortVodItemControlView itemControlView = getFTUIPlayerView(index);
    _currentVodController = await _shortPlayerController.bindVodPlayer(itemControlView.playerView, index);
    itemControlView.playerController = _currentVodController;
    await _shortPlayerController.startCurrent();
  }

  ShortVodItemControlView getFTUIPlayerView(int index) {
    // Prevent duplicate creation
    WeakReference<ShortVodItemControlView>? cacheView = _playerViews[index];
    ShortVodItemControlView itemControlView;
    if (null == cacheView || null == cacheView.target) {
      FTUIPlayerView playerView = FTUIPlayerView();
      itemControlView = ShortVodItemControlView(playerView, sources[index]);
      _playerViews[index] = WeakReference(itemControlView);
    } else {
      itemControlView = cacheView.target!;
    }
    return itemControlView;
  }

  @override
  void dispose() {
    super.dispose();
    _shortPlayerController.release();
  }
}
