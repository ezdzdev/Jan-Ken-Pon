//
//  MultiplayerNetworking.m
//  Jan Ken Pon!
//
//  Created by David Zhang on 2014-07-05.
//  Copyright (c) 2014 EzGame. All rights reserved.
//

#import "MultiplayerNetworking.h"

@implementation MultiplayerNetworking

#pragma mark - GameKitHelper delegate methods

- (void) matchStarted {
    NSLog(@"Match has started successfully");
}

- (void) matchEnded {
    NSLog(@"Match has ended");
    [_delegate matchEnded];
}

- (void) match:(GKMatch *)match
didReceiveData:(NSData *)data
    fromPlayer:(NSString *)playerID {
}
@end