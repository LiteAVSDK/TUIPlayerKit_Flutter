// Copyright (c) 2023 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TUIPlayerVodStrategyModel.h"

/// 视频设置
@interface TUIPlayerVideoConfig : NSObject<NSCopying>

@property (nonatomic, assign) float preDownloadSize; /// 预下载大小，单位MB，默认1MB
@property (nonatomic, assign) long mPreferredResolution;  /// 偏好分辨率
@property (nonatomic, assign) long switchResolution;///主动切换的分辨率
@property (nonatomic, assign) TUI_Enum_Type_RenderMode renderMode;///视频缩放模式
@property (nonatomic, strong) NSDictionary *headers; /// 自定义 HTTP Headers
@end


