//
//  ShopLogic.m
//  Factory Fall
//
//  Created by Willie on 2/28/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import "ShopLogic.h"
#import "PowerUpLogic.h"
#import "GameScene.h"

@implementation ShopLogic

+ (id) ShopLogic {
    

    return 0;
}
//------------------------------------------DoublePoints------------------------------------------//
-(void)showDPAmount {
    NSLog(@"DoublePointsAmount:" @"%ld", (long)DPInteger);
}
-(void)buyDP {
    
    DPInteger += 1;
    hasDP = YES;
    [self yesDP];
    NSLog(@"DoublePointsAmount:" @"%ld", (long)DPInteger);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:DPInteger forKey:@"DPInteger"];
    [defaults synchronize];
    [self loadDPInteger];
    
}
-(void)cantBuyDP {
    NSLog(@"Need More Factory Bucks");
}
-(void)loadDPInteger {
    
    DPInteger = [[NSUserDefaults standardUserDefaults] integerForKey:@"DPInteger"];
     NSLog(@"DoublePointsAmount:" @"%ld", (long)DPInteger);
    if (DPInteger >= 1 & powerUpAmount > 0) {
        [self yesDP];
    }
    if (DPInteger == 0) {
        hasDP = NO;
        canActivateDP = NO;
    }
    
}
-(void)saveDPInteger {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:DPInteger forKey:@"DPInteger"];
    [defaults synchronize];
    
}
-(void)usedDP {
    
    if (DPInteger >= 1 & powerUpAmount > 0) {
        canActivateDP = YES;
        
        [[NSUserDefaults standardUserDefaults] setInteger:DPInteger forKey:@"DPInteger"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (DPInteger == 0) {
        hasDP = NO;
        canActivateDP = NO;
        [[NSUserDefaults standardUserDefaults] setInteger:DPInteger forKey:@"DPInteger"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
-(void)yesDP {
    
    canActivateDP = YES;
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
-(void)noDP {
    
    canActivateDP = NO;
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//------------------------------------------TriplePoints------------------------------------------//
-(void)showTPAmount {
    NSLog(@"TriplePointsAmount:" @"%ld", (long)TPInteger);
}
-(void)buyTP {
    
    TPInteger += 1;
    hasTP = YES;
    [self yesTP];
    NSLog(@"TriplePointsAmount:" @"%ld", (long)TPInteger);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:TPInteger forKey:@"TPInteger"];
    [defaults synchronize];
    [self loadTPInteger];
}
-(void)cantBuyTP {
    NSLog(@"Need More Factory Bucks");
}
-(void)loadTPInteger {
    
    TPInteger = [[NSUserDefaults standardUserDefaults] integerForKey:@"TPInteger"];
    NSLog(@"TriplePointsAmount:" @"%ld", (long)TPInteger);
    if (TPInteger >= 1 & powerUpAmount > 0) {
        [self yesTP];
    }
    if (TPInteger == 0) {
        hasTP = NO;
        canActivateTP = NO;
    }

}
-(void)saveTPInteger {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:TPInteger forKey:@"TPInteger"];
    [defaults synchronize];
    
}
-(void)usedTP {
    
    if (TPInteger >= 1 & powerUpAmount > 0) {
        canActivateTP = YES;
        
        [[NSUserDefaults standardUserDefaults] setInteger:TPInteger forKey:@"TPInteger"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (TPInteger == 0) {
        hasTP = NO;
        canActivateTP = NO;
        [[NSUserDefaults standardUserDefaults] setInteger:TPInteger forKey:@"TPInteger"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}
-(void)yesTP {
    
    canActivateTP = YES;
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)noTP {
    
    canActivateTP = NO;
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//------------------------------------------QuadPoints------------------------------------------//
-(void)showQPAmount {
    NSLog(@"QuadPointsAmount:" @"%ld", (long)QPInteger);
}

-(void)buyQP {
    
    QPInteger += 1;
    hasQP = YES;
    [self yesQP];
    NSLog(@"QuadPointsAmount:" @"%ld", (long)QPInteger);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:QPInteger forKey:@"QPInteger"];
    [defaults synchronize];
    [self loadQPInteger];
}
-(void)cantBuyQP {
    NSLog(@"Need More Factory Bucks");
}
-(void)loadQPInteger {
    
    QPInteger = [[NSUserDefaults standardUserDefaults] integerForKey:@"QPInteger"];
    NSLog(@"QuadPointsAmount:" @"%ld", (long)QPInteger);
    if (QPInteger >= 1 & powerUpAmount > 0) {
        [self yesQP];
    }
    if (QPInteger == 0) {
        hasQP = NO;
        canActivateQP = NO;
    }
    
}
-(void)saveQPInteger {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:QPInteger forKey:@"QPInteger"];
    [defaults synchronize];
    
}
-(void)usedQP {
    
    if (QPInteger >= 1 & powerUpAmount > 0) {
        canActivateQP = YES;
        
        [[NSUserDefaults standardUserDefaults] setInteger:QPInteger forKey:@"QPInteger"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (QPInteger == 0) {
        hasQP = NO;
        canActivateQP = NO;
        [[NSUserDefaults standardUserDefaults] setInteger:QPInteger forKey:@"QPInteger"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}
-(void)yesQP {
    
    canActivateQP = YES;
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)noQP {
    
    canActivateQP = NO;
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//------------------------------------------ExtraLife1------------------------------------------//
-(void)showEL1Amount {
    NSLog(@"ExtraLife1Amount:" @"%ld", (long)EL1Integer);
}
-(void)buyEL1 {
    
    EL1Integer += 1;
    hasEL1 = YES;
    [self yesEL1];
    NSLog(@"ExtraLife1Amount:" @"%ld", (long)EL1Integer);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:EL1Integer forKey:@"EL1Integer"];
    [defaults synchronize];
    [self loadEL1Integer];
}
-(void)cantBuyEL1 {
    NSLog(@"Need More Factory Bucks");
}
-(void)loadEL1Integer {
    
    EL1Integer = [[NSUserDefaults standardUserDefaults] integerForKey:@"EL1Integer"];
    NSLog(@"ExtraLife2Amount:" @"%ld", (long)EL1Integer);
    if (EL1Integer >= 1 & powerUpAmount > 0) {
        [self yesEL1];
    }
    if (EL1Integer == 0) {
        hasEL1 = NO;
        canActivateEL1 = NO;
    }
    
}
-(void)saveEL1Integer {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:EL1Integer forKey:@"EL1Integer"];
    [defaults synchronize];
    
}
-(void)usedEL1 {
    
    if (EL1Integer >= 1 & powerUpAmount > 0) {
        canActivateEL1 = YES;
        
        [[NSUserDefaults standardUserDefaults] setInteger:EL1Integer forKey:@"EL1Integer"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (EL1Integer == 0) {
        hasEL1 = NO;
        canActivateEL1 = NO;
        [[NSUserDefaults standardUserDefaults] setInteger:EL1Integer forKey:@"EL1Integer"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}
-(void)yesEL1 {
    
    canActivateEL1 = YES;
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)noEL1 {
    
    canActivateEL1 = NO;
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//------------------------------------------ExtraLife2------------------------------------------//
-(void)showEL2Amount {
    NSLog(@"ExtraLife2Amount:" @"%ld", (long)EL2Integer);
}
-(void)buyEL2 {
    
    EL2Integer += 1;
    hasEL2 = YES;
    [self yesEL2];
    NSLog(@"ExtraLife2Amount:" @"%ld", (long)EL2Integer);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:EL2Integer forKey:@"EL2Integer"];
    [defaults synchronize];
    [self loadEL2Integer];
    
}
-(void)cantBuyEL2 {
    NSLog(@"Need More Factory Bucks");
}
-(void)loadEL2Integer {
    
    EL2Integer = [[NSUserDefaults standardUserDefaults] integerForKey:@"EL2Integer"];
    NSLog(@"ExtraLife2Amount:" @"%ld", (long)EL2Integer);
    if (EL2Integer >= 1 & powerUpAmount > 0) {
        [self yesEL2];
    }
    if (EL2Integer == 0) {
        hasEL2 = NO;
        canActivateEL2 = NO;
    }
    
}
-(void)saveEL2Integer {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:EL2Integer forKey:@"EL2Integer"];
    [defaults synchronize];
    
}
-(void)usedEL2 {
    
    if (EL2Integer >= 1 & powerUpAmount > 0) {
        canActivateEL2 = YES;
        
        [[NSUserDefaults standardUserDefaults] setInteger:EL2Integer forKey:@"EL2Integer"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (EL2Integer == 0) {
        hasEL2 = NO;
        canActivateEL2 = NO;
        [[NSUserDefaults standardUserDefaults] setInteger:EL2Integer forKey:@"EL2Integer"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}
-(void)yesEL2 {
    
    canActivateEL2 = YES;
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)noEL2 {
    
    canActivateEL2 = NO;
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//------------------------------------------ExtraLife3------------------------------------------//
-(void)showEL3Amount {
    NSLog(@"ExtraLife3Amount:" @"%ld", (long)EL3Integer);
}
-(void)buyEL3 {
    
    EL3Integer += 1;
    hasEL3 = YES;
    [self yesEL3];
    NSLog(@"ExtraLife3Amount:" @"%ld", (long)EL3Integer);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:EL3Integer forKey:@"EL3Integer"];
    [defaults synchronize];
    [self loadEL3Integer];
    
}
-(void)cantBuyEL3 {
    NSLog(@"Need More Factory Bucks");
}
-(void)loadEL3Integer {
    
    EL3Integer = [[NSUserDefaults standardUserDefaults] integerForKey:@"EL3Integer"];
    NSLog(@"ExtraLife3Amount:" @"%ld", (long)EL3Integer);
    if (EL3Integer >= 1 & powerUpAmount > 0) {
        [self yesEL3];
    }
    if (EL3Integer == 0) {
        hasEL3 = NO;
        canActivateEL3 = NO;
    }
    
}
-(void)saveEL3Integer {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:EL3Integer forKey:@"EL3Integer"];
    [defaults synchronize];
    
}
-(void)usedEL3 {
    
    if (EL3Integer >= 1 & powerUpAmount > 0) {
        canActivateEL3 = YES;
        
        [[NSUserDefaults standardUserDefaults] setInteger:EL3Integer forKey:@"EL3Integer"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (EL3Integer == 0) {
        hasEL3 = NO;
        canActivateEL3 = NO;
        [[NSUserDefaults standardUserDefaults] setInteger:EL3Integer forKey:@"EL3Integer"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}
-(void)yesEL3 {
    
    canActivateEL3 = YES;
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)noEL3 {
    
    canActivateEL3 = NO;
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//------------------------------------------10%hourGlass Code------------------------------------------//
-(void)showHG10Amount {
    NSLog(@"HourGlass10Amount:" @"%ld", (long)HG10Integer);
}
-(void)buyHG10 {
    
    HG10Integer += 1;
    hasHG10 = YES;
    [self yesHG10];
    NSLog(@"HourGlass10Amount:" @"%ld", (long)HG10Integer);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:HG10Integer forKey:@"HG10Integer"];
    [defaults synchronize];
    [self loadHG10Integer];
    
}
-(void)cantBuyHG10 {
    NSLog(@"Need More Factory Bucks");
}
-(void)loadHG10Integer {
    
    HG10Integer = [[NSUserDefaults standardUserDefaults] integerForKey:@"HG10Integer"];
    NSLog(@"HourGlass10Amount:" @"%ld", (long)HG10Integer);
    if (HG10Integer >= 1 & powerUpAmount > 0) {
        [self yesHG10];
    }
    if (HG10Integer == 0) {
        hasHG10 = NO;
        canActivateHG10 = NO;
    }
    
}
-(void)saveHG10Integer {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:HG10Integer forKey:@"HG10Integer"];
    [defaults synchronize];
    
}
-(void)usedHG10 {
    
    if (HG10Integer >= 1 & powerUpAmount > 0) {
        canActivateHG10 = YES;
        
        [[NSUserDefaults standardUserDefaults] setInteger:HG10Integer forKey:@"HG10Integer"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (HG10Integer == 0) {
        hasHG10 = NO;
        canActivateHG10 = NO;
        [[NSUserDefaults standardUserDefaults] setInteger:HG10Integer forKey:@"HG10Integer"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}
-(void)yesHG10 {
    
    canActivateHG10 = YES;
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)noHG10 {
    
    canActivateHG10 = NO;
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//------------------------------------------20%hourGlass Code------------------------------------------//
-(void)showHG20Amount {
    NSLog(@"HourGlass20Amount:" @"%ld", (long)HG20Integer);
}
-(void)buyHG20 {
    
    HG20Integer += 1;
    hasHG20 = YES;
    [self yesHG20];
    NSLog(@"HourGlass20Amount:" @"%ld", (long)HG20Integer);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:HG20Integer forKey:@"HG20Integer"];
    [defaults synchronize];
    [self loadHG20Integer];
    
}
-(void)cantBuyHG20 {
    NSLog(@"Need More Factory Bucks");
}
-(void)loadHG20Integer {
    
    HG20Integer = [[NSUserDefaults standardUserDefaults] integerForKey:@"HG20Integer"];
    NSLog(@"HourGlass20Amount:" @"%ld", (long)HG20Integer);
    if (HG20Integer >= 1 & powerUpAmount > 0) {
        [self yesHG20];
    }
    if (HG20Integer == 0) {
        hasHG20 = NO;
        canActivateHG20 = NO;
    }
    
}
-(void)saveHG20Integer {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:HG20Integer forKey:@"HG20Integer"];
    [defaults synchronize];
    
}
-(void)usedHG20 {
    
    if (HG20Integer >= 1 & powerUpAmount > 0) {
        canActivateHG20 = YES;
        
        [[NSUserDefaults standardUserDefaults] setInteger:HG20Integer forKey:@"HG20Integer"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (HG20Integer == 0) {
        hasHG20 = NO;
        canActivateHG20 = NO;
        [[NSUserDefaults standardUserDefaults] setInteger:HG20Integer forKey:@"HG20Integer"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}
-(void)yesHG20 {
    
    canActivateHG20 = YES;
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)noHG20 {
    
    canActivateHG20 = NO;
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//------------------------------------------30%hourGlass Code------------------------------------------//
-(void)showHG30Amount {
    NSLog(@"HourGlass30Amount:" @"%ld", (long)HG30Integer);
}
-(void)buyHG30 {
    
    HG30Integer += 1;
    hasHG30 = YES;
    [self yesHG30];
    NSLog(@"HourGlass30Amount:" @"%ld", (long)HG30Integer);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:HG30Integer forKey:@"HG30Integer"];
    [defaults synchronize];
    [self loadHG30Integer];

}
-(void)cantBuyHG30 {
    NSLog(@"Need More Factory Bucks");
}
-(void)loadHG30Integer {
    
    HG30Integer = [[NSUserDefaults standardUserDefaults] integerForKey:@"HG30Integer"];
    NSLog(@"HourGlass30Amount:" @"%ld", (long)HG30Integer);
    if (HG30Integer >= 1 & powerUpAmount > 0) {
        [self yesHG30];
    }
    if (HG30Integer == 0) {
        hasHG30 = NO;
        canActivateHG30 = NO;
    }
    
}
-(void)saveHG30Integer {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:HG30Integer forKey:@"HG30Integer"];
    [defaults synchronize];
    
}
-(void)usedHG30 {
    
    if (HG30Integer >= 1 & powerUpAmount > 0) {
        canActivateHG30 = YES;
        
        [[NSUserDefaults standardUserDefaults] setInteger:HG30Integer forKey:@"HG30Integer"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (HG30Integer == 0) {
        hasHG30 = NO;
        canActivateHG30 = NO;
        [[NSUserDefaults standardUserDefaults] setInteger:HG30Integer forKey:@"HG30Integer"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}
-(void)yesHG30 {
    
    canActivateHG30 = YES;
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)noHG30 {
    
    canActivateHG30 = NO;
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//------------------------------------------10%HeadStart Code------------------------------------------//
-(void)showHS10Amount {
    NSLog(@"HeadStart10Amount:" @"%ld", (long)HS10Integer);
}
-(void)buyHS10 {
    
    HS10Integer += 1;
    hasHS10 = YES;
    [self yesHS10];
    NSLog(@"HeadStart10Amount:" @"%ld", (long)HS10Integer);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:HS10Integer forKey:@"HS10Integer"];
    [defaults synchronize];
    [self loadHS10Integer];
    
}
-(void)cantBuyHS10 {
    NSLog(@"Need More Factory Bucks");
}
-(void)loadHS10Integer {
    
    HS10Integer = [[NSUserDefaults standardUserDefaults] integerForKey:@"HS10Integer"];
    NSLog(@"HeadStart10Amount:" @"%ld", (long)HS10Integer);
    if (HS10Integer >= 1 & powerUpAmount > 0) {
        [self yesHS10];
    }
    if (HS10Integer == 0) {
        hasHS10 = NO;
        canActivateHS10 = NO;
    }
    
}
-(void)saveHS10Integer {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:HS10Integer forKey:@"HS10Integer"];
    [defaults synchronize];
    
}
-(void)usedHS10 {
    
    if (HS10Integer >= 1 & powerUpAmount > 0) {
        canActivateHS10 = YES;
        
        [[NSUserDefaults standardUserDefaults] setInteger:HS10Integer forKey:@"HS10Integer"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (HS10Integer == 0) {
        hasHS10 = NO;
        canActivateHS10 = NO;
        [[NSUserDefaults standardUserDefaults] setInteger:HS10Integer forKey:@"HS10Integer"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}
-(void)yesHS10 {
    
    canActivateHS10 = YES;
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)noHS10 {
    
    canActivateHS10 = NO;
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//------------------------------------------20%HeadStart Code------------------------------------------//
-(void)showHS20Amount {
    NSLog(@"HeadStart20Amount:" @"%ld", (long)HS20Integer);
}
-(void)buyHS20 {
    
    HS20Integer += 1;
    hasHS20 = YES;
    [self yesHS20];
    NSLog(@"HeadStart20Amount:" @"%ld", (long)HS20Integer);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:HS20Integer forKey:@"HS20Integer"];
    [defaults synchronize];
    [self loadHS20Integer];
    
}
-(void)cantBuyHS20 {
    NSLog(@"Need More Factory Bucks");
}
-(void)loadHS20Integer {
    
    HS20Integer = [[NSUserDefaults standardUserDefaults] integerForKey:@"HS20Integer"];
    NSLog(@"HeadStart20Amount:" @"%ld", (long)HS20Integer);
    if (HS20Integer >= 1 & powerUpAmount > 0) {
        [self yesHS20];
    }
    if (HS20Integer == 0) {
        hasHS20 = NO;
        canActivateHS20 = NO;
    }
    
}
-(void)saveHS20Integer {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:HS20Integer forKey:@"HS20Integer"];
    [defaults synchronize];
    
}
-(void)usedHS20 {
    
    if (HS20Integer >= 1 & powerUpAmount > 0) {
        canActivateHS20 = YES;
        
        [[NSUserDefaults standardUserDefaults] setInteger:HS20Integer forKey:@"HS20Integer"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (HS20Integer == 0) {
        hasHS20 = NO;
        canActivateHS20 = NO;
        [[NSUserDefaults standardUserDefaults] setInteger:HS20Integer forKey:@"HS20Integer"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}
-(void)yesHS20 {
    
    canActivateHS20 = YES;
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)noHS20 {
    
    canActivateHS20 = NO;
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//------------------------------------------30%HeadStart Code------------------------------------------//
-(void)showHS30Amount {
    NSLog(@"HeadStart30Amount:" @"%ld", (long)HS30Integer);
}
-(void)buyHS30 {
    
    HS30Integer += 1;
    hasHS30 = YES;
    [self yesHS30];
    NSLog(@"HeadStart30Amount:" @"%ld", (long)HS30Integer);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:HS30Integer forKey:@"HS30Integer"];
    [defaults synchronize];
    [self loadHS30Integer];
    
}
-(void)cantBuyHS30 {
    NSLog(@"Need More Factory Bucks");
}
-(void)loadHS30Integer {
    
    HS30Integer = [[NSUserDefaults standardUserDefaults] integerForKey:@"HS30Integer"];
    NSLog(@"HeadStart30Amount:" @"%ld", (long)HS30Integer);
    if (HS30Integer >= 1 & powerUpAmount > 0) {
        [self yesHS30];
    }
    if (HS30Integer == 0) {
        hasHS30 = NO;
        canActivateHS30 = NO;
    }
    
}
-(void)saveHS30Integer {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:HS30Integer forKey:@"HS30Integer"];
    [defaults synchronize];
    
}
-(void)usedHS30 {
    
    if (HS30Integer >= 1 & powerUpAmount > 0) {
        canActivateHS30 = YES;
        
        [[NSUserDefaults standardUserDefaults] setInteger:HS30Integer forKey:@"HS30Integer"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (HS30Integer == 0) {
        hasHS30 = NO;
        canActivateHS30 = NO;
        [[NSUserDefaults standardUserDefaults] setInteger:HS30Integer forKey:@"HS30Integer"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}
-(void)yesHS30 {
    
    canActivateHS30 = YES;
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)noHS30 {
    
    canActivateHS30 = NO;
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//------------------------------------------Safe Pack Code------------------------------------------//

-(void)buySafePack {
    
    EL1Integer += 7;
    hasEL1 = YES;
    [self yesEL1];
    NSLog(@"ExtraLife1Amount:" @"%ld", (long)EL1Integer);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:EL1Integer forKey:@"EL1Integer"];
    [defaults synchronize];
    [self loadEL1Integer];
    
    EL2Integer += 3;
    hasEL2 = YES;
    [self yesEL2];
    NSLog(@"ExtraLife2Amount:" @"%ld", (long)EL2Integer);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
    [defaults1 setInteger:EL2Integer forKey:@"EL2Integer"];
    [defaults1 synchronize];
    [self loadEL2Integer];
    
    HG10Integer += 7;
    hasHG10 = YES;
    [self yesHG10];
    NSLog(@"HourGlass10Amount:" @"%ld", (long)HG10Integer);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults2 = [NSUserDefaults standardUserDefaults];
    [defaults2 setInteger:HG10Integer forKey:@"HG10Integer"];
    [defaults2 synchronize];
    [self loadHG10Integer];
    
    HG20Integer += 3;
    hasHG20 = YES;
    [self yesHG20];
    NSLog(@"HourGlass20Amount:" @"%ld", (long)HG20Integer);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults3 = [NSUserDefaults standardUserDefaults];
    [defaults3 setInteger:HG20Integer forKey:@"HG20Integer"];
    [defaults3 synchronize];
    [self loadHG20Integer];
    
    HS10Integer += 7;
    hasHS10 = YES;
    [self yesHS10];
    NSLog(@"HeadStart10Amount:" @"%ld", (long)HS10Integer);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults4 = [NSUserDefaults standardUserDefaults];
    [defaults4 setInteger:HS10Integer forKey:@"HS10Integer"];
    [defaults4 synchronize];
    [self loadHS10Integer];
    
    HS20Integer += 3;
    hasHS20 = YES;
    [self yesHS20];
    NSLog(@"HeadStart20Amount:" @"%ld", (long)HS20Integer);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults5 = [NSUserDefaults standardUserDefaults];
    [defaults5 setInteger:HS20Integer forKey:@"HS20Integer"];
    [defaults5 synchronize];
    [self loadHS20Integer];
    
    DPInteger += 7;
    hasDP = YES;
    [self yesDP];
    NSLog(@"DoublePointsAmount:" @"%ld", (long)DPInteger);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults6 = [NSUserDefaults standardUserDefaults];
    [defaults6 setInteger:DPInteger forKey:@"DPInteger"];
    [defaults6 synchronize];
    [self loadDPInteger];
    
    TPInteger += 3;
    hasTP = YES;
    [self yesTP];
    NSLog(@"TriplePointsAmount:" @"%ld", (long)TPInteger);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults7 = [NSUserDefaults standardUserDefaults];
    [defaults7 setInteger:TPInteger forKey:@"TPInteger"];
    [defaults7 synchronize];
    [self loadTPInteger];
    
}

//------------------------------------------Invisible Pack Code------------------------------------------//

-(void)buyInvinsiblePack {
    
    EL1Integer += 3;
    hasEL1 = YES;
    [self yesEL1];
    NSLog(@"ExtraLife1Amount:" @"%ld", (long)EL1Integer);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:EL1Integer forKey:@"EL1Integer"];
    [defaults synchronize];
    [self loadEL1Integer];
    
    EL2Integer += 7;
    hasEL2 = YES;
    [self yesEL2];
    NSLog(@"ExtraLife2Amount:" @"%ld", (long)EL2Integer);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
    [defaults1 setInteger:EL2Integer forKey:@"EL2Integer"];
    [defaults1 synchronize];
    [self loadEL2Integer];
    
    HG10Integer += 3;
    hasHG10 = YES;
    [self yesHG10];
    NSLog(@"HourGlass10Amount:" @"%ld", (long)HG10Integer);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults2 = [NSUserDefaults standardUserDefaults];
    [defaults2 setInteger:HG10Integer forKey:@"HG10Integer"];
    [defaults2 synchronize];
    [self loadHG10Integer];
    
    HG20Integer += 7;
    hasHG20 = YES;
    [self yesHG20];
    NSLog(@"HourGlass20Amount:" @"%ld", (long)HG20Integer);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults3 = [NSUserDefaults standardUserDefaults];
    [defaults3 setInteger:HG20Integer forKey:@"HG20Integer"];
    [defaults3 synchronize];
    [self loadHG20Integer];
    
    HS10Integer += 3;
    hasHS10 = YES;
    [self yesHS10];
    NSLog(@"HeadStart10Amount:" @"%ld", (long)HS10Integer);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults4 = [NSUserDefaults standardUserDefaults];
    [defaults4 setInteger:HS10Integer forKey:@"HS10Integer"];
    [defaults4 synchronize];
    [self loadHS10Integer];
    
    HS20Integer += 7;
    hasHS20 = YES;
    [self yesHS20];
    NSLog(@"HeadStart20Amount:" @"%ld", (long)HS20Integer);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults5 = [NSUserDefaults standardUserDefaults];
    [defaults5 setInteger:HS20Integer forKey:@"HS20Integer"];
    [defaults5 synchronize];
    [self loadHS20Integer];
    
    DPInteger += 3;
    hasDP = YES;
    [self yesDP];
    NSLog(@"DoublePointsAmount:" @"%ld", (long)DPInteger);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults6 = [NSUserDefaults standardUserDefaults];
    [defaults6 setInteger:DPInteger forKey:@"DPInteger"];
    [defaults6 synchronize];
    [self loadDPInteger];
    
    TPInteger += 7;
    hasTP = YES;
    [self yesTP];
    NSLog(@"TriplePointsAmount:" @"%ld", (long)TPInteger);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults7 = [NSUserDefaults standardUserDefaults];
    [defaults7 setInteger:TPInteger forKey:@"TPInteger"];
    [defaults7 synchronize];
    [self loadTPInteger];
    
}

//------------------------------------------God Pack Code------------------------------------------//

-(void)buyGodPack {
    
    TPInteger += 3;
    hasTP = YES;
    [self yesTP];
    NSLog(@"TriplePointsAmount:" @"%ld", (long)TPInteger);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:TPInteger forKey:@"TPInteger"];
    [defaults synchronize];
    [self loadTPInteger];
    
    QPInteger += 7;
    hasQP = YES;
    [self yesQP];
    NSLog(@"QuadPointsAmount:" @"%ld", (long)QPInteger);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
    [defaults1 setInteger:QPInteger forKey:@"QPInteger"];
    [defaults1 synchronize];
    [self loadQPInteger];
    
    EL2Integer += 3;
    hasEL2 = YES;
    [self yesEL2];
    NSLog(@"ExtraLife2Amount:" @"%ld", (long)EL2Integer);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults2 = [NSUserDefaults standardUserDefaults];
    [defaults2 setInteger:EL2Integer forKey:@"EL2Integer"];
    [defaults2 synchronize];
    [self loadEL2Integer];
    
    EL3Integer += 7;
    hasEL3 = YES;
    [self yesEL3];
    NSLog(@"ExtraLife3Amount:" @"%ld", (long)EL3Integer);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults3 = [NSUserDefaults standardUserDefaults];
    [defaults3 setInteger:EL3Integer forKey:@"EL3Integer"];
    [defaults3 synchronize];
    [self loadEL3Integer];
    
    HG20Integer += 3;
    hasHG20 = YES;
    [self yesHG20];
    NSLog(@"HourGlass20Amount:" @"%ld", (long)HG20Integer);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults4 = [NSUserDefaults standardUserDefaults];
    [defaults4 setInteger:HG20Integer forKey:@"HG20Integer"];
    [defaults4 synchronize];
    [self loadHG20Integer];
    
    HG30Integer += 7;
    hasHG30 = YES;
    [self yesHG30];
    NSLog(@"HourGlass30Amount:" @"%ld", (long)HG30Integer);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults5 = [NSUserDefaults standardUserDefaults];
    [defaults5 setInteger:HG30Integer forKey:@"HG30Integer"];
    [defaults5 synchronize];
    [self loadHG30Integer];
    
    HS20Integer += 3;
    hasHS20 = YES;
    [self yesHS20];
    NSLog(@"HeadStart20Amount:" @"%ld", (long)HS20Integer);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults6 = [NSUserDefaults standardUserDefaults];
    [defaults6 setInteger:HS20Integer forKey:@"HS20Integer"];
    [defaults6 synchronize];
    [self loadHS20Integer];
    
    HS30Integer += 7;
    hasHS30 = YES;
    [self yesHS30];
    NSLog(@"HeadStart30Amount:" @"%ld", (long)HS30Integer);
    //NSLog(@"BUYING");
    NSUserDefaults *defaults7 = [NSUserDefaults standardUserDefaults];
    [defaults7 setInteger:HS30Integer forKey:@"HS30Integer"];
    [defaults7 synchronize];
    [self loadHS30Integer];
}

@end
