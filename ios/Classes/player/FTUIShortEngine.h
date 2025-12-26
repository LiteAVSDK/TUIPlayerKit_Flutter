//
//  FTUIShortEngine.h
//  ftuiplayer_kit
//
//  Created by kongdywang on 21.8.24.
//

#import <Foundation/Foundation.h>
#import "FTUIItemViewFactory.h"
#import <Flutter/Flutter.h>
#import "FTUIShortEngineObserver.h"
#import "FTUIMessages.h"

NS_ASSUME_NONNULL_BEGIN

@interface FTUIShortEngine : NSObject<FTUIShortEngineObserver, FTUIPlayerKitPluginAPI>

- (instancetype)initWithViewFactory:(FTUIItemViewFactory*) viewFactory
                          messenger:(id<FlutterBinaryMessenger>) binaryMessenger;


@end

NS_ASSUME_NONNULL_END
