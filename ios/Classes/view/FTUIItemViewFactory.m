//
//  FTUIItemViewFactory.m
//  ftuiplayer_kit
//
//  Created by kongdywang on 21.8.24.
//

#import "FTUIItemViewFactory.h"
#import <Flutter/Flutter.h>

@interface FTUIItemViewFactory()

@property(nonatomic, strong) id<FlutterBinaryMessenger> binaryMessenger;
@property(nonatomic, strong) NSMutableDictionary* viewToPlatformViewMap;

@end

@implementation FTUIItemViewFactory

- (nonnull instancetype)initWithBinaryMessenger:(nonnull id<FlutterBinaryMessenger>)binaryMessenger {
    self = [super init];
    if (self) {
        self.viewToPlatformViewMap = @{}.mutableCopy;
        self.binaryMessenger = binaryMessenger;
    }
    return self;
}

- (NSObject<FlutterMessageCodec> *)createArgsCodec {
    return [FlutterStandardMessageCodec sharedInstance];
}

- (nonnull FTUIShortVideoItemView *)findViewById:(NSUInteger)viewId {
    return self.viewToPlatformViewMap[@(viewId)];
}

- (nonnull NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id _Nullable)args {
    FTUIShortVideoItemView *itemView = [[FTUIShortVideoItemView alloc] initWithFrame:frame viewIdentifier:viewId arguments:args messenger:self.binaryMessenger viewObserver:self];
    [self.viewToPlatformViewMap setObject:itemView forKey:@(viewId)];
    return itemView;
}

- (void)onDispose:(int64_t)viewId {
    [self.viewToPlatformViewMap removeObjectForKey:@(viewId)];
}


@end
