//
//  PowerUpLogic.h
//  Factory Fall
//
//  Created by Willie on 3/17/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import <Foundation/Foundation.h>

int powerUpAmount;
NSInteger upDateLvl;

@interface PowerUpLogic : NSObject

-(void)decrementBy1;
-(void)powerUpAmountCheck;
-(void)updatePowerUpAmount;
-(void)maxPowerUpAmount;
-(void)loadMaxPowerUpAmount;
@end
