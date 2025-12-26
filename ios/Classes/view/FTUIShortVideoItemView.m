//
//  FTUIShortVideoItemView.m
//  ftuiplayer_kit
//
//  Created by kongdywang on 21.8.24.
//

#import "FTUIShortVideoItemView.h"
#import <TUIPlayerShortVideo/TUIPlayerShortVideo-umbrella.h>
#import "FTUIMessages.h"

@interface FTUIShortVideoItemView()

@property(nonatomic, strong) TUIShortVideoItemView* itemView;
@property(nonatomic, strong) FTUIVodController* vodController;

@end

@implementation FTUIShortVideoItemView

- (nonnull instancetype)initWithFrame:(CGRect)frame
                       viewIdentifier:(int64_t)viewId
                            arguments:(id _Nullable)args
                            messenger:(nonnull id<FlutterBinaryMessenger>)binaryMessenger
                         viewObserver:(id<FTUIPlatformViewObserver>)platformObserver{
    self = [super init];
    if (self) {
        UITableView* tableView = [[UITableView alloc] initWithFrame:frame];
        TUIPlayerShortVideoUIManager* uiManager = [[TUIPlayerShortVideoUIManager alloc] init];
//        self.itemView = [TUIShortVideoItemView cellWithtableView:tableView uiManager:uiManager];
        self.itemView = [TUIShortVideoItemView tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:viewId inSection:0] uiManager:uiManager];
        [self.itemView hiddenCoverImage:YES];
        [self.itemView hideCenterView];
        [self.itemView stopLoading];
        FTUIVodPlayerFlutterAPI* flutterApi = [[FTUIVodPlayerFlutterAPI alloc] initWithBinaryMessenger:binaryMessenger messageChannelSuffix:[NSString stringWithFormat:@"%lld",viewId]];
        self.vodController = [[FTUIVodController alloc] initWithApi:flutterApi
                                                       viewObserver:platformObserver
                                                     viewIdentifier:viewId];
        SetUpFTUIVodPlayerAPIWithSuffix(binaryMessenger, self.vodController, [NSString stringWithFormat:@"%lld",viewId]);
    }
    return self;
}

- (FTUIVodController *)getVodController {
    return self.vodController;
}

- (nonnull UIView *)view { 
    return self.itemView;
}

@end
