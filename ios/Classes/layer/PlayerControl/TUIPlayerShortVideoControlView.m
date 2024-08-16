// Copyright (c) 2023 Tencent. All rights reserved.

#import "TUIPlayerShortVideoControlView.h"
#import "TUIShortVideoSliderView.h"
#import "TUIShortVideoTimeView.h"
#import "TUIPSDLoadingView.h"
#import "TUIPSVDResourceManager.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import "TUIPSVDCommonDefine.h"
#import "FtxMessages.h"
#import "FTUITransformer.h"
#import "TUIUtils.h"
#import "TUILayerHelper.h"
#import "FTUIConstant.h"
@interface TUIPlayerShortVideoControlView() <TUIPlayerShortVideoControl,
TUIShortVideoSliderViewDelegate, FTUIVodLayerAPI, FTUIVodPlayerAPI>
///当前播放器是否正在播放
@property (nonatomic, weak) TUITXVodPlayer *vodPlayer;
@property (nonatomic, weak) UIView *videoWidget;
@property (nonatomic, assign) CGRect videoLayerRect;
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, strong) TUIPSDLoadingView *loadingView;///loading
@property (nonatomic, strong) TUIShortVideoSliderView *sliderView;/// 滚动条控件
@property (nonatomic, assign) BOOL isSeeking;    ///是否正在滑动
@property (nonatomic, strong) TUIShortVideoTimeView *timeView;/// 视频播放时长和总时长控件
@property (nonatomic, strong) UIButton *playBtn;///播放按钮
@property (nonatomic, assign) float duration;///视频总时长
@property (nonatomic, strong) UIButton *commentButton;
@property (nonatomic, strong) UIButton *fangdaButton;
@property (nonatomic, strong) UIButton *resolutionButton;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) FTUIVodLayerFlutterAPI *layerFlutterAPI;
@property (nonatomic, assign) int layerId;
@end

@implementation TUIPlayerShortVideoControlView

@synthesize delegate;

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.isSeeking = NO;
        self.layerId = [TUILayerHelper pickLayerId];
        id<FlutterBinaryMessenger> binaryMessenger = [TUILayerHelper getGlobalMessager];
        NSString *suffixId = [NSString stringWithFormat:@"%d", self.layerId];
        self.layerFlutterAPI = [[FTUIVodLayerFlutterAPI alloc] initWithBinaryMessenger:binaryMessenger messageChannelSuffix:suffixId];
        SetUpFTUIVodLayerAPIWithSuffix(binaryMessenger, self, suffixId);
        SetUpFTUIVodPlayerAPIWithSuffix(binaryMessenger, self, suffixId);
        [self addSubview:self.sliderView];
        [self addSubview:self.timeView];
        [self addSubview:self.playBtn];
//        [self addSubview:self.commentButton];
//        [self addSubview:self.fangdaButton];
//        [self addSubview:self.resolutionButton];
        [self addSubview:self.stateLabel];
        [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(80);
        }];
        [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self).offset(-52);
            make.width.equalTo(self);
            make.height.mas_equalTo(80);
        }];
        [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.sliderView).offset(-20);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(30);
        }];
//        [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.width.height.equalTo(self.resolutionButton);
//            make.bottom.equalTo(self.fangdaButton.mas_top);
//        }];
//        [self.fangdaButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.width.height.equalTo(self.resolutionButton);
//            make.bottom.equalTo(self.resolutionButton.mas_top);
//        }];
//        [self.resolutionButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            //make.bottom.equalTo(self.mas_safeAreaLayoutGuideBottom).offset(-150);
//            make.bottom.equalTo(self.mas_bottom).offset(-200);
//            make.right.equalTo(self.mas_right).offset(-20);
//            make.width.equalTo(@(50));
//            make.height.equalTo(@(50));
//        }];
        [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(100);
            make.right.equalTo(self.mas_right).offset(-10);
            make.left.equalTo(self.mas_left).offset(10);
        }];
        self.stateLabel.hidden = YES;
 
        NSDictionary *dic = @{
            TMP_LAYER_EVENT_KEY : TMP_LAYER_EVENT_CREATED,
            TMP_LAYER_LAYER_ID_KEY : [NSString stringWithFormat:@"%d", self.layerId]
        };
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TUIPlayerShortVideoControlView_flutter_id" object:dic];
    }
    return self;
}

- (void)setDelegate:(id<TUIPlayerShortVideoControlDelegate>)delegate {
    self->delegate = delegate;
    if (delegate) {
        if ([delegate respondsToSelector:@selector(customCallbackEvent:)]) {
            NSDictionary *dic = @{
                TMP_LAYER_EVENT_KEY : TMP_LAYER_EVENT_CREATED,
                TMP_LAYER_LAYER_ID_KEY : [NSString stringWithFormat:@"%d", self.layerId]
            };
            [self.delegate customCallbackEvent:dic];
        }
    }
}

#pragma mark - lazyload
- (TUIPSDLoadingView *)loadingView {
    if (!_loadingView) {
        _loadingView = [[TUIPSDLoadingView alloc] init];
    }
    return _loadingView;
}
- (TUIShortVideoSliderView *)sliderView {
    if (!_sliderView) {
        _sliderView = [[TUIShortVideoSliderView alloc] init];
        _sliderView.backgroundColor = [UIColor clearColor];
        _sliderView.delegate = self;
    }
    return _sliderView;
}

- (TUIShortVideoTimeView *)timeView {
    if (!_timeView) {
        _timeView = [[TUIShortVideoTimeView alloc] init];
        _timeView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3/1.0];
        _timeView.layer.cornerRadius = 15;
        _timeView.layer.masksToBounds = YES;
    }
    return _timeView;
}
- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton new];
        [_playBtn setImage:[TUIPSVDResourceManager assetImageWithName:@"pause"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playVideo) forControlEvents:UIControlEventTouchUpInside];
        _playBtn.hidden = YES;
    }
    return _playBtn;
}
- (UIButton *)commentButton {
    if (!_commentButton) {
        _commentButton = [[UIButton alloc] init];
        _commentButton.backgroundColor = TUIPSVD_COLOR_BLACK;
        [_commentButton setImage:[TUIPSVDResourceManager assetImageWithName:@"tuipsvd_comment"] forState:UIControlStateNormal];
        [_commentButton addTarget:self action:@selector(commentButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentButton;
}
- (UIButton *)fangdaButton {
    if (!_fangdaButton) {
        _fangdaButton = [[UIButton alloc] init];
        _fangdaButton.backgroundColor = TUIPSVD_COLOR_BLACK;
        [_fangdaButton setImage:[TUIPSVDResourceManager assetImageWithName:@"tuipsvd_fullscreen"] forState:UIControlStateNormal];
        [_fangdaButton addTarget:self action:@selector(fangdaButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fangdaButton;
}
- (UIButton *)resolutionButton {
    if (!_resolutionButton) {
        _resolutionButton = [[UIButton alloc] init];
        _resolutionButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_resolutionButton setTitle:@"画质" forState:UIControlStateNormal];
        _resolutionButton.backgroundColor = TUIPSVD_COLOR_BLACK;
        [_resolutionButton addTarget:self action:@selector(resolutionButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resolutionButton;
}
- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.backgroundColor = TUIPSVD_COLOR_BLACK;
        _stateLabel.textColor = [UIColor whiteColor];
        _stateLabel.numberOfLines = 0;
    }
    return _stateLabel;
}
#pragma mark - Button Action
- (void)playVideo {
    if (self.isPlaying == YES) {
        if (self.delegate &&
            [self.delegate respondsToSelector:@selector(pause)]) {
            [self.delegate pause];
        }
    } else {
        if (self.delegate &&
            [self.delegate respondsToSelector:@selector(resume)]) {
            [self.delegate resume];
        }
    }
}
#pragma mark - TUIShortVideoSliderViewDelegate
- (void)onSeek:(nonnull UISlider *)slider {
    int progress = slider.value + 0.5;
    int duration = slider.maximumValue + 0.5;
    [_timeView setShortVideoTimeLabel:[self detailCurrentTime:progress totalTime:duration]];
    [_sliderView.slider setValue:slider.value];
}

- (void)onSeekBegin:(nonnull UISlider *)slider {
    _isSeeking = YES;
}

- (void)onSeekEnd:(nonnull UISlider *)slider {
    _isSeeking = NO;
    float sliderValue;
    if (slider.value >= slider.maximumValue) {
        sliderValue = slider.maximumValue;
    } else {
        sliderValue = slider.value;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(seekToTime:)]) {
        [self.delegate seekToTime:sliderValue];
    }
}

- (void)onSeekOutSide:(nonnull UISlider *)slider {
    _isSeeking = NO;
}

- (void)resolutionButtonClick {
}
- (void)commentButtonClick {
}
- (void)fangdaButtonClick {
}
#pragma mark - TUIPSVDCommentViewControllerDelegate
- (void)CommentViewControllerDismissed {
    self.hidden = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(resetVideoWeigetContainer)]) {
        [self.delegate resetVideoWeigetContainer];
    }
    self.hidden = NO;
}
#pragma mark - TUIPSDFullScreenViewControllerDelegate
- (void)viewControllerDismissed {
    if (self.delegate && [self.delegate respondsToSelector:@selector(resetVideoWeigetContainer)]) {
        [self.delegate resetVideoWeigetContainer];
    }
    [self.layerFlutterAPI onUnBindVodLayerWithCompletion:^(FlutterError * _Nullable error) {
        NSLog(@"layer return error:%@", error);
    }];
    self.hidden = NO;
}
#pragma mark - TUIPlayerShortVideoControl
- (void)setModel:(TUIPlayerVideoModel *)model {
    self.stateLabel.text = @"";
    [self.sliderView setProgress:0];
}
- (void)getVideoWidget:(UIView *)view {
    self.videoWidget = view;
}
- (void)getVideoLayerRect:(CGRect)rect {
    self.videoLayerRect = rect;
}
- (void)showLoadingView {
    [self.loadingView startLoading];
}

- (void)hiddenLoadingView {
    [self.loadingView stopLoading];
}

- (void)setCurrentTime:(float)time {
    NSString *timeLabelStr = [self detailCurrentTime:time totalTime:self.duration];
    [self.timeView setShortVideoTimeLabel:timeLabelStr];
}

- (void)setDurationTime:(float)time {
    self.duration = time;
    NSString *timeLabelStr = [self detailCurrentTime:0 totalTime:time];
    [self.timeView setShortVideoTimeLabel:timeLabelStr];
}

- (void)setProgress:(float)progress {
    if (_isSeeking) {
        return;
    }
    [self.sliderView setProgress:progress];
}

- (void)showSlider {
    self.sliderView.hidden = NO;
}
- (void)hideSlider {
    self.sliderView.hidden = YES;
}

- (void)hideCenterView {
    self.playBtn.hidden = YES;
}

- (void)showCenterView {
    self.playBtn.hidden = NO;
}
- (void)reloadControlData {
    
}
- (void)getPlayer:(TUITXVodPlayer *)player {
    self.vodPlayer = player;
    [self.layerFlutterAPI onBindVodLayerWithCompletion:^(FlutterError * _Nullable error) {
       NSLog(@"layer return error:%@", error);
    }];
}
- (void)onPlayEvent:(TUITXVodPlayer *)player
              event:(int)EvtID
          withParam:(NSDictionary *)param {
    ///Get the real-time status of the player
    if (EvtID == 2005) {
        
    } else {
        self.stateLabel.text = [NSString stringWithFormat:@"EvtID:%d param:%@",EvtID,param.description];
    }
    NSDictionary *params = [TUIUtils getParamsWithEvent:EvtID withParams:param];
    [self.layerFlutterAPI onPlayEventEvent:params completion:^(FlutterError * _Nullable error) {
        NSLog(@"layer return error:%@", error);
    }];
    NSLog(@"");
}
#pragma mark - touch began
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.isPlaying == YES) {
        if (self.delegate &&
            [self.delegate respondsToSelector:@selector(pause)]) {
            [self.delegate pause];
        }
    } else {
        if (self.delegate &&
            [self.delegate respondsToSelector:@selector(resume)]) {
            [self.delegate resume];
        }
    }
}

#pragma mark - private Methods
- (NSString *)detailCurrentTime:(float)currentTime totalTime:(float)totalTime {
    
    /// 错误时间戳设置
    if (currentTime <= 0) {
        return [NSString stringWithFormat:@"00:00/%02d:%02d",(int)(totalTime / 60), ((int)totalTime % 60)];
    }
    /// 返回正常时间戳设置
    return  [NSString stringWithFormat:@"%02d:%02d/%02d:%02d", (int)(currentTime / 60), (int)((int)currentTime % 60), ((int)totalTime / 60), ((int)totalTime % 60)];
}

- (BOOL)isPlaying {
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(isPlaying)]) {
        return [self.delegate isPlaying];
    }
    return NO;
}
- (nullable FTUIVodSourceMsg *)getModelWithError:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    FTUIVodSourceMsg *msg;
    if ([self.model isKindOfClass:TUIPlayerVideoModel.class]) {
        msg = [FTUITransformer transToMsgFromVodSource:[self.model asVodModel]];
    } else {
        msg = [[FTUIVodSourceMsg alloc] init];
    }
    return msg;
}

- (nullable NSNumber *)getCurrentPlayTimeWithError:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    if (self.vodPlayer) {
        return [NSNumber numberWithFloat:self.vodPlayer.currentPlaybackTime];
    }
    return @(0);
}

- (nullable NSNumber *)getDurationWithError:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    if (self.vodPlayer) {
        return [NSNumber numberWithFloat:self.vodPlayer.duration];
    }
    return @(0);
}

- (void)pauseWithError:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    if (self.vodPlayer) {
        return [self.vodPlayer pausePlay];
    }
}

- (void)resumeWithError:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    if (self.vodPlayer) {
        return [self.vodPlayer resumePlay];
    }
}

- (void)seekToTime:(double)time error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    if (self.vodPlayer) {
        return [self.vodPlayer seekToTime:time];
    }
}

- (void)setMuteMute:(BOOL)mute error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    if (self.vodPlayer) {
        return [self.vodPlayer setMute:mute];
    }
}

- (void)setRateRate:(double)rate error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    if (self.vodPlayer) {
        return [self.vodPlayer setRate:rate];
    }
}

- (void)startPlayMsg:(nonnull FTUIVodSourceMsg *)msg error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    if (self.vodPlayer) {
        TUIPlayerVideoModel *vodModel = [FTUITransformer transToVodSourceFromMsg:msg];
        [self.vodPlayer startVodPlayWithModel:vodModel];
    }
}

@end
