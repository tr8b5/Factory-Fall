//
//  DailyChallengeLogic.m
//  Factory Fall
//
//  Created by Willie on 3/29/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import "DailyChallengeLogic.h"

@implementation DailyChallengeLogic

-(void)updateMDNCheck {
    NSLog(@"%d", updateMDN);
    [[NSUserDefaults standardUserDefaults] setInteger:updateMDN forKey:@"updateMDN"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
-(void)incrementUpdateMDN {
    updateMDN += 1;
}
-(void)updateMDNAmount {
    if (updateMDN == 0) {
        maxDailyNum = 3;
    }
    if (updateMDN == 1) {
        maxDailyNum = 4;
    }
    if (updateMDN == 2) {
        maxDailyNum = 5;
    }
    if (updateMDN == 3) {
        maxDailyNum = 6;
    }
    if (updateMDN == 4) {
        maxDailyNum = 7;
    }
    if (updateMDN == 5) {
        maxDailyNum = 8;
    }
    if (updateMDN == 6) {
        maxDailyNum = 9;
    }
    if (updateMDN == 7) {
        maxDailyNum = 10;
    }
}
-(void)maxDailyNumCheck {
    NSLog(@"%d", maxDailyNum);
    [[NSUserDefaults standardUserDefaults] setInteger:maxDailyNum forKey:@"maxDailyNum"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)decrementMaxDailyNum {
    maxDailyNum -= 1;
}
-(void)randomEasyMode {
    
    easyMode = YES;
    easyNum = arc4random_uniform(3) + 1;
    NSLog(@"%d", easyNum);
}
-(void)randomMediumMode {
    
    mediumMode = YES;
    medNum = arc4random_uniform(3) + 1;

    
}
-(void)randomHardMode {
    
    hardMode = YES;
    hardNum = arc4random_uniform(3) + 1;

    
}
-(void)easyModeNum1 {
    easyMode = YES;
    easyNum = 1;
}
-(void)easyModeNum2 {
    easyMode = YES;
    easyNum = 2;
}
-(void)easyModeNum3 {
    easyMode = YES;
    easyNum = 3;
}
-(void)mediumModeNum1 {
    mediumMode = YES;
    medNum = 1;
}
-(void)mediumModeNum2 {
    mediumMode = YES;
    medNum = 2;
}
-(void)mediumModeNum3 {
    mediumMode = YES;
    medNum = 3;
}
-(void)hardModeNum1 {
    hardMode = YES;
    hardNum = 1;
}
-(void)hardModeNum2 {
    hardMode = YES;
    hardNum = 2;
}
-(void)hardModeNum3 {
    hardMode = YES;
    hardNum = 3;
}
@end
