//
//  TUILayerHelper.m
//  ftuiplayer_kit
//
//  Created by Kongdywang on 2024/7/29.
//

#import "TUILayerHelper.h"
#import <stdatomic.h>
#import <libkern/OSAtomic.h>

static atomic_int atomicId = 0;
static id<FlutterBinaryMessenger> globalMessager;

@implementation TUILayerHelper

+ (int)pickLayerId {
    int pid = atomic_fetch_add(&atomicId, 1);
    return pid;
}

+ (void)setGlobalMessager:(id<FlutterBinaryMessenger>)messager {
    globalMessager = messager;
}


+ (nonnull id<FlutterBinaryMessenger>)getGlobalMessager {
    return globalMessager;
}

@end
