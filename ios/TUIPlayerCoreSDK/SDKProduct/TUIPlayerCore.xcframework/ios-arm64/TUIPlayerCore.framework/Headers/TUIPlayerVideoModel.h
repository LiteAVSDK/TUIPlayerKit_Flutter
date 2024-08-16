// Copyright (c) 2023 Tencent. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TUIPlayerDataModel.h"
#import "TUIPlayerVideoConfig.h"
#import "TUIPlayerVideoPreloadState.h"
#import "TUIPlayerSubtitleModel.h"

NS_ASSUME_NONNULL_BEGIN

///视频数据模型
@interface TUIPlayerVideoModel : TUIPlayerDataModel<NSCopying>

/*** 基础信息 */
@property (nonatomic, copy) NSString *videoUrl;        /// 视频Url地址
@property (nonatomic, copy) NSString *coverPictureUrl; /// 封面图
@property (nonatomic, copy) NSString *duration;         /// 视频时长
@property (nonatomic, assign) int appId;                /// appid
@property (nonatomic, copy) NSString *fileId;           /// 视频的fileId
@property (nonatomic, copy) NSString *pSign;           /// 签名字串
@property (nonatomic, strong) NSArray <TUIPlayerSubtitleModel*>*subtitles;///字幕信息
/*** 预下载状态 */
@property (nonatomic, assign, readonly) TUIPlayerVideoPreloadState preloadState;///预下载状态
@property (nonatomic, strong, readonly) NSMutableDictionary *preloadStateMap;///预加载状态（按分辨率）

/*** 配置信息 */
@property (nonatomic, strong) TUIPlayerVideoConfig *config; ///配置

/**
 * 视频模型描述
 * @return 返回字符串描述信息
 */
- (NSString *)info ;


@end

NS_ASSUME_NONNULL_END
