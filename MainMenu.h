//
//  MainMenu.h
//  Factory Fall
//
//  Created by Willie on 1/12/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MainMenu : SKScene <SKPhysicsContactDelegate, AVAudioPlayerDelegate> {
    
    SKTextureAtlas *cloudsSprites;
    SKSpriteNode *clouds;
    SKTexture *cloudsTexture;
    SKSpriteNode *factory;
    SKTexture *factoryTexture;
    SKSpriteNode *bushes;
    SKTexture *bushesTexture;
    SKSpriteNode *title;
    SKTexture *titleTexture;
    SKSpriteNode *play;
    SKTexture *playTexture;
    SKSpriteNode *settings;
    SKTexture *settingsTexture;
    SKSpriteNode *vault;
    SKTexture *vaultTexture;
    SKSpriteNode *shop;
    SKTexture *shopTexture;
    SKSpriteNode *sunAndMoon;
    SKTexture *sunAndMoonTexture;
    SKSpriteNode *dayAndNight;
    SKTexture *dayAndNightTexture;
    SKSpriteNode *stars;
    SKTexture *starsTexture;
    SKSpriteNode *dailyCHallengesText;
    SKTexture *dailyCHallengesTextsTexture;
    SKSpriteNode *dailyChallengesBoard;
    SKTexture *dailyChallengesBoardTexture;
    SKSpriteNode *dailyChallengesBorder;
    SKTexture *dailyChallengesBorderTexture;
    SKSpriteNode *planets;
    SKTexture *planetsTexture;
    SKSpriteNode *factoryShadow;
    SKTexture *factoryShadowTexture;
    SKSpriteNode *playShadow;
    SKTexture *playShadowTexture;
    SKSpriteNode *settingsShadow;
    SKTexture *settingsShadowTexture;
    SKSpriteNode *vaultShadow;
    SKTexture *vaultShadowTexture;
    SKSpriteNode *shopShadow;
    SKTexture *shopShadowTexture;
    SKSpriteNode *filter;
    SKTexture *filterTexture;
    SKSpriteNode *quickPlay;
    SKTexture *quickPlayTexture;
    SKTextureAtlas *mainMenuSprites;
    SKSpriteNode *background;
    SKTexture *backgroundTexture;
    
    
    AVAudioPlayer *audioPlayer1;
    AVAudioPlayer *FallSound;
    AVAudioPlayer *windSound;
    AVAudioPlayer *popSound;
    AVAudioPlayer *popSound1;
    AVAudioPlayer *popSound2;
    AVAudioPlayer *popSound3;
    AVAudioPlayer *popSound4;
    AVAudioPlayer *swishSound;
    AVAudioPlayer *swishSound1;
    AVAudioPlayer *swishSound2;
    AVAudioPlayer *swishSound3;
    AVAudioPlayer *swishSound4;
    AVAudioPlayer *swishSound5;
    AVAudioPlayer *swishSound6;
    AVAudioPlayer *clickSound;
    AVAudioPlayer *shakeSound;
    
    SKAudioNode *qpSound;
}
@property (nonatomic, weak) SKView *skView;
@property (nonatomic) BOOL isMoving;

@end
