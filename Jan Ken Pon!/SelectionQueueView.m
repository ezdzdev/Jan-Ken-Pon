//
//  SelectionQueueView.m
//  Jan Ken Pon!
//
//  Created by David Zhang on 2014-07-06.
//  Copyright (c) 2014 EzGame. All rights reserved.
//

#import "SelectionQueueView.h"
@interface SelectionQueueView()
@property (nonatomic, strong) NSMutableArray *choiceQueue;
@end

@implementation SelectionQueueView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.choiceQueue = [NSMutableArray array];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.choiceQueue = [NSMutableArray array];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (UIImageView *) getImageFromChoice:(int)aChoice
{
    UIImage *img;
    if ( aChoice == 1 ) {
        img = [UIImage imageNamed:@"rock-small.png"];
    } else if ( aChoice == 2 ) {
        img = [UIImage imageNamed:@"paper-small.png"];
    } else if ( aChoice == 3 ) {
        img = [UIImage imageNamed:@"scissors-small.png"];
    }
    return [[UIImageView alloc] initWithImage:img];
}

- (void) enqueueSelection:(int)choice
{
    UIImageView *imgView = [self getImageFromChoice:choice];
    [self addSubview:imgView];
    // Enqueue
    [self.choiceQueue insertObject:imgView atIndex:0];
    
    // Render
    [self renderQueue];
    
    // If queue is full, delete last object
    if ( self.choiceQueue.count > 5 )
        [self.choiceQueue removeLastObject];
}

- (void) renderQueue
{
    NSLog(@"%@",self.choiceQueue);
    // If queue is full, fade out last element
    
    // move every frame in choiceQueue by 1 position
    for (int i = 0; i < self.choiceQueue.count; i++) {
        UIImageView *imgView = [self.choiceQueue objectAtIndex:i];
        imgView.frame = CGRectMake(45*i, 0, 45, 70);
    }
    
    // move new frame into last position
}
@end
