//
//  FTUIShortVideoItemView.h
//  ftuiplayer_kit
//
//  Created by kongdywang on 21.8.24.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import "FTUIVodController.h"
#import "FTUIPlatformViewObserver.h"

NS_ASSUME_NONNULL_BEGIN

@interface FTUIShortVideoItemView : NSObject<FlutterPlatformView>

- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
                    messenger:(id<FlutterBinaryMessenger>)binaryMessenger
                    viewObserver:(id<FTUIPlatformViewObserver>)platformObserver;

- (FTUIVodController*)getVodController;
@end

NS_ASSUME_NONNULL_END
