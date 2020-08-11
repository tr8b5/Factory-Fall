//
//  Tutorial.h
//  Factory Fall
//
//  Created by Willie on 4/7/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

BOOL tutorialFruit;
BOOL tutorialVeggy;
BOOL tutorialOther;

@interface Tutorial : SKScene <SKPhysicsContactDelegate, AVAudioPlayerDelegate> {
    SKSpriteNode *three;
    SKSpriteNode *two;
    SKSpriteNode *one;
    SKSpriteNode *tutorial;
    SKSpriteNode *apple;
    SKSpriteNode *blackScreen;
    SKSpriteNode *broccoli;
    SKSpriteNode *pizza;
    SKSpriteNode *foodCatcher;
    SKSpriteNode *foodDropper;
    SKSpriteNode *leftSensor;
    SKSpriteNode *rightSensor;
    SKSpriteNode *bottomSensor;
}
@property (nonatomic) BOOL canSlide;
@end
