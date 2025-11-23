// Copyright (c) 2025 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TUIPreplayStrategy) {
    TUIPreplayStrategyNone = 0,     // 不开启预播放
    TUIPreplayStrategyNext = 1,     // 向下预播放
    TUIPreplayStrategyPrevious = 2, // 向上预播放
    TUIPreplayStrategyAdjacent = 3, // 上下相邻预播放
};

@interface TUIPlayerStrategyModel : NSObject

// 预播放策略，默认为 TUIPreplayStrategyNext
@property (nonatomic, assign) TUIPreplayStrategy preplayStrategy;

@end

NS_ASSUME_NONNULL_END
