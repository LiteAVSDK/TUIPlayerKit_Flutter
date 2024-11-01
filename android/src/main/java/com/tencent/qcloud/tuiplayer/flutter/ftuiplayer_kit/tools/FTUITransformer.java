// Copyright (c) 2024 Tencent. All rights reserved.
package com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.tools;

import com.tencent.qcloud.tuiplayer.core.TUIPlayerConfig;
import com.tencent.qcloud.tuiplayer.core.api.TUIPlayerVodStrategy;
import com.tencent.qcloud.tuiplayer.core.api.common.TUIConstants;
import com.tencent.qcloud.tuiplayer.core.api.model.TUIVideoSource;
import com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.messages.FtxMessages;

import java.util.ArrayList;
import java.util.List;

public class FTUITransformer {

    public static TUIPlayerConfig transformToTUIPlayerConfig(FtxMessages.FTUIPlayerConfigMsg msg) {
        boolean enableLog = msg.getEnableLog() == null || msg.getEnableLog();
        return new TUIPlayerConfig.Builder()
                .enableLog(enableLog)
                .licenseUrl(msg.getLicenseUrl())
                .licenseKey(msg.getLicenseKey())
                .build();
    }

    public static FtxMessages.FTUIVodSourceMsg transToMsgFromVodSource(TUIVideoSource source) {
        FtxMessages.FTUIVodSourceMsg msg = new FtxMessages.FTUIVodSourceMsg();
        msg.setVideoURL(source.getVideoURL());
        msg.setAppId((long)source.getAppId());
        msg.setFileId(source.getFileId());
        msg.setPSign(source.getPSign());
        msg.setExtInfo(source.getExtInfo());
        msg.setCoverPictureUrl(source.getCoverPictureUrl());
        msg.setIsAutoPlay(source.isAutoPlay());
        return msg;
    }

    public static List<TUIVideoSource> transToListVodSourceFromMsg(FtxMessages.FTUIListVodSourceMsg msg) {
        List<TUIVideoSource> sourceList = new ArrayList<>();
        final List<FtxMessages.FTUIVodSourceMsg> msgList = msg.getListMsg();
        if (null != msgList) {
            for (FtxMessages.FTUIVodSourceMsg itemMsg : msgList) {
                sourceList.add(transToVodSourceFromMsg(itemMsg));
            }
        }
        return sourceList;
    }

    public static TUIVideoSource transToVodSourceFromMsg(FtxMessages.FTUIVodSourceMsg itemMsg) {
        TUIVideoSource videoSource = new TUIVideoSource();
        videoSource.setVideoURL(itemMsg.getVideoURL());
        if (null != itemMsg.getAppId()) {
            videoSource.setAppId(itemMsg.getAppId().intValue());
        }
        if (null != itemMsg.getFileId()) {
            videoSource.setFileId(itemMsg.getFileId());
        }
        if (null != itemMsg.getIsAutoPlay()) {
            videoSource.setAutoPlay(itemMsg.getIsAutoPlay());
        }
        videoSource.setPSign(itemMsg.getPSign());
        videoSource.setCoverPictureUrl(itemMsg.getCoverPictureUrl());
        videoSource.setExtInfoAndNotify(itemMsg.getExtInfo());
        return videoSource;
    }

    public static TUIPlayerVodStrategy transToVodStrategyOpenPreFromMsg(FtxMessages.FTUIPlayerVodStrategyMsg msg) {
        TUIPlayerVodStrategy.Builder strategy = new TUIPlayerVodStrategy.Builder();
        if (null != msg.getPreloadCount()) {
            strategy.setPreloadCount(msg.getPreloadCount().intValue());
        }
        if (null != msg.getPreDownloadSize()) {
            strategy.setPreDownloadSize(msg.getPreDownloadSize().floatValue());
        }
        if (null != msg.getPreloadBufferSizeInMB()) {
            strategy.setPreLoadBufferSize(msg.getPreloadBufferSizeInMB().floatValue());
        }
        if (null != msg.getMaxBufferSize()) {
            strategy.setMaxBufferSize(msg.getMaxBufferSize().floatValue());
        }
        if (null != msg.getPreferredResolution()) {
            strategy.setPreferredResolution(msg.getPreferredResolution());
        }
        if (null != msg.getProgressInterval()) {
            strategy.setProgressInterval(msg.getProgressInterval().intValue());
        }
        if (null != msg.getRenderMode()) {
            strategy.setRenderMode(msg.getRenderMode().intValue());
        }
        if (null != msg.getEnableSuperResolution()) {
            strategy.setSuperResolutionMode(msg.getEnableSuperResolution()
                    ? TUIConstants.TUISuperResolution.SUPER_RESOLUTION_ASR
                    : TUIConstants.TUISuperResolution.SUPER_RESOLUTION_NONE);
        }
        strategy.setIsRetainPreVod(true);
        return strategy.build();
    }

}
