//
//  OTHViewController.h
//  Othello
//
//  Created by Ciel學長 on 23/2/13.
//  Copyright (c) 2013 Ciel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTHGame.h"
#import "Constants.h"

@interface OTHViewController : UIViewController{
    IBOutlet UISwitch *aiEnabled;
    IBOutlet UISwitch *computerStarts;
    NSMutableArray *buttons;
    NSMutableArray *images;
    int gameType;
    int whoStartsFirst;
    OTHPlayer *player;
    IBOutlet UILabel *firstPlayerTotalBlocks;
    IBOutlet UILabel *secondPlayerTotalBlocks;
    IBOutlet UILabel *firstPlayersTurn;
    IBOutlet UILabel *secondPlayerTurn;
}

@property (nonatomic, retain) UISwitch *aiEnabled;
@property (nonatomic, retain) UISwitch *computerStarts;
@property (nonatomic, retain) NSMutableArray *buttons;
@property (nonatomic, retain) NSMutableArray *images;
@property (nonatomic) int gameType;
@property (nonatomic) int whoStartsFirst;
@property (nonatomic, retain) OTHPlayer *player;
@property (nonatomic, retain) UILabel *firstPlayerTotalBlocks;
@property (nonatomic, retain) UILabel *secondPlayerTotalBlocks;
@property (nonatomic, retain) UILabel *firstPlayersTurn;
@property (nonatomic, retain) UILabel *secondPlayerTurn;

-(IBAction)isAiEnabled:(id)sender;
-(IBAction)isComputerStarts:(id)sender;
-(IBAction)start:(id)sender;
-(IBAction)about:(id)sender;

@end
