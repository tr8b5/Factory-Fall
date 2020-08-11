//
//  PowerUpLogic.m
//  Factory Fall
//
//  Created by Willie on 3/17/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import "PowerUpLogic.h"

@implementation PowerUpLogic

-(void)powerUpAmountCheck {
    
    NSLog(@"%d", powerUpAmount);
    [[NSUserDefaults standardUserDefaults] setInteger:powerUpAmount forKey:@"powerUpAmount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
-(void)saveMaxPowerUpAmount {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:upDateLvl forKey:@"upDateLvl"];
    [defaults synchronize];
}
-(void)loadMaxPowerUpAmount {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    upDateLvl = [defaults integerForKey:@"upDateLvl"];
    NSLog(@"%ld", (long)upDateLvl);
}
-(void)decrementBy1 {
    
    if (powerUpAmount > 0) {
        powerUpAmount -= 1;
    }
    if (powerUpAmount == 0) {
        powerUpAmount = 0;
    }
}
-(void)updatePowerUpAmount {
    
    upDateLvl += 1;
    [self saveMaxPowerUpAmount];
    [self loadMaxPowerUpAmount];
}
-(void)maxPowerUpAmount {
    
    if (upDateLvl == 0) {
        powerUpAmount = 21;
    }
    if (upDateLvl == 1) {
        powerUpAmount = 4;
    }
    if (upDateLvl == 2) {
        powerUpAmount = 5;
    }
    if (upDateLvl == 3) {
        powerUpAmount = 6;
    }
    if (upDateLvl == 4) {
        powerUpAmount = 7;
    }
    if (upDateLvl == 5) {
        powerUpAmount = 8;
    }
    if (upDateLvl == 6) {
        powerUpAmount = 9;
    }
    if (upDateLvl == 7) {
        powerUpAmount = 10;
    }
}



@end
