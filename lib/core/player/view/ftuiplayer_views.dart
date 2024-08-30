// Copyright (c) 2024 Tencent. All rights reserved.
part of '../../../ftuiplayer_kit.dart';

const _kTuiPlayerItemViewType = "TUIShortVideoItemView";

class FTUIPlayerView extends StatefulWidget {

  int _viewId;
  TUIVodPlayerController? _controller;
  Completer<int> _viewIdCompleter = Completer();

  FTUIPlayerView({super.key})
      : _viewId = -1;

  @override
  State<FTUIPlayerView> createState() => _FTUIPlayerViewState();
}

class _FTUIPlayerViewState extends State<FTUIPlayerView> {

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
    if (widget._viewIdCompleter.isCompleted) {
      widget._viewIdCompleter = Completer();
    }
    widget._viewId = params.id;
    widget._viewIdCompleter.complete(params.id);
    widget._controller = TUIVodPlayerController(params.id);
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
    if (widget._viewIdCompleter.isCompleted) {
      widget._viewIdCompleter = Completer();
    }
    widget._viewId = id;
    widget._viewIdCompleter.complete(id);
    widget._controller = TUIVodPlayerController(id);
  }

  @override
  void dispose() {
    super.dispose();
    if (defaultTargetPlatform == TargetPlatform.iOS && null != widget._controller) {
      widget._controller!.release();
    }
  }
}