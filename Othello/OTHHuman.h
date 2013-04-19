//
//  OTHHuman.h
//  Othello
//
//  Created by Ciel學長 on 24/2/13.
//  Copyright (c) 2013 Ciel. All rights reserved.
//

#import "OTHPlayer.h"


@interface OTHHuman : OTHPlayer

-(OTHHuman*) initWithStartFirstInPVPCase:(BOOL)_startFirst;
-(OTHHuman*) initWithStartFirstInPVECase:(BOOL)_startFirst;

@end
