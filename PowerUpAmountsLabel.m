
//
//  PowerUpAmountsLabel.m
//  Factory Fall
//
//  Created by Willie on 3/26/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import "PowerUpAmountsLabel.h"
#import "ShopLogic.h"

@implementation PowerUpAmountsLabel
+(id)powerUpsLabelWithFontNamed:(NSString *)fontName
{
    PowerUpAmountsLabel *powerUpsLabel = [PowerUpAmountsLabel labelNodeWithFontNamed:fontName];
    powerUpsLabel.text = @"0";
    powerUpsLabel.number = 0;
    
    
    return powerUpsLabel;
}

-(void)incrementBy1
{
    self.number += 1;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    NSLog(@"DFGDGC" @"%li", (long)self.number);
    
}
-(void)incrementBy5
{
    self.number += 5;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    NSLog(@"DFGDGC" @"%li", (long)self.number);
    
}
-(void)decrementBy1
{
    self.number -= 1;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    NSLog(@"DFGDGC" @"%li", (long)self.number);
    
}
-(void)setPoints:(NSInteger)points
{
    self.number = points;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    
}
@end
