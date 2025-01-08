// Copyright (c) 2024 Tencent. All rights reserved.

#import "MonetHelper.h"

@implementation MonetHelper

+ (void)setAppInfo:(nonnull NSString *)appIdStr authId:(int)authId algorithmType:(int)srAlgorithmType {
    // 使用反射获取 TXCMonetPluginManager 类
    Class tpaClass = NSClassFromString(@"TXCMonetPluginManager");
    
    // 确保类存在
    if (!tpaClass) {
        NSLog(@"Class TXCMonetPluginManager not found.");
        return;
    }
    
    // 获取共享实例的方法
    SEL sharedManagerSelector = NSSelectorFromString(@"sharedManager");
    id manager = [tpaClass performSelector:sharedManagerSelector];
    
    // 确保获取到的实例不为 nil
    if (!manager) {
        NSLog(@"Failed to get sharedManager instance.");
        return;
    }
    
    // 获取 setAppInfo:authId:algorithmType: 方法选择器
    SEL setAppInfoSelector = NSSelectorFromString(@"setAppInfo:authId:algorithmType:");
    
    // 创建 NSInvocation 对象
    NSMethodSignature *signature = [manager methodSignatureForSelector:setAppInfoSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    
    // 设置目标和选择器
    [invocation setTarget:manager];
    [invocation setSelector:setAppInfoSelector];
    
    // 设置参数
    [invocation setArgument:&appIdStr atIndex:2]; // 第一个参数索引为 2
    [invocation setArgument:&authId atIndex:3];   // 第二个参数索引为 3
    [invocation setArgument:&srAlgorithmType atIndex:4]; // 第三个参数索引为 4
    
    // 调用方法
    [invocation invoke];
}

@end
