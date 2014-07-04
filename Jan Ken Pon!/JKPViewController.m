//
//  JKPViewController.m
//  Jan Ken Pon!
//
//  Created by David Zhang on 2014-07-04.
//  Copyright (c) 2014 EzGame. All rights reserved.
//

#import "JKPViewController.h"
#import "GameKitHelper.h"

typedef enum {
    ROCK = 1,
    PAPER = 2,
    SCISSORS = 3,
} JKPChoice;

typedef enum {
    WIN = 1,
    TIE = 0,
    LOSS = -1,
} JKPResult;

@interface JKPViewController ()
    <GameKitHelperDelegate> {
    int score;
}
@end

@implementation JKPViewController

- (void) viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerAuthenticated)
                                                 name:LocalPlayerIsAuthenticated object:nil];
    score = 0;
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) playerAuthenticated {
    [[GameKitHelper sharedGameKitHelper] findMatchWithViewController:self delegate:self];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}






#pragma mark - lol
- (IBAction) scissorsTouched:(id)sender {
    self.playerChoiceLabel.text = @"Scissors!";
    [self gameVersesRandomCPU:SCISSORS];
}

- (IBAction) paperTouched:(id)sender {
    self.playerChoiceLabel.text = @"Paper!";
    [self gameVersesRandomCPU:PAPER];
}

- (IBAction) rockTouched:(id)sender {
    self.playerChoiceLabel.text = @"Rock!";
    [self gameVersesRandomCPU:ROCK];
}





#pragma mark - Game Logic
- (void) gameVersesRandomCPU:(JKPChoice)playerChoice {
    // Random CPU, choses between 1-3 using rand()
    JKPChoice randomChoice = (int)rand() % 3 + 1;

    if ( randomChoice == ROCK )
        self.computerChoiceLabel.text = @"Rock!";
    else if ( randomChoice == PAPER )
        self.computerChoiceLabel.text = @"Paper!";
    else if ( randomChoice == SCISSORS )
        self.computerChoiceLabel.text = @"Scissors!";
    
    // Find results
    JKPResult result = [self A:playerChoice verseB:randomChoice];
    
    if ( result == WIN )
        self.view.backgroundColor = [UIColor greenColor];
    else if ( result == LOSS )
        self.view.backgroundColor = [UIColor redColor];
    else
        self.view.backgroundColor = [UIColor yellowColor];
    
    score += result;
    [self updateScore];
}

- (JKPResult) A:(JKPChoice)a verseB:(JKPChoice)b {
    NSAssert(!(a < 1 || a > 3), @"CHOICE A OUT OF BOUNDS [%d]", a);
    NSAssert(!(b < 1 || b > 3), @"CHOICE B OUT OF BOUNDS [%d]", b);
    
    // Tie state
    if ( a == b ) return TIE;
    
    // Win state
    if ( a == PAPER && b == ROCK )
        return WIN;
    else if ( a == ROCK && b == SCISSORS)
        return WIN;
    else if ( a == SCISSORS && b == PAPER)
        return WIN;
    
    // Loss state
    return LOSS;
}

- (void) updateScore {
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", score];
}






#pragma mark GameKitHelperDelegate
- (void) matchStarted {
    NSLog(@"Match started");
}

- (void) matchEnded {
    NSLog(@"Match ended");
}

- (void) match:(GKMatch *)match didReceiveData:(NSData *)data fromPlayer:(NSString *)playerID {
    NSLog(@"Received data");
}
@end
