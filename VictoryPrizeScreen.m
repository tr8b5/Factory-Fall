//
//  VictoryPrizeScreen.m
//  Factory Fall
//
//  Created by Willie on 6/17/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import "VictoryPrizeScreen.h"
#import "GameScene.h"
#import "RankLogic.h"
#import "GameViewController.h"

#define IPHONE_4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )
#define IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IPHONE_6 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )
#define IPHONE_6_PLUS ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )

@interface VictoryPrizeScreen ()

@property (strong, nonatomic) SKNode *gameLayer;
@property (strong, nonatomic) SKNode *spriteLayer;

//@property (strong, nonatomic) GameScene *Gscene;

@end

@implementation VictoryPrizeScreen

-(id)initWithSize:(CGSize)size {
    
    if ((self = [super initWithSize:size])) {
        
        self.anchorPoint = CGPointMake(0.5, 0.5);
        
        victoryPrizeScene1 = [self textureAtlasNamed:@"VictoryPrizeSpritesOne"];
        victoryPrizeScene2 = [self textureAtlasNamed:@"VictoryPrizeSpritesTwo"];
        mainMenuSprites = [self textureAtlasNamed:@"MainMenuSprites"];
        buttonSprites = [SKTextureAtlas atlasNamed:@"ButtonSprites"];
        
        backgroundTexture = [victoryPrizeScene1 textureNamed:@"VictoryPrizeScreenBackground"];
        
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
        
        NSLog(@"SceneView Open");
        
        self.physicsWorld.gravity = CGVectorMake(0, 0);
     
        [self MainAnimationSprites];
        [self performSelector:@selector(checkAni) withObject:nil afterDelay:0.2];
        NSLog(@"rankNumberVictoryScreen:" @"%ld", (long)rankNumber);
        
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
-(void)checkAni {
    
    NSString *sound1 = [[NSBundle mainBundle]pathForResource:@"VictorySound" ofType:@"wav"];
    victorySound = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound1]  error:NULL];
    victorySound.delegate = self;
    victorySound.volume = 1.0;
    
    NSString *sound = [[NSBundle mainBundle]pathForResource:@"Applause" ofType:@"wav"];
    applause = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
    applause.delegate = self;
    applause.volume = 0.5;
    [applause play];
    
    NSTimeInterval anotherDelay = 0.5;
    NSTimeInterval teh = victorySound.deviceCurrentTime;
    [victorySound playAtTime: teh + anotherDelay];
    
    prizeAquired = YES;
    
    if (showGoldEagle == YES) {
        [self eagleAnimation];
    }
    if (showGoldAcorn == YES) {
        [self acornAnimation];
    }
    if (showGoldBar == YES) {
        [self barAnimation];
    }
    if (showGoldChalice == YES) {
        [self chaliceAnimation];
    }
    if (showGoldGloves == YES) {
        [self glovesAnimation];
    }
    if (showGoldGolfClub == YES) {
        [self golfClubAnimation];
    }
    if (showGoldMicrophone == YES) {
        [self microphoneAnimation];
    }
    if (showGoldSwords == YES) {
        [self swordsAnimation];
    }
    if (showGoldUnicron == YES) {
        [self unicornAnimation];
    }
    if (showGoldWatch == YES) {
        [self watchAnimation];
    }
    
}
-(void)MainAnimationSprites {
    
    SKTexture *filterTexture = [mainMenuSprites textureNamed:@"Filter"];
    
    SKSpriteNode *filter = [SKSpriteNode spriteNodeWithTexture:filterTexture];
    filter.position = CGPointZero;
    filter.size = CGSizeMake(filter.frame.size.width/s, filter.frame.size.height / s);
    filter.zPosition = 20;
    [self.spriteLayer addChild:filter];
    
    SKTexture *backGoldTexture = [victoryPrizeScene2 textureNamed:@"VictoryPrizeScreenBackGold"];
    
    SKSpriteNode *backGold = [SKSpriteNode spriteNodeWithTexture:backGoldTexture];
    backGold.position = CGPointMake(0, 400);
    backGold.size = CGSizeMake(backGold.frame.size.width/s, backGold.frame.size.height / s);
    backGold.zPosition = 1;
    [self.spriteLayer addChild:backGold];
    
    SKAction *slowFall = [SKAction moveToY:100 duration:60];
    [backGold runAction:slowFall];
    
    SKTexture *mediumGoldTexture = [victoryPrizeScene2 textureNamed:@"VictoryPrizeScreenMediumGold"];
    
    SKSpriteNode *mediumGold = [SKSpriteNode spriteNodeWithTexture:mediumGoldTexture];
    mediumGold.position = CGPointMake(0, 400);
    mediumGold.size = CGSizeMake(mediumGold.frame.size.width/s, mediumGold.frame.size.height / s);
    mediumGold.zPosition = 3;
    [self.spriteLayer addChild:mediumGold];
    
    SKAction *FastFall = [SKAction moveToY:-400 duration:50];
    [mediumGold runAction:FastFall];
    
    SKTexture *topGoldTexture = [victoryPrizeScene2 textureNamed:@"VictoryPrizeScreenTopGold"];
    
    SKSpriteNode *topGold = [SKSpriteNode spriteNodeWithTexture:topGoldTexture];
    topGold.position = CGPointMake(0, 400);
    topGold.size = CGSizeMake(topGold.frame.size.width/s, topGold.frame.size.height / s);
    topGold.zPosition = 2;
    [self.spriteLayer addChild:topGold];
    
    SKAction *FasterFall = [SKAction moveToY:-400 duration:25];
    [topGold runAction:FasterFall];
    
    SKTexture *pedastalTexture = [victoryPrizeScene1 textureNamed:@"VictoryPrizeScreenPedastal"];
    
    SKSpriteNode *pedastal = [SKSpriteNode spriteNodeWithTexture:pedastalTexture];
    pedastal.position = CGPointZero;
    pedastal.size = CGSizeMake(pedastal.frame.size.width/s, pedastal.frame.size.height / s);
    pedastal.zPosition = 2;
    [self.spriteLayer addChild:pedastal];
    
    SKTexture *factoryFallTextTexture = [victoryPrizeScene1 textureNamed:@"VictoryPrizeScreenFactoryFallText"];
    
    SKSpriteNode *factoryFallText = [SKSpriteNode spriteNodeWithTexture:factoryFallTextTexture];
    factoryFallText.position = CGPointZero;
    factoryFallText.size = CGSizeMake(factoryFallText.frame.size.width/s, factoryFallText.frame.size.height / s);
    factoryFallText.zPosition = 3.1;
    [self.spriteLayer addChild:factoryFallText];
    
    /*SKTexture *facebookButtonTexture = [buttonSprites textureNamed:@"VictoryPrizeScreenFacebookButton"];
    
    SKSpriteNode *facebookButton = [SKSpriteNode spriteNodeWithTexture:facebookButtonTexture];
    facebookButton.position = CGPointMake(self.frame.size.width/-2.8, self.frame.size.height/-2.3);
    facebookButton.size = CGSizeMake(facebookButton.frame.size.width/s, facebookButton.frame.size.height / s);
    facebookButton.zPosition = 4;
    facebookButton.name = @"FacebookButton";
    [self.spriteLayer addChild:facebookButton];
    
    SKTexture *instagramButtonTexture = [buttonSprites textureNamed:@"VictoryPrizeScreenInstagramButton"];
    
    SKSpriteNode *instagramButton = [SKSpriteNode spriteNodeWithTexture:instagramButtonTexture];
    instagramButton.position = CGPointMake(self.frame.size.width/2.7, self.frame.size.height/-2.3);
    instagramButton.size = CGSizeMake(instagramButton.frame.size.width/s, instagramButton.frame.size.height / s);
    instagramButton.zPosition = 4;
    instagramButton.name = @"InstagramButton";
    [self.spriteLayer addChild:instagramButton];*/
    
    SKTexture *spotlightTexture = [victoryPrizeScene1 textureNamed:@"VictoryPrizeScreenSpotlight"];
    
    SKSpriteNode *spotlight = [SKSpriteNode spriteNodeWithTexture:spotlightTexture];
    spotlight.position = CGPointZero;
    spotlight.size = CGSizeMake(spotlight.frame.size.width/s, spotlight.frame.size.height / s);
    spotlight.zPosition = 2;
    spotlight.name = @"Spotlight";
    [self.spriteLayer addChild:spotlight];
    
    SKTexture *goldPileTexture = [victoryPrizeScene1 textureNamed:@"VictoryPrizeScreenGoldPile"];
    
    SKSpriteNode *goldPile = [SKSpriteNode spriteNodeWithTexture:goldPileTexture];
    goldPile.position = CGPointZero;
    goldPile.size = CGSizeMake(goldPile.frame.size.width/s, goldPile.frame.size.height / s);
    goldPile.zPosition = 1.1;
    [self.spriteLayer addChild:goldPile];
}

-(void)eagleAnimation {
    
    SKTexture *goldenEagleTextTexture = [victoryPrizeScene1 textureNamed:@"VictoryPrizeScreenGoldenEagleText"];
    
    SKSpriteNode *goldenEagleText = [SKSpriteNode spriteNodeWithTexture:goldenEagleTextTexture];
    goldenEagleText.position = CGPointZero;
    goldenEagleText.size = CGSizeMake(goldenEagleText.frame.size.width/s, goldenEagleText.frame.size.height / s);
    goldenEagleText.zPosition = 2;
    [self.spriteLayer addChild:goldenEagleText];
    
    SKTexture *goldenEagleTexture = [victoryPrizeScene1 textureNamed:@"VictoryPrizeScreenGoldenEagle"];
    
    SKSpriteNode *goldenEagle = [SKSpriteNode spriteNodeWithTexture:goldenEagleTexture];
    goldenEagle.position = CGPointMake(0, 400);
    goldenEagle.size = CGSizeMake(goldenEagle.frame.size.width/s, goldenEagle.frame.size.height / s);
    goldenEagle.zPosition = 2;
    [self.spriteLayer addChild:goldenEagle];
    
    SKAction *itemdrop = [SKAction moveTo:CGPointZero duration:10];
    SKAction *itemDesize = [SKAction scaleTo:0.3 duration:0];
    SKAction *itemResize = [SKAction scaleTo:1 duration:10];
    SKAction *group = [SKAction group:@[itemdrop,itemResize]];
    SKAction *sequence = [SKAction sequence:@[itemDesize,group]];
    [goldenEagle runAction:sequence];
    
}
-(void)acornAnimation {
    
    SKTexture *goldenAcornTextTexture = [victoryPrizeScene1 textureNamed:@"VictoryPrizeScreenGoldenAcornText"];
    
    SKSpriteNode *goldenAcornText = [SKSpriteNode spriteNodeWithTexture:goldenAcornTextTexture];
    goldenAcornText.position = CGPointZero;
    goldenAcornText.size = CGSizeMake(goldenAcornText.frame.size.width/s, goldenAcornText.frame.size.height / s);
    goldenAcornText.zPosition = 2;
    [self.spriteLayer addChild:goldenAcornText];
    
    SKTexture *goldenAcornTexture = [victoryPrizeScene1 textureNamed:@"VictoryPrizeScreenGoldenAcorn"];
    
    SKSpriteNode *goldenAcorn = [SKSpriteNode spriteNodeWithTexture:goldenAcornTexture];
    goldenAcorn.position = CGPointMake(0, 400);
    goldenAcorn.size = CGSizeMake(goldenAcorn.frame.size.width/s, goldenAcorn.frame.size.height / s);
    goldenAcorn.zPosition = 2;
    [self.spriteLayer addChild:goldenAcorn];
    
    SKAction *itemdrop = [SKAction moveTo:CGPointZero duration:10];
    SKAction *itemDesize = [SKAction scaleTo:0.3 duration:0];
    SKAction *itemResize = [SKAction scaleTo:1 duration:10];
    SKAction *group = [SKAction group:@[itemdrop,itemResize]];
    SKAction *sequence = [SKAction sequence:@[itemDesize,group]];
    [goldenAcorn runAction:sequence];
    
}
-(void)barAnimation {
    
    SKTexture *goldenBarTextTexture = [victoryPrizeScene1 textureNamed:@"VictoryPrizeScreenGoldenBarText"];
    
    SKSpriteNode *goldenBarText = [SKSpriteNode spriteNodeWithTexture:goldenBarTextTexture];
    goldenBarText.position = CGPointZero;
    goldenBarText.size = CGSizeMake(goldenBarText.frame.size.width/s, goldenBarText.frame.size.height / s);
    goldenBarText.zPosition = 2;
    [self.spriteLayer addChild:goldenBarText];
    
    SKTexture *goldenBarTexture = [victoryPrizeScene1 textureNamed:@"VictoryPrizeScreenGoldenBar"];
    
    SKSpriteNode *goldenBar = [SKSpriteNode spriteNodeWithTexture:goldenBarTexture];
    goldenBar.position = CGPointMake(0, 400);
    goldenBar.size = CGSizeMake(goldenBar.frame.size.width/s, goldenBar.frame.size.height / s);
    goldenBar.zPosition = 2;
    [self.spriteLayer addChild:goldenBar];
    
    SKAction *itemdrop = [SKAction moveTo:CGPointZero duration:10];
    SKAction *itemDesize = [SKAction scaleTo:0.3 duration:0];
    SKAction *itemResize = [SKAction scaleTo:1 duration:10];
    SKAction *group = [SKAction group:@[itemdrop,itemResize]];
    SKAction *sequence = [SKAction sequence:@[itemDesize,group]];
    [goldenBar runAction:sequence];
    
}
-(void)chaliceAnimation {
    
    SKTexture *goldenChaliceTextTexture = [victoryPrizeScene1 textureNamed:@"VictoryPrizeScreenGoldenChaliceText"];
    
    SKSpriteNode *goldenChaliceText = [SKSpriteNode spriteNodeWithTexture:goldenChaliceTextTexture];
    goldenChaliceText.position = CGPointZero;
    goldenChaliceText.size = CGSizeMake(goldenChaliceText.frame.size.width/s, goldenChaliceText.frame.size.height / s);
    goldenChaliceText.zPosition = 2;
    [self.spriteLayer addChild:goldenChaliceText];
    
    SKTexture *goldenChaliceTexture = [victoryPrizeScene1 textureNamed:@"VictoryPrizeScreenGoldenChalice"];
    
    SKSpriteNode *goldenChalice = [SKSpriteNode spriteNodeWithTexture:goldenChaliceTexture];
    goldenChalice.position = CGPointMake(0, 400);
    goldenChalice.size = CGSizeMake(goldenChalice.frame.size.width/s, goldenChalice.frame.size.height / s);
    goldenChalice.zPosition = 2;
    [self.spriteLayer addChild:goldenChalice];
    
    SKAction *itemdrop = [SKAction moveTo:CGPointZero duration:10];
    SKAction *itemDesize = [SKAction scaleTo:0.3 duration:0];
    SKAction *itemResize = [SKAction scaleTo:1 duration:10];
    SKAction *group = [SKAction group:@[itemdrop,itemResize]];
    SKAction *sequence = [SKAction sequence:@[itemDesize,group]];
    [goldenChalice runAction:sequence];
    
}
-(void)glovesAnimation {
    
    SKTexture *goldenGlovesTextTexture = [victoryPrizeScene1 textureNamed:@"VictoryPrizeScreenGoldenGlovesText"];
    
    SKSpriteNode *goldenGlovesText = [SKSpriteNode spriteNodeWithTexture:goldenGlovesTextTexture];
    goldenGlovesText.position = CGPointZero;
    goldenGlovesText.size = CGSizeMake(goldenGlovesText.frame.size.width/s, goldenGlovesText.frame.size.height / s);
    goldenGlovesText.zPosition = 2.1;
    [self.spriteLayer addChild:goldenGlovesText];
    
    SKTexture *goldenGlovesTexture = [victoryPrizeScene1 textureNamed:@"VictoryPrizeScreenGoldenGloves"];
    
    SKSpriteNode *goldenGloves = [SKSpriteNode spriteNodeWithTexture:goldenGlovesTexture];
    goldenGloves.position = CGPointMake(0, 500);
    goldenGloves.size = CGSizeMake(goldenGloves.frame.size.width/s, goldenGloves.frame.size.height / s);
    goldenGloves.zPosition = 2;
    [self.spriteLayer addChild:goldenGloves];
    
    SKAction *itemdrop = [SKAction moveTo:CGPointZero duration:4];
    SKAction *itemDesize = [SKAction scaleTo:0.3 duration:0];
    SKAction *itemResize = [SKAction scaleTo:1 duration:4];
    SKAction *group = [SKAction group:@[itemdrop,itemResize]];
    SKAction *sequence = [SKAction sequence:@[itemDesize,group,[SKAction repeatActionForever:[SKAction sequence:@[[SKAction moveByX:0 y:50 duration:2],[SKAction moveByX:0 y:-50 duration:2]]]]]];
    [goldenGloves runAction:sequence];
    
}
-(void)golfClubAnimation {
    
    SKTexture *goldenGolfClubTextTexture = [victoryPrizeScene1 textureNamed:@"VictoryPrizeScreenGoldenGolfClubText"];
    
    SKSpriteNode *goldenGolfClubText = [SKSpriteNode spriteNodeWithTexture:goldenGolfClubTextTexture];
    goldenGolfClubText.position = CGPointZero;
    goldenGolfClubText.size = CGSizeMake(goldenGolfClubText.frame.size.width/s, goldenGolfClubText.frame.size.height / s);
    goldenGolfClubText.zPosition = 2;
    [self.spriteLayer addChild:goldenGolfClubText];
    
    SKTexture *goldenGolfClubTexture = [victoryPrizeScene1 textureNamed:@"VictoryPrizeScreenGoldenGolfClub"];
    
    SKSpriteNode *goldenGolfClub = [SKSpriteNode spriteNodeWithTexture:goldenGolfClubTexture];
    goldenGolfClub.position = CGPointMake(0, 400);
    goldenGolfClub.size = CGSizeMake(goldenGolfClub.frame.size.width/s, goldenGolfClub.frame.size.height / s);
    goldenGolfClub.zPosition = 2;
    [self.spriteLayer addChild:goldenGolfClub];
    
    SKAction *itemdrop = [SKAction moveTo:CGPointZero duration:10];
    SKAction *itemDesize = [SKAction scaleTo:0.3 duration:0];
    SKAction *itemResize = [SKAction scaleTo:1 duration:10];
    SKAction *group = [SKAction group:@[itemdrop,itemResize]];
    SKAction *sequence = [SKAction sequence:@[itemDesize,group]];
    [goldenGolfClub runAction:sequence];
    
}
-(void)microphoneAnimation {
    
    SKTexture *goldenMicrophoneTextTexture = [victoryPrizeScene1 textureNamed:@"VictoryPrizeScreenGoldenMicrophoneText"];
    
    SKSpriteNode *goldenMicrophoneText = [SKSpriteNode spriteNodeWithTexture:goldenMicrophoneTextTexture];
    goldenMicrophoneText.position = CGPointZero;
    goldenMicrophoneText.size = CGSizeMake(goldenMicrophoneText.frame.size.width/s, goldenMicrophoneText.frame.size.height / s);
    goldenMicrophoneText.zPosition = 2;
    [self.spriteLayer addChild:goldenMicrophoneText];
    
    SKTexture *goldenMicrophoneTexture = [victoryPrizeScene1 textureNamed:@"VictoryPrizeScreenGoldenMicrophone"];
    
    SKSpriteNode *goldenMicrophone = [SKSpriteNode spriteNodeWithTexture:goldenMicrophoneTexture];
    goldenMicrophone.position = CGPointMake(0, 400);
    goldenMicrophone.size = CGSizeMake(goldenMicrophone.frame.size.width/s, goldenMicrophone.frame.size.height / s);
    goldenMicrophone.zPosition = 2;
    [self.spriteLayer addChild:goldenMicrophone];
    
    SKAction *itemdrop = [SKAction moveTo:CGPointZero duration:10];
    SKAction *itemDesize = [SKAction scaleTo:0.3 duration:0];
    SKAction *itemResize = [SKAction scaleTo:1 duration:10];
    SKAction *group = [SKAction group:@[itemdrop,itemResize]];
    SKAction *sequence = [SKAction sequence:@[itemDesize,group]];
    [goldenMicrophone runAction:sequence];
    
}
-(void)swordsAnimation {
    
    SKTexture *goldenSwordsTextTexture = [victoryPrizeScene1 textureNamed:@"VictoryPrizeScreenGoldenSwordsText"];
    
    SKSpriteNode *goldenSwordsText = [SKSpriteNode spriteNodeWithTexture:goldenSwordsTextTexture];
    goldenSwordsText.position = CGPointZero;
    goldenSwordsText.size = CGSizeMake(goldenSwordsText.frame.size.width/s, goldenSwordsText.frame.size.height / s);
    goldenSwordsText.zPosition = 2;
    [self.spriteLayer addChild:goldenSwordsText];
    
    SKTexture *goldenSwordsTexture = [victoryPrizeScene1 textureNamed:@"VictoryPrizeScreenGoldenSwords"];
    
    SKSpriteNode *goldenSwords = [SKSpriteNode spriteNodeWithTexture:goldenSwordsTexture];
    goldenSwords.position = CGPointMake(0, 400);
    goldenSwords.size = CGSizeMake(goldenSwords.frame.size.width/s, goldenSwords.frame.size.height / s);
    goldenSwords.zPosition = 2;
    [self.spriteLayer addChild:goldenSwords];
    
    SKAction *itemdrop = [SKAction moveTo:CGPointZero duration:10];
    SKAction *itemDesize = [SKAction scaleTo:0.3 duration:0];
    SKAction *itemResize = [SKAction scaleTo:1 duration:10];
    SKAction *group = [SKAction group:@[itemdrop,itemResize]];
    SKAction *sequence = [SKAction sequence:@[itemDesize,group]];
    [goldenSwords runAction:sequence];
    
}
-(void)unicornAnimation {
    
    SKTexture *goldenUnicornTextTexture = [victoryPrizeScene1 textureNamed:@"VictoryPrizeScreenGoldenUnicornText"];
    
    SKSpriteNode *goldenUnicornText = [SKSpriteNode spriteNodeWithTexture:goldenUnicornTextTexture];
    goldenUnicornText.position = CGPointZero;
    goldenUnicornText.size = CGSizeMake(goldenUnicornText.frame.size.width/s, goldenUnicornText.frame.size.height / s);
    goldenUnicornText.zPosition = 2;
    [self.spriteLayer addChild:goldenUnicornText];
    
    SKTexture *goldenUnicornTexture = [victoryPrizeScene1 textureNamed:@"VictoryPrizeScreenGoldenUnicorn"];
    
    SKSpriteNode *goldenUnicorn = [SKSpriteNode spriteNodeWithTexture:goldenUnicornTexture];
    goldenUnicorn.position = CGPointMake(0, 400);
    goldenUnicorn.size = CGSizeMake(goldenUnicorn.frame.size.width/s, goldenUnicorn.frame.size.height / s);
    goldenUnicorn.zPosition = 2;
    [self.spriteLayer addChild:goldenUnicorn];
    
    SKAction *itemdrop = [SKAction moveTo:CGPointZero duration:10];
    SKAction *itemDesize = [SKAction scaleTo:0.3 duration:0];
    SKAction *itemResize = [SKAction scaleTo:1 duration:10];
    SKAction *group = [SKAction group:@[itemdrop,itemResize]];
    SKAction *sequence = [SKAction sequence:@[itemDesize,group]];
    [goldenUnicorn runAction:sequence];
    
}
-(void)watchAnimation {
    
    SKTexture *goldenWatchTextTexture = [victoryPrizeScene1 textureNamed:@"VictoryPrizeScreenGoldenWatchText"];
    
    SKSpriteNode *goldenWatchText = [SKSpriteNode spriteNodeWithTexture:goldenWatchTextTexture];
    goldenWatchText.position = CGPointZero;
    goldenWatchText.size = CGSizeMake(goldenWatchText.frame.size.width/s, goldenWatchText.frame.size.height / s);
    goldenWatchText.zPosition = 2;
    [self.spriteLayer addChild:goldenWatchText];
    
    SKTexture *goldenWatchTexture = [victoryPrizeScene1 textureNamed:@"VictoryPrizeScreenGoldenWatch"];
    
    SKSpriteNode *goldenWatch = [SKSpriteNode spriteNodeWithTexture:goldenWatchTexture];
    goldenWatch.position = CGPointMake(0, 400);
    goldenWatch.size = CGSizeMake(goldenWatch.frame.size.width/s, goldenWatch.frame.size.height / s);
    goldenWatch.zPosition = 2;
    [self.spriteLayer addChild:goldenWatch];
    
    SKAction *itemdrop = [SKAction moveTo:CGPointZero duration:10];
    SKAction *itemDesize = [SKAction scaleTo:0.3 duration:0];
    SKAction *itemResize = [SKAction scaleTo:1 duration:10];
    SKAction *group = [SKAction group:@[itemdrop,itemResize]];
    SKAction *sequence = [SKAction sequence:@[itemDesize,group]];
    [goldenWatch runAction:sequence];
    
}

-(void)handleNodesAtLocation:(CGPoint)location
{
    NSArray* nodes = [[self spriteLayer] nodesAtPoint:location];
    for(SKNode * node in nodes)
    {
        if ([[node name] isEqualToString:@"Spotlight"])
        {
            
            self.skView = (SKView *)self.view;
            [self.skView presentScene:nil];
            
            victoryPrizeScene1 = nil;
            victoryPrizeScene2 = nil;
            
            // Create and configure the scene.
            GameScene *Gscene = [GameScene sceneWithSize:self.skView.bounds.size];
            Gscene.scaleMode = SKSceneScaleModeAspectFill;
            // Present the scene.
            [self.skView presentScene:Gscene];
            
            
            
            
        }
        else if ([[node name] isEqualToString:@""])
        {
            
            
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
