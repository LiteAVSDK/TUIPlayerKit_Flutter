package com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.player;

import android.content.Context;

import androidx.annotation.NonNull;

import com.tencent.liteav.monet.MonetPlugin;
import com.tencent.qcloud.tuiplayer.core.TUIPlayerCore;
import com.tencent.qcloud.tuiplayer.core.tools.TUIPlayerLog;
import com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.messages.FtxMessages;
import com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.tools.FTUITransformer;
import com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.view.FTUIItemViewFactory;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

import io.flutter.plugin.common.BinaryMessenger;

public class FTUIShortEngine implements FTUIShortEngineObserver, FtxMessages.FTUIPlayerKitPluginAPI {

    private static final String TAG = "FTUIShortEngine";

    private final FTUIItemViewFactory mViewFactory;
    private final AtomicInteger mShortIDProvider = new AtomicInteger(0);
    private final Map<Integer, FTUIShortController> mControllers = new HashMap<>();
    private final Context mContext;
    private final BinaryMessenger mMessenger;

    public FTUIShortEngine(FTUIItemViewFactory viewFactory, Context context, BinaryMessenger messenger) {
        mViewFactory = viewFactory;
        mContext = context;
        mMessenger = messenger;
    }

    private int createShortController() {
        final int controllerId = mShortIDProvider.getAndIncrement();
        FTUIShortController shortController = new FTUIShortController(mContext, mViewFactory,
                controllerId ,mMessenger,  this);
        mControllers.put(controllerId, shortController);
        return controllerId;
    }

    @Override
    public void onRelease(int controllerId) {
        TUIPlayerLog.i(TAG, "onRelease shortController, controllerId" + controllerId);
        if (mControllers.containsKey(controllerId)) {
            mControllers.remove(controllerId);
        } else {
            TUIPlayerLog.w(TAG, "controllerId " + controllerId + " is miss, did it add to engine?");
        }
    }

    @Override
    public void setConfig(@NonNull FtxMessages.FTUIPlayerConfigMsg msg) {
        TUIPlayerLog.i(TAG, "called setConfig:" + msg);
        TUIPlayerCore.init(mContext, FTUITransformer.transformToTUIPlayerConfig(msg));
    }

    @NonNull
    @Override
    public Long createShortEngine() {
        int controllerId = createShortController();
        TUIPlayerLog.i(TAG, "called createShortEngine, controllerId" + controllerId);
        return (long) controllerId;
    }

    @Override
    public void setMonetAppInfo(@NonNull Long appId, @NonNull Long authId, @NonNull Long srAlgorithmType) {
        TUIPlayerLog.i(TAG, "called setAppInfo,appId:" + appId);
        long appIdInt = appId;
        int authIdInt = authId.intValue();
        int srIdInt = srAlgorithmType.intValue();
        MonetPlugin.setAppInfo(appIdInt, authIdInt, srIdInt);
    }
}
