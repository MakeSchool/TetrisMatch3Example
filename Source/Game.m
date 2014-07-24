//
//  Game.m
//  TetrisMatch3Example
//
//  Created by Benjamin Encz on 24/07/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Game.h"
#import "Dot.h"

static NSInteger const COLUMNS = 5;
static NSInteger const ROWS = 10;

@implementation Game {
    // column; row
    NSMutableArray *_grid;
    Dot *_currentDot;
}

- (id)init {
    self = [super init];
    
    if (self) {
        
        _grid = [NSMutableArray array];
        
        for (int i = 0; i < COLUMNS; i++) {
            _grid[i] = [NSMutableArray array];
            
            for (int j = 0; j < ROWS; j++) {
                _grid[i][j] = [NSNull null];
            }
        }
    }
    
    return self;
}

- (void)step {
    if (!_currentDot) {
        [self spawnDot];
    } else {
        Index currentIndex = {_currentDot.indexX, _currentDot.indexY};
        Index newIndex = {_currentDot.indexX, _currentDot.indexY-1};
        BOOL movePossible = [self moveFromIndex:currentIndex toIndex:newIndex];
        if (!movePossible) {
            _currentDot = nil;
        }
    }
}

- (BOOL)moveFromIndex:(Index)fromIndex toIndex:(Index)toIndex {
    if (toIndex.y < 0 || _grid[toIndex.x][toIndex.y] != [NSNull null]) {
        return NO;
    } else {
        Dot *dot = _grid[fromIndex.x][fromIndex.y];
        _grid[fromIndex.x][fromIndex.y] = [NSNull null];
        _grid[toIndex.x][toIndex.y] = dot;
        dot.indexX = toIndex.x;
        dot.indexY = toIndex.y;
        
        return YES;
    }
}

- (void)spawnDot {
    NSInteger randomColumn = arc4random_uniform(COLUMNS);
    NSInteger spawnX = randomColumn;
    NSInteger spawnY = ROWS-1;
    _currentDot = [[Dot alloc] init];
    _grid[spawnX][spawnY] = _currentDot;
    _currentDot.indexX = spawnX;
    _currentDot.indexY = spawnY;
}


- (NSString *)gridRepresentation {
    NSMutableString *gridString = [NSMutableString string];
    
    for (int i = ROWS-1; i >= 0; i--) {
        NSMutableString *rowString = [NSMutableString string];
        
        for (int j = 0; j < COLUMNS; j++) {
            id dot = _grid[j][i];
            
            if ([dot isKindOfClass:[Dot class]]) {
                [rowString appendString:@"1"];
            } else {
                [rowString appendString:@"0"];
            }
        }
        
        [rowString appendString:@"\n"];
        [gridString appendString:rowString];
    }
    
    CCLOG(@"%@", gridString);
    return gridString;
}

@end
