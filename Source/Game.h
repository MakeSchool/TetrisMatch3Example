//
//  Game.h
//  TetrisMatch3Example
//
//  Created by Benjamin Encz on 24/07/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject

- (NSString *)gridRepresentation;
- (void)step;

@end
