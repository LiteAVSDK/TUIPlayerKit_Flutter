//
//  FTUIVideoViewFactory.h
//  ftuiplayer_kit
//
//  Created by Kongdywang on 2024/7/25.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface FTUIVideoViewFactory : NSObject<FlutterPlatformViewFactory>

- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>) binaryMessenger;

@end

NS_ASSUME_NONNULL_END
