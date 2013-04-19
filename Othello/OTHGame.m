//
//  OTHGame.m
//  Othello
//
//  Created by Ciel學長 on 24/2/13.
//  Copyright (c) 2013 Ciel. All rights reserved.
//

#import "OTHGame.h"

@implementation OTHGame

OTHPlayer *player[2];
OTHBoard *board;
int kindOfGame;
int status = GameOver;

-(OTHGame*)initWithGameTypePlayerVSplayer{
    self = [super init];
    if(self){
        kindOfGame = PlayerVSPlayer;
        status = GameStart;
        //init two players
        player[0] = [[OTHHuman alloc]initWithStartFirstInPVPCase:true];
        player[1] = [[OTHHuman alloc]initWithStartFirstInPVPCase:false];
        player[0].myTurn = true;
        player[1].myTurn = false;
        player[0].oppPlayer = player[1];
        player[1].oppPlayer = player[0];
        NSLog(@"Load two human player.");
        NSLog(@"player0 : %@, oppPlayer: %@.",player[0].name,player[0].oppPlayer.name);
        NSLog(@"player1 : %@, oppPlayer: %@.",player[1].name,player[1].oppPlayer.name);
        
        //init game data;
        [self initGameData];
    }
    return self;
}

-(OTHGame*)initWithGameTypePlayerVSComputerWithComputerStartsFirst:(BOOL)startFirst{
    self = [super init];
    if(self){
        kindOfGame = PlayerVSComputer;
        status = GameStart;
        //init a player and a computer player
        if(startFirst){
            player[0] = [[OTHComputer alloc] initWithStartFirstInPVPCase:true];
            player[1] = [[OTHHuman alloc]initWithStartFirstInPVECase:false];
            player[0].oppPlayer = player[1];
            player[1].oppPlayer = player[0];
            player[0].myTurn = true;
            player[1].myTurn = false;
            NSLog(@"Load one human player and Deep Ciel with computer start First.");
            NSLog(@"player0 : %@, oppPlayer: %@",player[0].name,player[0].oppPlayer.name);
            NSLog(@"player1 : %@, oppPlayer: %@",player[1].name,player[1].oppPlayer.name);
        }
        else{
            player[0] = [[OTHHuman alloc]initWithStartFirstInPVECase:true];
            player[1] = [[OTHComputer alloc] initWithStartFirstInPVPCase:false];
            player[0].oppPlayer = player[1];
            player[1].oppPlayer = player[0];
            player[0].myTurn = true;
            player[1].myTurn = false;
            NSLog(@"Load one human player and Deep Ciel with player start First.");
            NSLog(@"player0 : %@, oppPlayer: %@",player[0].name,player[0].oppPlayer.name);
            NSLog(@"player1 : %@, oppPlayer: %@",player[1].name,player[1].oppPlayer.name);
        }
        
        //init game data;
        [self initGameData];
    }
    return self;
}

-(void)initGameData{
    status = GameStart;
    board = [[OTHBoard alloc] initNewBoard];
    NSLog(@"Load board successfully!");
}

-(OTHPlayer*)getPlayerWithIndex:(int)i{
    return player[i];
}

-(OTHBoard*)getBoard{
    return board;
}

-(BOOL)checkAvailable:(OTHPlayer*)player{
    return [board checkAvailableWithSign:player.chessMan];
}

-(BOOL)playerMovesWithPlayer:(OTHPlayer*)player onX:(int)x andY:(int)y{
    NSLog(@"%@ Move.",player.name);
    return [board canPutThisSign:player.chessMan onX:x andY:y];
}

-(BOOL)computerMovesWithCPUPlayer:(OTHPlayer*)player{
    NSLog(@"Computer Starts Moving!");
    return [board computerMovesWithSign:player.chessMan];
}

-(void)updatePlayersTotalBlocks{
    player[0].totalChessBlock = 0;
    player[1].totalChessBlock = 0;
    for(int i=0;i<8;i++)
        for(int j=0;j<8;j++){
            if([board getBlocksFaceWithX:i andY:j]==firstSign)
                player[0].totalChessBlock++;
            else if ([board getBlocksFaceWithX:i andY:j] == secondSign)
                player[1].totalChessBlock++;
            else
                continue;
        }
}

-(int)checkGameStatus{
    if(status==GameOver)
        return GameOver;
    else{
        if(player[0].totalChessBlock == 0 && player[1].totalChessBlock !=0){
            status = GameOver;
            return secondWin;
        }
        else if(player[0].totalChessBlock != 0 && player[1].totalChessBlock ==0){
            status = GameOver;
            return firstWin;
        }
        else{
            if([board getTotalBlocks]==64){
                NSLog(@"Game ends, total blocks = 64.");
                if(player[0].totalChessBlock > player[1].totalChessBlock){
                    status = GameOver;
                    return firstWin;
                }
                else if(player[0].totalChessBlock == player[1].totalChessBlock){
                    status = GameOver;
                    return draw;
                }
                else{
                    status = GameOver;
                    return secondWin;
                }
            }
            else
                return status;
        }
    }
}


@end