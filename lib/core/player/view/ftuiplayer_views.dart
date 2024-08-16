// Copyright (c) 2024 Tencent. All rights reserved.
part of '../../../ftuiplayer_kit.dart';

const _kTuiPlayerItemViewType = "TUIShortVideoItemView";

class FTUIPlayerView extends StatelessWidget {

  int _viewId;
  Completer<int> _viewIdCompleter = Completer();

  FTUIPlayerView({super.key})
      : _viewId = -1;

  TUIVodPlayerController? _controller;

  @override
  Widget build(BuildContext context) {
    return _getPlatformView();
  }

  Widget _getPlatformView() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return PlatformViewLink(
          surfaceFactory: (context, controller) {
            return AndroidViewSurface(
              controller: controller as AndroidViewController,
              gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
              hitTestBehavior: PlatformViewHitTestBehavior.opaque,
            );
          },
          onCreatePlatformView: _onCreateAndroidView,
          viewType: _kTuiPlayerItemViewType);
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
          viewType: _kTuiPlayerItemViewType,
          layoutDirection: TextDirection.ltr,
          creationParams: const {},
          creationParamsCodec: const StandardMessageCodec(),
          onPlatformViewCreated: _onCreateIOSView
      );
    } else {
      throw ArgumentError("platform not support: $defaultTargetPlatform");
    }
  }

  PlatformViewController _onCreateAndroidView(PlatformViewCreationParams params) {
    if (_viewIdCompleter.isCompleted) {
      _viewIdCompleter = Completer();
    }
    _viewId = params.id;
    _viewIdCompleter.complete(params.id);
    _controller = TUIVodPlayerController(params.id);
    return PlatformViewsService.initSurfaceAndroidView(
      id: params.id,
      viewType: _kTuiPlayerItemViewType,
      layoutDirection: TextDirection.ltr,
      creationParams: {},
      creationParamsCodec: const StandardMessageCodec(),
      onFocus: () {
        params.onFocusChanged(true);
      },
    )
      ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
      ..create();
  }

  void _onCreateIOSView(int id) {
    if (_viewIdCompleter.isCompleted) {
      _viewIdCompleter = Completer();
    }
    _viewId = id;
    _viewIdCompleter.complete(id);
    _controller = TUIVodPlayerController(id);
  }
}