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
}

- (void)didLoadFromCCB {
    [self schedule:@selector(gameStep) interval:1.f];
    
     _game = [[Game alloc] init];
}

- (void)gameStep {
    [_game step];
    [_game gridRepresentation];
}

@end
