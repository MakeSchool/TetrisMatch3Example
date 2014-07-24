//
//  Game.m
//  TetrisMatch3Example
//
//  Created by Benjamin Encz on 24/07/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Game.h"
#import "Dot.h"
#import "Brick.h"

static NSInteger const COLUMNS = 5;
static NSInteger const ROWS = 10;
static NSInteger const BRICK_LENGTH = 3;

@implementation Game {
    // column; row
    NSMutableArray *_grid;
    Brick *_currentBrick;
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
    if (!_currentBrick) {
        [self spawnBrick];
    } else {
        Index currentIndex = {_currentBrick.index.x, _currentBrick.index.y};
        Index newIndex = {_currentBrick.index.x, _currentBrick.index.y-1};
        BOOL movePossible = [self moveFromIndex:currentIndex toIndex:newIndex];
        if (!movePossible) {
            _currentBrick = nil;
        }
    }
}

- (BOOL)moveFromIndex:(Index)fromIndex toIndex:(Index)toIndex {
    // check if move is possible
    BOOL movePossible = YES;
    BOOL reachedGround = NO;
    BOOL targetIndexOccupied = NO;
    // set the index on the brick to update the dots of the brick
    [_currentBrick savePreviousPositionsOfDots];
    _currentBrick.index = toIndex;
    
    for (Dot *dot in _currentBrick.dots) {
        reachedGround = dot.index.y == -1;
        if (reachedGround) {
            break;
        }
        
        targetIndexOccupied = _grid[dot.index.x][dot.index.y] != [NSNull null];
        
        // check if the target index is occupied by a dot that belongs to this block
        if (targetIndexOccupied) {
            Dot *occuppingDot = _grid[dot.index.x][dot.index.y];
            
            if (occuppingDot.brick == dot.brick) {
                targetIndexOccupied = NO;
            }
        }
        
        if (targetIndexOccupied) {
            break;
        }
    }
    
    movePossible = (!targetIndexOccupied && !reachedGround);
    
    if (!movePossible) {
        // reset the position of the current brick because we can not move it
        _currentBrick.index = fromIndex;
        return NO;
    }
    
    // if move was possible, actually move the dots of the brick in the grid
    for (Dot *dot in _currentBrick.dots) {
        _grid[dot.previousIndex.x][dot.previousIndex.y] = [NSNull null];
        _grid[dot.index.x][dot.index.y] = dot;
        dot.previousIndex = dot.index;
    }

    return YES;
}

- (void)spawnBrick {
    NSInteger randomColumn = arc4random_uniform(COLUMNS);
    NSInteger spawnY = ROWS-BRICK_LENGTH;
    Index spawnIndex = {randomColumn, spawnY};

    _currentBrick = [[Brick alloc] init];
    _currentBrick.index = spawnIndex;

    for (Dot *dot in _currentBrick.dots) {
        _grid[dot.index.x][dot.index.y] = dot;
    }
}


- (NSString *)gridRepresentation {
    NSMutableString *gridString = [NSMutableString string];
    
    for (int i = ROWS-1; i >= 0; i--) {
        NSMutableString *rowString = [NSMutableString string];
        
        for (int j = 0; j < COLUMNS; j++) {
            id dot = _grid[j][i];
            
            if ([dot isKindOfClass:[Dot class]]) {
                [rowString appendString:@"X"];
            } else {
                [rowString appendString:@"0"];
            }
        }
        
        [rowString appendString:@"\n"];
        [gridString appendString:rowString];
    }
    
    return gridString;
}

@end
