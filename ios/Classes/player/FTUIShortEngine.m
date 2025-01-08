//
//  FTUIShortEngine.m
//  ftuiplayer_kit
//
//  Created by kongdywang on 21.8.24.
//

#import "FTUIShortEngine.h"
#import <TUIPlayerCore/TUIPlayerCore-umbrella.h>
#import <stdatomic.h>
#import <libkern/OSAtomic.h>
#import "FTUIShortController.h"
#import "MonetHelper.h"

static atomic_int atomicId = 0;

@interface FTUIShortEngine()

@property(nonatomic, strong)id<FlutterBinaryMessenger> binaryMessenger;
@property(nonatomic, strong)FTUIItemViewFactory* viewFactory;
@property(nonatomic, strong)NSMutableDictionary* controllers;

@end

@implementation FTUIShortEngine

- (nonnull instancetype)initWithViewFactory:(nonnull FTUIItemViewFactory *)viewFactory messenger:(nonnull id<FlutterBinaryMessenger>)binaryMessenger {
    self = [super init];
    if (self) {
        self.viewFactory = viewFactory;
        self.binaryMessenger = binaryMessenger;
        self.controllers = @{}.mutableCopy;
    }
    return self;
}

- (void)onRelease:(NSUInteger)controllerId {
    if ([self.controllers objectForKey:@(controllerId)]) {
        [self.controllers removeObjectForKey:@(controllerId)];
    } else {
        TUILOGW(@"controllerId %lu is miss, did it add to engine?", (unsigned long)controllerId);
    }
}

#pragma mark FTUIPlayerKitPluginAPI

- (nullable NSNumber *)createShortEngineWithError:(FlutterError * _Nullable __autoreleasing * _Nonnull)error {
    // 添加移除日志
    int controllerId = atomic_fetch_add(&atomicId, 1);
    FTUIShortController *controller = [[FTUIShortController alloc] initWithViewFactory:self.viewFactory controllerId:controllerId messenger:self.binaryMessenger observer:self];
    [self.controllers setObject:controller forKey:@(controllerId)];
    return @(controllerId);
}

- (void)setConfigMsg:(nonnull FTUIPlayerConfigMsg *)msg error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    TUIPlayerConfig *config = [TUIPlayerConfig new];
    config.enableLog = [msg.enableLog boolValue];
    [[TUIPlayerCore shareInstance] setPlayerConfig:config];
    [TXLiveBase setLicenceURL:msg.licenseUrl key:msg.licenseKey];
}

- (void)setMonetAppInfoAppId:(NSInteger)appId authId:(NSInteger)authId srAlgorithmType:(NSInteger)srAlgorithmType error:(FlutterError * _Nullable __autoreleasing *)error {
    NSString *appIdStr = [NSString stringWithFormat:@"%@", @(appId)];
    [MonetHelper setAppInfo:appIdStr authId:(int)authId algorithmType:(int)srAlgorithmType];
}

@end
