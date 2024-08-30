//
//  FTUIShortEngineObserver.h
//  ftuiplayer_kit
//
//  Created by kongdywang on 21.8.24.
//

#import <Foundation/Foundation.h>

#ifndef FTUIShortEngineObserver_h
#define FTUIShortEngineObserver_h

@protocol FTUIShortEngineObserver <NSObject>

- (void)onRelease:(NSUInteger)controllerId;

@end


#endif /* FTUIShortEngineObserver_h */
