//
//  OTHBoard.h
//  Othello
//
//  Created by Ciel學長 on 24/2/13.
//  Copyright (c) 2013 Ciel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "OTHBlock.h"

@interface OTHBoard : NSObject

-(OTHBoard*)initNewBoard;
-(int)getBlocksFaceWithX:(int)x andY:(int)y;
-(void)setBlocksFaceWithSign:(int)sign onX:(int)x andY:(int)y;
-(int)getTotalBlocks;
-(BOOL)checkAvailableWithSign:(int)sign;
-(BOOL)canPutThisSign:(int)sign onX:(int)x andY:(int)y;
-(BOOL)computerMovesWithSign:(int)sign;

@end
