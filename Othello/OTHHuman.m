//
//  OTHHuman.m
//  Othello
//
//  Created by Ciel學長 on 24/2/13.
//  Copyright (c) 2013 Ciel. All rights reserved.
//

#import "OTHHuman.h"

@implementation OTHHuman

-(OTHHuman*) initWithStartFirstInPVPCase:(BOOL)_startFirst{
    self = [super init];
    if(self){
        self.startFirst = _startFirst;
        self.isComputer = FALSE;
        self.totalChessBlock = 2;
        self.myTurn = _startFirst;
        if(_startFirst){
            self.name = @"Player 1";
            self.chessMan = firstSign;
        }
        else{
            self.name = @"Player 2";
            self.chessMan = secondSign;
        }
    }
    return self;
}

-(OTHHuman*) initWithStartFirstInPVECase:(BOOL)_startFirst{
    self = [super init];
    if(self){
        self.startFirst = _startFirst;
        self.isComputer = FALSE;
        self.totalChessBlock = 2;
        self.myTurn = _startFirst;
        self.name = @"Player";
        if(_startFirst){
            self.chessMan = firstSign;
        }
        else{
            self.chessMan = secondSign;
        }
    }
    return self;
}

@end
