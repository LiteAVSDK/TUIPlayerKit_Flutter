// Copyright (c) 2024 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TUIPlayerDataModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TUIPlayerLiveModel : TUIPlayerDataModel <NSCopying>
@property (nonatomic, copy) NSString *liveUrl;        /// 直播Url
@property (nonatomic, copy) NSString *coverPictureUrl; /// 封面图

@end

NS_ASSUME_NONNULL_END
