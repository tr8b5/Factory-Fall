//
//  PowerUpAmountsLabel.h
//  Factory Fall
//
//  Created by Willie on 3/26/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>



@interface PowerUpAmountsLabel : SKLabelNode
@property NSInteger number;
+(id)powerUpsLabelWithFontNamed:(NSString *)fontName;
-(void)incrementBy1;
-(void)incrementBy5;
-(void)decrementBy1;
-(void)setPoints:(NSInteger)points;
@end
