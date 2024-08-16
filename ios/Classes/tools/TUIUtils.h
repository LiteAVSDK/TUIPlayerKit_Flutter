//
//  TUIUtils.h
//  ftuiplayer_kit
//
//  Created by Kongdywang on 2024/7/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TUIUtils : NSObject

+ (NSDictionary *)getParamsWithEvent:(int)EvtID withParams:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
