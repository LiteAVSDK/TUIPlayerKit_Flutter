package com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit;

import androidx.annotation.NonNull;

import com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.common.FTUIConstant;
import com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.engine.FlutterViewEngine;
import com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.messages.FtxMessages;
import com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.player.FTUIShortEngine;
import com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.view.FTUIItemViewFactory;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;

/**
 * FtuiplayerKitPlugin
 */
public class FtuiplayerKitPlugin implements FlutterPlugin, ActivityAware {

    private FlutterPluginBinding mPluginBinding;
    private FlutterViewEngine mTUIPlayerLayerEngine;

    private ActivityPluginBinding mCurActBinding;
    private FTUIShortEngine mShortManager;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        mPluginBinding = flutterPluginBinding;
        FTUIItemViewFactory itemViewFactory = new FTUIItemViewFactory(flutterPluginBinding.getBinaryMessenger());
        flutterPluginBinding
                .getPlatformViewRegistry()
                .registerViewFactory(FTUIConstant.TUI_SHORT_VIEW_ITEM_ID, itemViewFactory);
        mShortManager = new FTUIShortEngine(itemViewFactory, flutterPluginBinding.getApplicationContext(),
                flutterPluginBinding.getBinaryMessenger());
        FtxMessages.FTUIPlayerKitPluginAPI.setUp(flutterPluginBinding.getBinaryMessenger(), mShortManager);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {

    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        mCurActBinding = binding;
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {

    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

    }

    @Override
    public void onDetachedFromActivity() {

    }
}
