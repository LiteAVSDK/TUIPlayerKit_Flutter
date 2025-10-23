package com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.view;

import android.content.Context;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.tencent.qcloud.tuiplayer.core.api.common.TUIConstants;
import com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.messages.FtxMessages;
import com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.player.event.FTUIVodController;
import com.tencent.qcloud.tuiplayer.shortvideo.ui.view.TUIShortVideoItemView;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.platform.PlatformView;

public class FTUIShortVideoItemView implements PlatformView {

    private final TUIShortVideoItemView mItemView;
    private final FTUIVodController mController;
    private final FTUIPlatformViewObserver mPlatformObserver;
    private final int viewId;
    private final BinaryMessenger mMessenger;

    public FTUIShortVideoItemView(@NonNull Context context, int id, @Nullable Map<String, Object> creationParams
            , BinaryMessenger messenger, FTUIPlatformViewObserver platformViewObserver) {
        mMessenger = messenger;
        mPlatformObserver = platformViewObserver;
        viewId = id;
        mItemView = new TUIShortVideoItemView(context, TUIConstants.RenderViewType.TEXTURE_VIEW);
        mItemView.setClickable(false);
        mItemView.setFocusableInTouchMode(false);
        mItemView.setLongClickable(false);
        FtxMessages.FTUIVodPlayerFlutterAPI flutterAPI =
                new FtxMessages.FTUIVodPlayerFlutterAPI(messenger, String.valueOf(viewId));
        mController = new FTUIVodController(flutterAPI, this);
        mItemView.addVideoItemViewListener(mController);
        mItemView.createDisplayView();
        FtxMessages.FTUIVodPlayerAPI.setUp(messenger, String.valueOf(viewId), mController);
    }

    @Override
    public View getView() {
        return mItemView;
    }

    @Override
    public void dispose() {
        mItemView.onViewDestroyed();
        FtxMessages.FTUIVodPlayerAPI.setUp(mMessenger, String.valueOf(viewId), null);
        mPlatformObserver.onDispose(viewId);
    }
}
