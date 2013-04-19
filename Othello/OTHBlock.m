//
//  OTHBlock.m
//  Othello
//
//  Created by Ciel學長 on 24/2/13.
//  Copyright (c) 2013 Ciel. All rights reserved.
//

#import "OTHBlock.h"

@implementation OTHBlock

@synthesize face;
@synthesize position;

-(OTHBlock*)initNewBlockWithX:(int)_x andY:(int)_y{
    self = [super init];
    if(self){
        self.position = _x*10 + _y;
        self.face = nilSign;
    }
    return self;
}

@end
