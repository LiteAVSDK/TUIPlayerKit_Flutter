package com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.player;

import android.content.Context;

import androidx.annotation.NonNull;

import com.tencent.qcloud.tuiplayer.core.api.TUIPlayerBridge;
import com.tencent.qcloud.tuiplayer.core.api.TUIPlayerManager;
import com.tencent.qcloud.tuiplayer.core.api.TUIPlayerVodStrategy;
import com.tencent.qcloud.tuiplayer.core.api.model.TUIPlaySource;
import com.tencent.qcloud.tuiplayer.core.api.model.TUIVideoSource;
import com.tencent.qcloud.tuiplayer.core.api.tools.TUIDataUtils;
import com.tencent.qcloud.tuiplayer.core.api.ui.view.TUIBaseVideoView;
import com.tencent.qcloud.tuiplayer.core.preload.TUIVideoDataHolder;
import com.tencent.qcloud.tuiplayer.core.tools.TUIPlayerLog;
import com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.messages.FtxMessages;
import com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.tools.FTUITransformer;
import com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.view.FTUIItemViewFactory;
import com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.view.FTUIShortVideoItemView;

import java.util.List;

import io.flutter.plugin.common.BinaryMessenger;

public class FTUIShortController implements TUIPlayerBridge, FtxMessages.FTUIPlayerShortAPI {

    private static final String TAG = "FTUIShortController";

    private final TUIPlayerManager mManager;
    private final FTUIItemViewFactory mViewFactory;
    private final int mId;
    private final FTUIShortEngineObserver mEngineObserver;
    private int mCurrentIndex;
    private final TUIVideoDataHolder mDataHolder;

    public FTUIShortController(Context context, FTUIItemViewFactory viewFactory, int id, BinaryMessenger messenger,
                               FTUIShortEngineObserver observer) {
        mManager = new TUIPlayerManager(context, this);
        mDataHolder = mManager.getDataHolder();
        mViewFactory = viewFactory;
        mId = id;
        mEngineObserver = observer;
        FtxMessages.FTUIPlayerShortAPI.setUp(messenger, String.valueOf(mId), this);
    }

    public void bindVideoView(int viewId, boolean isPreBind, int curIndex) {
        FTUIShortVideoItemView itemView = mViewFactory.findViewById(viewId);
        if (null != itemView) {
            TUIBaseVideoView itemVideoView = (TUIBaseVideoView) itemView.getView();
            itemVideoView.bindVideoModel(mDataHolder.getSource(curIndex));
            if (isPreBind) {
                TUIPlayerLog.v(TAG, "start preRender index" + curIndex);
                mManager.preRenderOnView(itemVideoView);
            } else {
                mCurrentIndex = curIndex;
                TUIPlayerLog.v(TAG, "mCurrentIndex start update to:" + mCurrentIndex);
                mManager.bindVideoView(itemVideoView);
                TUIPlayerLog.v(TAG, "mCurrentIndex updated to:" + mCurrentIndex);
            }
        } else {
            TUIPlayerLog.e(TAG, "bindVideoView met a null view,viewId:" + viewId);
        }
    }

    @NonNull
    @Override
    public Long setModels(@NonNull FtxMessages.FTUIListVodSourceMsg msg) {
        List<TUIPlaySource> sources = TUIDataUtils.copyModels(FTUITransformer.transToListVodSourceFromMsg(msg));
        return (long) mManager.setModels(sources);
    }

    @NonNull
    @Override
    public Long appendModels(@NonNull FtxMessages.FTUIListVodSourceMsg msg) {
        List<TUIPlaySource> copyModels = TUIDataUtils.copyModels(FTUITransformer.transToListVodSourceFromMsg(msg));
        return (long) mManager.appendModels(copyModels);
    }

    @NonNull
    @Override
    public Long startCurrent() {
        return (long) mManager.startCurrent();
    }

    @Override
    public void setVodStrategy(@NonNull FtxMessages.FTUIPlayerVodStrategyMsg msg) {
        TUIPlayerVodStrategy strategy = FTUITransformer.transToVodStrategyOpenPreFromMsg(msg);
        mManager.updateVodStrategy(strategy);
    }

    @NonNull
    @Override
    public FtxMessages.FTUIVodSourceMsg getCurrentModel() {
        TUIPlaySource source = mManager.getCurrentModel();
        if (source instanceof TUIVideoSource) {
            return FTUITransformer.transToMsgFromVodSource((TUIVideoSource) source);
        }
        return new FtxMessages.FTUIVodSourceMsg();
    }

    @Override
    public void bindVideoView(@NonNull Long pageViewId, @NonNull Long index) {
        bindVideoView(pageViewId.intValue(), false, index.intValue());
    }

    @Override
    public void preBindVideo(@NonNull Long pageViewId, @NonNull Long index) {
        bindVideoView(pageViewId.intValue(), true, index.intValue());
    }

    public void release() {
        mManager.releasePlayers();
        mEngineObserver.onRelease(mId);
    }


    @Override
    public int getCurrentScrollState() {
        return 0;
    }

    @Override
    public int getCurrentPlayingIndex() {
        return mCurrentIndex;
    }

    @Override
    public void onCurrentPlayEnd() {

    }

    @Override
    public void postHandlePlayCurrent(int i) {

    }

    @Override
    public void postOnMain(Runnable runnable) {

    }
}
