//
//  TUILayerHelper.h
//  ftuiplayer_kit
//
//  Created by Kongdywang on 2024/7/29.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface TUILayerHelper : NSObject

+(int)pickLayerId;

+(void)setGlobalMessager:(id<FlutterBinaryMessenger>)messager;

+(id<FlutterBinaryMessenger>)getGlobalMessager;

@end

NS_ASSUME_NONNULL_END
