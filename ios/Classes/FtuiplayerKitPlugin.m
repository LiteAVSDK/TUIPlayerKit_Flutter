//
//  FtuiplayerKitPlugin.m
//  ftuiplayer_kit
//
//  Created by Kongdywang on 2024/7/25.
//

#import "FtuiplayerKitPlugin.h"
#import "FtxMessages.h"
#import <TUIPlayerCore/TUIPlayerCore-umbrella.h>
#import "FTUIConstant.h"
#import "FTUIVideoViewFactory.h"
#import "TUILayerHelper.h"

@interface FtuiplayerKitPlugin() <FlutterPlugin, FTUIPlayerKitPluginAPI>

@property (nonatomic, strong) NSObject<FlutterPluginRegistrar>* registrar;

@end

@implementation FtuiplayerKitPlugin

FtuiplayerKitPlugin* instance;

+ (void)registerWithRegistrar:(nonnull NSObject<FlutterPluginRegistrar> *)registrar {
    instance = [[FtuiplayerKitPlugin alloc] initWithRegistrar:registrar];
    [TUILayerHelper setGlobalMessager:[registrar messenger]];
    [registrar registerViewFactory:[[FTUIVideoViewFactory alloc] initWithBinaryMessenger:[registrar messenger]] withId:TUI_SHORT_VIEW_ID];
}

- (void)detachFromEngineForRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    [TUILayerHelper setGlobalMessager:nil];
}

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    self = [super init];
    if (self) {
        [registrar publish:self];
        _registrar = registrar;
        SetUpFTUIPlayerKitPluginAPI([registrar messenger], self);
    }
    return self;
}


- (void)setConfigMsg:(nonnull FTUIPlayerConfigMsg *)msg error:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    TUIPlayerConfig *config = [[TUIPlayerConfig alloc] init];
    config.enableLog = msg.enableLog;
    [[TUIPlayerCore shareInstance] setPlayerConfig:config];
    [TXLiveBase setLicenceURL:msg.licenseUrl key:msg.licenseKey];
}

@end
