//
//  FTUIShortController.h
//  ftuiplayer_kit
//
//  Created by kongdywang on 21.8.24.
//

#import <Foundation/Foundation.h>
#import "FTUIItemViewFactory.h"
#import <Flutter/Flutter.h>
#import "FTUIShortEngineObserver.h"

NS_ASSUME_NONNULL_BEGIN

@interface FTUIShortController : NSObject

- (instancetype)initWithViewFactory:(FTUIItemViewFactory*)viewFactory
                       controllerId:(NSUInteger)controllerId
                          messenger:(id<FlutterBinaryMessenger>)messenger
                           observer:(id<FTUIShortEngineObserver>)observer;



@end

NS_ASSUME_NONNULL_END
