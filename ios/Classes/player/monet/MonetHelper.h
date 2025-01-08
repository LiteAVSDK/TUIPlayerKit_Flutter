// Copyright (c) 2024 Tencent. All rights reserved.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MonetHelper : NSObject

+ (void)setAppInfo:(NSString *)appIdStr authId:(int)authId algorithmType:(int)srAlgorithmType;

@end

NS_ASSUME_NONNULL_END
