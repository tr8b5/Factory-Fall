//
//  DailyChallengeLogic.h
//  Factory Fall
//
//  Created by Willie on 3/29/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import <Foundation/Foundation.h>

int maxDailyNum;
int updateMDN;
int easyNum;
int medNum;
int hardNum;
BOOL easyMode;
BOOL mediumMode;
BOOL hardMode;

@interface DailyChallengeLogic : NSObject

-(void)maxDailyNumCheck;
-(void)decrementMaxDailyNum;
-(void)updateMDNAmount;
-(void)updateMDNCheck;
-(void)incrementUpdateMDN;
-(void)randomEasyMode;
-(void)randomMediumMode;
-(void)randomHardMode;
-(void)easyModeNum1;
-(void)easyModeNum2;
-(void)easyModeNum3;
-(void)mediumModeNum1;
-(void)mediumModeNum2;
-(void)mediumModeNum3;
-(void)hardModeNum1;
-(void)hardModeNum2;
-(void)hardModeNum3;

@end
