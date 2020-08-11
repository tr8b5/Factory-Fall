//
//  VictoryPrizeScreen.h
//  Factory Fall
//
//  Created by Willie on 6/17/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

BOOL showGoldEagle;
BOOL showGoldGloves;
BOOL showGoldAcorn;
BOOL showGoldApple;
BOOL showGoldBar;
BOOL showGoldChalice;
BOOL showGoldEagle;
BOOL showGoldGolfClub;
BOOL showGoldMicrophone;
BOOL showGoldSwords;
BOOL showGoldUnicron;
BOOL showGoldWatch;
BOOL prizeAquired;

@interface VictoryPrizeScreen : SKScene <AVAudioPlayerDelegate> {
    
    SKSpriteNode *background;
    SKTexture *backgroundTexture;
    AVAudioPlayer *applause;
    //AVAudioPlayer *prizeCollected;
    AVAudioPlayer *victorySound;
    
    SKTextureAtlas *victoryPrizeScene1;
    SKTextureAtlas *victoryPrizeScene2;
    
}

@property (nonatomic, weak) SKView *skView;

-(void)eagleAnimation;
-(void)acornAnimation;
-(void)barAnimation;
-(void)chaliceAnimation;
-(void)glovesAnimation;
-(void)golfClubAnimation;
-(void)microphoneAnimation;
-(void)swordsAnimation;
-(void)unicornAnimation;
-(void)watchAnimation;
@end
