package com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.view;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.tencent.qcloud.tuiplayer.core.tools.TUIPlayerLog;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class FTUIItemViewFactory extends PlatformViewFactory implements FTUIPlatformViewObserver {
    private static final String TAG = "FTUIItemViewFactory";

    private final Map<Integer, FTUIShortVideoItemView> viewToPlatformViewMap = new HashMap<>();

    private final BinaryMessenger mBinaryMessenger;

    /**
     * param createArgsCodec the codec used to decode the args parameter of {@link #create}.
     */
    public FTUIItemViewFactory(BinaryMessenger messenger) {
        super(StandardMessageCodec.INSTANCE);
        this.mBinaryMessenger = messenger;
    }

    public FTUIShortVideoItemView findViewById(int viewId) {
        return viewToPlatformViewMap.get(viewId);
    }

    @NonNull
    @Override
    public PlatformView create(Context context, int viewId, @Nullable Object args) {
        final Map<String, Object> creationParams = (Map<String, Object>) args;
        FTUIShortVideoItemView view = new FTUIShortVideoItemView(context, viewId,
                creationParams, mBinaryMessenger, this);
        viewToPlatformViewMap.put(viewId, view);
        return view;
    }

    @Override
    public void onDispose(int viewId) {
        if (viewToPlatformViewMap.containsKey(viewId)) {
            viewToPlatformViewMap.remove(viewId);
        } else {
            TUIPlayerLog.w(TAG, "viewId " + viewId + " is miss, did it add to viewMap?");
        }
    }
}
