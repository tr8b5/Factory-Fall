//
//  ArcadeMenu.h
//  Factory Fall
//
//  Created by Willie on 1/12/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>
#import <GLKit/GLKit.h>

BOOL canPlayRank0;
BOOL canPlayRank1;
BOOL canPlayRank2;
BOOL canPlayRank3;
BOOL canPlayRank4;
BOOL canPlayRank5;
BOOL canPlayRank6;
BOOL canPlayRank7;
BOOL canPlayRank8;
BOOL canPlayRank9;
BOOL canPlayRank10;
BOOL canPlayRank11;
BOOL canPlayRank12;
BOOL canPlayRank13;
BOOL canPlayRank14;
BOOL canPlayRank15;
BOOL canPlayRank16;
BOOL canPlayRank17;
BOOL canPlayRank18;
BOOL canPlayRank19;
BOOL canPlayRank20;
BOOL canPlayRank21;
BOOL canPlayRank22;
BOOL canPlayRank23;
BOOL canPlayRank24;
BOOL canPlayRank25;
BOOL canPlayRank26;
BOOL canPlayRank27;
BOOL canPlayRank28;
BOOL canPlayRank29;
BOOL beatTutorial;
BOOL machineUp;
AVAudioPlayer *dink;
AVAudioPlayer *clickSound;

BOOL didLoad;
BOOL didLoad1;

NSArray *bgSeq;

@interface ArcadeMenu : SKScene <AVAudioPlayerDelegate> {
    
    SKTexture *normalMachineTexture;
    SKSpriteNode *normalMachine;
    SKTexture *rightTimeMachineTexture;
    SKSpriteNode *rightTimeMachine;
    SKTexture *twoFingerSlamMachineTexture;
    SKSpriteNode *twoFingerSlamMachine;
    SKTexture *foodOnlyMachineTexture;
    SKSpriteNode *foodOnlyMachine;
    SKTexture *basketMachineTexture;
    SKSpriteNode *basketMachine;
    SKTexture *homeMachineTexture;
    SKSpriteNode *homeMachine;
    SKTexture *backMachineTexture;
    SKSpriteNode *backMachine;
    SKTexture *ffArcadeTitleTexture;
    SKSpriteNode *ffArcadeTitle;
    SKTexture *filterTexture;
    SKSpriteNode *filter;
    
    SKTexture *tilePattern1Texture;
    SKSpriteNode *tilePattern1;
    SKTexture *tilePattern2Texture;
    SKSpriteNode *tilePattern2;
    SKTexture *tilePattern3Texture;
    SKSpriteNode *tilePattern3;
    SKTexture *tilePattern4Texture;
    SKSpriteNode *tilePattern4;
    SKTexture *tilePattern5Texture;
    SKSpriteNode *tilePattern5;
      //do tile patterns.
    
    SKTexture *r1O1Texture;
    SKSpriteNode *r1O1;
    SKTexture *r1O2Texture;
    SKSpriteNode *r1O2;
    SKTexture *r1O3Texture;
    SKSpriteNode *r1O3;
    SKTexture *r2O1Texture;
    SKSpriteNode *r2O1;
    SKTexture *r2O2Texture;
    SKSpriteNode *r2O2;
    SKTexture *r2O3Texture;
    SKSpriteNode *r2O3;
    SKTexture *r3O1Texture;
    SKSpriteNode *r3O1;
    SKTexture *r3O2Texture;
    SKSpriteNode *r3O2;
    SKTexture *r3O3Texture;
    SKSpriteNode *r3O3;
    SKTexture *r4O1Texture;
    SKSpriteNode *r4O1;
    SKTexture *r4O2Texture;
    SKSpriteNode *r4O2;
    SKTexture *r4O3Texture;
    SKSpriteNode *r4O3;
    SKTexture *r5O1Texture;
    SKSpriteNode *r5O1;
    SKTexture *r5O2Texture;
    SKSpriteNode *r5O2;
    SKTexture *r5O3Texture;
    SKSpriteNode *r5O3;
    SKTexture *r6O1Texture;
    SKSpriteNode *r6O1;
    SKTexture *r6O2Texture;
    SKSpriteNode *r6O2;
    SKTexture *r6O3Texture;
    SKSpriteNode *r6O3;
    SKTexture *r7O1Texture;
    SKSpriteNode *r7O1;
    SKTexture *r7O2Texture;
    SKSpriteNode *r7O2;
    SKTexture *r7O3Texture;
    SKSpriteNode *r7O3;
    SKTexture *r8O1Texture;
    SKSpriteNode *r8O1;
    SKTexture *r8O2Texture;
    SKSpriteNode *r8O2;
    SKTexture *r8O3Texture;
    SKSpriteNode *r8O3;
    SKTexture *r9O1Texture;
    SKSpriteNode *r9O1;
    SKTexture *r9O2Texture;
    SKSpriteNode *r9O2;
    SKTexture *r9O3Texture;
    SKSpriteNode *r9O3;
    SKTexture *r10O1Texture;
    SKSpriteNode *r10O1;
    SKTexture *r10O2Texture;
    SKSpriteNode *r10O2;
    SKTexture *r10O3Texture;
    SKSpriteNode *r10O3;
    SKTexture *playBackTexture;
    SKSpriteNode *playBack;
    SKTexture *playForwardTexture;
    SKSpriteNode *playForward;
    SKTexture *aMCrownTexture;
    SKSpriteNode *aMCrown;
    SKTexture *aMBlueMarlinTexture;
    SKSpriteNode *aMBlueMarlin;
    SKTexture *aMBlueTangTexture;
    SKSpriteNode *aMBlueTang;
    SKTexture *aMBlueWhaleTexture;
    SKSpriteNode *aMBlueWhale;
    SKTexture *aMDolphinTexture;
    SKSpriteNode *aMDolphin;
    SKTexture *aMHermitCrabTexture;
    SKSpriteNode *aMHermitCrab;
    SKTexture *aMKillerWhaleTexture;
    SKSpriteNode *aMKillerWhale;
    SKTexture *aMLockTexture;
    SKSpriteNode *aMLock;
    SKTexture *aMOctopusTexture;
    SKSpriteNode *aMOctopus;
    SKTexture *aMSealTexture;
    SKSpriteNode *aMSeal;
    SKTexture *aMSharkTexture;
    SKSpriteNode *aMShark;
    SKTexture *aMShrimpTexture;
    SKSpriteNode *aMShrimp;
    SKTexture *aMStar1aTexture;
    SKSpriteNode *aMStar1a;
    SKTexture *aMStar2aTexture;
    SKSpriteNode *aMStar2a;
    SKTexture *aMstar3aTexture;
    SKSpriteNode *aMstar3a;
    SKTexture *aMStar1bTexture;
    SKSpriteNode *aMStar1b;
    SKTexture *aMStar2bTexture;
    SKSpriteNode *aMStar2b;
    SKTexture *aMstar3bTexture;
    SKSpriteNode *aMstar3b;
    SKTexture *aMStar1cTexture;
    SKSpriteNode *aMStar1c;
    SKTexture *aMStar2cTexture;
    SKSpriteNode *aMStar2c;
    SKTexture *aMstar3cTexture;
    SKSpriteNode *aMstar3c;
    SKTexture *aMStarHoldersTexture;
    SKSpriteNode *aMStarHolders;
    SKTexture *bFoVMachineTexture;
    SKSpriteNode *bFoVMachine;
    SKTexture *aMPlaySpinModuleTexture;
    SKSpriteNode *aMPlaySpinModule;
    SKTexture *aMPlayButtonTexture;
    SKSpriteNode *aMPlayButton;
    SKTexture *aMBackButtonTexture;
    SKSpriteNode *aMBackButton;
    SKTexture *clockScreenTexture;
    SKSpriteNode *clockScreen;
    SKTexture *borderTexture;
    SKSpriteNode *border;
    SKTexture *starsTexture;
    SKSpriteNode *stars;
    SKTexture *stars1Texture;
    SKSpriteNode *stars1;
    SKTexture *shineTexture;
    SKSpriteNode *shine;
    SKTexture *rankNumbersTexture;
    SKSpriteNode *rankNumbers;
    SKTexture *normalMachineShadingTexture;
    SKSpriteNode *normalMachineShading;
    
    
    SKTexture *fovIconTexture;
    SKSpriteNode *fovIcon;
    SKTexture *endlessButtonTexture;
    SKSpriteNode *endlessButton;
    SKTexture *storyButtonTexture;
    SKSpriteNode *storyButton;
    SKTexture *backgroundTexture;
    SKSpriteNode *background;
    
    SKTexture *bigClockTexture;
    SKSpriteNode *bigClock;
    SKTexture *clockBackTexture;
    SKSpriteNode *clockBack;
    SKTexture *clockBuyRFLTexture;
    SKSpriteNode *clockBuyRFL;
    
    AVAudioPlayer *CasinoAmbience;
    AVAudioPlayer *drop;
    AVAudioPlayer *drop1;
    AVAudioPlayer *drop2;
    AVAudioPlayer *drop3;
    AVAudioPlayer *drop4;
    AVAudioPlayer *drop5;
    AVAudioPlayer *drop6;
    AVAudioPlayer *bigDrop;
    AVAudioPlayer *theDrop;
    AVAudioPlayer *shakeSound;
    
    SKTextureAtlas *arcadeSpritesOne;
    SKTextureAtlas *arcadeSpritesTwo;
    SKTextureAtlas *arcadeSpritesThree;
    
}

@property (nonatomic, weak) SKView *skView;
@property int secondsTime;
@property int breakTime;
-(void)expirationChecks;
-(void)getDate;
-(void)waitTime;
-(void)showTimerCheck;
@end
