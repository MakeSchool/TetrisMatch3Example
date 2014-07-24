//
//  Game.h
//  TetrisMatch3Example
//
//  Created by Benjamin Encz on 24/07/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

struct Index {
    NSInteger x;
    NSInteger y;
};
typedef struct Index Index;

@interface Game : NSObject

- (NSString *)gridRepresentation;
- (void)step;

@end
