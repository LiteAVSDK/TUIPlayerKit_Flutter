//
//  FTUIItemViewFactory.h
//  ftuiplayer_kit
//
//  Created by kongdywang on 21.8.24.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import "FTUIShortVideoItemView.h"
#import "FTUIPlatformViewObserver.h"

NS_ASSUME_NONNULL_BEGIN

@interface FTUIItemViewFactory : NSObject<FTUIPlatformViewObserver, FlutterPlatformViewFactory>

- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>) binaryMessenger;

- (FTUIShortVideoItemView*)findViewById:(NSUInteger)viewId;

@end

NS_ASSUME_NONNULL_END
