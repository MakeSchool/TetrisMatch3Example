//
//  Dot.h
//  TetrisMatch3Example
//
//  Created by Benjamin Encz on 24/07/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Brick;

@interface Dot : NSObject

@property Index index;
@property Index previousIndex;
@property (weak) Brick *brick;

@end
