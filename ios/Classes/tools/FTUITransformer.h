//
//  FTUITransformer.h
//  ftuiplayer_kit
//
//  Created by Kongdywang on 2024/7/25.
//

#import <Foundation/Foundation.h>
#import "FtxMessages.h"
#import <TUIPlayerShortVideo/TUIPlayerShortVideo-umbrella.h>

NS_ASSUME_NONNULL_BEGIN

@interface FTUITransformer : NSObject

+ (FTUIVodSourceMsg*)transToMsgFromVodSource:(TUIPlayerVideoModel*)source;

+ (TUIPlayerVideoModel *)transToVodSourceFromMsg:(FTUIVodSourceMsg *)itemMsg;

+ (NSArray*)transToListVodSourceFromMsg:(FTUIListVodSourceMsg*)msg;

+ (TUIPlayerVodStrategyModel*)transToVodStrategyFromMsg:(FTUIPlayerVodStrategyMsg*)msg;

@end

NS_ASSUME_NONNULL_END
