// Copyright (c) 2024 Tencent. All rights reserved.
package com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.tools;

import com.tencent.qcloud.tuiplayer.core.TUIPlayerConfig;
import com.tencent.qcloud.tuiplayer.core.api.TUIPlayerVodStrategy;
import com.tencent.qcloud.tuiplayer.core.api.common.TUIConstants;
import com.tencent.qcloud.tuiplayer.core.api.model.TUIPlayerVideoConfig;
import com.tencent.qcloud.tuiplayer.core.api.model.TUIVideoSource;
import com.tencent.qcloud.tuiplayer.flutter.ftuiplayer_kit.messages.FTUIMessages;

import java.util.ArrayList;
import java.util.List;

public class FTUITransformer {

    public static TUIPlayerConfig transformToTUIPlayerConfig(FTUIMessages.FTUIPlayerConfigMsg msg) {
        boolean enableLog = msg.getEnableLog() == null || msg.getEnableLog();
        return new TUIPlayerConfig.Builder()
                .enableLog(enableLog)
                .licenseUrl(msg.getLicenseUrl())
                .licenseKey(msg.getLicenseKey())
                .build();
    }

    public static FTUIMessages.FTUIVodSourceMsg transToMsgFromVodSource(TUIVideoSource source) {
        FTUIMessages.FTUIVodSourceMsg msg = new FTUIMessages.FTUIVodSourceMsg();
        msg.setVideoURL(source.getVideoURL());
        msg.setAppId((long)source.getAppId());
        msg.setFileId(source.getFileId());
        msg.setPSign(source.getPSign());
        msg.setExtInfo(source.getExtInfo());
        msg.setCoverPictureUrl(source.getCoverPictureUrl());
        msg.setIsAutoPlay(source.isAutoPlay());
        return msg;
    }

    public static List<TUIVideoSource> transToListVodSourceFromMsg(FTUIMessages.FTUIListVodSourceMsg msg) {
        List<TUIVideoSource> sourceList = new ArrayList<>();
        final List<FTUIMessages.FTUIVodSourceMsg> msgList = msg.getListMsg();
        if (null != msgList) {
            for (FTUIMessages.FTUIVodSourceMsg itemMsg : msgList) {
                sourceList.add(transToVodSourceFromMsg(itemMsg));
            }
        }
        return sourceList;
    }

    public static TUIVideoSource transToVodSourceFromMsg(FTUIMessages.FTUIVodSourceMsg itemMsg) {
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

    public static TUIPlayerVodStrategy transToVodStrategyOpenPreFromMsg(FTUIMessages.FTUIPlayerVodStrategyMsg msg) {
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
//        strategy.setIsRetainPreVod(true);
        strategy.setPrePlayStrategy(TUIConstants.TUIPrePlayStrategy.TUIPrePlayStrategyAdjacent);
        return strategy.build();
    }

}
