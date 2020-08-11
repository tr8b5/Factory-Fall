//
//  LoadingScreen.h
//  Factory Fall
//
//  Created by Willie on 8/26/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

int reggyNum;
BOOL canBlinkOBJ;
BOOL canBlinkFoods;
BOOL clickOB;
BOOL clickFB;

@interface LoadingScreen : SKScene <AVAudioPlayerDelegate> {
    
    //SKTextureAtlas *tutorial;
    SKTextureAtlas *reggyTauntSprites;
    SKSpriteNode *reggyBot;
    SKTexture *reggyBotTexture;
    AVAudioPlayer *aCrown;
    AVAudioPlayer *phrase;
    SKSpriteNode *objectiveButton;
    SKTexture *objectiveButtonTexture;
    SKSpriteNode *foodsButton;
    SKTexture *foodsButtonTexture;
    SKSpriteNode *load;
    SKTexture *loadTexture;
    SKSpriteNode *objectives;
    SKTexture *objectivesTexture;
    SKSpriteNode *foods;
    SKTexture *foodsTexture;
    SKSpriteNode * playButton;
    SKTexture *playButtonTexture;
    SKSpriteNode *key1;
    SKTexture *key1Texture;
    SKSpriteNode *key2;
    SKTexture *key2Texture;
    SKSpriteNode *filter;
    SKTexture *filterTexture;
    SKSpriteNode *reggyFace;
    SKTexture *reggyFaceTexture;
    SKSpriteNode *background;
    SKTexture *backgroundTexture;
    SKSpriteNode *checkMark;
    
    AVAudioPlayer *swishSound;
    AVAudioPlayer *swishSound1;
    AVAudioPlayer *swishSound2;
    AVAudioPlayer *swishSound3;
    AVAudioPlayer *swishSound4;
    AVAudioPlayer *swishSound5;
    AVAudioPlayer *swishSound6;
    AVAudioPlayer *taunt;
    
    SKTextureAtlas *ThroneSprites;
    SKTextureAtlas *loadingScreenSprites;
    SKTextureAtlas *loadingScreenSprites1;
    SKTextureAtlas *loadingScreenSprites2;
    SKTextureAtlas *loadingScreenSprites3;
    SKTextureAtlas *loadingScreenSprites4;
}
@property (nonatomic, weak) SKView *skView;

@end
