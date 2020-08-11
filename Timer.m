//
//  Timer.m
//  Factory Fall
//
//  Created by Willie on 5/8/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import "Timer.h"
/*
 - Be sure to add a timely decrement to the timer
 - Fix Problems 
 -and remenber to show the timer
 */

@implementation Timer
+(id)TimerWithFontNamed:(NSString *)fontName
{
    Timer *time = [Timer labelNodeWithFontNamed:@"TrebuchetMS"];
    //time.text = @"00:00";
    //time.secondsTime = 00.10;
    
    return time;
}
-(void)runTimer
{
    self.secondsTime = self.secondsTime - 1;
    int minutes = self.secondsTime / 60;
    int seconds = self.secondsTime - (minutes * 60);
    
    NSString *timerView = [NSString stringWithFormat:@"%2d:%.2d", minutes, seconds];
    self.text = timerView;
    
}
-(void)setTimer {
    self.secondsTime = 10;
    
    SKAction *runFunction = [SKAction performSelector:@selector(runTimer) onTarget:self];
    SKAction *waitFor = [SKAction waitForDuration:1];
    SKAction *countdownSequence = [SKAction sequence:@[waitFor,runFunction]];
    SKAction *repeatCountdown = [SKAction repeatAction:countdownSequence count:10];
    [self runAction:repeatCountdown];
}
-(void)setPoints:(int)points {
    self.secondsTime = points;
    int hour = self.secondsTime;
    int minutes = self.secondsTime;
    int seconds = self.secondsTime;
    self.text = [NSString stringWithFormat:@"%02d:%02d:%02.0d", hour, minutes, seconds];
}


@end
