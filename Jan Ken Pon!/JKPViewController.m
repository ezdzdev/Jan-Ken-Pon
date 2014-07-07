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

typedef enum {
    RANDOM = 1,
} JKPAI;

@interface JKPViewController () {
    int _score;
    BOOL _isAttacker;
    MultiplayerNetworking *_networkingEngine;
}
@property (nonatomic, strong) NSMutableArray *attackingArray;
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
    _score = 0;
    _isAttacker = NO;
    self.attackingArray = [NSMutableArray arrayWithCapacity:5];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) playerAuthenticated {
    self.findMatchButton.hidden = NO;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}






#pragma mark - lol
- (IBAction) scissorsTouched:(id)sender {
    self.playerChoiceLabel.text = @"Scissors!";
    [self game:SCISSORS];
}

- (IBAction) paperTouched:(id)sender {
    self.playerChoiceLabel.text = @"Paper!";
    [self game:PAPER];
}

- (IBAction) rockTouched:(id)sender {
    self.playerChoiceLabel.text = @"Rock!";
    [self game:ROCK];
}

- (IBAction)findMatch:(id)sender {
    _networkingEngine = [[MultiplayerNetworking alloc] init];
    _networkingEngine.delegate = self;
    
    [[GameKitHelper sharedGameKitHelper] findMatchWithViewController:self delegate:_networkingEngine];
}





#pragma mark - Game Logic
// TODO: Separate opponent AI with ours
// TODO: Then we can implement an overarching function for turn logic
- (void) gameAttackMode:(JKPChoice)playerChoice {
    // Create attacking array
    [self.attackingArray addObject:[NSNumber numberWithInt:playerChoice]];
    
    // Opponent turn
    if ( self.attackingArray.count == 5 ) {
        // let AI defend
        for ( int i = 0; i < 5; i++ )
            [self.attackingArray addObject:[NSNumber numberWithInt:[self getChoice:RANDOM]]];
    }
}

- (void) gameDefendMode:(JKPChoice)playerChoice {
    // Let AI create attacking array
    // Opponent turn
    if ( self.attackingArray.count == 0 ) {
        for ( int i = 0; i < 5; i++ ) {
            [self.attackingArray addObject:[NSNumber numberWithInt:[self getChoice:RANDOM]]];
        }
    }
    
    // Let player defend
    _score += [self A:playerChoice verseB:(JKPChoice)[self.attackingArray lastObject]];
    [self.attackingArray removeLastObject];
}

- (void) game:(JKPChoice)playerChoice {
    [self.selectionQueueView enqueueSelection:playerChoice];
}

- (void) gameVersesRandomCPU:(JKPChoice)playerChoice {
    // Random CPU, choses between 1-3 using rand()
    JKPChoice choice = [self getChoice:RANDOM];

    if ( choice == ROCK )
        self.computerChoiceLabel.text = @"Rock!";
    else if ( choice == PAPER )
        self.computerChoiceLabel.text = @"Paper!";
    else if ( choice == SCISSORS )
        self.computerChoiceLabel.text = @"Scissors!";
    
    // Find results
    JKPResult result = [self A:playerChoice verseB:choice];
    
    if ( result == WIN )
        self.view.backgroundColor = [UIColor greenColor];
    else if ( result == LOSS )
        self.view.backgroundColor = [UIColor redColor];
    else
        self.view.backgroundColor = [UIColor yellowColor];
    
    _score += result;
    [self updateScore];
}

- (JKPChoice) getChoice:(JKPAI)ai {
    JKPChoice choice;
    if (ai == RANDOM) {
        choice = rand() % 3 + 1;
    }
    NSAssert(!(choice < 1 || choice > 3), @"CHOICE OUT OF BOUNDS [%d]", choice);
    return choice;
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
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", _score];
}






#pragma mark - MultiplayerNetworkingDelegate
- (void) matchEnded {
    NSLog(@"Match ended");
}
@end
