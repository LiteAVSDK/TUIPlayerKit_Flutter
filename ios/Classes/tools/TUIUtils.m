//
//  TUIUtils.m
//  ftuiplayer_kit
//
//  Created by Kongdywang on 2024/7/29.
//

#import "TUIUtils.h"

@implementation TUIUtils

+ (NSDictionary *)getParamsWithEvent:(int)EvtID withParams:(NSDictionary *)params
{
    NSMutableDictionary<NSString*,NSObject*> *dict = [NSMutableDictionary dictionaryWithObject:@(EvtID) forKey:@"event"];
    if (params != nil && params.count != 0) {
        [dict addEntriesFromDictionary:params];
    }
    return dict;
}

@end
