//
//  FTUIShortVideoView.m
//  ftuiplayer_kit
//
//  Created by Kongdywang on 2024/7/25.
//

#import "FTUIShortVideoView.h"
#import <TUIPlayerShortVideo/TUIPlayerShortVideo-umbrella.h>
#import "FtxMessages.h"
#import "FTUITransformer.h"
#import "TUIPlayerShortVideoControlView.h"
#import "FTUIConstant.h"

@interface FTUIShortVideoView() <FTUIPlayerViewAPI, TUIShortVideoViewDelegate, TUIShortVideoViewCustomCallbackDelegate>

@property(nonatomic, strong) TUIShortVideoView *shortVideoView;
@property(nonatomic, strong) FTUIPlayerViewFlutterAPI *flutterApi;

@end

@implementation FTUIShortVideoView

- (instancetype)initWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args messenger:(id<FlutterBinaryMessenger>)binaryMessenger {
        self = [super init];
        if (self) {
            self.flutterApi = [[FTUIPlayerViewFlutterAPI alloc] initWithBinaryMessenger:binaryMessenger messageChannelSuffix:[NSString stringWithFormat:@"%lld", viewId]];
            SetUpFTUIPlayerViewAPIWithSuffix(binaryMessenger, self, [NSString stringWithFormat:@"%lld", viewId]);
            TUIPlayerShortVideoUIManager *uiManager = [[TUIPlayerShortVideoUIManager alloc] init];
            
            [uiManager setControlViewClass: TUIPlayerShortVideoControlView.class];
            
            self.shortVideoView = [[TUIShortVideoView alloc] initWithUIManager:uiManager];
            self.shortVideoView.frame = frame;
            self.shortVideoView.customCallbackDelegate = self;
            self.shortVideoView.delegate = self;
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TUIPlayerShortVideoControlView_flutter_id:) name:@"TUIPlayerShortVideoControlView_flutter_id" object:nil];
        }
        return self;
}

- (nonnull UIView *)view { 
    return self.shortVideoView;
}


#pragma mark - FTUIPlayerViewAPI

- (void)appendModelsMsg:(nonnull FTUIListVodSourceMsg *)msg error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    [self.shortVideoView appendShortVideoModels:[FTUITransformer transToListVodSourceFromMsg:msg]];
}

- (nullable NSNumber *)getCurrentDataCountWithError:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    NSInteger count = [[self.shortVideoView getDataManager] getCurrentDataCount];
    return [NSNumber numberWithInteger:count];
}

- (void)setModelsMsg:(nonnull FTUIListVodSourceMsg *)msg error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    [self.shortVideoView setShortVideoModels:[FTUITransformer transToListVodSourceFromMsg:msg]];
}

- (void)setVodStrategyMsg:(nonnull FTUIPlayerVodStrategyMsg *)msg error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    [[self.shortVideoView getVodStrategyManager] setVideoStrategy:[FTUITransformer transToVodStrategyFromMsg:msg]];
}

- (void)releaseWithError:(FlutterError * _Nullable __autoreleasing *)error {
    [self.shortVideoView destoryPlayer];
}

- (nullable FTUIVodSourceMsg *)getCurrentModelWithError:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    TUIPlayerDataModel *model = [[self.shortVideoView getDataManager] getCurrentModel];
    if ([model isKindOfClass:[TUIPlayerVideoModel class]]) {
        FTUIVodSourceMsg *msg = [FTUITransformer transToMsgFromVodSource:[model asVodModel]];
        return msg;
    }
    return [[FTUIVodSourceMsg alloc] init];
}


- (void)pauseWithError:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    [self.shortVideoView pause];
}


- (void)resumeWithError:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    [self.shortVideoView resume];
}


- (void)startPlayIndexIndex:(NSInteger)index smoothScroll:(BOOL)smoothScroll error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    [self.shortVideoView didScrollToCellWithIndex:index animated:smoothScroll];
}


#pragma mark - TUIShortVideoViewDelegate

- (void)currentVideo:(nonnull TUIPlayerVideoModel *)videoModel currentTime:(float)currentTime totalTime:(float)totalTime progress:(float)progress {
    
}

- (void)currentVideo:(nonnull TUIPlayerVideoModel *)videoModel statusChanged:(TUITXVodPlayerStatus)status {
    
}

- (void)onNetStatus:(nonnull TUIPlayerVideoModel *)videoModel withParam:(nonnull NSDictionary *)param { 
    
}

- (void)onReachLast { 
    
}

- (void)scrollToVideoIndex:(NSInteger)videoIndex videoModel:(nonnull TUIPlayerDataModel *)videoModel { 
    FTUIPageChangedMsg *msg = [[FTUIPageChangedMsg alloc] init];
    msg.index = [NSNumber numberWithInteger:videoIndex];
    FTUIVodSourceMsg *sourceMsg = [FTUITransformer transToMsgFromVodSource:[videoModel asVodModel]];
    msg.source = sourceMsg;
    [self.flutterApi onPageChangedMsg:msg completion:^(FlutterError * _Nullable error) {
        NSLog(@"onPageChangedMsg return error:%@", error);
    }];
}

- (void)scrollViewDidEndDeceleratingIndex:(NSInteger)videoIndex videoModel:(nonnull TUIPlayerDataModel *)videoModel { 
    
}

- (void)scrollViewDidScrollContentOffset:(CGPoint)contentOffset { 
    
}

- (void)videoPreLoadStateWithModel:(nonnull TUIPlayerVideoModel *)videoModel { 
    
}

- (void)customCallbackEvent:(nonnull id)info {
    NSDictionary *dic = info;
    NSString *event = dic[TMP_LAYER_EVENT_KEY];
    if ([TMP_LAYER_EVENT_CREATED isEqualToString:event]) {
        NSString *layerIdStr = dic[TMP_LAYER_LAYER_ID_KEY];
        int layerId = [layerIdStr intValue];
        [self.flutterApi onCreateVodLayerLayerId:layerId completion:^(FlutterError * _Nullable error) {
            NSLog(@"onCreateVodLayerLayerId return error:%@", error);
        }];
    }
}

-(void)TUIPlayerShortVideoControlView_flutter_id:(NSNotification *)noti {
    NSDictionary *dic = noti.object;
    NSString *event = dic[TMP_LAYER_EVENT_KEY];
    if ([TMP_LAYER_EVENT_CREATED isEqualToString:event]) {
        NSString *layerIdStr = dic[TMP_LAYER_LAYER_ID_KEY];
        __block NSInteger layerId = [layerIdStr integerValue];
        // 将延迟时间转换为 dispatch_time_t 类型
        dispatch_time_t delayDispatchTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(500 * NSEC_PER_MSEC));

        // 使用 dispatch_after 在主线程上延迟执行代码块
        dispatch_after(delayDispatchTime, dispatch_get_main_queue(), ^{
            [self.flutterApi onCreateVodLayerLayerId:layerId completion:^(FlutterError * _Nullable error) {
                NSLog(@"onCreateVodLayerLayerId return error:%@", error);
            }];
        });
    }
}
@end
