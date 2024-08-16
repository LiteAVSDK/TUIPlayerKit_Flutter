// Copyright (c) 2023 Tencent. All rights reserved.

#import <Foundation/Foundation.h>
#import "TUITXVodPlayer.h"
#import "TUIPlayerVideoModel.h"
#import "TUIPlayerVodStrategyManager.h"
#import "TUIPlayerResumeManager.h"
NS_ASSUME_NONNULL_BEGIN
@protocol TUIPlayerVodManagerDelegate <NSObject>

- (void)currentPlayer:(TUITXVodPlayer *)player;
- (void)onPlayEvent:(TUITXVodPlayer *)player event:(int)EvtID withParam:(NSDictionary *)param ;
- (void)onNetStatus:(TUITXVodPlayer *)player withParam:(NSDictionary *)param ;
- (void)player:(TUITXVodPlayer *)player statusChanged:(TUITXVodPlayerStatus)status;
- (void)player:(TUITXVodPlayer *)player currentTime:(float)currentTime totalTime:(float)totalTime progress:(float)progress;
- (void)vodRenderModeChanged:(TUI_Enum_Type_RenderMode)renderMode;
@end
/// 播放器预加载缓存管理
@interface TUIPlayerVodManager : NSObject

///视频播放设置策略管理
@property (nonatomic, strong) TUIPlayerVodStrategyManager *strategyManager;
@property (nonatomic, strong, nullable) TUITXVodPlayer *currentVodPlayer; ///当前正在播放的播放器
@property (nonatomic, assign) BOOL loop;
- (void)addDelegate:(id<TUIPlayerVodManagerDelegate>)delegate;
- (void)removeDelegate:(id<TUIPlayerVodManagerDelegate>)delegate;
- (void)setVideoWidget:(UIView *)view
                 model:(TUIPlayerVideoModel *)model
    firstFrameCallBack:(void (^)(BOOL isFirstFrame))firstFrameCallBack;
- (void)playWithModel:(TUIPlayerVideoModel *)model
        resumeManager:(TUIPlayerResumeManager *)resumeManager
            lastModel:(TUIPlayerVideoModel *)lastModel
            nextModel:(TUIPlayerVideoModel *)nextModel;
/**
 * 预播放
 * @param model 视频模型
 */
- (void)prePlayWithModel:(TUIPlayerVideoModel *)model
                    type:(NSInteger)type;
- (void)firstPrePlayWithModel:(TUIPlayerVideoModel *)model
                    lastModel:(TUIPlayerVideoModel *)lastModel
                    nextModel:(TUIPlayerVideoModel *)nextModel;
/**
 * 移除播放器缓存
 */
- (void)removeAllPlayerCache;
- (BOOL)removePlayerCache:(TUIPlayerVideoModel *)model;
- (BOOL)removePlayerCacheForPlayer:(TUITXVodPlayer *)player;
/**
 * 销毁所有播放器
 */
- (void)stopAllPlayer;
- (void)resetAllPlayer;
- (void)muteAllPlayer;
- (void)pause;
- (void)resume;
@end

NS_ASSUME_NONNULL_END
