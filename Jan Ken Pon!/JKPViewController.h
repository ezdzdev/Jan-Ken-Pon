//
//  JKPViewController.h
//  Jan Ken Pon!
//
//  Created by David Zhang on 2014-07-04.
//  Copyright (c) 2014 EzGame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultiplayerNetworking.h"
#import "SelectionQueueView.h"

@interface JKPViewController : UIViewController
<MultiplayerNetworkingProtocol>
- (IBAction)scissorsTouched:(id)sender;
- (IBAction)paperTouched:(id)sender;
- (IBAction)rockTouched:(id)sender;
- (IBAction)findMatch:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerChoiceLabel;
@property (weak, nonatomic) IBOutlet UILabel *computerChoiceLabel;
@property (weak, nonatomic) IBOutlet UIButton *scissorsButton;
@property (weak, nonatomic) IBOutlet UIButton *paperButton;
@property (weak, nonatomic) IBOutlet UIButton *rockButton;
@property (weak, nonatomic) IBOutlet UIButton *findMatchButton;
@property (weak, nonatomic) IBOutlet SelectionQueueView *selectionQueueView;
@end
