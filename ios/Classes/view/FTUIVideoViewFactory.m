//
//  FTUIVideoViewFactory.m
//  ftuiplayer_kit
//
//  Created by Kongdywang on 2024/7/25.
//

#import "FTUIVideoViewFactory.h"
#import "FTUIShortVideoView.h"

@interface FTUIVideoViewFactory()

@property(nonatomic, strong) id<FlutterBinaryMessenger> binaryMessenger;

@end

@implementation FTUIVideoViewFactory

- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger {
    self = [super init];
    if (self) {
        self.binaryMessenger = binaryMessenger;
    }
    return self;
}

- (NSObject<FlutterMessageCodec> *)createArgsCodec {
    return [FlutterStandardMessageCodec sharedInstance];
}


- (nonnull NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame
                                            viewIdentifier:(int64_t)viewId
                                                 arguments:(id _Nullable)args {
    FTUIShortVideoView *shortVideoView = [[FTUIShortVideoView alloc] initWithFrame:frame
                                                                    viewIdentifier:viewId
                                                                         arguments:args
                                                                         messenger:self.binaryMessenger];
    return shortVideoView;
}

@end
