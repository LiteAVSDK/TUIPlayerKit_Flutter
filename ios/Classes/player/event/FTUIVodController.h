//
//  FTUIVodController.h
//  ftuiplayer_kit
//
//  Created by kongdywang on 27.8.24.
//

#import <Foundation/Foundation.h>
#import "FtxMessages.h"
#import <TUIPlayerShortVideo/TUIPlayerShortVideo-umbrella.h>
#import "FTUIPlatformViewObserver.h"

NS_ASSUME_NONNULL_BEGIN

@interface FTUIVodController : NSObject<TUIShortVideoItemViewDelegate, FTUIVodPlayerAPI, TUIPlayerVodManagerDelegate>

- (instancetype)initWithApi:(FTUIVodPlayerFlutterAPI*)mApi
               viewObserver:(id<FTUIPlatformViewObserver>)platformObserver
             viewIdentifier:(int64_t)viewId;

- (void)onBindController:(TUITXVodPlayer*)player;

- (void)onUnBindController;

@end

NS_ASSUME_NONNULL_END
