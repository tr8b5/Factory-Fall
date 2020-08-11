//
//  NMPointsLabel.m
//  Factory Fall
//
//  Created by Willie on 1/19/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import "NMPointsLabel.h"
#import "GameScene.h"

@implementation NMPointsLabel

+(id)pointsLabelWithFontNamed:(NSString *)fontName
{
    NMPointsLabel *pointsLabel = [NMPointsLabel labelNodeWithFontNamed:fontName];
    pointsLabel.text = @"0";
    pointsLabel.number = 0;
    return pointsLabel;
}

-(void)decrementTimerText:(NSInteger)time {
    
    self.secondsCount = self.secondsCount - 1;
    self.minutes = self.secondsCount / 60;
    self.seconds = self.secondsCount - (self.minutes * 60);
    
    self.text = [NSString stringWithFormat:@"%ld:%02ld" , (long)self.minutes, (long)self.seconds];
    self.number = time;
    
}
-(void)incrementTimerText:(NSInteger)time {
    
    self.secondsCount = self.secondsCount + 1;
    self.minutes = self.secondsCount / 60;
    self.seconds = self.secondsCount - (self.minutes * 60);
    
    self.text = [NSString stringWithFormat:@"%ld:%02ld" , (long)self.minutes, (long)self.seconds];
    self.number = time;
    
}
-(void)incrementTimerNumber {
    
    self.number += 1;
    self.text = [NSString stringWithFormat:@"%ld:%02ld" , (long)self.minutes, (long)self.seconds];
    
}
-(void)setTimer:(NSInteger)time
{
    self.secondsCount = time;
    self.minutes = self.secondsCount / 60;
    self.seconds = self.secondsCount - (self.minutes * 60);
    self.text = [NSString stringWithFormat:@"%ld:%02ld" , (long)self.minutes, (long)self.seconds];
    self.number = time;
    
}
-(void)decrementTimerNumber {
    
    self.number -= 1;
    self.text = [NSString stringWithFormat:@"%ld:%02ld" , (long)self.minutes, (long)self.seconds];
    
}
-(void)decrementBy1
{
    self.number -= 1;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy1
{
    self.number += 1;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy2
{
    self.number += 2;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy3
{
    self.number += 3;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy4
{
    self.number += 4;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy5
{
    self.number += 5;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy6
{
    self.number += 6;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy7
{
    self.number += 7;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy8
{
    self.number += 8;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy9
{
    self.number += 9;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy10
{
    self.number += 10;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy11
{
    self.number += 11;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy12
{
    self.number += 12;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy13
{
    self.number += 13;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy14
{
    self.number += 14;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy15
{
    self.number += 15;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy16
{
    self.number += 16;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy17
{
    self.number += 17;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy18
{
    self.number += 18;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy19
{
    self.number += 19;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy20
{
    self.number += 20;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy21
{
    self.number += 21;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy22
{
    self.number += 22;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy23
{
    self.number += 23;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy24
{
    self.number += 24;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy25
{
    self.number += 25;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy26
{
    self.number += 26;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy27
{
    self.number += 27;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy28
{
    self.number += 28;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy29
{
    self.number += 29;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy30
{
    self.number += 30;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy31
{
    self.number += 31;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy32
{
    self.number += 32;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy33
{
    self.number += 33;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    }
-(void)incrementBy34
{
    self.number += 34;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy35
{
    self.number += 35;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy36
{
    self.number += 36;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy37
{
    self.number += 37;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy38
{
    self.number += 38;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy39
{
    self.number += 39;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy40
{
    self.number += 40;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
    
}
-(void)incrementBy500
{
    self.number += 500;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    //NSLog(@"%i", self.number);
}
-(void)setPoints:(NSInteger)points
{
    self.number = points;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    
}
-(void)givePoints:(NSInteger)pointValue
{
    self.number = pointValue;
    self.text = [NSString stringWithFormat:@"%li", (long)self.number];
    
}
-(void)reset
{
    self.number = 0;
    self.text = @"0";
}
@end
