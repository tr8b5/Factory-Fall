//
//  RankLogic.h
//  Factory Fall
//
//  Created by Willie on 3/1/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GameViewController;
@class GameScene;

NSInteger rankNumber;
NSInteger topRank;
NSInteger currentGameNumber;
NSInteger maxPlaysLvl;
NSArray *reggyHP;
NSArray *energy;
NSArray *humanHPArray;
NSArray *foodArray;
NSString *foodName;

BOOL canPay;
BOOL canPlay;
BOOL bronze101;
BOOL bronze102;
BOOL bronze103;
BOOL bronze201;
BOOL bronze202;
BOOL bronze203;
BOOL bronze301;
BOOL bronze302;
BOOL bronze303;
BOOL bronze401;
BOOL bronze402;
BOOL bronze403;
BOOL bronze501;
BOOL bronze502;
BOOL bronze503;
BOOL bronze601;
BOOL bronze602;
BOOL bronze603;
BOOL bronze701;
BOOL bronze702;
BOOL bronze703;
BOOL bronze801;
BOOL bronze802;
BOOL bronze803;
BOOL bronze901;
BOOL bronze902;
BOOL bronze903;
BOOL bronze1001;
BOOL bronze1002;
BOOL bronze1003;

BOOL silver101;
BOOL silver102;
BOOL silver103;
BOOL silver201;
BOOL silver202;
BOOL silver203;
BOOL silver301;
BOOL silver302;
BOOL silver303;
BOOL silver401;
BOOL silver402;
BOOL silver403;
BOOL silver501;
BOOL silver502;
BOOL silver503;
BOOL silver601;
BOOL silver602;
BOOL silver603;
BOOL silver701;
BOOL silver702;
BOOL silver703;
BOOL silver801;
BOOL silver802;
BOOL silver803;
BOOL silver901;
BOOL silver902;
BOOL silver903;
BOOL silver1001;
BOOL silver1002;
BOOL silver1003;

BOOL gold101;
BOOL gold102;
BOOL gold103;
BOOL gold201;
BOOL gold202;
BOOL gold203;
BOOL gold301;
BOOL gold302;
BOOL gold303;
BOOL gold401;
BOOL gold402;
BOOL gold403;
BOOL gold501;
BOOL gold502;
BOOL gold503;
BOOL gold601;
BOOL gold602;
BOOL gold603;
BOOL gold701;
BOOL gold702;
BOOL gold703;
BOOL gold801;
BOOL gold802;
BOOL gold803;
BOOL gold901;
BOOL gold902;
BOOL gold903;
BOOL gold1001;
BOOL gold1002;
BOOL gold1003;

BOOL ab1;
BOOL bb1;
BOOL b2;
BOOL b3;
BOOL ab4;
BOOL bb4;
BOOL b5;
BOOL b6;
BOOL ab7;
BOOL bb7;
BOOL b8;
BOOL b9;
BOOL ab10;
BOOL bb10;
BOOL b11;
BOOL b12;
BOOL ab13;
BOOL bb13;
BOOL b14;
BOOL b15;
BOOL ab16;
BOOL bb16;
BOOL b17;
BOOL b18;
BOOL ab19;
BOOL bb19;
BOOL b20;
BOOL b21;
BOOL ab22;
BOOL bb22;
BOOL b23;
BOOL b24;
BOOL ab25;
BOOL bb25;
BOOL b26;
BOOL b27;
BOOL cantLock1Blink;
BOOL cantLock2Blink;
BOOL cantLock3Blink;

BOOL helpActivated;

@interface RankLogic : NSObject

-(void)incrementby1;
-(void)decrementby1;
-(void)currentRank;
-(void)loadCurrentRank;
-(void)saveCurrentGameNumber;

-(void)increment1;
-(void)decrement1;
-(void)currentGame;
-(void)loadCurrentGameNumber;
-(void)resetCurrentGameNumber;

-(void)incrementMaxPlays;
-(void)loadCurrentMaxPlaysLvl;

-(void)saveRankValues;
-(void)loadRankValues;
-(void)tauntCheck;

-(void)payCheckSave;
-(void)payCheckLoad;

-(void)canBlinkLogic;
-(void)didBlinkLogic;

-(void)saveHelpActivated;
-(void)loadHelpActivated;

-(void)canPlayCheck;

-(void)bossBattleArraySprites;

-(void)blinkData;
-(void)foodsTextures;

-(void)initialPowerUpCode;
@end
