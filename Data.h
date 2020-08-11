//
//  Data.h
//  Factory Fall
//
//  Created by Willie on 8/7/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import <Foundation/Foundation.h>
NSInteger scoreInput;
NSInteger highScore1;
NSInteger highScore2;
NSInteger highScore3;
NSInteger highScore4;
NSInteger highScore5;
NSInteger highScore6;
NSInteger highScore7;
NSInteger highScore8;
NSInteger highScore9;
NSInteger amountDP;
NSInteger amountTP;
NSInteger amountQP;
NSInteger amountEL1;
NSInteger amountEL2;
NSInteger amountEL3;
NSInteger amountHG10;
NSInteger amountHG20;
NSInteger amountHG30;
NSInteger amountHS10;
NSInteger amountHS20;
NSInteger amountHS30;
NSInteger amountFB;
NSInteger amountMPPG;
NSInteger amountMTUB;

@interface Data : NSUserDefaults {
    
    NSUserDefaults *amountDPData;
    NSUserDefaults *amountTPData;
    NSUserDefaults *amountQPData;
    NSUserDefaults *amountEL1Data;
    NSUserDefaults *amountEL2Data;
    NSUserDefaults *amountEL3Data;
    NSUserDefaults *amountHG10Data;
    NSUserDefaults *amountHG20Data;
    NSUserDefaults *amountHG30Data;
    NSUserDefaults *amountHS10Data;
    NSUserDefaults *amountHS20Data;
    NSUserDefaults *amountHS30Data;
    NSUserDefaults *amountFBData;
    NSUserDefaults *amountMPPGData;
    NSUserDefaults *amountMTUBData;
}

-(void)saveTopScore;
-(void)loadTopScore;

-(void)saveAmountFB;
-(void)loadAmountFB;



@end

