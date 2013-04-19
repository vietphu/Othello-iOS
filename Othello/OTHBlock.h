//
//  OTHBlock.h
//  Othello
//
//  Created by Ciel學長 on 24/2/13.
//  Copyright (c) 2013 Ciel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface OTHBlock : NSObject

@property (nonatomic) int position;
@property (nonatomic) int face;

-(OTHBlock*)initNewBlockWithX:(int)_x andY:(int)_y;

@end
