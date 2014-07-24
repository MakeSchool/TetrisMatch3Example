//
//  Brick.m
//  TetrisMatch3Example
//
//  Created by Benjamin Encz on 24/07/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Brick.h"
#import "Dot.h"

@implementation Brick

- (id)init {
    self = [super init];
    
    if (self) {
        // create three dots per default
        Dot *dot1 = [[Dot alloc] init];
        dot1.index = (Index) {0,0};
        dot1.brick = self;
        
        Dot *dot2 = [[Dot alloc] init];
        dot2.index = (Index) {0,1};
        dot2.brick= self;

        
        Dot *dot3 = [[Dot alloc] init];
        dot3.index = (Index) {0,2};
        dot3.brick = self;

        _dots = @[dot1, dot2, dot3];
    }
    
    return self;
}

- (void)setIndex:(Index)index {
    _index = index;
    
    // calculate indexes of dots based on index of brick
    for (int i = 0; i < [_dots count]; i++) {
        Dot *currentDot = _dots[i];
        // first dot is position of brick, second dot is one row above position of brick, etc.
        currentDot.index = (Index){self.index.x, self.index.y + i};
    }
}

- (void)savePreviousPositionsOfDots {
    for (Dot *dot in _dots) {
        dot.previousIndex = dot.index;
    }
}

@end
