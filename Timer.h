//
//  Timer.h
//  Factory Fall
//
//  Created by Willie on 5/8/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>


@interface Timer : SKLabelNode
@property int secondsTime;
+(id)TimerWithFontNamed:(NSString *)fontName;
-(void)setPoints:(int)points;
-(void)runTimer;
-(void)setTimer;


@end
