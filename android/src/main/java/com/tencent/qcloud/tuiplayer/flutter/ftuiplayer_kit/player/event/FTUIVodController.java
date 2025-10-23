package com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.player.event;

import android.os.Bundle;

import androidx.annotation.NonNull;

import com.tencent.qcloud.tuiplayer.core.api.TUIPlayerController;
import com.tencent.qcloud.tuiplayer.core.api.model.TUIFileVideoInfo;
import com.tencent.qcloud.tuiplayer.core.api.model.TUIVideoSource;
import com.tencent.qcloud.tuiplayer.core.api.ui.player.ITUIVodPlayer;
import com.tencent.qcloud.tuiplayer.core.api.ui.player.TUIVodObserver;
import com.tencent.qcloud.tuiplayer.core.api.ui.view.TUIBaseVideoView;
import com.tencent.qcloud.tuiplayer.core.api.ui.view.vod.TUIVodViewListener;
import com.tencent.qcloud.tuiplayer.core.tools.TUIPlayerLog;
import com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.common.FTUIConstant;
import com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.messages.FtxMessages;
import com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.tools.FTUITransformer;
import com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.tools.FTUIUtils;
import com.tencent.rtmp.TXTrackInfo;

import java.util.List;
import java.util.Map;

import io.flutter.plugin.platform.PlatformView;

public class FTUIVodController implements TUIVodViewListener, FtxMessages.FTUIVodPlayerAPI,
        FtxMessages.VoidResult, TUIVodObserver {

    private static final String TAG = "FTUIVodController";
    private TUIPlayerController mController;
    private TUIVideoSource mCurSource;
    private final PlatformView mPlatformView;
    FtxMessages.FTUIVodPlayerFlutterAPI mFlutterAPI;

    public FTUIVodController(FtxMessages.FTUIVodPlayerFlutterAPI flutterAPI, PlatformView platformView) {
        mFlutterAPI = flutterAPI;
        mPlatformView = platformView;
    }


    @Override
    public void onPlayerAttached(TUIPlayerController tuiPlayerController) {

    }


    // 做好非空判断，播放器一致会服用，客户一致持有这个引用的话，就要及时置空，让客户调用没有效果，避免调用错乱
    @Override
    public void onPlayerControllerBind(TUIPlayerController tuiPlayerController) {
        mController = tuiPlayerController;
        tuiPlayerController.addPlayerObserver(this);
        mFlutterAPI.onBindVodController(this);
    }

    @Override
    public void onPlayerControllerUnBind(TUIPlayerController tuiPlayerController) {
        mController = null;
        mFlutterAPI.onUnBindVodController(this);
    }

    @Override
    public void onBindData(TUIVideoSource tuiVideoSource) {
        mCurSource = tuiVideoSource;
    }

    @Override
    public void onExtInfoChanged(TUIVideoSource tuiVideoSource) {
        mCurSource = tuiVideoSource;
    }

    @Override
    public void onViewRecycled(TUIBaseVideoView tuiBaseVideoView) {
    }

    @Override
    public void onShortVideoDestroyed() {
        if (null != mController) {
            mController.stop();
        }
    }

    @Override
    public void startPlay(@NonNull FtxMessages.FTUIVodSourceMsg msg) {
        if (null != mController && mController.getPlayer() instanceof ITUIVodPlayer) {
            TUIVideoSource source = FTUITransformer.transToVodSourceFromMsg(msg);
            ((ITUIVodPlayer) mController.getPlayer()).startPlay(source);
        }
    }

    @Override
    public void pause() {
        if (null != mController) {
            mController.pause();
        }
    }

    @Override
    public void resume() {
        if (null != mController) {
            mController.resume();
        }
    }

    @Override
    public void setRate(@NonNull Double rate) {
        if (null != mController && mController.getPlayer() instanceof ITUIVodPlayer) {
            ((ITUIVodPlayer) mController.getPlayer()).setRate(rate.floatValue());
        }
    }

    @Override
    public void setMute(@NonNull Boolean mute) {
        if (null != mController && mController.getPlayer() instanceof ITUIVodPlayer) {
            mController.getPlayer().setMute(mute);
        }
    }

    @Override
    public void seekTo(@NonNull Double time) {
        if (null != mController) {
            mController.seekTo(time.floatValue());
        }
    }

    @Override
    public void setStringOption(@NonNull String value, @NonNull Object key) {
        if (null != mController && mController.getPlayer() instanceof ITUIVodPlayer) {
            ITUIVodPlayer vodPlayer = (ITUIVodPlayer) mController.getPlayer();
            vodPlayer.setStringOption(value, key);
        } else {
            TUIPlayerLog.e(TAG, "setStringOption failed, controller is not init");
        }
    }

    @NonNull
    @Override
    public Double getDuration() {
        if (null != mController && mController.getPlayer() instanceof ITUIVodPlayer) {
            return (double) ((ITUIVodPlayer) mController.getPlayer()).getDuration();
        }
        return 0.0;
    }

    @NonNull
    @Override
    public Double getCurrentPlayTime() {
        if (null != mController && mController.getPlayer() instanceof ITUIVodPlayer) {
            return (double) ((ITUIVodPlayer) mController.getPlayer()).getCurrentPlayTime();
        }
        return 0.0;
    }

    @NonNull
    @Override
    public Boolean isPlaying() {
        if (null != mController) {
            return mController.isPlaying();
        }
        return false;
    }

    @Override
    public void release() {
        mPlatformView.dispose();
        if (null != mCurSource) {
            mCurSource.attachView(null);
        }
    }

    @Override
    public void success() {

    }

    @Override
    public void error(@NonNull Throwable error) {
        TUIPlayerLog.e(TAG, "send msg to flutter failed", error);
    }

    @Override
    public void onPlayEvent(ITUIVodPlayer ituiVodPlayer, int i, Bundle bundle) {
        Map<String, Object> params = FTUIUtils.getParams(i, bundle);
        mFlutterAPI.onPlayEvent(params, this);
    }

    @Override
    public void onPlayPrepare() {

    }

    @Override
    public void onPlayBegin() {

    }

    @Override
    public void onPlayLoading() {

    }

    @Override
    public void onPlayLoadingEnd() {

    }

    @Override
    public void onPlayProgress(long l, long l1, long l2) {

    }

    @Override
    public void onSeek(float v) {

    }

    @Override
    public void onError(int i, String s, Bundle bundle) {

    }

    @Override
    public void onRcvFirstIframe() {

    }

    @Override
    public void onRcvAudioTrackInformation(List<TXTrackInfo> list) {

    }

    @Override
    public void onRcvTrackInformation(List<TXTrackInfo> list) {

    }

    @Override
    public void onRcvSubTitleTrackInformation(List<TXTrackInfo> list) {

    }

    @Override
    public void onRecFileVideoInfo(TUIFileVideoInfo tuiFileVideoInfo) {

    }

    @Override
    public void onResolutionChanged(long l, long l1) {

    }

    @Override
    public void onFirstFrameRendered() {
        Map<String, Object> params = FTUIUtils.getParams(FTUIConstant.PLAY_EVT_FIRST_FRAME_RENDERED, new Bundle());
        mFlutterAPI.onPlayEvent(params, FTUIVodController.this);
    }

    @Override
    public void onPlayEnd() {

    }

    @Override
    public void onRetryConnect(int i, Bundle bundle) {

    }

    @Override
    public void onPlayPause() {

    }

    @Override
    public void onPlayStop() {

    }
}
