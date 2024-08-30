// Copyright (c) 2024 Tencent. All rights reserved.
// Autogenerated from Pigeon (v21.1.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import "FtxMessages.h"

#if TARGET_OS_OSX
#import <FlutterMacOS/FlutterMacOS.h>
#else
#import <Flutter/Flutter.h>
#endif

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSArray<id> *wrapResult(id result, FlutterError *error) {
  if (error) {
    return @[
      error.code ?: [NSNull null], error.message ?: [NSNull null], error.details ?: [NSNull null]
    ];
  }
  return @[ result ?: [NSNull null] ];
}

static FlutterError *createConnectionError(NSString *channelName) {
  return [FlutterError errorWithCode:@"channel-error" message:[NSString stringWithFormat:@"%@/%@/%@", @"Unable to establish connection on channel: '", channelName, @"'."] details:@""];
}

static id GetNullableObjectAtIndex(NSArray<id> *array, NSInteger key) {
  id result = array[key];
  return (result == [NSNull null]) ? nil : result;
}

@interface FTUIPlayerConfigMsg ()
+ (FTUIPlayerConfigMsg *)fromList:(NSArray<id> *)list;
+ (nullable FTUIPlayerConfigMsg *)nullableFromList:(NSArray<id> *)list;
- (NSArray<id> *)toList;
@end

@interface FTUIVodSourceMsg ()
+ (FTUIVodSourceMsg *)fromList:(NSArray<id> *)list;
+ (nullable FTUIVodSourceMsg *)nullableFromList:(NSArray<id> *)list;
- (NSArray<id> *)toList;
@end

@interface FTUIListVodSourceMsg ()
+ (FTUIListVodSourceMsg *)fromList:(NSArray<id> *)list;
+ (nullable FTUIListVodSourceMsg *)nullableFromList:(NSArray<id> *)list;
- (NSArray<id> *)toList;
@end

@interface FTUIPlayerVodStrategyMsg ()
+ (FTUIPlayerVodStrategyMsg *)fromList:(NSArray<id> *)list;
+ (nullable FTUIPlayerVodStrategyMsg *)nullableFromList:(NSArray<id> *)list;
- (NSArray<id> *)toList;
@end

@implementation FTUIPlayerConfigMsg
+ (instancetype)makeWithLicenseUrl:(nullable NSString *)licenseUrl
    licenseKey:(nullable NSString *)licenseKey
    enableLog:(nullable NSNumber *)enableLog {
  FTUIPlayerConfigMsg* pigeonResult = [[FTUIPlayerConfigMsg alloc] init];
  pigeonResult.licenseUrl = licenseUrl;
  pigeonResult.licenseKey = licenseKey;
  pigeonResult.enableLog = enableLog;
  return pigeonResult;
}
+ (FTUIPlayerConfigMsg *)fromList:(NSArray<id> *)list {
  FTUIPlayerConfigMsg *pigeonResult = [[FTUIPlayerConfigMsg alloc] init];
  pigeonResult.licenseUrl = GetNullableObjectAtIndex(list, 0);
  pigeonResult.licenseKey = GetNullableObjectAtIndex(list, 1);
  pigeonResult.enableLog = GetNullableObjectAtIndex(list, 2);
  return pigeonResult;
}
+ (nullable FTUIPlayerConfigMsg *)nullableFromList:(NSArray<id> *)list {
  return (list) ? [FTUIPlayerConfigMsg fromList:list] : nil;
}
- (NSArray<id> *)toList {
  return @[
    self.licenseUrl ?: [NSNull null],
    self.licenseKey ?: [NSNull null],
    self.enableLog ?: [NSNull null],
  ];
}
@end

@implementation FTUIVodSourceMsg
+ (instancetype)makeWithVideoURL:(nullable NSString *)videoURL
    coverPictureUrl:(nullable NSString *)coverPictureUrl
    appId:(nullable NSNumber *)appId
    fileId:(nullable NSString *)fileId
    pSign:(nullable NSString *)pSign
    isAutoPlay:(nullable NSNumber *)isAutoPlay
    extInfo:(nullable id )extInfo {
  FTUIVodSourceMsg* pigeonResult = [[FTUIVodSourceMsg alloc] init];
  pigeonResult.videoURL = videoURL;
  pigeonResult.coverPictureUrl = coverPictureUrl;
  pigeonResult.appId = appId;
  pigeonResult.fileId = fileId;
  pigeonResult.pSign = pSign;
  pigeonResult.isAutoPlay = isAutoPlay;
  pigeonResult.extInfo = extInfo;
  return pigeonResult;
}
+ (FTUIVodSourceMsg *)fromList:(NSArray<id> *)list {
  FTUIVodSourceMsg *pigeonResult = [[FTUIVodSourceMsg alloc] init];
  pigeonResult.videoURL = GetNullableObjectAtIndex(list, 0);
  pigeonResult.coverPictureUrl = GetNullableObjectAtIndex(list, 1);
  pigeonResult.appId = GetNullableObjectAtIndex(list, 2);
  pigeonResult.fileId = GetNullableObjectAtIndex(list, 3);
  pigeonResult.pSign = GetNullableObjectAtIndex(list, 4);
  pigeonResult.isAutoPlay = GetNullableObjectAtIndex(list, 5);
  pigeonResult.extInfo = GetNullableObjectAtIndex(list, 6);
  return pigeonResult;
}
+ (nullable FTUIVodSourceMsg *)nullableFromList:(NSArray<id> *)list {
  return (list) ? [FTUIVodSourceMsg fromList:list] : nil;
}
- (NSArray<id> *)toList {
  return @[
    self.videoURL ?: [NSNull null],
    self.coverPictureUrl ?: [NSNull null],
    self.appId ?: [NSNull null],
    self.fileId ?: [NSNull null],
    self.pSign ?: [NSNull null],
    self.isAutoPlay ?: [NSNull null],
    self.extInfo ?: [NSNull null],
  ];
}
@end

@implementation FTUIListVodSourceMsg
+ (instancetype)makeWithListMsg:(nullable NSArray<FTUIVodSourceMsg *> *)listMsg {
  FTUIListVodSourceMsg* pigeonResult = [[FTUIListVodSourceMsg alloc] init];
  pigeonResult.listMsg = listMsg;
  return pigeonResult;
}
+ (FTUIListVodSourceMsg *)fromList:(NSArray<id> *)list {
  FTUIListVodSourceMsg *pigeonResult = [[FTUIListVodSourceMsg alloc] init];
  pigeonResult.listMsg = GetNullableObjectAtIndex(list, 0);
  return pigeonResult;
}
+ (nullable FTUIListVodSourceMsg *)nullableFromList:(NSArray<id> *)list {
  return (list) ? [FTUIListVodSourceMsg fromList:list] : nil;
}
- (NSArray<id> *)toList {
  return @[
    self.listMsg ?: [NSNull null],
  ];
}
@end

@implementation FTUIPlayerVodStrategyMsg
+ (instancetype)makeWithPreloadCount:(nullable NSNumber *)preloadCount
    preDownloadSize:(nullable NSNumber *)preDownloadSize
    preloadBufferSizeInMB:(nullable NSNumber *)preloadBufferSizeInMB
    maxBufferSize:(nullable NSNumber *)maxBufferSize
    preferredResolution:(nullable NSNumber *)preferredResolution
    progressInterval:(nullable NSNumber *)progressInterval
    renderMode:(nullable NSNumber *)renderMode {
  FTUIPlayerVodStrategyMsg* pigeonResult = [[FTUIPlayerVodStrategyMsg alloc] init];
  pigeonResult.preloadCount = preloadCount;
  pigeonResult.preDownloadSize = preDownloadSize;
  pigeonResult.preloadBufferSizeInMB = preloadBufferSizeInMB;
  pigeonResult.maxBufferSize = maxBufferSize;
  pigeonResult.preferredResolution = preferredResolution;
  pigeonResult.progressInterval = progressInterval;
  pigeonResult.renderMode = renderMode;
  return pigeonResult;
}
+ (FTUIPlayerVodStrategyMsg *)fromList:(NSArray<id> *)list {
  FTUIPlayerVodStrategyMsg *pigeonResult = [[FTUIPlayerVodStrategyMsg alloc] init];
  pigeonResult.preloadCount = GetNullableObjectAtIndex(list, 0);
  pigeonResult.preDownloadSize = GetNullableObjectAtIndex(list, 1);
  pigeonResult.preloadBufferSizeInMB = GetNullableObjectAtIndex(list, 2);
  pigeonResult.maxBufferSize = GetNullableObjectAtIndex(list, 3);
  pigeonResult.preferredResolution = GetNullableObjectAtIndex(list, 4);
  pigeonResult.progressInterval = GetNullableObjectAtIndex(list, 5);
  pigeonResult.renderMode = GetNullableObjectAtIndex(list, 6);
  return pigeonResult;
}
+ (nullable FTUIPlayerVodStrategyMsg *)nullableFromList:(NSArray<id> *)list {
  return (list) ? [FTUIPlayerVodStrategyMsg fromList:list] : nil;
}
- (NSArray<id> *)toList {
  return @[
    self.preloadCount ?: [NSNull null],
    self.preDownloadSize ?: [NSNull null],
    self.preloadBufferSizeInMB ?: [NSNull null],
    self.maxBufferSize ?: [NSNull null],
    self.preferredResolution ?: [NSNull null],
    self.progressInterval ?: [NSNull null],
    self.renderMode ?: [NSNull null],
  ];
}
@end

@interface nullFtxMessagesPigeonCodecReader : FlutterStandardReader
@end
@implementation nullFtxMessagesPigeonCodecReader
- (nullable id)readValueOfType:(UInt8)type {
  switch (type) {
    case 129: 
      return [FTUIPlayerConfigMsg fromList:[self readValue]];
    case 130: 
      return [FTUIVodSourceMsg fromList:[self readValue]];
    case 131: 
      return [FTUIListVodSourceMsg fromList:[self readValue]];
    case 132: 
      return [FTUIPlayerVodStrategyMsg fromList:[self readValue]];
    default:
      return [super readValueOfType:type];
  }
}
@end

@interface nullFtxMessagesPigeonCodecWriter : FlutterStandardWriter
@end
@implementation nullFtxMessagesPigeonCodecWriter
- (void)writeValue:(id)value {
  if ([value isKindOfClass:[FTUIPlayerConfigMsg class]]) {
    [self writeByte:129];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[FTUIVodSourceMsg class]]) {
    [self writeByte:130];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[FTUIListVodSourceMsg class]]) {
    [self writeByte:131];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[FTUIPlayerVodStrategyMsg class]]) {
    [self writeByte:132];
    [self writeValue:[value toList]];
  } else {
    [super writeValue:value];
  }
}
@end

@interface nullFtxMessagesPigeonCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation nullFtxMessagesPigeonCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[nullFtxMessagesPigeonCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[nullFtxMessagesPigeonCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *nullGetFtxMessagesCodec(void) {
  static FlutterStandardMessageCodec *sSharedObject = nil;
  static dispatch_once_t sPred = 0;
  dispatch_once(&sPred, ^{
    nullFtxMessagesPigeonCodecReaderWriter *readerWriter = [[nullFtxMessagesPigeonCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}
void SetUpFTUIPlayerKitPluginAPI(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FTUIPlayerKitPluginAPI> *api) {
  SetUpFTUIPlayerKitPluginAPIWithSuffix(binaryMessenger, api, @"");
}

void SetUpFTUIPlayerKitPluginAPIWithSuffix(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FTUIPlayerKitPluginAPI> *api, NSString *messageChannelSuffix) {
  messageChannelSuffix = messageChannelSuffix.length > 0 ? [NSString stringWithFormat: @".%@", messageChannelSuffix] : @"";
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.ftuiplayer_kit.FTUIPlayerKitPluginAPI.setConfig", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:nullGetFtxMessagesCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(setConfigMsg:error:)], @"FTUIPlayerKitPluginAPI api (%@) doesn't respond to @selector(setConfigMsg:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray<id> *args = message;
        FTUIPlayerConfigMsg *arg_msg = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api setConfigMsg:arg_msg error:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.ftuiplayer_kit.FTUIPlayerKitPluginAPI.createShortEngine", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:nullGetFtxMessagesCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(createShortEngineWithError:)], @"FTUIPlayerKitPluginAPI api (%@) doesn't respond to @selector(createShortEngineWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        NSNumber *output = [api createShortEngineWithError:&error];
        callback(wrapResult(output, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
}
void SetUpFTUIPlayerShortAPI(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FTUIPlayerShortAPI> *api) {
  SetUpFTUIPlayerShortAPIWithSuffix(binaryMessenger, api, @"");
}

void SetUpFTUIPlayerShortAPIWithSuffix(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FTUIPlayerShortAPI> *api, NSString *messageChannelSuffix) {
  messageChannelSuffix = messageChannelSuffix.length > 0 ? [NSString stringWithFormat: @".%@", messageChannelSuffix] : @"";
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.ftuiplayer_kit.FTUIPlayerShortAPI.setModels", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:nullGetFtxMessagesCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(setModelsMsg:error:)], @"FTUIPlayerShortAPI api (%@) doesn't respond to @selector(setModelsMsg:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray<id> *args = message;
        FTUIListVodSourceMsg *arg_msg = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        NSNumber *output = [api setModelsMsg:arg_msg error:&error];
        callback(wrapResult(output, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.ftuiplayer_kit.FTUIPlayerShortAPI.appendModels", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:nullGetFtxMessagesCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(appendModelsMsg:error:)], @"FTUIPlayerShortAPI api (%@) doesn't respond to @selector(appendModelsMsg:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray<id> *args = message;
        FTUIListVodSourceMsg *arg_msg = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        NSNumber *output = [api appendModelsMsg:arg_msg error:&error];
        callback(wrapResult(output, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.ftuiplayer_kit.FTUIPlayerShortAPI.startCurrent", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:nullGetFtxMessagesCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(startCurrentWithError:)], @"FTUIPlayerShortAPI api (%@) doesn't respond to @selector(startCurrentWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        NSNumber *output = [api startCurrentWithError:&error];
        callback(wrapResult(output, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.ftuiplayer_kit.FTUIPlayerShortAPI.setVodStrategy", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:nullGetFtxMessagesCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(setVodStrategyMsg:error:)], @"FTUIPlayerShortAPI api (%@) doesn't respond to @selector(setVodStrategyMsg:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray<id> *args = message;
        FTUIPlayerVodStrategyMsg *arg_msg = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api setVodStrategyMsg:arg_msg error:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.ftuiplayer_kit.FTUIPlayerShortAPI.getCurrentModel", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:nullGetFtxMessagesCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getCurrentModelWithError:)], @"FTUIPlayerShortAPI api (%@) doesn't respond to @selector(getCurrentModelWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        FTUIVodSourceMsg *output = [api getCurrentModelWithError:&error];
        callback(wrapResult(output, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.ftuiplayer_kit.FTUIPlayerShortAPI.bindVideoView", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:nullGetFtxMessagesCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(bindVideoViewPageViewId:index:error:)], @"FTUIPlayerShortAPI api (%@) doesn't respond to @selector(bindVideoViewPageViewId:index:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray<id> *args = message;
        NSInteger arg_pageViewId = [GetNullableObjectAtIndex(args, 0) integerValue];
        NSInteger arg_index = [GetNullableObjectAtIndex(args, 1) integerValue];
        FlutterError *error;
        [api bindVideoViewPageViewId:arg_pageViewId index:arg_index error:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.ftuiplayer_kit.FTUIPlayerShortAPI.preBindVideo", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:nullGetFtxMessagesCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(preBindVideoPageViewId:index:error:)], @"FTUIPlayerShortAPI api (%@) doesn't respond to @selector(preBindVideoPageViewId:index:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray<id> *args = message;
        NSInteger arg_pageViewId = [GetNullableObjectAtIndex(args, 0) integerValue];
        NSInteger arg_index = [GetNullableObjectAtIndex(args, 1) integerValue];
        FlutterError *error;
        [api preBindVideoPageViewId:arg_pageViewId index:arg_index error:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.ftuiplayer_kit.FTUIPlayerShortAPI.release", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:nullGetFtxMessagesCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(releaseWithError:)], @"FTUIPlayerShortAPI api (%@) doesn't respond to @selector(releaseWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        [api releaseWithError:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
}
void SetUpFTUIVodPlayerAPI(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FTUIVodPlayerAPI> *api) {
  SetUpFTUIVodPlayerAPIWithSuffix(binaryMessenger, api, @"");
}

void SetUpFTUIVodPlayerAPIWithSuffix(id<FlutterBinaryMessenger> binaryMessenger, NSObject<FTUIVodPlayerAPI> *api, NSString *messageChannelSuffix) {
  messageChannelSuffix = messageChannelSuffix.length > 0 ? [NSString stringWithFormat: @".%@", messageChannelSuffix] : @"";
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.ftuiplayer_kit.FTUIVodPlayerAPI.startPlay", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:nullGetFtxMessagesCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(startPlayMsg:error:)], @"FTUIVodPlayerAPI api (%@) doesn't respond to @selector(startPlayMsg:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray<id> *args = message;
        FTUIVodSourceMsg *arg_msg = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api startPlayMsg:arg_msg error:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.ftuiplayer_kit.FTUIVodPlayerAPI.pause", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:nullGetFtxMessagesCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(pauseWithError:)], @"FTUIVodPlayerAPI api (%@) doesn't respond to @selector(pauseWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        [api pauseWithError:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.ftuiplayer_kit.FTUIVodPlayerAPI.resume", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:nullGetFtxMessagesCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(resumeWithError:)], @"FTUIVodPlayerAPI api (%@) doesn't respond to @selector(resumeWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        [api resumeWithError:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.ftuiplayer_kit.FTUIVodPlayerAPI.setRate", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:nullGetFtxMessagesCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(setRateRate:error:)], @"FTUIVodPlayerAPI api (%@) doesn't respond to @selector(setRateRate:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray<id> *args = message;
        double arg_rate = [GetNullableObjectAtIndex(args, 0) doubleValue];
        FlutterError *error;
        [api setRateRate:arg_rate error:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.ftuiplayer_kit.FTUIVodPlayerAPI.setMute", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:nullGetFtxMessagesCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(setMuteMute:error:)], @"FTUIVodPlayerAPI api (%@) doesn't respond to @selector(setMuteMute:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray<id> *args = message;
        BOOL arg_mute = [GetNullableObjectAtIndex(args, 0) boolValue];
        FlutterError *error;
        [api setMuteMute:arg_mute error:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.ftuiplayer_kit.FTUIVodPlayerAPI.seekTo", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:nullGetFtxMessagesCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(seekToTime:error:)], @"FTUIVodPlayerAPI api (%@) doesn't respond to @selector(seekToTime:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray<id> *args = message;
        double arg_time = [GetNullableObjectAtIndex(args, 0) doubleValue];
        FlutterError *error;
        [api seekToTime:arg_time error:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.ftuiplayer_kit.FTUIVodPlayerAPI.getDuration", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:nullGetFtxMessagesCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getDurationWithError:)], @"FTUIVodPlayerAPI api (%@) doesn't respond to @selector(getDurationWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        NSNumber *output = [api getDurationWithError:&error];
        callback(wrapResult(output, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.ftuiplayer_kit.FTUIVodPlayerAPI.getCurrentPlayTime", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:nullGetFtxMessagesCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(getCurrentPlayTimeWithError:)], @"FTUIVodPlayerAPI api (%@) doesn't respond to @selector(getCurrentPlayTimeWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        NSNumber *output = [api getCurrentPlayTimeWithError:&error];
        callback(wrapResult(output, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.ftuiplayer_kit.FTUIVodPlayerAPI.isPlaying", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:nullGetFtxMessagesCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(isPlayingWithError:)], @"FTUIVodPlayerAPI api (%@) doesn't respond to @selector(isPlayingWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        NSNumber *output = [api isPlayingWithError:&error];
        callback(wrapResult(output, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:[NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.ftuiplayer_kit.FTUIVodPlayerAPI.release", messageChannelSuffix]
        binaryMessenger:binaryMessenger
        codec:nullGetFtxMessagesCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(releaseWithError:)], @"FTUIVodPlayerAPI api (%@) doesn't respond to @selector(releaseWithError:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        [api releaseWithError:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
}
@interface FTUIVodPlayerFlutterAPI ()
@property(nonatomic, strong) NSObject<FlutterBinaryMessenger> *binaryMessenger;
@property(nonatomic, strong) NSString *messageChannelSuffix;
@end

@implementation FTUIVodPlayerFlutterAPI

- (instancetype)initWithBinaryMessenger:(NSObject<FlutterBinaryMessenger> *)binaryMessenger {
  return [self initWithBinaryMessenger:binaryMessenger messageChannelSuffix:@""];
}
- (instancetype)initWithBinaryMessenger:(NSObject<FlutterBinaryMessenger> *)binaryMessenger messageChannelSuffix:(nullable NSString*)messageChannelSuffix{
  self = [self init];
  if (self) {
    _binaryMessenger = binaryMessenger;
    _messageChannelSuffix = [messageChannelSuffix length] == 0 ? @"" : [NSString stringWithFormat: @".%@", messageChannelSuffix];
  }
  return self;
}
- (void)onPlayEventEvent:(NSDictionary<NSString *, id> *)arg_event completion:(void (^)(FlutterError *_Nullable))completion {
  NSString *channelName = [NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.ftuiplayer_kit.FTUIVodPlayerFlutterAPI.onPlayEvent", _messageChannelSuffix];
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:channelName
      binaryMessenger:self.binaryMessenger
      codec:nullGetFtxMessagesCodec()];
  [channel sendMessage:@[arg_event ?: [NSNull null]] reply:^(NSArray<id> *reply) {
    if (reply != nil) {
      if (reply.count > 1) {
        completion([FlutterError errorWithCode:reply[0] message:reply[1] details:reply[2]]);
      } else {
        completion(nil);
      }
    } else {
      completion(createConnectionError(channelName));
    } 
  }];
}
- (void)onBindVodControllerWithCompletion:(void (^)(FlutterError *_Nullable))completion {
  NSString *channelName = [NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.ftuiplayer_kit.FTUIVodPlayerFlutterAPI.onBindVodController", _messageChannelSuffix];
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:channelName
      binaryMessenger:self.binaryMessenger
      codec:nullGetFtxMessagesCodec()];
  [channel sendMessage:nil reply:^(NSArray<id> *reply) {
    if (reply != nil) {
      if (reply.count > 1) {
        completion([FlutterError errorWithCode:reply[0] message:reply[1] details:reply[2]]);
      } else {
        completion(nil);
      }
    } else {
      completion(createConnectionError(channelName));
    } 
  }];
}
- (void)onUnBindVodControllerWithCompletion:(void (^)(FlutterError *_Nullable))completion {
  NSString *channelName = [NSString stringWithFormat:@"%@%@", @"dev.flutter.pigeon.ftuiplayer_kit.FTUIVodPlayerFlutterAPI.onUnBindVodController", _messageChannelSuffix];
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:channelName
      binaryMessenger:self.binaryMessenger
      codec:nullGetFtxMessagesCodec()];
  [channel sendMessage:nil reply:^(NSArray<id> *reply) {
    if (reply != nil) {
      if (reply.count > 1) {
        completion([FlutterError errorWithCode:reply[0] message:reply[1] details:reply[2]]);
      } else {
        completion(nil);
      }
    } else {
      completion(createConnectionError(channelName));
    } 
  }];
}
@end

