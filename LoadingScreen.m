//
//  LoadingScreen.m
//  Factory Fall
//
//  Created by Willie on 8/26/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import "LoadingScreen.h"
#import "RankLogic.h"
#import "AtlastData.h"
#import "GameScene.h"
#import "NormalLogic.h"
#import "GameViewController.h"
#import "ArcadeMenu.h"
#import "Food.h"

#define IPHONE_4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )
#define IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IPHONE_6 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )
#define IPHONE_6_PLUS ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )

@interface LoadingScreen ()

@property (strong, nonatomic) SKNode *gameLayer;
@property (strong, nonatomic) SKNode *spriteLayer;
@property (strong, nonatomic) SKAction *yourSoundAction;
@property (strong, nonatomic) SKAction *yourSoundAction1;


@end

@implementation LoadingScreen

-(id)initWithSize:(CGSize)size {
    
    if ((self = [super initWithSize:size])) {
        
        self.anchorPoint = CGPointMake(0.5, 0.5);
        
        loadingScreenSprites = [self textureAtlasNamed:@"LoadingScreenSprites"];
        loadingScreenSprites1 = [self textureAtlasNamed:@"LoadingScreenSprites1"];
        loadingScreenSprites2 = [self textureAtlasNamed:@"LoadingScreenSpites2"];
        loadingScreenSprites3 = [self textureAtlasNamed:@"LoadingScreenSprites3"];
        loadingScreenSprites4 = [self textureAtlasNamed:@"LoadingScreenSprites4"];
        mainMenuSprites = [self textureAtlasNamed:@"MainMenuSprites"];
        buttonSprites = [self textureAtlasNamed:@"ButtonSprites"];
        ThroneSprites = [self textureAtlasNamed:@"ThroneSprites"];
        reggyTauntSprites = [self textureAtlasNamed:@"ReggyTauntSprites"];
        
        backgroundTexture = [loadingScreenSprites textureNamed:@"LoadingScreenReggyBotThroneBackGround"];
        
        background = [SKSpriteNode spriteNodeWithTexture:backgroundTexture];
        [background setName:@"Background"];
        background.size = CGSizeMake(background.frame.size.width/s, background.frame.size.height / s);
        [self addChild:background];
        
        self.gameLayer = [SKNode node];
        [self addChild:self.gameLayer];
        
        CGPoint layerPosition = CGPointZero;
        
        self.spriteLayer = [SKNode node];
        self.spriteLayer.position = layerPosition;
        
        [self.gameLayer addChild:self.spriteLayer];
        
        SKTextureAtlas *tutorialSprites = [self textureAtlasNamed:@"Tutorial"];
        SKTexture *tutorialTexture = [tutorialSprites textureNamed:@"Tutorial1"];
        SKSpriteNode *tutorial = [SKSpriteNode spriteNodeWithTexture:tutorialTexture];
        tutorial.position = CGPointZero;
        tutorial.zPosition = 19;
        tutorial.name = @"tutorial";
        tutorial.size = CGSizeMake(tutorial.frame.size.width/s, tutorial.frame.size.height/s);
        [self.spriteLayer addChild:tutorial];
        
        filterTexture = [mainMenuSprites textureNamed:@"Filter"];
        
        filter = [SKSpriteNode spriteNodeWithTexture:filterTexture];
        filter.position = CGPointZero;
        filter.size = CGSizeMake(filter.frame.size.width/s, filter.frame.size.height / s);
        filter.zPosition = 20;
        [self.spriteLayer addChild:filter];
        
        objectiveButtonTexture = [buttonSprites textureNamed:@"LoadingScreenObjectiveButton"];
        
        objectiveButton = [SKSpriteNode spriteNodeWithTexture:objectiveButtonTexture];
        objectiveButton.position = CGPointMake(-self.frame.size.width/3, self.frame.size.height/2.5);
        objectiveButton.size = CGSizeMake(objectiveButton.frame.size.width/s, objectiveButton.frame.size.height / s);
        objectiveButton.zPosition = 2;
        objectiveButton.name = @"objButton";
        [self.spriteLayer addChild:objectiveButton];
        
        foodsButtonTexture = [buttonSprites textureNamed:@"LoadingScreenFoVButton"];
        
        foodsButton = [SKSpriteNode spriteNodeWithTexture:foodsButtonTexture];
        foodsButton.position = CGPointMake(self.frame.size.width/3, self.frame.size.height/2.5);
        foodsButton.size = CGSizeMake(foodsButton.frame.size.width/s, foodsButton.frame.size.height / s);
        foodsButton.zPosition = 2;
        foodsButton.name = @"foodsButton";
        [self.spriteLayer addChild:foodsButton];
        
        key1Texture = [loadingScreenSprites textureNamed:@"LoadingScreenLeftKey"];
        
        key1 = [SKSpriteNode spriteNodeWithTexture:key1Texture];
        key1.position = CGPointZero;
        key1.size = CGSizeMake(key1.frame.size.width/s, key1.frame.size.height / s);
        key1.zPosition = 1.1;
        [self.spriteLayer addChild:key1];
        
        key2Texture = [loadingScreenSprites textureNamed:@"LoadingScreenRightKey"];
        
        key2 = [SKSpriteNode spriteNodeWithTexture:key2Texture];
        key2.position = CGPointZero;
        key2.size = CGSizeMake(key2.frame.size.width/s, key2.frame.size.height / s);
        key2.zPosition = 1.1;
        [self.spriteLayer addChild:key2];
        
        reggyBotTexture = [loadingScreenSprites textureNamed:@"LoadingScreenReggyBot"];
        
        reggyBot = [SKSpriteNode spriteNodeWithTexture:reggyBotTexture];
        reggyBot.position = CGPointZero;
        reggyBot.size = CGSizeMake(reggyBot.frame.size.width/s, reggyBot.frame.size.height / s);
        reggyBot.zPosition = 2;
        [self.spriteLayer addChild:reggyBot];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneA1"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];
        
        SKAction *sequence = [SKAction sequence:@[[SKAction moveByX:0 y:20 duration:3],
                                                  [SKAction moveByX:0 y:-20 duration:3]]];
        SKAction *repeatSequence = [SKAction repeatActionForever:sequence];
        [key1 runAction:repeatSequence];
        [key2 runAction:repeatSequence];
        
        
        NSString *sound1 = [[NSBundle mainBundle]pathForResource:@"dink" ofType:@"wav"];
        dink = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound1]  error:NULL];
        dink.delegate = self;
        
        clickFB = NO;
        clickOB = NO;
        canBlinkOBJ = YES;
        canBlinkFoods = NO;
        if (rankNumber == 0 || rankNumber == 3 || rankNumber == 6 || rankNumber == 9 || rankNumber == 12 || rankNumber == 15 || rankNumber == 18 || rankNumber == 21 || rankNumber == 24) {
            canBlinkFoods = YES;
        }
        
        [self loadSeq];
        
        [self performSelector:@selector(reggyTaunts) withObject:self afterDelay:2];
        
        RankLogic *blinkCheck = [[RankLogic alloc]init];
        [blinkCheck canBlinkLogic];
        
        /*if ((bronze101 == NO || silver101 == NO || gold101 == NO) & (rankNumber == 0)) {
            canBlink = YES;
        }
        if ((bronze102 == NO || silver102 == NO || gold102 == NO) & (rankNumber == 1)) {
            canBlink = YES;
        }
        if ((bronze103 == NO || silver103 == NO || gold103 == NO) & (rankNumber == 2)) {
            canBlink = YES;
        }
        if ((bronze201 == NO || silver201 == NO || gold201 == NO) & (rankNumber == 3)) {
            canBlink = YES;
        }
        if ((bronze202 == NO || silver202 == NO || gold202 == NO) & (rankNumber == 4)) {
            canBlink = YES;
        }
        if ((bronze203 == NO || silver203 == NO || gold203 == NO) & (rankNumber == 5)) {
            canBlink = YES;
        }
        if ((bronze301 == NO || silver301 == NO || gold301 == NO) & (rankNumber == 6)) {
            canBlink = YES;
        }
        if ((bronze302 == NO || silver302 == NO || gold302 == NO) & (rankNumber == 7)) {
            canBlink = YES;
        }
        if ((bronze303 == NO || silver303 == NO || gold303 == NO) & (rankNumber == 8)) {
            canBlink = YES;
        }
        if ((bronze401 == NO || silver401 == NO || gold401 == NO) & (rankNumber == 9)) {
            canBlink = YES;
        }
        if ((bronze402 == NO || silver402 == NO || gold402 == NO) & (rankNumber == 10)) {
            canBlink = YES;
        }
        if ((bronze403 == NO || silver403 == NO || gold403 == NO) & (rankNumber == 11)) {
            canBlink = YES;
        }
        if ((bronze501 == NO || silver501 == NO || gold501 == NO) & (rankNumber == 12)) {
            canBlink = YES;
        }
        if ((bronze502 == NO || silver502 == NO || gold502 == NO) & (rankNumber == 13)) {
            canBlink = YES;
        }
        if ((bronze503 == NO || silver503 == NO || gold503 == NO) & (rankNumber == 14)) {
            canBlink = YES;
        }
        if ((bronze601 == NO || silver601 == NO || gold601 == NO) & (rankNumber == 15)) {
            canBlink = YES;
        }
        if ((bronze602 == NO || silver602 == NO || gold602 == NO) & (rankNumber == 16)) {
            canBlink = YES;
        }
        if ((bronze603 == NO || silver603 == NO || gold603 == NO) & (rankNumber == 17)) {
            canBlink = YES;
        }
        if ((bronze701 == NO || silver701 == NO || gold701 == NO) & (rankNumber == 18)) {
            canBlink = YES;
        }
        if ((bronze702 == NO || silver702 == NO || gold702 == NO) & (rankNumber == 19)) {
            canBlink = YES;
        }
        if ((bronze703 == NO || silver703 == NO || gold703 == NO) & (rankNumber == 20)) {
            canBlink = YES;
        }
        if ((bronze801 == NO || silver801 == NO || gold801 == NO) & (rankNumber == 21)) {
            canBlink = YES;
        }
        if ((bronze802 == NO || silver802 == NO || gold802 == NO) & (rankNumber == 22)) {
            canBlink = YES;
        }
        if ((bronze803 == NO || silver803 == NO || gold803 == NO) & (rankNumber == 23)) {
            canBlink = YES;
        }
        if ((bronze901 == NO || silver901 == NO || gold901 == NO) & (rankNumber == 24)) {
            canBlink = YES;
        }
        if ((bronze902 == NO || silver902 == NO || gold902 == NO) & (rankNumber == 25)) {
            canBlink = YES;
        }
        if ((bronze903 == NO || silver903 == NO || gold903 == NO) & (rankNumber == 26)) {
            canBlink = YES;
        }
        if ((bronze1001 == NO || silver1001 == NO || gold1001 == NO) & (rankNumber == 27)) {
            canBlink = YES;
        }
        if ((bronze1002 == NO || silver1002 == NO || gold1002 == NO) & (rankNumber == 28)) {
            canBlink = YES;
        }*/
        SKAction * blinkAnim = [SKAction sequence:@[[SKAction fadeAlphaTo:0 duration:0.3],
                                                    [SKAction fadeAlphaTo:1.0 duration:0.3]]];
        if (canBlinkOBJ == YES) {
            
            [objectiveButton runAction:[SKAction repeatActionForever:blinkAnim]];
        }
        if (canBlinkFoods == YES) {
          
                [foodsButton runAction:[SKAction repeatActionForever:blinkAnim]];
        }
        
    }
    return self;
}
- (SKTextureAtlas *)textureAtlasNamed:(NSString *)fileName
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if( [ [ UIScreen mainScreen ] respondsToSelector: @selector( nativeBounds ) ] )
        {
            if (IPHONE_4) {
                s = 2;
                fileName = [NSString stringWithFormat:@"%@", fileName];
                
            }
            if (IPHONE_5) {
                s = 2;
                fileName = [NSString stringWithFormat:@"%@-568", fileName];
                
            }else if (IPHONE_6) {
                s = 2;
                fileName = [NSString stringWithFormat:@"%@-667", fileName];
                
            } else if (IPHONE_6_PLUS) {
                s = 3;
                fileName = [NSString stringWithFormat:@"%@-736", fileName];
                
            } else {
                
                fileName = fileName;
                
            }
            
        } else {
            fileName = [NSString stringWithFormat:@"%@-ipad", fileName];
        }
    }
    SKTextureAtlas *textureAtlas = [SKTextureAtlas atlasNamed:fileName];
    
    return textureAtlas;
}
-(void)didMoveToView:(SKView *)view {
    
}
-(void)loadSeq {
    
#define LOAD_TEXT [SKTexture textureWithImageNamed:@"LoadingScreenLoadingIcon1"]
    
    load = [SKSpriteNode spriteNodeWithTexture:LOAD_TEXT];
    load.position = CGPointZero;
    load.size = CGSizeMake(load.frame.size.width/s, load.frame.size.height / s);
    load.zPosition = 2;
    [self.spriteLayer addChild:load];
    
#define LOAD_ANIM_START @[ \
[SKTexture textureWithImageNamed:@"LoadingScreenLoadingIcon1"], \
[SKTexture textureWithImageNamed:@"LoadingScreenLoadingIcon2"], \
[SKTexture textureWithImageNamed:@"LoadingScreenLoadingIcon3"]   \
]
    SKAction *bGAction = [SKAction animateWithTextures:LOAD_ANIM_START timePerFrame:1];
    SKAction *repeat = [SKAction repeatActionForever:bGAction];
    [load runAction:repeat];
    
    //[gameSceneSpritesNine preloadWithCompletionHandler:^{
        
        //[gameSceneSpritesFive preloadWithCompletionHandler:^{
        
            //[gameSceneSpritesOne preloadWithCompletionHandler:^{
                        
                //[gameSceneSpritesThree preloadWithCompletionHandler:^{
                            
                    //[powerUpAnimSprites1 preloadWithCompletionHandler:^{
                                                                        
                        //[confettiAnimSprites2 preloadWithCompletionHandler:^{
                                                                            
                            //[confettiAnimSprites3 preloadWithCompletionHandler:^{
                                                                                
                                //[confettiAnimSprites4 preloadWithCompletionHandler:^{
                                             
                                    //[foodSprites preloadWithCompletionHandler:^{
                                        
                                        //[reggyTauntSprites preloadWithCompletionHandler:^{
                                            
            [load removeAllActions];
            [load removeFromParent];
            
                    playButtonTexture = [buttonSprites textureNamed:@"LoadingScreenPlayButton"];
                    
                    playButton = [SKSpriteNode spriteNodeWithTexture:playButtonTexture];
                    playButton.position = CGPointMake(0, self.frame.size.height/2.5);
                    playButton.size = CGSizeMake(playButton.frame.size.width/s, playButton.frame.size.height / s);
                    playButton.name = @"PlayButton";
                    playButton.zPosition = 3;
                    [self.spriteLayer addChild:playButton];
            
            SKAction *startGameFade = [SKAction fadeAlphaTo:0.1 duration:1];
            SKAction *startGameColor = [SKAction fadeAlphaTo:1.0 duration:1];
            SKAction *startGameSequence = [SKAction sequence:@[startGameFade,startGameColor]];
            SKAction *startGameActionRepeatForever = [SKAction repeatActionForever:startGameSequence];
            [playButton runAction:startGameActionRepeatForever];
                                            
                                        //}];
                                        
                                  //  }];
                                                                                    
                               // }];
                                         
                            //}];
                                         
                        //}];
                                                                
                    //}];
                            
                //}];
                                                    
           // }];
                                                
       // }];
                                            
    //}];
    
}
-(void)goToNormalMode {
    
    self.skView = (SKView *)self.view;
    [self.skView presentScene:nil];
    loadingScreenSprites = nil;
    loadingScreenSprites1 = nil;
    loadingScreenSprites2 = nil;
    loadingScreenSprites3 = nil;
    loadingScreenSprites4 = nil;
    ThroneSprites = nil;
    reggyTauntSprites = nil;
    // Create and configure the scene.
    GameScene *Gscene = [GameScene sceneWithSize:self.skView.bounds.size];
    Gscene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Load the level.
    //NormalLogic *logic = [[NormalLogic alloc] init];
    //Gscene.logic = logic;
    
    // Present the scene.
    [self.skView presentScene:Gscene];
    
}
-(void)reggyTaunts {
    
    //[self runAction:self.yourSoundAction];
    
    
    if (rankNumber == 0) {
        
        [reggyFace removeFromParent];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneA1"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];
        
        NSString *sound = [[NSBundle mainBundle]pathForResource:@"FailureAheadOfYou" ofType:@"wav"];
        taunt = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        taunt.delegate = self;
        [taunt play];
        
        SKAction *bGAction = [SKAction animateWithTextures:ThroneA_Anim_Start timePerFrame:0.083333333];
        [reggyFace runAction:bGAction];
    }
    if (rankNumber == 1) {
        
        [reggyFace removeFromParent];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneB1"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];;
        
        NSString *sound = [[NSBundle mainBundle]pathForResource:@"GoodLuckBuddy" ofType:@"wav"];
        taunt = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        taunt.delegate = self;
        [taunt play];
        
        SKAction *bGAction = [SKAction animateWithTextures:ThroneB_Anim_Start timePerFrame:0.083333333];
        [reggyFace runAction:bGAction];
    }
    if (rankNumber == 2) {
        
        [reggyFace removeFromParent];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneC1"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];
        
        NSString *sound = [[NSBundle mainBundle]pathForResource:@"FiveStars" ofType:@"wav"];
        taunt = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        taunt.delegate = self;
        [taunt play];
        
        SKAction *bGAction = [SKAction animateWithTextures:ThroneC_Anim_Start timePerFrame:0.083333333];
        [reggyFace runAction:bGAction];
    }
    if (rankNumber == 3) {
        
        [reggyFace removeFromParent];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneD1"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];
        
        NSString *sound = [[NSBundle mainBundle]pathForResource:@"ForAKing" ofType:@"wav"];
        taunt = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        taunt.delegate = self;
        [taunt play];
        
        SKAction *bGAction = [SKAction animateWithTextures:ThroneD_Anim_Start timePerFrame:0.083333333];
        [reggyFace runAction:bGAction];
    }
    if (rankNumber == 4) {
        
        [reggyFace removeFromParent];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneE1"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];
        
        NSString *sound = [[NSBundle mainBundle]pathForResource:@"1To10Odds" ofType:@"wav"];
        taunt = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        taunt.delegate = self;
        [taunt play];
        
        SKAction *bGAction = [SKAction animateWithTextures:ThroneE_Anim_Start timePerFrame:0.083333333];
        [reggyFace runAction:bGAction];
    }
    if (rankNumber == 5) {
        
        [reggyFace removeFromParent];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneF1"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];
        
        NSString *sound = [[NSBundle mainBundle]pathForResource:@"YourBack_" ofType:@"wav"];
        taunt = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        taunt.delegate = self;
        [taunt play];
        
        SKAction *bGAction = [SKAction animateWithTextures:ThroneF_Anim_Start timePerFrame:0.083333333];
        [reggyFace runAction:bGAction];
    }
    if (rankNumber == 6) {
        
        [reggyFace removeFromParent];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneG1"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];
        
        NSString *sound = [[NSBundle mainBundle]pathForResource:@"MostPlayers" ofType:@"wav"];
        taunt = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        taunt.delegate = self;
        [taunt play];
        
        SKAction *bGAction = [SKAction animateWithTextures:ThroneG_Anim_Start timePerFrame:0.083333333];
        [reggyFace runAction:bGAction];
    }
    if (rankNumber == 7) {
        
        [reggyFace removeFromParent];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneH1"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];
        
        NSString *sound = [[NSBundle mainBundle]pathForResource:@"BackForMore" ofType:@"wav"];
        taunt = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        taunt.delegate = self;
        [taunt play];
        
        SKAction *bGAction = [SKAction animateWithTextures:ThroneH_Anim_Start timePerFrame:0.083333333];
        [reggyFace runAction:bGAction];
    }
    if (rankNumber == 8) {
        
        [reggyFace removeFromParent];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneI1"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];
        
        NSString *sound = [[NSBundle mainBundle]pathForResource:@"PlayCheckers" ofType:@"wav"];
        taunt = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        taunt.delegate = self;
        [taunt play];
        
        SKAction *bGAction = [SKAction animateWithTextures:ThroneI_Anim_Start timePerFrame:0.083333333];
        [reggyFace runAction:bGAction];
    }
    if (rankNumber == 9) {
        
        [reggyFace removeFromParent];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneJ1"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];
        
        NSString *sound = [[NSBundle mainBundle]pathForResource:@"ReggyIsSuperior" ofType:@"wav"];
        taunt = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        taunt.delegate = self;
        [taunt play];
        
        SKAction *bGAction = [SKAction animateWithTextures:ThroneJ_Anim_Start timePerFrame:0.083333333];
        [reggyFace runAction:bGAction];
    }
    if (rankNumber == 10) {
        
        [reggyFace removeFromParent];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneK1"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];
        
        NSString *sound = [[NSBundle mainBundle]pathForResource:@"YourHopeless" ofType:@"wav"];
        taunt = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        taunt.delegate = self;
        [taunt play];
        
        SKAction *bGAction = [SKAction animateWithTextures:ThroneK_Anim_Start timePerFrame:0.083333333];
        [reggyFace runAction:bGAction];
    }
    if (rankNumber == 11) {
        
        [reggyFace removeFromParent];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneL1"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];
        
        NSString *sound = [[NSBundle mainBundle]pathForResource:@"GiveUpNow" ofType:@"wav"];
        taunt = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        taunt.delegate = self;
        [taunt play];
        
        SKAction *bGAction = [SKAction animateWithTextures:ThroneL_Anim_Start timePerFrame:0.083333333];
        [reggyFace runAction:bGAction];
    }
    if (rankNumber == 12) {
        
        [reggyFace removeFromParent];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneM1"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];
        
        NSString *sound = [[NSBundle mainBundle]pathForResource:@"NoHumanIsSmartEnough" ofType:@"wav"];
        taunt = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        taunt.delegate = self;
        [taunt play];
        
        SKAction *bGAction = [SKAction animateWithTextures:ThroneM_Anim_Start timePerFrame:0.083333333];
        [reggyFace runAction:bGAction];
    }
    if (rankNumber == 13) {
        
        [reggyFace removeFromParent];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneN1"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];
        
        NSString *sound = [[NSBundle mainBundle]pathForResource:@"HumansLikeYou" ofType:@"wav"];
        taunt = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        taunt.delegate = self;
        [taunt play];
        
        SKAction *bGAction = [SKAction animateWithTextures:ThroneN_Anim_Start timePerFrame:0.083333333];
        [reggyFace runAction:bGAction];
    }
    if (rankNumber == 14) {
        
        [reggyFace removeFromParent];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneO1"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];
        
        NSString *sound = [[NSBundle mainBundle]pathForResource:@"ImDonePlayingGames" ofType:@"wav"];
        taunt = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        taunt.delegate = self;
        [taunt play];
        
        SKAction *bGAction = [SKAction animateWithTextures:ThroneO_Anim_Start timePerFrame:0.083333333];
        [reggyFace runAction:bGAction];
    }
    if (rankNumber == 15) {
        
        [reggyFace removeFromParent];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneP1"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];
        
        NSString *sound = [[NSBundle mainBundle]pathForResource:@"YourPersistance" ofType:@"wav"];
        taunt = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        taunt.delegate = self;
        [taunt play];
        
        SKAction *bGAction = [SKAction animateWithTextures:ThroneP_Anim_Start timePerFrame:0.083333333];
        [reggyFace runAction:bGAction];
    }
    if (rankNumber == 16) {
        
        [reggyFace removeFromParent];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneQ1"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];
        
        NSString *sound = [[NSBundle mainBundle]pathForResource:@"YourReallyPushingIt" ofType:@"wav"];
        taunt = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        taunt.delegate = self;
        [taunt play];
        
        SKAction *bGAction = [SKAction animateWithTextures:ThroneQ_Anim_Start timePerFrame:0.083333333];
        [reggyFace runAction:bGAction];
    }
    if (rankNumber == 17) {
        
        [reggyFace removeFromParent];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneR1"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];
        
        //NSString *sound = [[NSBundle mainBundle]pathForResource:@"FailureAheadOfYou" ofType:@"wav"];
        //taunt = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        //taunt.delegate = self;
        //[taunt play];
        
        //SKAction *bGAction = [SKAction animateWithTextures:ThroneR_Anim_Start timePerFrame:0.083333333];
        //[reggyFace runAction:bGAction];
    }
    if (rankNumber == 18) {
        
        [reggyFace removeFromParent];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneS1"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];
        
        NSString *sound = [[NSBundle mainBundle]pathForResource:@"YouDiscustMe" ofType:@"wav"];
        taunt = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        taunt.delegate = self;
        [taunt play];
        
        SKAction *bGAction = [SKAction animateWithTextures:ThroneS_Anim_Start timePerFrame:0.083333333];
        [reggyFace runAction:bGAction];
    }
    if (rankNumber == 19) {
        [reggyFace removeFromParent];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneY24"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];
        
        //SKAction *bGAction = [SKAction animateWithTextures:ThroneT_Anim_Start timePerFrame:0.083333333];
        //[reggyFace runAction:bGAction];
    }
    if (rankNumber == 20) {
        [reggyFace removeFromParent];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneY24"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];
        
        //SKAction *bGAction = [SKAction animateWithTextures:ThroneU_Anim_Start timePerFrame:0.083333333];
        //[reggyFace runAction:bGAction];
    }
    if (rankNumber == 21) {
        
        [reggyFace removeFromParent];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneV1"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];
        
        NSString *sound = [[NSBundle mainBundle]pathForResource:@"IveHadEnough" ofType:@"wav"];
        taunt = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        taunt.delegate = self;
        [taunt play];
        
        SKAction *bGAction = [SKAction animateWithTextures:ThroneV_Anim_Start timePerFrame:0.083333333];
        [reggyFace runAction:bGAction];
    }
    if (rankNumber == 22) {
        
        [reggyFace removeFromParent];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneW1"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];
        
        NSString *sound = [[NSBundle mainBundle]pathForResource:@"WhatsUpNext" ofType:@"wav"];
        taunt = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        taunt.delegate = self;
        [taunt play];
        
        SKAction *bGAction = [SKAction animateWithTextures:ThroneW_Anim_Start timePerFrame:0.083333333];
        [reggyFace runAction:bGAction];
    }
    if (rankNumber == 23) {
        
        [reggyFace removeFromParent];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneX1"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];
        
        NSString *sound = [[NSBundle mainBundle]pathForResource:@"GoPlaySomeThingElse" ofType:@"wav"];
        taunt = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        taunt.delegate = self;
        [taunt play];
        
        SKAction *bGAction = [SKAction animateWithTextures:ThroneX_Anim_Start timePerFrame:0.083333333];
        [reggyFace runAction:bGAction];
    }
    if (rankNumber == 24) {
        
        [reggyFace removeFromParent];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneY1"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];
        
        NSString *sound = [[NSBundle mainBundle]pathForResource:@"YouCrossedTheLine" ofType:@"wav"];
        taunt = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        taunt.delegate = self;
        [taunt play];
        
        SKAction *bGAction = [SKAction animateWithTextures:ThroneY_Anim_Start timePerFrame:0.083333333];
        [reggyFace runAction:bGAction];
    }
    if (rankNumber == 25) {
        
        [reggyFace removeFromParent];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneZ1"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];
        
        NSString *sound = [[NSBundle mainBundle]pathForResource:@"BringItOn" ofType:@"wav"];
        taunt = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        taunt.delegate = self;
        [taunt play];
        
        SKAction *bGAction = [SKAction animateWithTextures:ThroneZ_Anim_Start timePerFrame:0.083333333];
        [reggyFace runAction:bGAction];
    }
    if (rankNumber == 26) {
        
        [reggyFace removeFromParent];
        
        reggyFaceTexture = [ThroneSprites textureNamed:@"ThroneAA1"];
        
        reggyFace = [SKSpriteNode spriteNodeWithTexture:reggyFaceTexture];
        reggyFace.position = CGPointZero;
        reggyFace.size = CGSizeMake(reggyFace.frame.size.width/s, reggyFace.frame.size.height / s);
        reggyFace.zPosition = 3;
        [self.spriteLayer addChild:reggyFace];
        
        NSString *sound = [[NSBundle mainBundle]pathForResource:@"BeatThisRound" ofType:@"wav"];
        taunt = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        taunt.delegate = self;
        [taunt play];
        
        SKAction *bGAction = [SKAction animateWithTextures:ThroneAA_Anim_Start timePerFrame:0.083333333];
        [reggyFace runAction:bGAction];
    }
    
   
}
-(void)showObjectives {
    [self removeItems];
    if (rankNumber == 0) {
        
        objectivesTexture = [loadingScreenSprites1 textureNamed:@"LoadingScreenLevel1Objectives"];
        
        if (bronze101 == YES) {
            
        }
        if (bronze102 == YES) {
            
        }
        if (bronze103 == YES) {
            
        }
          
    }
    if (rankNumber == 1) {
        objectivesTexture = [loadingScreenSprites1 textureNamed:@"LoadingScreenLevel2Objectives"];
         
    }
    if (rankNumber == 2) {
        objectivesTexture = [loadingScreenSprites1 textureNamed:@"LoadingScreenLevel3Objectives"];
        
    }
    if (rankNumber == 3) {
        objectivesTexture = [loadingScreenSprites1 textureNamed:@"LoadingScreenLevel4Objectives"];
        
    }
    if (rankNumber == 4) {
        objectivesTexture = [loadingScreenSprites1 textureNamed:@"LoadingScreenLevel5Objectives"];
        
    }
    if (rankNumber == 5) {
        objectivesTexture = [loadingScreenSprites1 textureNamed:@"LoadingScreenLevel6Objectives"];
        
    }
    if (rankNumber == 6) {
        objectivesTexture = [loadingScreenSprites1 textureNamed:@"LoadingScreenLevel7Objectives"];
        
    }
    if (rankNumber == 7) {
        objectivesTexture = [loadingScreenSprites1 textureNamed:@"LoadingScreenLevel8Objectives"];
        
    }
    if (rankNumber == 8) {
        objectivesTexture = [loadingScreenSprites1 textureNamed:@"LoadingScreenLevel9Objectives"];
        
    }
    if (rankNumber == 9) {
        objectivesTexture = [loadingScreenSprites2 textureNamed:@"LoadingScreenLevel10Objectives"];
        
    }
    if (rankNumber == 10) {
        objectivesTexture = [loadingScreenSprites2 textureNamed:@"LoadingScreenLevel11Objectives"];
        
    }
    if (rankNumber == 11) {
        objectivesTexture = [loadingScreenSprites2 textureNamed:@"LoadingScreenLevel12Objectives"];
        
    }
    if (rankNumber == 12) {
        objectivesTexture = [loadingScreenSprites2 textureNamed:@"LoadingScreenLevel13Objectives"];
        
    }
    if (rankNumber == 13) {
        objectivesTexture = [loadingScreenSprites2 textureNamed:@"LoadingScreenLevel14Objectives"];
        
    }
    if (rankNumber == 14) {
        objectivesTexture = [loadingScreenSprites2 textureNamed:@"LoadingScreenLevel15Objectives"];
        
    }
    if (rankNumber == 15) {
        objectivesTexture = [loadingScreenSprites2 textureNamed:@"LoadingScreenLevel16Objectives"];
        
    }
    if (rankNumber == 16) {
        objectivesTexture = [loadingScreenSprites2 textureNamed:@"LoadingScreenLevel17Objectives"];
        
    }
    if (rankNumber == 17) {
        objectivesTexture = [loadingScreenSprites2 textureNamed:@"LoadingScreenLevel18Objectives"];
        
    }
    if (rankNumber == 18) {
        objectivesTexture = [loadingScreenSprites2 textureNamed:@"LoadingScreenLevel19Objectives"];
        
    }
    if (rankNumber == 19) {
        objectivesTexture = [loadingScreenSprites4 textureNamed:@"LoadingScreenLevel20Objectives"];
        
    }
    if (rankNumber == 20) {
        objectivesTexture = [loadingScreenSprites4 textureNamed:@"LoadingScreenLevel21Objectives"];
        
    }
    if (rankNumber == 21) {
        objectivesTexture = [loadingScreenSprites4 textureNamed:@"LoadingScreenLevel22Objectives"];
        
    }
    if (rankNumber == 22) {
        objectivesTexture = [loadingScreenSprites4 textureNamed:@"LoadingScreenLevel23Objectives"];
        
    }
    if (rankNumber == 23) {
        objectivesTexture = [loadingScreenSprites4 textureNamed:@"LoadingScreenLevel24Objectives"];
        
    }
    if (rankNumber == 24) {
        objectivesTexture = [loadingScreenSprites4 textureNamed:@"LoadingScreenLevel25Objectives"];
        
    }
    if (rankNumber == 25) {
        objectivesTexture = [loadingScreenSprites4 textureNamed:@"LoadingScreenLevel26Objectives"];
        
    }
    if (rankNumber == 26) {
        objectivesTexture = [loadingScreenSprites4 textureNamed:@"LoadingScreenLevel27Objectives"];
        
    }
    
        objectives = [SKSpriteNode spriteNodeWithTexture:objectivesTexture];
        objectives.position = CGPointZero;
        objectives.size = CGSizeMake(objectives.frame.size.width/s, objectives.frame.size.height / s);
        objectives.zPosition = 3.1;
        [self.spriteLayer addChild:objectives];
    
    SKAction *seq = [SKAction sequence:@[[SKAction moveByX:0 y:1000 duration:0],
                                         [SKAction moveByX:0 y:-1000 duration:0.3],
                                         [SKAction moveByX:0 y:20 duration:0.1],
                                         [SKAction moveByX:0 y:-20 duration:0.2]]];
    [objectives runAction:seq];
}
-(void)showFoods {
    [self removeItems];
    if (rankNumber == 0 || rankNumber == 1 || rankNumber == 2) {
        
        foodsTexture = [loadingScreenSprites textureNamed:@"LoadingScreenLevel1Foods"];
    }
    if (rankNumber == 3 || rankNumber == 4 || rankNumber == 5) {
        
        foodsTexture = [loadingScreenSprites3 textureNamed:@"LoadingScreenLevel2Foods"];
        
    }
    if (rankNumber == 6 || rankNumber == 7 || rankNumber == 8) {
        
        foodsTexture = [loadingScreenSprites3 textureNamed:@"LoadingScreenLevel3Foods"];
        
    }
    if (rankNumber == 9 || rankNumber == 10 || rankNumber == 11) {
        
        foodsTexture = [loadingScreenSprites3 textureNamed:@"LoadingScreenLevel4Foods"];
        
    }
    if (rankNumber == 12 || rankNumber == 13 || rankNumber == 14) {
        
        foodsTexture = [loadingScreenSprites3 textureNamed:@"LoadingScreenLevel5Foods"];
        
    }
    if (rankNumber == 15 || rankNumber == 16 || rankNumber == 17) {
        
        foodsTexture = [loadingScreenSprites3 textureNamed:@"LoadingScreenLevel6Foods"];
        
    }
    if (rankNumber == 18 || rankNumber == 19 || rankNumber == 20) {
        
        foodsTexture = [loadingScreenSprites3 textureNamed:@"LoadingScreenLevel7Foods"];
        
    }
    if (rankNumber == 21 || rankNumber == 22 || rankNumber == 23) {
        
        foodsTexture = [loadingScreenSprites3 textureNamed:@"LoadingScreenLevel8Foods"];
        
    }
    if (rankNumber == 24 || rankNumber == 25 || rankNumber == 26) {
        
        foodsTexture = [loadingScreenSprites textureNamed:@"LoadingScreenLevel9Foods"];
        
    }
    
        foods = [SKSpriteNode spriteNodeWithTexture:foodsTexture];
        foods.position = CGPointZero;
        foods.size = CGSizeMake(foods.frame.size.width/s, foods.frame.size.height / s);
        foods.zPosition = 3;
        [self.spriteLayer addChild:foods];
    
    SKAction *seq = [SKAction sequence:@[[SKAction moveByX:0 y:1000 duration:0],
                                         [SKAction moveByX:0 y:-1000 duration:0.3],
                                         [SKAction moveByX:0 y:20 duration:0.1],
                                         [SKAction moveByX:0 y:-20 duration:0.2]]];
    [foods runAction:seq];
    
}
-(void)removeItems {
    [objectives removeFromParent];
    [foods removeFromParent];
}
-(void)handleNodesAtLocation:(CGPoint)location
{
    NSArray* nodes = [[self spriteLayer] nodesAtPoint:location];
    for(SKNode * node in nodes)
    {
        if ([[node name] isEqualToString:@"objButton"])
        {
            [dink play];
            [self showObjectives];
            [objectiveButton removeAllActions];
            objectiveButton.alpha = 1.0;
            canBlinkOBJ = NO;
            clickOB = YES;
            RankLogic *didBlink = [[RankLogic alloc]init];
            [didBlink didBlinkLogic];
            
            [[self.spriteLayer childNodeWithName:@"tutorial"] removeFromParent];
            
            SKTextureAtlas *tutorialSprites = [self textureAtlasNamed:@"Tutorial"];
            SKTexture *tutorialTexture = [tutorialSprites textureNamed:@"Tutorial2"];
            SKSpriteNode *tutorial = [SKSpriteNode spriteNodeWithTexture:tutorialTexture];
            tutorial.position = CGPointZero;
            tutorial.zPosition = 19;
            tutorial.name = @"tutorial";
            tutorial.size = CGSizeMake(tutorial.frame.size.width/s, tutorial.frame.size.height/s);
            [self.spriteLayer addChild:tutorial];
            
        }
        if ([[node name] isEqualToString:@"foodsButton"])
        {
            [dink play];
            [self showFoods];
            [foodsButton removeAllActions];
            foodsButton.alpha = 1.0;
            canBlinkFoods = NO;
            clickFB = YES;
            RankLogic *blinkCheck = [[RankLogic alloc]init];
            [blinkCheck canBlinkLogic];
            RankLogic *didBlink = [[RankLogic alloc]init];
            [didBlink didBlinkLogic];
            
            [[self.spriteLayer childNodeWithName:@"tutorial"] removeFromParent];
            
            SKTextureAtlas *tutorialSprites = [self textureAtlasNamed:@"Tutorial"];
            SKTexture *tutorialTexture = [tutorialSprites textureNamed:@"Tutorial3"];
            SKSpriteNode *tutorial = [SKSpriteNode spriteNodeWithTexture:tutorialTexture];
            tutorial.position = CGPointZero;
            tutorial.zPosition = 19;
            tutorial.name = @"tutorial";
            tutorial.size = CGSizeMake(tutorial.frame.size.width/s, tutorial.frame.size.height/s);
            [self.spriteLayer addChild:tutorial];
            
        }
        if ([[node name] isEqualToString:@"PlayButton"])
        {
            [dink play];
                foods = nil;
                objectives = nil;
                [self goToNormalMode];
            
            
        }
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch* touch in touches)
    {
        CGPoint location = [touch locationInNode:[self spriteLayer]];
        
        [self handleNodesAtLocation:location];
        
    }
    
    [super touchesEnded:touches withEvent:event];
}
@end
