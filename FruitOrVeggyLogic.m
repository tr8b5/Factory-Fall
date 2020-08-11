//
//  FruitOrVeggyLogic.m
//  Factory Fall
//
//  Created by Willie on 6/12/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import "FruitOrVeggyLogic.h"
#import "GameScene.h"
#import "NormalLogic.h"
#import "Food.h"
#import "ArcadeMenu.h"
#import "GameViewController.h"
#import "NMPointsLabel.h"
#import "MainMenu.h"
#import "FactoryBucksLabel.h"
#import "FBLabelLogic.h"
#import "RankLogic.h"
#import "ShopLogic.h"
#import "PowerUpLogic.h"
#import "PowerUpAmountsLabel.h"
#import "Data.h"

@implementation FruitOrVeggyLogic

-(void)loadInitialData {
    
    Data *FBCount = [[Data alloc]init];
    [FBCount loadAmountFB];
    
    RankLogic *currentGameCheck = [[RankLogic alloc]init];
    [currentGameCheck loadCurrentGameNumber];
    
    RankLogic *maxPlayCheck = [[RankLogic alloc]init];
    [maxPlayCheck loadCurrentMaxPlaysLvl];
    
    RankLogic *gameCheck = [[RankLogic alloc]init];
    [gameCheck currentGame];
    
    RankLogic *load = [[RankLogic alloc]init];
    [load loadRankValues];
    
    PowerUpLogic *PAmountCheck = [[PowerUpLogic alloc]init];
    [PAmountCheck powerUpAmountCheck];
    
    PowerUpLogic *loadMaxPAAmount = [[PowerUpLogic alloc]init];
    [loadMaxPAAmount loadMaxPowerUpAmount];
    
    PowerUpLogic *maxPAmount = [[PowerUpLogic alloc]init];
    [maxPAmount maxPowerUpAmount];
    
    ShopLogic *showDP = [[ShopLogic alloc]init];
    [showDP loadDPInteger];
    
    
    ShopLogic *showTP = [[ShopLogic alloc]init];
    [showTP loadTPInteger];
    
    
    ShopLogic *showQP = [[ShopLogic alloc]init];
    [showQP loadQPInteger];
    
    
    ShopLogic *showEL1 = [[ShopLogic alloc]init];
    [showEL1 loadEL1Integer];
    
    
    ShopLogic *showEL2 = [[ShopLogic alloc]init];
    [showEL2 loadEL2Integer];
    
    
    ShopLogic *showEL3 = [[ShopLogic alloc]init];
    [showEL3 loadEL3Integer];
    
    
    ShopLogic *showHG10 = [[ShopLogic alloc]init];
    [showHG10 loadHG10Integer];
    
    
    ShopLogic *showHG20 = [[ShopLogic alloc]init];
    [showHG20 loadHG20Integer];
    
    
    ShopLogic *showHG30 = [[ShopLogic alloc]init];
    [showHG30 loadHG30Integer];
    
    
    ShopLogic *showHS10 = [[ShopLogic alloc]init];
    [showHS10 loadHS10Integer];
    
    
    ShopLogic *showHS20 = [[ShopLogic alloc]init];
    [showHS20 loadHS20Integer];
    
    
    ShopLogic *showHS30 = [[ShopLogic alloc]init];
    [showHS30 loadHS30Integer];
}

@end
