//
//  OTHBoard.m
//  Othello
//
//  Created by Ciel學長 on 24/2/13.
//  Copyright (c) 2013 Ciel. All rights reserved.
//

#import "OTHBoard.h"


@implementation OTHBoard

OTHBlock* blocks[8][8];
int totalBlocks;

-(OTHBoard*)initNewBoard{
    self = [super init];
    if(self){
        totalBlocks = 4;
        for(int i=0;i<8;i++)
            for(int j=0;j<8;j++){
                blocks[i][j] = [[OTHBlock alloc]initNewBlockWithX:i andY:j];
            }
        blocks[3][3].face = firstSign;
		blocks[3][4].face = secondSign;
		blocks[4][3].face = secondSign;
		blocks[4][4].face = firstSign;
    }
    return self;
}

-(int)getBlocksFaceWithX:(int)x andY:(int)y{
    return blocks[x][y].face;
}

-(void)setBlocksFaceWithSign:(int)sign onX:(int)x andY:(int)y{
    blocks[x][y].face = sign;
}

-(int)getTotalBlocks{
    return totalBlocks;
}

-(BOOL)checkAvailableWithSign:(int)sign{
    int oppSign = sign==firstSign?secondSign:firstSign;
    for(int i=0;i<8;i++)
        for(int j=0;j<8;j++){
            if(blocks[i][j].face == nilSign){
                //check row
                int count = 0;
                int selfcount = 0;
                for(int a = j-1;a>=0;a--){
                    if(blocks[i][a].face == oppSign)
                        count++;
                    else if(blocks[i][a].face == sign){
                        selfcount = 1;
                        break;
                    }
                    else{
                        count = 0;
                        break;
                    }
                }
                if(count!=0 && selfcount != 0){
                    return YES;
                }
                count = 0;
                selfcount = 0;
                for(int a = j+1;a<8;a++){
                    if(blocks[i][a].face == oppSign)
                        count++;
                    else if(blocks[i][a].face == sign){
                        selfcount = 1;
                        break;
                    }
                    else{
                        count = 0;
                        break;
                    }
                }
                if(count!=0 && selfcount != 0){
                    return YES;
                }
                
                //check col
                count = 0;
                selfcount = 0;
                for(int a = i-1;a>=0;a--){
                    if(blocks[a][j].face == oppSign)
                        count++;
                    else if(blocks[a][j].face == sign){
                        selfcount = 1;
                        break;
                    }
                    else{
                        count = 0;
                        break;
                    }
                }
                if(count!=0 && selfcount != 0){
                    return YES;
                }
                count = 0;
                selfcount = 0;
                for(int a = i+1;a<8;a++){
                    if(blocks[a][j].face == oppSign)
                        count++;
                    else if(blocks[a][j].face == sign){
                        selfcount = 1;
                        break;
                    }
                    else{
                        count = 0;
                        break;
                    }
                }
                if(count!=0 && self !=0){
                    return YES;
                }
                
                //check left diagonal;
                count = 0;
                selfcount = 0;
                int a = i-1,b = j-1;
                while(a>=0 && b>=0){
                    if(blocks[a][b].face == oppSign)
                        count++;
                    else if(blocks[a][b].face == sign){
                        selfcount = 1;
                        break;
                    }
                    else{
                        count = 0;
                        break;
                    }
                    a--;
                    b--;
                }
                if(count!=0 && selfcount !=0){
                    return YES;
                }
                count = 0;
                selfcount = 0;
                a = i+1;
                b = j+1;
                while(a<8 && b<8){
                    if(blocks[a][b].face == oppSign)
                        count++;
                    else if(blocks[a][b].face == sign){
                        selfcount = 1;
                        break;
                    }
                    else{
                        count = 0;
                        break;
                    }
                    a++;
                    b++;
                }
                if(count!=0 && selfcount !=0){
                    return YES;
                }
                
                //check right diagonal
                count = 0;
                selfcount = 0;
                a = i-1;
                b = j+1;
                while(a>=0 && b<8){
                    if(blocks[a][b].face == oppSign)
                        count++;
                    else if(blocks[a][b].face == sign){
                        selfcount = 1;
                        break;
                    }
                    else{
                        count = 0;
                        break;
                    }
                    a--;
                    b++;
                }
                if(count!=0 && selfcount != 0){
                    return YES;
                }
                count = 0;
                selfcount = 0;
                a = i+1;
                b = j-1;
                while(a<8 && b>=0){
                    if(blocks[a][b].face == oppSign)
                        count++;
                    else if(blocks[a][b].face == sign){
                        selfcount = 1;
                        break;
                    }
                    else{
                        count = 0;
                        break;
                    }
                    a++;
                    b--;
                }
                if(count!=0 && selfcount != 0){
                    return YES;
                }
            }
        }
    return NO;
}

-(NSMutableArray*)AvailalePositionForSign:(int)sign{
    NSMutableArray *result;
    int oppSign = sign==firstSign?secondSign:firstSign;
    result = [[NSMutableArray alloc]init];
    for(int i=0;i<8;i++)
        for(int j=0;j<8;j++){
            if(blocks[i][j].face == nilSign){
                //check row
                int count = 0;
                int selfcount = 0;
                for(int a = j-1;a>=0;a--){
                    if(blocks[i][a].face == oppSign)
                        count++;
                    else if(blocks[i][a].face == sign){
                        selfcount = 1;
                        break;
                    }
                    else{
                        count = 0;
                        break;
                    }
                }
                if(count!=0 && selfcount != 0){
                    [result addObject:[[NSNumber alloc]initWithInt:i*10+j]];
                    continue;
                }
                count = 0;
                selfcount = 0;
                for(int a = j+1;a<8;a++){
                    if(blocks[i][a].face == oppSign)
                        count++;
                    else if(blocks[i][a].face == sign){
                        selfcount = 1;
                        break;
                    }
                    else{
                        count = 0;
                        break;
                    }
                }
                if(count!=0 && selfcount != 0){
                    [result addObject:[[NSNumber alloc]initWithInt:i*10+j]];
                    continue;
                }
                
                //check col
                count = 0;
                selfcount = 0;
                for(int a = i-1;a>=0;a--){
                    if(blocks[a][j].face == oppSign)
                        count++;
                    else if(blocks[a][j].face == sign){
                        selfcount = 1;
                        break;
                    }
                    else{
                        count = 0;
                        break;
                    }
                }
                if(count!=0 && selfcount != 0){
                    [result addObject:[[NSNumber alloc]initWithInt:i*10+j]];
                    continue;
                }
                count = 0;
                selfcount = 0;
                for(int a = i+1;a<8;a++){
                    if(blocks[a][j].face == oppSign)
                        count++;
                    else if(blocks[a][j].face == sign){
                        selfcount = 1;
                        break;
                    }
                    else{
                        count = 0;
                        break;
                    }
                }
                if(count!=0 && self !=0){
                    [result addObject:[[NSNumber alloc]initWithInt:i*10+j]];
                    continue;
                }
                
                //check left diagonal;
                count = 0;
                selfcount = 0;
                int a = i-1,b = j-1;
                while(a>=0 && b>=0){
                    if(blocks[a][b].face == oppSign)
                        count++;
                    else if(blocks[a][b].face == sign){
                        selfcount = 1;
                        break;
                    }
                    else{
                        count = 0;
                        break;
                    }
                    a--;
                    b--;
                }
                if(count!=0 && selfcount !=0){
                    [result addObject:[[NSNumber alloc]initWithInt:i*10+j]];
                    continue;
                }
                count = 0;
                selfcount = 0;
                a = i+1;
                b = j+1;
                while(a<8 && b<8){
                    if(blocks[a][b].face == oppSign)
                        count++;
                    else if(blocks[a][b].face == sign){
                        selfcount = 1;
                        break;
                    }
                    else{
                        count = 0;
                        break;
                    }
                    a++;
                    b++;
                }
                if(count!=0 && selfcount !=0){
                    [result addObject:[[NSNumber alloc]initWithInt:i*10+j]];
                    continue;
                }
                
                //check right diagonal
                count = 0;
                selfcount = 0;
                a = i-1;
                b = j+1;
                while(a>=0 && b<8){
                    if(blocks[a][b].face == oppSign)
                        count++;
                    else if(blocks[a][b].face == sign){
                        selfcount = 1;
                        break;
                    }
                    else{
                        count = 0;
                        break;
                    }
                    a--;
                    b++;
                }
                if(count!=0 && selfcount != 0){
                    [result addObject:[[NSNumber alloc]initWithInt:i*10+j]];
                    continue;
                }
                count = 0;
                selfcount = 0;
                a = i+1;
                b = j-1;
                while(a<8 && b>=0){
                    if(blocks[a][b].face == oppSign)
                        count++;
                    else if(blocks[a][b].face == sign){
                        selfcount = 1;
                        break;
                    }
                    else{
                        count = 0;
                        break;
                    }
                    a++;
                    b--;
                }
                if(count!=0 && selfcount != 0){
                    [result addObject:[[NSNumber alloc]initWithInt:i*10+j]];
                    continue;
                }
            }
        }
    return result;
}

-(void)changeWithSign:(int)sign onX:(int)x andY:(int)y{
    int oppSign = sign==firstSign?secondSign:firstSign;
    int count,selfcount,a,b;
	blocks[x][y].face = sign;
    
    //change row
	count = 0;
	selfcount = 0;
	for(a = y-1;a>=0;a--){
		if(blocks[x][a].face == oppSign)
			count++;
		else if(blocks[x][a].face == sign){
			selfcount = 1;
			break;
		}
		else{
			count = 0;
			break;
		}
	}
	if(count!=0 && selfcount!=0){
		for(int i=y-1;i>a;i--)
			blocks[x][i].face = sign;
	}
	count = 0;
	selfcount = 0;
	for(a = y+1;a<8;a++){
		if(blocks[x][a].face == oppSign)
			count++;
		else if(blocks[x][a].face == sign){
			selfcount = 1;
			break;
		}
		else{
			count = 0;
			break;
		}
	}
	if(count!=0 && selfcount!=0){
		for(int i=y+1;i<a;i++)
			blocks[x][i].face = sign;
	}
    
    //change col
	count = 0;
	selfcount = 0;
	for(a = x-1;a>=0;a--){
		if(blocks[a][y].face == oppSign)
			count++;
		else if(blocks[a][y].face == sign){
			selfcount = 1;
			break;
		}
		else{
			count = 0;
			break;
		}
	}
	if(count!=0 && selfcount !=0){
		for(int i=x-1;i>a;i--)
			blocks[i][y].face = sign;
	}
	count = 0;
	selfcount = 0;
	for(a = x+1;a<8;a++){
		if(blocks[a][y].face == oppSign)
			count++;
		else if(blocks[a][y].face == sign){
			selfcount = 1;
			break;
		}
		else{
			count = 0;
			break;
		}
	}
	if(count!=0 && selfcount !=0){
		for(int i=x+1;i<a;i++)
			blocks[i][y].face = sign;
	}
    
    //change left diagonal
	count = 0;
	selfcount =0;
	a = x-1;
	b = y-1;
	while(a>=0 && b>=0){
		if(blocks[a][b].face == oppSign)
			count++;
		else if(blocks[a][b].face == sign){
			selfcount = 1;
			break;
		}
		else{
			count = 0;
			break;
		}
		a--;
		b--;
	}
	if(count!=0 && selfcount != 0){
		int i = x-1;
		int j = y-1;
		while(i>a && j>b){
			blocks[i][j].face = sign;
			i--;
			j--;
		}
	}
	count = 0;
	selfcount = 0;
	a = x+1;
	b = y+1;
	while(a<8 && b<8){
		if(blocks[a][b].face == oppSign)
			count++;
		else if(blocks[a][b].face == sign){
			selfcount = 1;
			break;
		}
		else{
			count = 0;
			break;
		}
		a++;
		b++;
	}
	if(count!=0 && selfcount != 0){
		int i = x+1;
		int j = y+1;
		while(i<a && j<b){
			blocks[i][j].face = sign;
			i++;
			j++;
		}
	}
    
    //change right diagonal
	count = 0;
	selfcount = 0;
	a = x-1;
	b = y+1;
	while(a>=0 && b<8){
		if(blocks[a][b].face == oppSign)
			count++;
		else if(blocks[a][b].face == sign){
			selfcount = 1;
			break;
		}
		else{
			count = 0;
		}
		a--;
		b++;
	}
	if(count!=0 && selfcount != 0){
		int i = x-1;
		int j = y+1;
		while(i>a && j<b){
			blocks[i][j].face = sign;
			i--;
			j++;
		}
	}
	count = 0;
	selfcount = 0;
	a = x+1;
	b = y-1;
	while(a<8 && b>=0){
		if(blocks[a][b].face == oppSign)
			count++;
		else if(blocks[a][b].face == sign){
			selfcount = 1;
			break;
		}
		else{
			count = 0;
		}
		a++;
		b--;
	}
	if(count!=0 && selfcount !=0){
		int i = x+1;
		int j = y-1;
		while(i<a && j>b){
			blocks[i][j].face = sign;
			i++;
			j--;
		}
	}
}

-(BOOL)canPutThisSign:(int)sign onX:(int)x andY:(int)y{
    if(blocks[x][y].face != nilSign){
        return NO;
        NSLog(@"(%d, %d),Already placed",x,y);
    }
    else{
        NSLog(@"(%d, %d),The target is empty!",x,y);
        int position = x*10+y;
        NSMutableArray *result = [self AvailalePositionForSign:sign];
        NSLog(@"There are %d legal moves",result.count);
        
        
        BOOL available = NO;
        for(int i=0;i<[result count];i++)
            if(position == [[result objectAtIndex:i] intValue]){
                available = YES;
                break;
            }
        if(!available){
            NSLog(@"The position can not use!");
            return NO;
        }
        totalBlocks++;
        [self changeWithSign:sign onX:x andY:y];
        NSLog(@"Move successfully! And total blocks on board is %d",totalBlocks);
        return YES;
    }
}

-(BOOL)canPutThisSignWithComputerSearching:(int)sign onX:(int)x andY:(int)y{
    if(blocks[x][y].face != nilSign){
        return NO;
        NSLog(@"(%d, %d),Already placed",x,y);
    }
    else{
        NSLog(@"(%d, %d),The target is empty!",x,y);
        int position = x*10+y;
        NSMutableArray *result = [self AvailalePositionForSign:sign];
        NSLog(@"There are %d legal moves",result.count);
        
        
        BOOL available = NO;
        for(int i=0;i<[result count];i++)
            if(position == [[result objectAtIndex:i] intValue]){
                available = YES;
                break;
            }
        if(!available){
            NSLog(@"The position can not use!");
            return NO;
        }
        [self changeWithSign:sign onX:x andY:y];
        NSLog(@"Searching! Move successfully with sign %d! And total blocks on board is %d",sign,totalBlocks);
        return YES;
    }
}

-(BOOL)computerMovesWithSign:(int)sign{
    NSMutableArray *steps;
    steps = [self AvailalePositionForSign:sign];
    int maxPoint = 0;
    int maxMoveStepX = [[steps objectAtIndex:0] intValue]/10,maxMoveStepY = [[steps objectAtIndex:0] intValue]%10;
    int currentBlocks[8][8];
    for(int i=0;i<8;i++)
        for(int j=0;j<8;j++){
            currentBlocks[i][j] = [self getBlocksFaceWithX:i andY:j];
        }
    //This is no AI. Computer will choose the first position he can find.
    //This code has bugs!
    //This code is calling AlphaBetaSeraching function which is shown below.
    //edit and send pull request if you can fix bugs.
    /*for(int step = 0;step<[steps count];step++){
        int position = [[steps objectAtIndex:step] intValue];
        int x = position/10;
        int y = position%10;
        [self canPutThisSignWithComputerSearching:sign onX:x andY:y];
        int point = [self AlphaBetaWithSign:sign andDepth:0 andAlpha:-INFINITY andBeta:INFINITY];
        if(point>=maxPoint){
            maxMoveStepX = x;
            maxMoveStepY = y;
            maxPoint = point;
        }
        for(int i=0;i<8;i++)
            for(int j=0;j<8;j++){
                blocks[i][j].face = currentBlocks[i][j];
            }
    }*/
    return [self canPutThisSign:sign onX:maxMoveStepX andY:maxMoveStepY];
}

-(int)AlphaBetaWithSign:(int)sign andDepth:(int)depth andAlpha:(int)alpha andBeta:(int)beta{
    int oppSign = sign==firstSign?secondSign:firstSign;
    if(depth == 0)
        return [self totalPointOfCurrentBoardWithSign:sign];
    NSMutableArray *legalMoves;
    legalMoves = [self AvailalePositionForSign:sign];
    int currentBlocks[8][8];
    for(int i=0;i<8;i++)
        for(int j=0;j<8;j++){
            currentBlocks[i][j] = [self getBlocksFaceWithX:i andY:j];
        }
    for(int step=0;step<[legalMoves count];step++){
        int position = [[legalMoves objectAtIndex:step] intValue];
        int x = position/10;
        int y = position%10;
        [self canPutThisSignWithComputerSearching:sign onX:x andY:y];
        int val = - [self AlphaBetaWithSign:oppSign andDepth:depth-1 andAlpha:-beta andBeta:-alpha];
        for(int i=0;i<8;i++)
            for(int j=0;j<8;j++){
                blocks[i][j].face = currentBlocks[i][j];
            }
        if(val>=beta)
            return beta;
        if(val>alpha)
            alpha = val;
    }
    return alpha;
}



-(int)chanceForSign:(int)sign onX:(int)x andY:(int)y{
    int total = 0;
    int i,j;
    BOOL flag;
    //check row
    flag = true;
    for(j=0;j<y;j++){
        if(blocks[x][j].face != sign){
            flag = false;
            break;
        }
    }
    if(flag)
        total++;
    flag = true;
    for(j=y+1;j<8;j++){
        if(blocks[x][j].face != sign){
            flag = false;
            break;
        }
    }
    if(flag)
        total++;
    
    //check col
    flag = true;
    for(i=0;i<x;i++){
        if(blocks[i][y].face != sign){
            flag = false;
            break;
        }
    }
    if(flag)
        total++;
    flag = true;
    for(i=x+1;i<8;i++){
        if(blocks[i][y].face != sign){
            flag = false;
            break;
        }
    }
    if(flag)
        total++;
    flag = true;
    
    //check left diagonal
    flag = true;
    i = x-1;
    j = y-1;
    while(i>=0 && j>=0){
        if(blocks[i][j].face != sign){
            flag = false;
            break;
        }
        i--;
        j--;
    }
    if(flag)
        total++;
    flag = true;
    i = x+1;
    j = y+1;
    while(i>=0 && j<8){
        if(blocks[i][j].face != sign){
            flag = false;
            break;
        }
        i--;
        j++;
    }
    if(flag)
        total++;
    
    //check right diagonal
    flag = true;
    i = x+1;
    j = y-1;
    while(i<8 && j>=0){
        if(blocks[i][j].face != sign){
            flag = false;
            break;
        }
        i++;
        j--;
    }
    if(flag)
        total++;
    flag = true;
    i = x-1;
    j = y+1;
    while(i>=0 && j<8){
        if(blocks[i][j].face != sign){
            flag = false;
            break;
        }
        i--;
        j++;
    }
    if(flag)
        total++;
    
    return total;
}

-(int)totalPointOfCurrentBoardWithSign:(int)sign{
    int total = 0;
    
    //check own corner and blocks near corner;
    if(blocks[0][0].face == sign){
        total = total + 50;
        if(blocks[0][1].face == sign)
            total = total + 10;
        if(blocks[1][1].face == sign)
            total = total + 10;
        if(blocks[1][0].face == sign)
            total = total + 10;
    }
    if(blocks[0][7].face == sign){
        total = total + 50;
        if(blocks[0][6].face == sign)
            total = total + 10;
        if(blocks[1][6].face == sign)
            total = total + 10;
        if(blocks[1][7].face == sign)
            total = total + 10;
    }
    if(blocks[7][7].face == sign){
        total = total + 50;
        if(blocks[6][6].face == sign)
            total = total + 10;
        if(blocks[6][7].face == sign)
            total = total + 10;
        if(blocks[7][6].face == sign)
            total = total + 10;
    }
    if(blocks[7][0].face == sign){
        total = total + 50;
        if(blocks[6][0].face == sign)
            total = total + 10;
        if(blocks[6][1].face == sign)
            total = total + 10;
        if(blocks[7][1].face == sign)
            total = total + 10;
    }
    
    //check edges
    int i,j;
    i = 0;
    for(j=2;j<=5;j++){
        if(blocks[i][j].face == sign)
            total = total+16;
    }
    i = 7;
    for(j=2;j<=5;j++){
        if(blocks[i][j].face == sign)
            total = total+16;
    }
    j = 0;
    for(i=2;i<=5;i++){
        if(blocks[i][j].face == sign)
            total = total+16;
    }
    j = 7;
    for(i=2;i<=5;i++){
        if(blocks[i][j].face == sign)
            total = total+16;
    }
    
    //check second edge
    i = 1;
    for(j=2;j<=5;j++){
        if(blocks[i][j].face == sign){
            if([self chanceForSign:sign onX:i andY:j] != 0)
                total = total + 4*[self chanceForSign:sign onX:i andY:j];
            else
                total = total + 1;
        }
    }
    i = 6;
    for(j=2;j<=5;j++){
        if(blocks[i][j].face == sign){
            if([self chanceForSign:sign onX:i andY:j]!= 0)
                total = total + 4*[self chanceForSign:sign onX:i andY:j];
            else
                total = total + 1;
        }
    }
    j = 1;
    for(i=2;i<=5;i++){
        if(blocks[i][j].face == sign){
            if([self chanceForSign:sign onX:i andY:j] != 0)
                total = total + 4*[self chanceForSign:sign onX:i andY:j];
            else
                total = total + 1;
        }
    }
    j = 6;
    for(i=2;i<=5;i++){
        if(blocks[i][j].face == sign){
            if([self chanceForSign:sign onX:i andY:j] != 0)
                total = total + 4*[self chanceForSign:sign onX:i andY:j];
            else
                total = total + 1;
        }
    }
    
    //check other point
    for(i=2;i<=5;i++)
        for(j=2;j<=5;j++){
            if(blocks[i][j].face == sign){
                if([self chanceForSign:sign onX:i andY:j] != 0)
                    total = total +4*[self chanceForSign:sign onX:i andY:j];
                else
                    total = total + 2;
            }
        }
    return total;
}


@end
