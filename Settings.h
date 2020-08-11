//
//  Settings.h
//  Factory Fall
//
//  Created by Willie on 6/9/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

BOOL soundOn;

@interface Settings : SKScene <SKPhysicsContactDelegate, AVAudioPlayerDelegate> {
    
    SKTexture *offButtonTexture;
    SKSpriteNode *offButton;
    
    SKTexture *offButtonPressedTexture;
    SKSpriteNode *offButtonPressed;
    
    SKTexture *onButtonTexture;
    SKSpriteNode *onButton;
    
    SKTexture *onButtonPressedTexture;
    SKSpriteNode *onButtonPressed;
    
    SKTexture *homeButtonTexture;
    SKSpriteNode *homeButton;
    
    
    NSUserDefaults *off;
    NSUserDefaults *on;
    AVAudioPlayer *click;
    NSURL *music;
}
@property (nonatomic, weak) SKView *skView;
-(void)loadSoundOnOrOff;
-(void)playTheme;
@end
