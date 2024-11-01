//
//  FTUIVodController.m
//  ftuiplayer_kit
//
//  Created by kongdywang on 27.8.24.
//

#import "FTUIVodController.h"
#import "FTUITransformer.h"
#import "FTUIConstant.h"

@interface FTUIVodController()

@property(nonatomic, strong)FTUIVodPlayerFlutterAPI *flutterApi;
@property(nonatomic, strong)TUITXVodPlayer* curPlayer;
@property(nonatomic, strong)id<FTUIPlatformViewObserver> platformObserver;
@property(nonatomic, assign)int64_t viewId;

@end

@implementation FTUIVodController

- (instancetype)initWithApi:(FTUIVodPlayerFlutterAPI *)mApi
               viewObserver:(id<FTUIPlatformViewObserver>)platformObserver
             viewIdentifier:(int64_t)viewId{
    self = [super init];
    if (self) {
        self.flutterApi = mApi;
        self.platformObserver = platformObserver;
        self.viewId = viewId;
    }
    return self;
}

- (void)onBindController:(TUITXVodPlayer *)player {
    self.curPlayer = player;
    if (self.flutterApi) {
        [self.flutterApi onBindVodControllerWithCompletion:^(FlutterError * _Nullable error) {
            TUILOGE(@"onBindController return error:%@", error);
        }];
    }
}


- (void)onUnBindController {
    self.curPlayer = nil;
    if (self.flutterApi) {
        [self.flutterApi onUnBindVodControllerWithCompletion:^(FlutterError * _Nullable error) {
            TUILOGE(@"onUnBindController return error:%@", error);
        }];
    }
}


- (BOOL)cellIsPlaying {
    return NO;
}

- (void)cellPause { 
    
}

- (void)cellResume { 
    
}

- (void)didSeekToTime:(float)playTime { 
    
}

- (void)vodCustomCallbackEvent:(nonnull id)info { 
    
}

- (nullable NSNumber *)getCurrentPlayTimeWithError:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    if (self.curPlayer) {
        return @(self.curPlayer.currentPlaybackTime);
    }
    return @(0.0);
}

- (nullable NSNumber *)getDurationWithError:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    if (self.curPlayer) {
        return @(self.curPlayer.duration);
    }
    return @(0.0);
}

- (nullable NSNumber *)isPlayingWithError:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    if (self.curPlayer) {
        return @(self.curPlayer.isPlaying);
    }
    return @(0);
}

- (void)pauseWithError:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    if (self.curPlayer) {
        [self.curPlayer pausePlay];
    }
}

- (void)resumeWithError:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    if (self.curPlayer) {
        [self.curPlayer resumePlay];
    }
}

- (void)seekToTime:(double)time error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    if (self.curPlayer) {
        [self.curPlayer seekToTime:time];
    }
}

- (void)setMuteMute:(BOOL)mute error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    if (self.curPlayer) {
        [self.curPlayer setMute:mute];
    }
}

- (void)setRateRate:(double)rate error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    if (self.curPlayer) {
        [self.curPlayer seekToTime:rate];
    }
}

- (void)startPlayMsg:(nonnull FTUIVodSourceMsg *)msg error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    if (self.curPlayer) {
        TUIPlayerVideoModel* model = [FTUITransformer transToVodSourceFromMsg:msg];
        [self.curPlayer startVodPlayWithModel:model];
    }
}

- (void)releaseWithError:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    [self.platformObserver onDispose:self.viewId];
}

- (void)setStringOptionValue:(nonnull NSString *)value key:(nonnull id)key error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    // ios need string value
    NSString *str = [NSString stringWithFormat:@"%@", key];
    [self.curPlayer setExtentOptionInfo:@{value : str}];
}


- (void)currentPlayer:(nonnull TUITXVodPlayer *)player {
}

- (void)onNetStatus:(nonnull TUITXVodPlayer *)player withParam:(nonnull NSDictionary *)param { 
    
}

- (void)onPlayEvent:(nonnull TUITXVodPlayer *)player event:(int)EvtID withParam:(nonnull NSDictionary *)param { 
    if (self.flutterApi) {
        NSMutableDictionary *callbackParams = @{
            TMP_LAYER_EVENT_KEY : @(EvtID)
        }.mutableCopy;
        [callbackParams addEntriesFromDictionary:param];
        [self.flutterApi onPlayEventEvent:callbackParams completion:^(FlutterError* _Nullable error) {
            TUILOGE(@"onPlayEventEvent return error:%@", error);
        }];
        if (EvtID == PLAY_EVT_RCV_FIRST_I_FRAME) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
                NSDictionary *firstParams = @{
                    TMP_LAYER_EVENT_KEY : @(PLAY_EVT_FIRST_FRAME_RENDERED)
                };
                [self.flutterApi onPlayEventEvent:firstParams completion:^(FlutterError* _Nullable error) {
                    TUILOGE(@"onPlayEventEvent return error:%@", error);
                }];
            });
        }
    }
}

- (void)player:(nonnull TUITXVodPlayer *)player currentTime:(float)currentTime totalTime:(float)totalTime progress:(float)progress { 
    
}

- (void)player:(nonnull TUITXVodPlayer *)player statusChanged:(TUITXVodPlayerStatus)status { 
    
}

- (void)vodRenderModeChanged:(TUI_Enum_Type_RenderMode)renderMode { 
    
}

@end
