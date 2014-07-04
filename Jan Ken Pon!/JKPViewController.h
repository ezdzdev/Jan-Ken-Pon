//
//  JKPViewController.h
//  Jan Ken Pon!
//
//  Created by David Zhang on 2014-07-04.
//  Copyright (c) 2014 EzGame. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKPViewController : UIViewController
- (IBAction)scissorsTouched:(id)sender;
- (IBAction)paperTouched:(id)sender;
- (IBAction)rockTouched:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerChoiceLabel;
@property (weak, nonatomic) IBOutlet UILabel *computerChoiceLabel;
@property (weak, nonatomic) IBOutlet UIButton *scissorsButton;
@property (weak, nonatomic) IBOutlet UIButton *paperButton;
@property (weak, nonatomic) IBOutlet UIButton *rockButton;
@end
