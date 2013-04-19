//
//  OTHPlayer.h
//  Othello
//
//  Created by Ciel學長 on 24/2/13.
//  Copyright (c) 2013 Ciel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface OTHPlayer : NSObject

@property (nonatomic) BOOL startFirst;
@property (nonatomic) BOOL isComputer;
@property (nonatomic) int totalChessBlock;
@property (nonatomic) BOOL myTurn;
@property (nonatomic) NSString *name;
@property (nonatomic) OTHPlayer *oppPlayer;
@property (nonatomic) char chessMan;

@end
