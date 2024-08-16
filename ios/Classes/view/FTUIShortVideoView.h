//
//  FTUIShortVideoView.h
//  ftuiplayer_kit
//
//  Created by Kongdywang on 2024/7/25.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface FTUIShortVideoView : NSObject<FlutterPlatformView>

- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
                    messenger:(id<FlutterBinaryMessenger>)binaryMessenger ;

@end

NS_ASSUME_NONNULL_END
