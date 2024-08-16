// Copyright (c) 2023 Tencent. All rights reserved.

#import <Foundation/Foundation.h>
#import "TUIPlayerCoreLiteAVSDKHeader.h"
#import "TUIPlyerCoreSDKTypeDef.h"

///播放器策略模型
@interface TUIPlayerVodStrategyModel : NSObject

@property (nonatomic, assign) NSInteger mPreloadConcurrentCount;    /// 缓存个数，默认3
@property (nonatomic, assign) float mPreloadBufferSizeInMB; /// 预播放大小，单位MB，默认0.5MB
@property (nonatomic, assign) long mPreferredResolution;  /// 偏好分辨率，默认720 * 1280
@property (nonatomic, assign) long mProgressInterval;     /// 进度条回调间隔时长，单位毫秒，默认500ms
@property (nonatomic, assign) TUI_Enum_Type_RenderMode mRenderMode; ///画布填充样式，默认RENDER_MODE_FILL_SCREEN
@property (nonatomic, strong) NSDictionary *mExtInfoMap;   ///额外参数，预留
@property (nonatomic, assign) BOOL enableAutoBitrate; /// 是否开启自适应码率，默认NO
/// 设置媒资类型
///【重要】若自适应码率播放，暂须指定具体类型，如自适应播放HLS直播资源，须传入TUI_MEDIA_TYPE_HLS_LIVE类型
@property (nonatomic, assign) TUI_Enum_MediaType mediaType;
@property (nonatomic, assign) long switchResolution;///主动切换的全局分辨率
///最大预加载大小，单位 MB ，默认10MB，此设置会影响playableDuration，设置越大，提前缓存的越多
@property(nonatomic, assign) float maxBufferSize;
@property (nonatomic, assign) TUI_Enum_Type_ResumModel mResumeModel; ///续播模式，默认TUI_RESUM_MODEL_NONE
@property (nonatomic, assign) float preDownloadSize;/// 预下载大小，单位MB，默认1MB
///是否精确 seek，默认 YES。开启精确后 seek，seek 的时间平均多出 200ms
@property (nonatomic, assign) BOOL enableAccurateSeek;
/// 音量均衡 .响度范围：-70～0(LUFS)。此配置需要LiteAVSDK 11.7 及以上版本支持。
/// 以下几种常量供参考使用
/// 关：AUDIO_NORMALIZATION_OFF (TXVodPlayConfig.h)
/// 开（标准响度）：AUDIO_NORMALIZATION_STANDARD (TXVodPlayConfig.h)
/// 开（低响度）：AUDIO_NORMALIZATION_LOW (TXVodPlayConfig.h)
/// 开（高响度）：AUDIO_NORMALIZATION_HIGH (TXVodPlayConfig.h)
/// 默认值为AUDIO_NORMALIZATION_OFF。
@property (nonatomic, assign) float audioNormalization;
@property (nonatomic, assign) BOOL isLastPrePlay; ///是否保留上一个预播放，默认NO
/// 超分类型，默认0
/// 注意：开启超分需要先集成超分插件，否则无效
@property (nonatomic, assign) TUI_Enume_Type_SuperResolution superResolutionType;
@property (nonatomic, strong) TXPlayerSubtitleRenderModel *subtitleRenderModel; /// 字幕样式
@property (nonatomic, strong) NSDictionary *headers; /// 自定义 HTTP Headers

@end

