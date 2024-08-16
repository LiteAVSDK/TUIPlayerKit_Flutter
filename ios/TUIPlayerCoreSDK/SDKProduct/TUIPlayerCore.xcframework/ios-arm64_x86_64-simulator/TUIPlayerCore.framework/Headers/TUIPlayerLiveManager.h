//  Copyright © 2024 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TUIPlayerLiveModel.h"
#import "TUITXLivePlayer.h"
#import "TUIPlayerLiveStrategyManager.h"
NS_ASSUME_NONNULL_BEGIN
@protocol TUIPlayerLiveManagerDelegate <NSObject>

- (void)currentPlayer:(TUITXLivePlayer *)player;
- (void)liveRenderModeChanged:(V2TXLiveFillMode)renderMode;
- (void)onVideoResolutionChanged:(TUITXLivePlayer *)player
                           width:(NSInteger)width
                          height:(NSInteger)height;
@end
@interface TUIPlayerLiveManager : NSObject
@property (nonatomic, strong) TUIPlayerLiveStrategyManager *liveStrategyManager;///直播播放策略
@property (nonatomic, strong) TUITXLivePlayer *currentLivePlayer; ///当前正在播放的播放器
- (void)setVideoWidget:(UIView *)view
                 model:(TUIPlayerLiveModel *)model;
- (void)prePlayWithModel:(TUIPlayerLiveModel *)model
                    type:(NSInteger)type;
- (void)playWithModel:(TUIPlayerLiveModel *)model
            lastModel:(TUIPlayerLiveModel *)lastModel
            nextModel:(TUIPlayerLiveModel *)nextModel
          videoWidget:(UIView *)videoWidget;
- (void)removeLivePlayerCache;
- (BOOL)removePlayerCache:(TUIPlayerLiveModel *)model;
- (BOOL)removePlayerCacheForPlayer:(TUITXLivePlayer *)player;
- (void)stopAllPlayer;
- (void)muteAllPlayer;
- (void)addDelegate:(id<TUIPlayerLiveManagerDelegate>)delegate;
- (void)removeDelegate:(id<TUIPlayerLiveManagerDelegate>)delegate;

- (BOOL)isPlaying;
- (void)pauseAudio;
- (void)resumeAudio;
- (void)pauseVideo;
- (void)resumeVideo;
@end

NS_ASSUME_NONNULL_END
