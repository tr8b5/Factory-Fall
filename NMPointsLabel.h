//
//  NMPointsLabel.h
//  Factory Fall
//
//  Created by Willie on 1/19/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface NMPointsLabel : SKLabelNode {
    //NSString *timerOutput;
}
@property NSInteger number;
@property NSInteger secondsCount;
@property NSInteger minutes;
@property NSInteger seconds;
+(id)pointsLabelWithFontNamed:(NSString *)fontName;
-(void)decrementTimerText:(NSInteger)time;
-(void)incrementTimerText:(NSInteger)time;
-(void)decrementTimerNumber;
-(void)incrementTimerNumber;
-(void)decrementBy1;
-(void)incrementBy1;
-(void)incrementBy2;
-(void)incrementBy3;
-(void)incrementBy4;
-(void)incrementBy5;
-(void)incrementBy6;
-(void)incrementBy7;
-(void)incrementBy8;
-(void)incrementBy9;
-(void)incrementBy10;
-(void)incrementBy11;
-(void)incrementBy12;
-(void)incrementBy13;
-(void)incrementBy14;
-(void)incrementBy15;
-(void)incrementBy16;
-(void)incrementBy17;
-(void)incrementBy18;
-(void)incrementBy19;
-(void)incrementBy20;
-(void)incrementBy21;
-(void)incrementBy22;
-(void)incrementBy23;
-(void)incrementBy24;
-(void)incrementBy25;
-(void)incrementBy26;
-(void)incrementBy27;
-(void)incrementBy28;
-(void)incrementBy29;
-(void)incrementBy30;
-(void)incrementBy31;
-(void)incrementBy32;
-(void)incrementBy33;
-(void)incrementBy34;
-(void)incrementBy35;
-(void)incrementBy36;
-(void)incrementBy37;
-(void)incrementBy38;
-(void)incrementBy39;
-(void)incrementBy40;
-(void)incrementBy500;
-(void)setPoints:(NSInteger)points;
-(void)reset;
-(void)givePoints:(NSInteger)pointValue;
-(void)setTimer:(NSInteger)time;
@end
