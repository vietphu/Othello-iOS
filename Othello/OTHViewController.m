//
//  OTHViewController.m
//  Othello
//
//  Created by Ciel學長 on 23/2/13.
//  Copyright (c) 2013 Ciel. All rights reserved.
//

#import "OTHViewController.h"

@interface OTHViewController ()

@end

@implementation OTHViewController

@synthesize aiEnabled,computerStarts;
@synthesize buttons,images;
@synthesize gameType,whoStartsFirst;
@synthesize player;
@synthesize firstPlayersTurn,firstPlayerTotalBlocks,secondPlayerTotalBlocks,secondPlayerTurn;

BOOL GameIsinProcess;
OTHGame *Game;


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //init two switches;
    [self.aiEnabled setEnabled:YES];
    [self.computerStarts setEnabled:YES];
    self.aiEnabled.on = NO;
    if(!self.aiEnabled.on){
        [self.computerStarts setEnabled:NO];
        self.computerStarts.on = NO;
        gameType = PlayerVSPlayer;
        whoStartsFirst = 0;
    }
    else{
        [self.computerStarts setEnabled:YES];
        self.computerStarts.on = NO;
        gameType = PlayerVSComputer;
        whoStartsFirst = PlayerStartsFirst;
    }
    [self addImage];
    [self addButton];
    GameIsinProcess = NO;
    [firstPlayersTurn setHidden:YES];
    [secondPlayerTurn setHidden:YES];
    [firstPlayerTotalBlocks setHidden:YES];
    [secondPlayerTotalBlocks setHidden:YES];
}

-(IBAction)start:(id)sender{
    GameIsinProcess = YES;
    //init the chessboard and the button on that;
    [self initButtonsAndImagesStatus];
    //init the inside data;
    if(gameType == PlayerVSPlayer){
        Game = [[OTHGame alloc] initWithGameTypePlayerVSplayer];
        NSLog(@"the main object Game load successfully with playerVSplayer method!");
    }
    else{
        if(whoStartsFirst == ComputerStartsFirst){
            Game = [[OTHGame alloc] initWithGameTypePlayerVSComputerWithComputerStartsFirst:true];
            NSLog(@"the main object Game load successfully with computer starts first method!");
        }
        else{
            Game = [[OTHGame alloc] initWithGameTypePlayerVSComputerWithComputerStartsFirst:false];
            NSLog(@"the main object Game load successfully with player starts first method!");
        }
    }
    self.player = [Game getPlayerWithIndex:0];
    [firstPlayersTurn setHidden:NO];
    [secondPlayerTurn setHidden:YES];
    firstPlayerTotalBlocks.text = [[NSString alloc]initWithFormat:@"%d",2];
    secondPlayerTotalBlocks.text = [[NSString alloc]initWithFormat:@"%d",2];
    [firstPlayerTotalBlocks setHidden:NO];
    [secondPlayerTotalBlocks setHidden:NO];
    if(gameType == PlayerVSComputer && whoStartsFirst == ComputerStartsFirst)
        [self computerMoves];
}

-(IBAction)isAiEnabled:(id)sender{
    UISwitch *obj = (UISwitch*)sender;
    if(obj.on){
        [self.computerStarts setEnabled:YES];
        gameType = PlayerVSComputer;
    }
    else{
        [self.computerStarts setEnabled:NO];
        gameType = PlayerVSPlayer;
    }
}

-(IBAction)isComputerStarts:(id)sender{
    UISwitch *obj = (UISwitch*)sender;
    if(obj.on){
        whoStartsFirst = ComputerStartsFirst;
    }
    else{
        whoStartsFirst = PlayerStartsFirst;
    }
    
}

-(IBAction)about:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Othello info" message:[[NSString alloc] initWithFormat:@"Powered by Ciel\nNanyang Technological University\nimwithye@gmail.com"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

-(void)playerMoves:(UIButton*)sender{
    if(gameType == PlayerVSPlayer)
        [self playerMovesWithPlayer:sender];
    if(gameType == PlayerVSComputer){
        [self playerMovesWithPlayer:sender];
        [self performSelector:@selector(computerMoves) withObject:nil afterDelay:1];
    }
}

-(void)playerMovesWithPlayer:(UIButton*)sender{
    int status = [Game checkGameStatus];
    if(status != GameStart){
        [self gameEnds:status];
        return;
    }
    if(player.isComputer)
        return;
    [sender setEnabled:NO];
    int x,y;
    x = sender.tag/10;
    y = sender.tag%10;
    BOOL moveResult = [Game playerMovesWithPlayer:player onX:x andY:y];
    if(moveResult){
        [Game updatePlayersTotalBlocks];
        [self reDrawBoard];
        status = [Game checkGameStatus];
        if(status != GameStart)
            [self gameEnds:status];
        else{
            BOOL oppPlayerCanMove = [Game checkAvailable:player.oppPlayer];
            if(!oppPlayerCanMove){
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"NO Steps" message:[[NSString alloc] initWithFormat:@"NO steps are availavle. %@ moves.",player.name] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
            else{
                player = player.oppPlayer;
            }
            
        }
        [Game updatePlayersTotalBlocks];
        [self reDrawBoard];
        [sender setEnabled:NO];
    }
    [sender setEnabled:YES];
}

-(void)computerMoves{
    int status = [Game checkGameStatus];
    if(status != GameStart){
        [self gameEnds:status];
        return;
    }
    if(!player.isComputer)
        return;
    BOOL movResult = [Game computerMovesWithCPUPlayer:player];
    if(movResult){
        [Game updatePlayersTotalBlocks];
        [self reDrawBoard];
        status = [Game checkGameStatus];
        if(status != GameStart)
            [self gameEnds:status];
        else{
            BOOL oppPlayerCanMove = [Game checkAvailable:player.oppPlayer];
            if(!oppPlayerCanMove){
                [Game updatePlayersTotalBlocks];
                [self reDrawBoard];
                [self computerMoves];
            }
            else{
                player = player.oppPlayer;
            }
        }
        [Game updatePlayersTotalBlocks];
        [self reDrawBoard];
    }
    NSLog(@"Computer moves field");
}

-(void)reDrawBoard{
    OTHBoard *board = [Game getBoard];
    firstPlayerTotalBlocks.text = [[NSString alloc]initWithFormat:@"%d",[Game getPlayerWithIndex:0].totalChessBlock];
    secondPlayerTotalBlocks.text = [[NSString alloc]initWithFormat:@"%d",[Game getPlayerWithIndex:1].totalChessBlock];
    if(player.chessMan == firstSign){
        [firstPlayersTurn setHidden:NO];
        [secondPlayerTurn setHidden:YES];
    }
    if(player.chessMan == secondSign){
        [firstPlayersTurn setHidden:YES];
        [secondPlayerTurn setHidden:NO];
    }
    for(int i=0;i<8;i++)
        for(int j=0;j<8;j++){
            int sign = [board getBlocksFaceWithX:i andY:j];
            if(sign == nilSign)
                continue;
            else if (sign == firstSign)
                [[images objectAtIndex:i*8+j] setImage:[UIImage imageNamed:@"first.png"]];
            else
                [[images objectAtIndex:i*8+j] setImage:[UIImage imageNamed:@"second.png"]];
        }
}

//init the game board
- (void)addButton{
    self.buttons = [[NSMutableArray alloc]init];
    float startX = 39,startY = 26,size = 21.5;
    for(int i = 0;i<8;i++)
        for(int j=0;j<8;j++){
            float Xoffset = j*10;
            float Yoffset = i*10;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame  = CGRectMake(startX + j*size+Xoffset, startY+i*size+Yoffset, size, size);
            button.tag = i*10+j;
            [button setEnabled:NO];
            [button addTarget:self action:@selector(playerMoves:) forControlEvents:UIControlEventTouchUpInside];
            [self.buttons addObject:button];
            [self.view addSubview:button];
        }
}

-(void)addImage{
    self.images = [[NSMutableArray alloc] init];
    float startX = 39,startY = 26,size = 21.5;
    for(int i = 0;i<8;i++)
        for(int j=0;j<8;j++){
            float Xoffset = j*10;
            float Yoffset = i*10;
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(startX + j*size+Xoffset, startY+i*size+Yoffset, size, size)];
            image.tag = i*10+j;
            [image setImage:nil];
            image.opaque = YES;
            [self.images addObject:image];
            [self.view addSubview:image];
        }
}

-(void)initButtonsAndImagesStatus{
    for(int i = 0;i<buttons.count;i++){
        [[buttons objectAtIndex:i] setEnabled:YES];
    }
    for(int i = 0;i<images.count;i++){
        [[images objectAtIndex:i] setImage:nil];
    }
    int index;
    index = (33/10)*8+33%10;
    [[images objectAtIndex:index] setImage:[UIImage imageNamed:@"first.png"]];
    [[buttons objectAtIndex:index] setEnabled:NO];
    index = (34/10)*8+34%10;
    [[images objectAtIndex:index] setImage:[UIImage imageNamed:@"second.png"]];
    [[buttons objectAtIndex:index] setEnabled:NO];
    index = (43/10)*8+43%10;
    [[images objectAtIndex:index] setImage:[UIImage imageNamed:@"second.png"]];
    [[buttons objectAtIndex:index] setEnabled:NO];
    index = (44/10)*8+44%10;
    [[images objectAtIndex:index] setImage:[UIImage imageNamed:@"first.png"]];
    [[buttons objectAtIndex:index] setEnabled:NO];
}

-(void)gameEnds:(int)status{
    //disable All elements.
    for(int i = 0;i<buttons.count;i++){
        [[buttons objectAtIndex:i] setEnabled:NO];
    }
    for(int i = 0;i<images.count;i++){
        [[images objectAtIndex:i] setEnabled:NO];
    }
    
    if(status == firstWin){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Game ends" message:([[NSString alloc] initWithFormat:@"%@ won!",[Game getPlayerWithIndex:0].name]) delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    if(status == secondWin){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Game ends" message:([[NSString alloc] initWithFormat:@"%@ won!",[Game getPlayerWithIndex:1].name]) delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    if(status == draw){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Game ends" message:[[NSString alloc] initWithFormat:@"Draw!"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
