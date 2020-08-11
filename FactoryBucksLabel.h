//
//  FactoryBucksLabel.h
//  Factory Fall
//
//  Created by Willie on 2/25/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

NSInteger payAmount;
NSInteger payAprox;

@interface FactoryBucksLabel : SKLabelNode 
@property NSInteger amount;
+(id)FBLabelWithFontNamed:(NSString *)fontName;
-(void)incrementAmount;
-(void)incrementBy500;
-(void)incrementBy750;
-(void)incrementBy1000;
-(void)incrementBy1250;
-(void)incrementBy2000;
-(void)incrementBy3000;
-(void)incrementBy4000;
-(void)incrementBy5500;
-(void)incrementBy6000;
-(void)incrementBy7000;
-(void)incrementBy8000;
-(void)incrementBy8500;
-(void)incrementBy9000;
-(void)incrementBy30000;
-(void)incrementBy5000;
-(void)incrementBy10000;
-(void)incrementBy27000;
-(void)incrementBy45000;
-(void)incrementBy50000;
-(void)incrementBy72000;
-(void)incrementBy75000;
-(void)incrementBy100000;
-(void)incrementBy144000;
-(void)incrementBy150000;
-(void)incrementBy300000;
-(void)decrementBy1000;
-(void)decrementBy3000;
-(void)decrementBy6000;
-(void)decrementBy9000;
-(void)decrementBy10000;
-(void)decrementBy20000;
-(void)setPoints:(NSInteger)points;
@end
