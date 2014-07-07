//
//  MultiplayerNetworking.h
//  Jan Ken Pon!
//
//  Created by David Zhang on 2014-07-05.
//  Copyright (c) 2014 EzGame. All rights reserved.
//

#import "GameKitHelper.h"

@protocol MultiplayerNetworkingProtocol <NSObject>
- (void) matchEnded;
@end

@interface MultiplayerNetworking : NSObject<GameKitHelperDelegate>
@property (nonatomic, assign) id<MultiplayerNetworkingProtocol> delegate;
@end
