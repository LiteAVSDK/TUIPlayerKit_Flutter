//
//  FtuiplayerKitPlugin.h
//  ftuiplayer_kit
//
//  Created by Kongdywang on 2024/7/25.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import "FTUIItemViewFactory.h"

NS_ASSUME_NONNULL_BEGIN

@interface FtuiplayerKitPlugin : NSObject<FlutterPlugin>

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar
                      viewFactory:(FTUIItemViewFactory*)viewFactory;

@end

NS_ASSUME_NONNULL_END
