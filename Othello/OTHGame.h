//
//  OTHGame.h
//  Othello
//
//  Created by Ciel學長 on 24/2/13.
//  Copyright (c) 2013 Ciel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OTHPlayer.h"
#import "OTHHuman.h"
#import "OTHComputer.h"
#import "OTHBoard.h"
#import "Constants.h"


@interface OTHGame : NSObject

-(OTHGame*)initWithGameTypePlayerVSplayer;
-(OTHGame*)initWithGameTypePlayerVSComputerWithComputerStartsFirst:(BOOL)startFirst;

-(OTHPlayer*)getPlayerWithIndex:(int)i;
-(OTHBoard*)getBoard;
-(BOOL)checkAvailable:(OTHPlayer*)player;
-(BOOL)computerMovesWithCPUPlayer:(OTHPlayer*)player;
-(BOOL)playerMovesWithPlayer:(OTHPlayer*)player onX:(int)x andY:(int)y;
-(void)updatePlayersTotalBlocks;
-(int)checkGameStatus;

@end
