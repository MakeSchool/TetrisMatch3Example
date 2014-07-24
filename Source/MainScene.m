//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "Game.h"

@implementation MainScene {
    Game *_game;
    CCLabelTTF *_gameStateLabel;
}

- (void)didLoadFromCCB {
    [self schedule:@selector(gameStep) interval:0.5f];
    
     _game = [[Game alloc] init];
    
    // add gesture recognizers to detect swipes
    UISwipeGestureRecognizer *swipeLeft= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeft)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [[[CCDirector sharedDirector]view]addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRight)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [[[CCDirector sharedDirector]view]addGestureRecognizer:swipeRight];
}

- (void)swipeLeft {
    CCLOG(@"Swipe left");
}

- (void)swipeRight {
    CCLOG(@"Swipe right");
}

- (void)gameStep {
    [_game step];
    _gameStateLabel.string = [_game gridRepresentation];
}

@end
