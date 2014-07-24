//
//  Brick.h
//  TetrisMatch3Example
//
//  Created by Benjamin Encz on 24/07/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Brick : NSObject

@property (readonly) NSArray *dots;
// first dot will be placed at index, second dot one row above, etc.
@property (nonatomic) Index index;

@end
