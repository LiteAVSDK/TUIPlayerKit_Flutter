//  Copyright © 2022 Tencent. All rights reserved.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TXCMonetPluginHelper : NSObject

/**
 @brief  获取组件的版本号
 @discussion  获取组件的版本号
 @return  返回超分组件的版本
*/
+(NSString *)getMonetPluginSDKVersion DEPRECATED_MSG_ATTRIBUTE("Use TXCMonetPluginManager#getMonetPluginSDKVersion instead.");;

@end

NS_ASSUME_NONNULL_END
