//
//  OTHComputer.m
//  Othello
//
//  Created by Ciel學長 on 24/2/13.
//  Copyright (c) 2013 Ciel. All rights reserved.
//

#import "OTHComputer.h"

@implementation OTHComputer

-(OTHComputer*) initWithStartFirstInPVPCase:(BOOL)_startFirst{
    self = [super init];
    if(self){
        self.startFirst = _startFirst;
        self.isComputer = TRUE;
        self.totalChessBlock = 2;
        self.myTurn = _startFirst;
        self.name = @"Deep Ciel";
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
