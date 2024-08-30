//
//  FTUIPlatformViewObserver.h
//  ftuiplayer_kit
//
//  Created by kongdywang on 21.8.24.
//

#import <Foundation/Foundation.h>

#ifndef FTUIPlatformViewObserver_h
#define FTUIPlatformViewObserver_h

@protocol FTUIPlatformViewObserver <NSObject>

- (void)onDispose:(int64_t)viewId;

@end

#endif /* FTUIPlatformViewObserver_h */
