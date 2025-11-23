//
//  FtuiplayerKitPlugin.m
//  ftuiplayer_kit
//
//  Created by Kongdywang on 2024/7/25.
//

#import "FtuiplayerKitPlugin.h"
#import "FtxShortVideoMessages.h"
#import <TUIPlayerCore/TUIPlayerCore-umbrella.h>
#import "FTUIConstant.h"
#import "FTUIShortEngine.h"

@interface FtuiplayerKitPlugin() <FlutterPlugin>

@property (nonatomic, strong) NSObject<FlutterPluginRegistrar>* registrar;
@property (nonatomic, strong) FTUIShortEngine *shortManager;
@property (nonatomic, strong) FTUIItemViewFactory* viewFactory;

@end

@implementation FtuiplayerKitPlugin

FtuiplayerKitPlugin* instance;

+ (void)registerWithRegistrar:(nonnull NSObject<FlutterPluginRegistrar> *)registrar {
    FTUIItemViewFactory *viewFactory = [[FTUIItemViewFactory alloc] initWithBinaryMessenger:[registrar messenger]];
    [registrar registerViewFactory:viewFactory withId:TUI_SHORT_VIEW_ITEM_ID];
    instance = [[FtuiplayerKitPlugin alloc] initWithRegistrar:registrar viewFactory:viewFactory];
}

- (void)detachFromEngineForRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    
}

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar
                      viewFactory:(FTUIItemViewFactory*)viewFactory {
    self = [super init];
    if (self) {
        [registrar publish:self];
        _registrar = registrar;
        self.shortManager = [[FTUIShortEngine alloc] initWithViewFactory:viewFactory messenger:[registrar messenger]];
        SetUpFTUIPlayerKitPluginAPI([registrar messenger], self.shortManager);
    }
    return self;
}


@end
