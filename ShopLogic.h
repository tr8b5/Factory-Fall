//
//  ShopLogic.h
//  Factory Fall
//
//  Created by Willie on 2/28/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
// ---- DoublePoints Code ---- //
NSInteger DPInteger;
BOOL  hasDP; // if DPInteger > 0 then hasDP = YES and it is able to be used while playing the game //
BOOL  canActivateDP; // if canActivateDP = YES then it is able to be used in the game //
// ---- TriplePoints Code ---- //
NSInteger TPInteger;
BOOL  hasTP;
BOOL  canActivateTP;
// ---- QuadPoints Code ---- //
NSInteger QPInteger;
BOOL  hasQP;
BOOL  canActivateQP;
// ---- 1ExtraLife Code ---- //
NSInteger EL1Integer;
BOOL hasEL1;
BOOL canActivateEL1;
// ---- 2ExtraLife Code ---- //
NSInteger EL2Integer;
BOOL hasEL2;
BOOL canActivateEL2;
// ---- 3ExtraLife Code ---- //
NSInteger EL3Integer;
BOOL hasEL3;
BOOL canActivateEL3;
// ---- 10%hourGlass Code ---- //
NSInteger HG10Integer;
BOOL hasHG10;
BOOL canActivateHG10;
// ---- 20%hourGlass Code ---- //
NSInteger HG20Integer;
BOOL hasHG20;
BOOL canActivateHG20;
// ---- 30%hourGlass Code ---- //
NSInteger HG30Integer;
BOOL hasHG30;
BOOL canActivateHG30;
// ---- 10%HeadStart Code ---- //
NSInteger HS10Integer;
BOOL hasHS10;
BOOL canActivateHS10;
// ---- 20%HeadStart Code ---- //
NSInteger HS20Integer;
BOOL hasHS20;
BOOL canActivateHS20;
// ---- 30%HeadStart Code ---- //
NSInteger HS30Integer;
BOOL hasHS30;
BOOL canActivateHS30;

@interface ShopLogic : NSObject

// ---- DoublePoints Code ---- //

//@property int DPInteger; // this number increases by 1 once DP has been bought //

-(void)noDP; // if DPInteger = 0 then hasDP = NO and it is not able to be used while playing the game //
-(void)yesDP; // DPInteger > 0 , hasDP = YES and it is able to be used while playing the game //
-(void)buyDP; // increases the value of DPInt by 1 and calls the moethod yes DP //
-(void)cantBuyDP; // Causes the robot to say something about buying more facctory bucks //
-(void)usedDP; // Decreases the value of DPInt by 1 and if the value of DPInt = 0 then it calls the method noDP //
-(void)showDPAmount; // Shows the amount of the Double Points PowerUp //
-(void)loadDPInteger;
-(void)saveDPInteger;

// ---- TriplePoints Code ---- //
-(void)noTP;
-(void)yesTP;
-(void)buyTP;
-(void)cantBuyTP;
-(void)usedTP;
-(void)showTPAmount;
-(void)loadTPInteger;
-(void)saveTPInteger;
// ---- QuadPoints Code ---- //
-(void)noQP;
-(void)yesQP;
-(void)buyQP;
-(void)cantBuyQP;
-(void)usedQP;
-(void)showQPAmount;
-(void)loadQPInteger;
-(void)saveQPInteger;
// ---- 1Life Code ---- //
-(void)noEL1;
-(void)yesEL1;
-(void)buyEL1;
-(void)cantBuyEL1;
-(void)usedEL1;
-(void)showEL1Amount;
-(void)loadEL1Integer;
-(void)saveEL1Integer;
// ---- 2ExtraLife Code ---- //
-(void)noEL2;
-(void)yesEL2;
-(void)buyEL2;
-(void)cantBuyEL2;
-(void)usedEL2;
-(void)showEL2Amount;
-(void)loadEL2Integer;
-(void)saveEL2Integer;
// ---- 3ExtraLife Code ---- //
-(void)noEL3;
-(void)yesEL3;
-(void)buyEL3;
-(void)cantBuyEL3;
-(void)usedEL3;
-(void)showEL3Amount;
-(void)loadEL3Integer;
-(void)saveEL3Integer;
// ---- 10%hourGlass Code ---- //
-(void)noHG10;
-(void)yesHG10;
-(void)buyHG10;
-(void)cantBuyHG10;
-(void)usedHG10;
-(void)showHG10Amount;
-(void)loadHG10Integer;
-(void)saveHG10Integer;
// ---- 20%hourGlass Code ---- //
-(void)noHG20;
-(void)yesHG20;
-(void)buyHG20;
-(void)cantBuyHG20;
-(void)usedHG20;
-(void)showHG20Amount;
-(void)loadHG20Integer;
-(void)saveHG20Integer;
// ---- 30%hourGlass Code ---- //
-(void)noHG30;
-(void)yesHG30;
-(void)buyHG30;
-(void)cantBuyHG30;
-(void)usedHG30;
-(void)showHG30Amount;
-(void)loadHG30Integer;
-(void)saveHG30Integer;
// ---- 10%HeadStart Code ---- //
-(void)noHS10;
-(void)yesHS10;
-(void)buyHS10;
-(void)cantBuyHS10;
-(void)usedHS10;
-(void)showHS10Amount;
-(void)loadHS10Integer;
-(void)saveHS10Integer;
// ---- 20%HeadStart Code ---- //
-(void)noHS20;
-(void)yesHS20;
-(void)buyHS20;
-(void)cantBuyHS20;
-(void)usedHS20;
-(void)showHS20Amount;
-(void)loadHS20Integer;
-(void)saveHS20Integer;
// ---- 30%HeadStart Code ---- //
-(void)noHS30;
-(void)yesHS30;
-(void)buyHS30;
-(void)cantBuyHS30;
-(void)usedHS30;
-(void)showHS30Amount;
-(void)loadHS30Integer;
-(void)saveHS30Integer;
// ---- Safe Pack Code ---- //
-(void)buySafePack;
-(void)buyInvinsiblePack;
-(void)buyGodPack;
















@end
