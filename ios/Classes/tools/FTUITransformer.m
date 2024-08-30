//
//  FTUITransformer.m
//  ftuiplayer_kit
//
//  Created by Kongdywang on 2024/7/25.
//

#import "FTUITransformer.h"

@implementation FTUITransformer

+ (nonnull FTUIVodSourceMsg *)transToMsgFromVodSource:(nonnull TUIPlayerVideoModel *)source {
    FTUIVodSourceMsg *msg = [[FTUIVodSourceMsg alloc] init];
    msg.videoURL = source.videoUrl;
    if (source.appId) {
        msg.appId = [NSNumber numberWithInt:source.appId];
    }
    msg.fileId = source.fileId;
    msg.pSign = source.pSign;
//    msg.isAutoPlay = source.pla
    msg.coverPictureUrl = source.coverPictureUrl;
    msg.extInfo = source.extInfo;
    return msg;
}

+ (nonnull NSArray *)transToListVodSourceFromMsg:(nonnull FTUIListVodSourceMsg *)msg {
    NSMutableArray *dataList = @[].mutableCopy;
    NSArray *msgList = msg.listMsg;
    if (msgList) {
        for (FTUIVodSourceMsg *itemMsg in msgList) {
            [dataList addObject:[self transToVodSourceFromMsg:itemMsg]];
        }
    }
    return dataList;
}

+ (nonnull TUIPlayerVideoModel *)transToVodSourceFromMsg:(nonnull FTUIVodSourceMsg *)itemMsg {
    TUIPlayerVideoModel *model = [[TUIPlayerVideoModel alloc] init];
    model.videoUrl = itemMsg.videoURL;
    if (itemMsg.appId) {
        model.appId = [itemMsg.appId intValue];
    }
    model.fileId = itemMsg.fileId;
    model.pSign = itemMsg.pSign;
    model.coverPictureUrl = itemMsg.coverPictureUrl;
    model.extInfo = itemMsg.extInfo;
    return model;
}

+ (nonnull TUIPlayerVodStrategyModel *)transToVodStrategyOpenPreFromMsg:(nonnull FTUIPlayerVodStrategyMsg *)msg {
    TUIPlayerVodStrategyModel *model = [[TUIPlayerVodStrategyModel alloc] init];
    if (msg.preloadCount) {
        model.mPreloadConcurrentCount = [msg.preloadCount integerValue];
    }
    if (msg.preDownloadSize) {
        model.preDownloadSize = [msg.preDownloadSize floatValue];
    }
    if (msg.preloadBufferSizeInMB) {
        model.mPreloadBufferSizeInMB = [msg.preloadBufferSizeInMB floatValue];
    }
    if (msg.maxBufferSize) {
        model.maxBufferSize = [msg.maxBufferSize floatValue];
    }
    if (msg.preferredResolution) {
        model.mPreferredResolution = [msg.preferredResolution longValue];
    }
    if (msg.progressInterval) {
        model.mProgressInterval = [msg.progressInterval longValue];
    }
    if (msg.renderMode) {
        model.mRenderMode = [msg.renderMode intValue];
    }
    model.isLastPrePlay = YES;
    return model;
}

@end
