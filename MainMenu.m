//
//  MainMenu.m
//  Factory Fall
//
//  Created by Willie on 1/12/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import "MainMenu.h"
#import "GameScene.h"
#import "NormalLogic.h"
#import "ArcadeMenu.h"
#import "Shop.h"
#import "DailyChallengeLogic.h"
#import "Settings.h"
#import "VictoryPrizeScreen.h"
#import "Settings.h"
#import "RankLogic.h"
#import "LoadingScreen.h"
#import "GameViewController.h"


#define IPHONE_4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )
#define IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IPHONE_6 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )
#define IPHONE_6_PLUS ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )                                                             

@interface MainMenu ()

@property (strong, nonatomic) SKNode *gameLayer;
//@property (nonatomic, strong) SKSpriteNode *background;
@property (strong, nonatomic) SKNode *spriteLayer;
@property (strong, nonatomic) SKNode *aniLayer;
@property BOOL contentCreated;
//@property (strong, nonatomic) GameScene *Gscene;
//@property (strong, nonatomic) NormalLogic *logic;
//@property (strong, nonatomic) ArcadeMenu *FFArcade;
//@property (strong, nonatomic) Shop *FFShop;
//@property (strong, nonatomic) Settings *SScene;
//@property (strong, nonatomic) VictoryPrizeScreen *VictoryScreen;
//@property (strong, nonatomic) LoadingScreen *Lscene;
//@property (strong, nonatomic) MainMenu *Mainscene;

@end



@implementation MainMenu

-(id)initWithSize:(CGSize)size {
    
    if ((self = [super initWithSize:size])) {
        if (!self.contentCreated)
            
        {
            
            [self sprites];
            
            self.contentCreated = YES;
            
            mainMenuSprites = [self textureAtlasNamed:@"MainMenuSprites"];
            
            buttonSprites = [self textureAtlasNamed:@"ButtonSprites"];
            
            //arcadeSpritesOne = [self textureAtlasNamed:@"ArcadeSpritesOne"];
            
            //arcadeSpritesTwo = [self textureAtlasNamed:@"ArcadeSpritesTwo"];
            
            //arcadeSpritesThree = [self textureAtlasNamed:@"ArcadeSpritesThree"];
            
            //settingsSprites = [self textureAtlasNamed:@"SettingsSprites"];
            
            cloudsSprites = [self textureAtlasNamed:@"CloudSprites"];
            
        self.physicsWorld.contactDelegate = self;
        
        self.anchorPoint = CGPointMake(0.5, 0.5);
        
        backgroundTexture = [mainMenuSprites textureNamed:@"MainMenu"];
            
        background = [SKSpriteNode spriteNodeWithTexture:backgroundTexture];
        [background setName:@"MainMenu"];
        background.size = CGSizeMake(background.frame.size.width/s, background.frame.size.height / s);
        [self addChild:background];
        
        self.gameLayer = [SKNode node];
        [self addChild:self.gameLayer];
        
        CGPoint layerPosition = CGPointZero;
        
        self.spriteLayer = [SKNode node];
        self.spriteLayer.position = layerPosition;
            
        [self.gameLayer addChild:self.spriteLayer];
            
            self.aniLayer = [SKNode node];
            self.aniLayer.position = layerPosition;
            
            [self.spriteLayer addChild:self.aniLayer];
    
            [self sprites];
            [self DayandNightAnimation];
            
        self.physicsWorld.gravity = CGVectorMake(0, 0);
            
            NSString *sound = [[NSBundle mainBundle]pathForResource:@"ClickSound" ofType:@"wav"];
            clickSound = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
            clickSound.delegate = self;
            
            NSString *sound1 = [[NSBundle mainBundle]pathForResource:@"ShakeSound" ofType:@"wav"];
            shakeSound = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound1]  error:NULL];
            shakeSound.delegate = self;
            
            if (justOpened == YES) {
                justOpened = NO;
            }
            
            
                //[audioPlayer1 play];
               // NSLog(@"on2");
            
        /*SKTexture *cloudsBackTexture = [SKTexture textureWithImageNamed:@"CloudsBack"];
        SKAction *moveCloudsBack = [SKAction moveByX:-cloudsBackTexture.size.width/2 y:0 duration:0.1*cloudsBackTexture.size.width];
        SKAction *resetCloudsBack = [SKAction moveByX:cloudsBackTexture.size.width/2 y:0 duration:0];
        SKAction *moveCloudsBackForever = [SKAction repeatActionForever:[SKAction sequence:@[moveCloudsBack, resetCloudsBack]]];
        for( int i = 0; i < 2 + self.frame.size.width / ( cloudsBackTexture.size.width * 2); ++i ) {
            SKSpriteNode* cloudsBack = [SKSpriteNode spriteNodeWithTexture:cloudsBackTexture];
            //[clouds setScale:10];
            cloudsBack.zPosition = 1; // Must be infront of the background but behind the buttons to avoid click conflic //
            cloudsBack.anchorPoint = CGPointZero;
            cloudsBack.position = CGPointMake(i * cloudsBack.size.width, 0);
            [cloudsBack runAction:moveCloudsBackForever];
            [background addChild:cloudsBack];
            
        }
        
        cloudsTexture = [cloudsSprites textureNamed:@"Clouds"];
            SKAction *moveClouds = [SKAction moveTo:CGPointMake(clouds.size.width * 2, -105) duration:300
                                *cloudsTexture.size.width];
        SKAction *resetClouds = [SKAction moveTo:CGPointMake(clouds.size.width, -105) duration:0];
        SKAction *moveCloudsForever = [SKAction repeatActionForever:[SKAction sequence:@[moveClouds, resetClouds]]];
        
            clouds = [SKSpriteNode spriteNodeWithTexture:cloudsTexture];
            clouds.zPosition = 2.4;
            //clouds.anchorPoint = CGPointZero;
            clouds.position = CGPointMake(clouds.size.width, -105);
            clouds.size = CGSizeMake(clouds.frame.size.width/(s + 0.5), clouds.frame.size.height / (s + 0.5));
            [clouds runAction:moveCloudsForever];
            [background addChild:clouds];*/
            
            
            
            /*
            SKTexture *cloudsBackTexture = [cloudsSprites textureNamed:@"Clouds"];
            SKAction *moveCloudsBack = [SKAction moveByX:-cloudsBackTexture.size.width/2 y:0 duration:0.1*cloudsBackTexture.size.width];
            SKAction *resetCloudsBack = [SKAction moveByX:cloudsBackTexture.size.width/2 y:0 duration:0];
            SKAction *moveCloudsBackForever = [SKAction repeatActionForever:[SKAction sequence:@[moveCloudsBack, resetCloudsBack]]];
            for( int i = 0; i < 2 + self.frame.size.width / ( cloudsBackTexture.size.width * 2); ++i ) {
                SKSpriteNode* cloudsBack = [SKSpriteNode spriteNodeWithTexture:cloudsBackTexture];
                //[clouds setScale:10];
                cloudsBack.zPosition = 1; // Must be infront of the background but behind the buttons to avoid click conflic //
                cloudsBack.anchorPoint = CGPointZero;
                cloudsBack.position = CGPointMake(i * cloudsBack.size.width, 0);
                [cloudsBack runAction:moveCloudsBackForever];
                [background addChild:cloudsBack];
                
            }
            SKTexture *cloudsTexture = [SKTexture textureWithImageNamed:@"Clouds"];
            SKAction *moveClouds = [SKAction moveByX:-cloudsTexture.size.width/2 y:0 duration:0.1*cloudsTexture.size.width];
            SKAction *resetClouds = [SKAction moveByX:cloudsTexture.size.width/2 y:0 duration:0];
            SKAction *moveCloudsForever = [SKAction repeatActionForever:[SKAction sequence:@[moveClouds, resetClouds]]];
            for( int i = 0; i < 2 + self.frame.size.width / ( cloudsTexture.size.width * 2); ++i ) {
                SKSpriteNode* clouds = [SKSpriteNode spriteNodeWithTexture:cloudsTexture];
                //[clouds setScale:10];
                clouds.zPosition = 2; // Must be infront of the background but behind the buttons to avoid click conflic //
                clouds.anchorPoint = CGPointZero;
                clouds.position = CGPointMake(i * clouds.size.width, 0);
                [clouds runAction:moveCloudsForever];
                [background addChild:clouds];
                
            }
            */
            
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            canPlay = [defaults boolForKey:@"canPlay"];
            
            NSLog(canPlay ? @"Yes" : @"No");
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
-(void)sprites {
    
    filterTexture = [mainMenuSprites textureNamed:@"Filter"];
    
    filter = [SKSpriteNode spriteNodeWithTexture:filterTexture];
    filter.position = CGPointZero;
    filter.zPosition = 20;
    filter.size = CGSizeMake(filter.frame.size.width/s, filter.frame.size.height / s);
    [self.spriteLayer addChild:filter];
    
    titleTexture = [mainMenuSprites textureNamed:@"Title"];
    
    title = [SKSpriteNode spriteNodeWithTexture:titleTexture];
    title.position = CGPointMake(0, 500);
    title.zPosition = 3;
    title.size = CGSizeMake(title.frame.size.width/s, title.frame.size.height / s);
    [self.spriteLayer addChild:title];
    
    factoryTexture = [mainMenuSprites textureNamed:@"Factory"];
    
    factory = [SKSpriteNode spriteNodeWithTexture:factoryTexture];
    factory.position = CGPointMake(0, 1000);
    factory.zPosition = 3;
    factory.size = CGSizeMake(factory.frame.size.width/s, factory.frame.size.height / s);
    [self.spriteLayer addChild:factory];
    
    factoryShadowTexture = [mainMenuSprites textureNamed:@"FactoryShadow"];
    
    factoryShadow = [SKSpriteNode spriteNodeWithTexture:factoryShadowTexture];
    factoryShadow.position = CGPointZero;
    factoryShadow.zPosition = 2;
    factoryShadow.size = CGSizeMake(factoryShadow.frame.size.width/s, factoryShadow.frame.size.height / s);
    [self.spriteLayer addChild:factoryShadow];
    
    planetsTexture = [mainMenuSprites textureNamed:@"Planets"];
    
    planets = [SKSpriteNode spriteNodeWithTexture:planetsTexture];
    planets.position = CGPointMake(0, 0);
    planets.zPosition = 2.3;
    planets.size = CGSizeMake(planets.frame.size.width/s, planets.frame.size.height / s);
    [self.spriteLayer addChild:planets];
    
    bushesTexture = [mainMenuSprites textureNamed:@"Bushes"];
    
    bushes = [SKSpriteNode spriteNodeWithTexture:bushesTexture];
    bushes.position = CGPointMake(0, 1000);
    bushes.zPosition = 3.1;
    bushes.size = CGSizeMake(bushes.frame.size.width/s, bushes.frame.size.height / s);
    [self.spriteLayer addChild:bushes];
    
    playTexture = [buttonSprites textureNamed:@"PlayButton"];
    
    play = [SKSpriteNode spriteNodeWithTexture:playTexture];
    play.position = CGPointMake(-80, 600);
    play.size = CGSizeMake(play.frame.size.width/(s + 0.5), play.frame.size.height / (s + 0.5));
    play.zPosition = 4; 
    play.name = @"PlayButton";
    play.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:play.size];
    [self.aniLayer addChild:play];
    
    settingsTexture = [buttonSprites textureNamed:@"SettingsButton"];
    
    settings = [SKSpriteNode spriteNodeWithTexture:settingsTexture];
    settings.position = CGPointMake(-65, 600);
    settings.size = CGSizeMake(settings.frame.size.width/2.5, settings.frame.size.height / 2.5);
    settings.zPosition = 4;
    settings.name = @"SettingsButton";
    [self.spriteLayer addChild:settings];
    
    /*vaultTexture = [buttonSprites textureNamed:@"VaultButton"];
    
    vault = [SKSpriteNode spriteNodeWithTexture:vaultTexture];
    vault.position = CGPointMake(80, 600);
    vault.size = CGSizeMake(vault.frame.size.width/(s + 0.5), vault.frame.size.height / (s + 0.5));
    vault.zPosition = 4;
    vault.name = @"VaultButton";
    [self.spriteLayer addChild:vault];*/
    
    shopTexture = [buttonSprites textureNamed:@"ShopButton"];
    
    shop = [SKSpriteNode spriteNodeWithTexture:shopTexture];
    shop.position = CGPointMake(95, 600);
    shop.size = CGSizeMake(shop.frame.size.width/(s + 0.5), shop.frame.size.height / (s + 0.5));
    shop.zPosition = 4.5;
    shop.name = @"ShopButton";
    [self.spriteLayer addChild:shop];
    
    dailyChallengesBorderTexture = [mainMenuSprites textureNamed:@"DailyChallengesBorder"];
    
    dailyChallengesBorder = [SKSpriteNode spriteNodeWithTexture:dailyChallengesBorderTexture];
    dailyChallengesBorder.position = CGPointMake(0, -100);
    dailyChallengesBorder.zPosition = 3.23;
    dailyChallengesBorder.size = CGSizeMake(dailyChallengesBorder.frame.size.width/s, dailyChallengesBorder.frame.size.height / s);
    [self.spriteLayer addChild:dailyChallengesBorder];
    
    dailyChallengesBoardTexture = [mainMenuSprites textureNamed:@"DailyChallengesBoard"];
    
    dailyChallengesBoard = [SKSpriteNode spriteNodeWithTexture:dailyChallengesBoardTexture];
    dailyChallengesBoard.position = CGPointMake(0, -100);
    dailyChallengesBoard.zPosition = 3.2;
    dailyChallengesBoard.size = CGSizeMake(dailyChallengesBoard.frame.size.width/s, dailyChallengesBoard.frame.size.height / s);
    [self.spriteLayer addChild:dailyChallengesBoard];
    
    dailyCHallengesTextsTexture = [mainMenuSprites textureNamed:@"DailyChallengesText"];
    
    dailyCHallengesText = [SKSpriteNode spriteNodeWithTexture:dailyCHallengesTextsTexture];
    dailyCHallengesText.position = CGPointMake(0, -100);
    dailyCHallengesText.zPosition = 3.22;
    dailyCHallengesText.size = CGSizeMake(dailyCHallengesText.frame.size.width/s, dailyCHallengesText.frame.size.height / s);
    [self.spriteLayer addChild:dailyCHallengesText];
    
    quickPlayTexture = [buttonSprites textureNamed:@"QuickPlay"];
    
    quickPlay = [SKSpriteNode spriteNodeWithTexture:quickPlayTexture];
    quickPlay.position = CGPointMake(-self.frame.size.width/2.1 + quickPlay.size.width/4.5, -self.frame.size.height/2.0 + quickPlay.size.height/4.5);
    quickPlay.anchorPoint = CGPointMake(0.5, 0.5);
    quickPlay.size = CGSizeMake(quickPlay.frame.size.width/s, quickPlay.frame.size.height / s);
    quickPlay.name = @"QuickPlay";
    quickPlay.zPosition = 19;
    [self.spriteLayer addChild:quickPlay];
    
    if (canPlay == NO) {
        [quickPlay removeFromParent];
    }
    
    SKAction *moveFactory = [SKAction moveTo:CGPointZero duration:0.5];
    SKAction *factoryBounce = [SKAction moveTo:CGPointMake(0, 20) duration:0.2];
    SKAction *factoryFall = [SKAction moveTo:CGPointZero duration:0.2];
    SKAction *playSound = [SKAction performSelector:@selector(startSynchronizedPlayback) onTarget:self];
    SKAction *factorySequence = [SKAction sequence:@[playSound,moveFactory,factoryBounce,factoryFall]];
    [factory runAction:factorySequence];
    
    SKAction *tiny = [SKAction scaleTo:0.1 duration:0];
    SKAction *big = [SKAction scaleTo:1 duration:0.5];
    SKAction *small = [SKAction scaleTo:0.8 duration:0.2];
    SKAction *huge = [SKAction scaleTo:1 duration:0.2];
    SKAction *seq = [SKAction sequence:@[tiny,big,small,huge]];
    [factoryShadow runAction:seq];
    
    SKAction *bushWait = [SKAction waitForDuration:0.3];
    SKAction *moveBush = [SKAction moveTo:CGPointZero duration:0.5];
    SKAction *bushBounce = [SKAction moveTo:CGPointMake(0, 20) duration:0.2];
    SKAction *bushFall = [SKAction moveTo:CGPointZero duration:0.2];
    SKAction *bushSequence = [SKAction sequence:@[bushWait,moveBush,bushBounce,bushFall]];
    [bushes runAction:bushSequence];
    
    SKAction *settingsWait = [SKAction waitForDuration:0.5];
    SKAction *moveSettings = [SKAction moveTo:CGPointMake(-65, -120) duration:0.5];
    SKAction *settingsbounce = [SKAction moveTo:CGPointMake(-65, -100) duration:0.2];
    SKAction *settingsFall = [SKAction moveTo:CGPointMake(-65, -120) duration:0.2];
    
    SKAction *ssmove = [SKAction moveToY:-130 duration:1];
    SKAction *ssbounce = [SKAction moveToY:-110 duration:0.2];
    SKAction *ssfall = [SKAction moveToY:-130 duration:0.2];
    SKAction *sssequence = [SKAction sequence:@[settingsWait,ssmove,ssbounce,ssfall]];
    [settingsShadow runAction:sssequence];
    SKAction *settingsSequence = [SKAction sequence:@[settingsWait, moveSettings, settingsbounce, settingsFall]];
    [settings runAction:settingsSequence];
    
    /*SKAction *vaultWait = [SKAction waitForDuration:0.7];
    SKAction *moveVault = [SKAction moveTo:CGPointMake(80, -30) duration:0.5];
    SKAction *vaultBounce = [SKAction moveTo:CGPointMake(80, -10) duration:0.2];
    SKAction *vaultFall = [SKAction moveTo:CGPointMake(80, -30) duration:0.2];
    SKAction *vaultSequence = [SKAction sequence:@[vaultWait,moveVault,vaultBounce,vaultFall]];
    [vault runAction:vaultSequence];*/
    
    SKAction *playWait = [SKAction waitForDuration:0.9];
    SKAction *movePlay = [SKAction moveTo:CGPointMake(-80, 0) duration:0.5];
    SKAction *playBounce = [SKAction moveTo:CGPointMake(-80, 20) duration:0.2];
    SKAction *playFall = [SKAction moveTo:CGPointMake(-80, 0) duration:0.2];
    
    SKAction *psmove = [SKAction moveToY:-10 duration:0.5];
    SKAction *psbounce = [SKAction moveToY:10 duration:0.2];
    SKAction *psfall = [SKAction moveToY:-10 duration:0.2];
    SKAction *pssequence = [SKAction sequence:@[playWait,psmove,psbounce,psfall]];
    [playShadow runAction:pssequence];
    SKAction *playSequence = [SKAction sequence:@[playWait,movePlay,playBounce,playFall]];
    [play runAction:playSequence];
    
    SKAction *shopWait = [SKAction waitForDuration:1.1];
    SKAction *shopVault = [SKAction moveTo:CGPointMake(95, -160) duration:0.5];
    SKAction *shopBounce = [SKAction moveTo:CGPointMake(95, -140) duration:0.2];
    SKAction *shopFall = [SKAction moveTo:CGPointMake(95, -160) duration:0.2];
    
    SKAction *shsmove = [SKAction moveToY:-180 duration:0.5];
    SKAction *shsbounce = [SKAction moveToY:-160 duration:0.2];
    SKAction *shsfall = [SKAction moveToY:-180 duration:0.2];
    SKAction *shssequence = [SKAction sequence:@[playWait,shsmove,shsbounce,shsfall]];
    [shopShadow runAction:shssequence];
    SKAction *shopSequence = [SKAction sequence:@[shopWait,shopVault,shopBounce,shopFall]];
    [shop runAction:shopSequence];
    
    SKAction *titleWait = [SKAction waitForDuration:1.3];
    SKAction *moveTitle = [SKAction moveTo:CGPointMake(0, -self.frame.size.height/24.5) duration:0.5];
    SKAction *titleBounce = [SKAction moveTo:CGPointMake(0, -self.frame.size.height/24.3) duration:0.2];
    SKAction *titleFall = [SKAction moveTo:CGPointMake(0, -self.frame.size.height/24.5) duration:0.2];
    SKAction *titleSequence = [SKAction sequence:@[titleWait,moveTitle,titleBounce,titleFall]];
    [title runAction:titleSequence];
    SKAction *titleSizeWait = [SKAction waitForDuration:5];
    SKAction *titlePop = [SKAction scaleBy:1.02 duration:0.5];
    SKAction *titleShribble = [SKAction scaleTo:1 duration:0.5];
    SKAction *titleWait1 = [SKAction waitForDuration:2];
    SKAction *titleSizeSequence1 = [SKAction sequence:@[titlePop,titleWait1,titleShribble,titleWait1]];
    SKAction *repeatSequence1 = [SKAction repeatActionForever:titleSizeSequence1];
    SKAction *titleSizeSequence = [SKAction sequence:@[titleSizeWait,repeatSequence1]];
    
    [title runAction:titleSizeSequence];
    
    NSArray * titleSprites = @[[SKTexture textureWithImageNamed:@"Title1"],
                               [SKTexture textureWithImageNamed:@"Title2"],
                               [SKTexture textureWithImageNamed:@"Title3"],
                               [SKTexture textureWithImageNamed:@"Title4"],
                               [SKTexture textureWithImageNamed:@"Title5"]];
    SKAction *titlePause = [SKAction waitForDuration:3];
    SKAction *titleAnimate = [SKAction animateWithTextures:titleSprites timePerFrame:0.1];
    SKAction *repeatTitleAnimateForever = [SKAction repeatActionForever:titleAnimate];
    SKAction *titleSequence1 = [SKAction sequence:@[titlePause,repeatTitleAnimateForever]];
    [title runAction:titleSequence1];
    
    SKAction *dcwait1 = [SKAction waitForDuration:2.5];
    SKAction *dcmove1 = [SKAction moveToY:20 duration:0.2];
    SKAction *dcreturn1 = [SKAction moveToY:0 duration:0.2];
    SKAction *dcsequence1 = [SKAction sequence:@[dcwait1,dcmove1,dcreturn1]];
    [dailyChallengesBoard runAction:dcsequence1];
    [dailyChallengesBorder runAction:dcsequence1];
    [dailyCHallengesText runAction:dcsequence1];
    
    
    SKAction *bswait = [SKAction waitForDuration:5];
    SKAction *bspop = [SKAction scaleBy:1.1 duration:1];
    SKAction *bsshribble = [SKAction scaleTo:1 duration:1.85];
    SKAction *bssequence = [SKAction sequence:@[bspop,bsshribble]];
    SKAction *bsequence = [SKAction sequence:@[bsshribble,bspop]];
    SKAction *bsrepeat = [SKAction repeatActionForever:bssequence];
    SKAction *brepeat = [SKAction repeatActionForever:bsequence];
    SKAction *bssequence1 = [SKAction sequence:@[bswait,bsrepeat]];
    SKAction *bsequence1 = [SKAction sequence:@[bswait,brepeat]];
    [settings runAction:bssequence1];
    [settingsShadow runAction:bsequence1];
    [play runAction:bssequence1];
    [playShadow runAction:bsequence1];
    [shop runAction:bssequence1];
    [shopShadow runAction:bsequence1];
    [vault runAction:bssequence1];
    
    SKAction *dcWait2 = [SKAction waitForDuration:3.5];
    SKAction *dcMove2 = [SKAction moveToX:400 duration:1];
    SKAction *dcMove3 = [SKAction moveToX:-400 duration:0];
    SKAction *dcMove4 = [SKAction moveToX:0 duration:1];
    SKAction *dcWait3 = [SKAction waitForDuration:1.5];
    SKAction *dcseq2 = [SKAction sequence:@[dcWait2,dcMove2,dcMove3,dcMove4,dcWait3]];
    SKAction *dcRep = [SKAction repeatActionForever:dcseq2];
    [dailyCHallengesText runAction:dcRep];
    
    
    /* Once you click play all the sprites will drop down and then it will show the next screen after the animations are finished*/
 
}
- (void) startSynchronizedPlayback {
    
    NSString *music = [[NSBundle mainBundle]pathForResource:@"FallSound" ofType:@"wav"];
    FallSound = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:music]  error:NULL];
    FallSound.delegate = self;
    
    NSString *mustard = [[NSBundle mainBundle]pathForResource:@"Wind" ofType:@"wav"];
    windSound = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:mustard]  error:NULL];
    windSound.delegate = self;
    
    NSString *popsicle = [[NSBundle mainBundle]pathForResource:@"Pop" ofType:@"wav"];
    popSound = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:popsicle]  error:NULL];
    popSound.delegate = self;
    
    NSString *popsicle1 = [[NSBundle mainBundle]pathForResource:@"Pop" ofType:@"wav"];
    popSound1 = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:popsicle1]  error:NULL];
    popSound1.delegate = self;
    
    NSString *popsicle2 = [[NSBundle mainBundle]pathForResource:@"Pop" ofType:@"wav"];
    popSound2 = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:popsicle2]  error:NULL];
    popSound2.delegate = self;
    
    NSString *popsicle3 = [[NSBundle mainBundle]pathForResource:@"Pop" ofType:@"wav"];
    popSound3 = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:popsicle3]  error:NULL];
    popSound3.delegate = self;
    
    NSString *popsicle4 = [[NSBundle mainBundle]pathForResource:@"Pop" ofType:@"wav"];
    popSound4 = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:popsicle4]  error:NULL];
    popSound4.delegate = self;
    
                // seconds
    NSTimeInterval anotherDelay = 0.0;
    NSTimeInterval delay3 = 0.8;
    NSTimeInterval delay4 = 1.0;
    NSTimeInterval delay5 = 1.2;
    NSTimeInterval delay6 = 1.4;
    NSTimeInterval delay7 = 1.6;
    NSTimeInterval teh = windSound.deviceCurrentTime;
    NSTimeInterval meh = popSound.deviceCurrentTime;
    NSTimeInterval leh = popSound1.deviceCurrentTime;
    NSTimeInterval deh = popSound1.deviceCurrentTime;
    NSTimeInterval heh = popSound1.deviceCurrentTime;
    NSTimeInterval veh = popSound1.deviceCurrentTime;
    
    [windSound       playAtTime: teh + anotherDelay];
    [popSound        playAtTime: meh + delay3];
    [popSound1        playAtTime: leh + delay4];
    [popSound2        playAtTime: deh + delay5];
    [popSound3       playAtTime: heh + delay6];
    [popSound4        playAtTime: veh + delay7];
    
    // Here, update state and user interface for each player, as appropriate
}
- (void) startSynchronizedPlaybackFall {
    
    NSString *svish = [[NSBundle mainBundle]pathForResource:@"Swish" ofType:@"wav"];
    swishSound = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:svish]  error:NULL];
    swishSound.delegate = self;
    
    NSString *svish1 = [[NSBundle mainBundle]pathForResource:@"Swish" ofType:@"wav"];
    swishSound1 = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:svish1]  error:NULL];
    swishSound1.delegate = self;
    
    NSString *svish2 = [[NSBundle mainBundle]pathForResource:@"Swish" ofType:@"wav"];
    swishSound2 = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:svish2]  error:NULL];
    swishSound2.delegate = self;
    
    NSString *svish3 = [[NSBundle mainBundle]pathForResource:@"Swish" ofType:@"wav"];
    swishSound3 = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:svish3]  error:NULL];
    swishSound3.delegate = self;
    
    NSString *svish4 = [[NSBundle mainBundle]pathForResource:@"Swish" ofType:@"wav"];
    swishSound4 = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:svish4]  error:NULL];
    swishSound4.delegate = self;
    
    NSString *svish5 = [[NSBundle mainBundle]pathForResource:@"Swish" ofType:@"wav"];
    swishSound5 = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:svish5]  error:NULL];
    swishSound5.delegate = self;
    
    NSString *svish6 = [[NSBundle mainBundle]pathForResource:@"Swish" ofType:@"wav"];
    swishSound6 = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:svish6]  error:NULL];
    swishSound6.delegate = self;
    
    NSTimeInterval shortStartDelay = 0.2;
    NSTimeInterval shortStartDelay1 = 0.4;
    NSTimeInterval shortStartDelay2 = 0.6;
    NSTimeInterval shortStartDelay3 = 0.8;
    NSTimeInterval shortStartDelay4 = 1.0;
    NSTimeInterval shortStartDelay5 = 1.2;
    NSTimeInterval shortStartDelay6 = 1.4;
    NSTimeInterval now = swishSound.deviceCurrentTime;
    NSTimeInterval now1 = swishSound1.deviceCurrentTime;
    NSTimeInterval now2 = swishSound2.deviceCurrentTime;
    NSTimeInterval now3 = swishSound3.deviceCurrentTime;
    NSTimeInterval now4 = swishSound4.deviceCurrentTime;
    NSTimeInterval now5 = swishSound5.deviceCurrentTime;
    NSTimeInterval now6 = swishSound6.deviceCurrentTime;
    
    [swishSound       playAtTime: now + shortStartDelay];
    [swishSound1       playAtTime: now1 + shortStartDelay1];
    [swishSound2       playAtTime: now2 + shortStartDelay2];
    [swishSound3       playAtTime: now3 + shortStartDelay3];
    [swishSound4       playAtTime: now4 + shortStartDelay4];
    [swishSound5       playAtTime: now5 + shortStartDelay5];
    [swishSound6       playAtTime: now6 + shortStartDelay6];
    
}

-(void)DayandNightAnimation
{
    
    sunAndMoonTexture = [buttonSprites textureNamed:@"SunAndMoon"];
    
    sunAndMoon = [SKSpriteNode spriteNodeWithTexture:sunAndMoonTexture];
    sunAndMoon.anchorPoint = CGPointMake(0.5, 0.5);
    sunAndMoon.zPosition = 2.2;
    sunAndMoon.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2); // Estimate //
    sunAndMoon.size = CGSizeMake(sunAndMoon.frame.size.width/s, sunAndMoon.frame.size.height / s);
    [self.spriteLayer addChild:sunAndMoon];
    SKAction *sunAndMoonSpin = [SKAction rotateByAngle:M_PI duration:30]; // 5 Minutes //
    [sunAndMoon runAction:[SKAction repeatActionForever:sunAndMoonSpin]];
    
    dayAndNightTexture = [mainMenuSprites textureNamed:@"DayAndNight"];
    
    dayAndNight = [SKSpriteNode spriteNodeWithTexture:dayAndNightTexture];
    dayAndNight.alpha = 0.0;
    dayAndNight.zPosition = 2;
    dayAndNight.position = CGPointZero;
    dayAndNight.size = CGSizeMake(dayAndNight.frame.size.width/s, dayAndNight.frame.size.height / s);
    [self.spriteLayer addChild:dayAndNight];
    SKAction *dayToNight = [SKAction fadeAlphaTo:1.0 duration:30]; // Make sure the dayAndNight images alpha is already transparent so it doesnt completely cover the screen //
    SKAction *nightToDay = [SKAction fadeAlphaTo:0.0 duration:30];
    SKAction *dayToNightNightToDaySequence = [SKAction sequence:@[dayToNight, nightToDay]];
    [dayAndNight runAction:[SKAction repeatActionForever:dayToNightNightToDaySequence]]; // May have to make a seperat action that reverts the night alpha back to the days alpha //
    
    starsTexture = [mainMenuSprites textureNamed:@"Stars"];
    
    stars = [SKSpriteNode spriteNodeWithTexture:starsTexture];
    stars.alpha = 1.0;
    stars.zPosition = 2.1;
    stars.position = CGPointZero;
    stars.size = CGSizeMake(stars.frame.size.width/s, stars.frame.size.height / s);
    [self.spriteLayer addChild:stars];
   /*SKAction *staryNight = [SKAction fadeAlphaBy:1.0 duration:30];
    SKAction *starlessDay = [SKAction fadeAlphaTo:0.0 duration:30];
    SKAction *starSequence = [SKAction sequence:@[staryNight, starlessDay]];
    [stars runAction:[SKAction repeatActionForever:starSequence]];*/

}
-(void)goToArcadeMenu {
    
    
    self.skView = (SKView *)self.view;
    [self.skView presentScene:nil];
    cloudsSprites = nil;
    // Create and configure the scene.
    ArcadeMenu *FFArcade = [[ArcadeMenu alloc]initWithSize:self.skView.bounds.size];
    FFArcade = [ArcadeMenu sceneWithSize:self.skView.bounds.size];
    FFArcade.scaleMode = SKSceneScaleModeAspectFill;
    // Present the scene.
    [self.skView presentScene:FFArcade];
   
}
-(void)goToVictoryPrizeScreen {
    
    self.skView = (SKView *)self.view;
    [self.skView presentScene:nil];
    cloudsSprites = nil;
    // Create and configure the scene.
    VictoryPrizeScreen *VictoryScreen = [VictoryPrizeScreen sceneWithSize:self.skView.bounds.size];
    VictoryScreen.scaleMode = SKSceneScaleModeAspectFill;
    // Present the scene.
    [self.skView presentScene:VictoryScreen];
    
}
-(void)goToShop {
    
    NSLog(@"Buy");
    
    self.skView = (SKView *)self.view;
    [self.skView presentScene:nil];
    cloudsSprites = nil;
    // Create and configure the scene.
    Shop *FFShop = [Shop sceneWithSize:self.skView.bounds.size];
    FFShop.scaleMode = SKSceneScaleModeAspectFill;
    // Present the scene.
    [self.skView presentScene:FFShop];
    
    
    
    
}
-(void)goToNormalMode {
    
    NSLog(@"Play");
    
    self.skView = (SKView *)self.view;
    [self.skView presentScene:nil];
    cloudsSprites = nil;
    // Create and configure the scene.
    GameScene *Gscene = [GameScene sceneWithSize:self.skView.bounds.size];
    Gscene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Load the level.
    //NormalLogic *logic = [[NormalLogic alloc] init];
    //Gscene.logic = logic;
    
    // Present the scene.
    [self.skView presentScene:Gscene];
    
    
}
-(void)gotoSettings {
    
    self.skView = (SKView *)self.view;
    [self.skView presentScene:nil];
    cloudsSprites = nil;
    // Create and configure the scene.
    Settings *SScene = [Settings sceneWithSize:self.skView.bounds.size];
    SScene.scaleMode = SKSceneScaleModeAspectFill;
    // Present the scene.
    [self.skView presentScene:SScene];
    
}
-(void)goToLoadingScreen {
    
    
    self.skView = (SKView *)self.view;
    [self.skView presentScene:nil];
    cloudsSprites = nil;
    // Create and configure the scene.
    LoadingScreen *Lscene = [LoadingScreen sceneWithSize:self.skView.bounds.size];
    self.scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [self.skView presentScene:Lscene];
    
}
-(void)handleNodesAtLocation:(CGPoint)location
{
    NSArray* nodes = [[self spriteLayer] nodesAtPoint:location];
    for(SKNode * node in nodes)
    {
        if ([[node name] isEqualToString:@"PlayButton"] & (self.isMoving == NO))
        {
            self.isMoving = YES;
            
            [clickSound play];
            
            SKAction *factoryBounce = [SKAction moveTo:CGPointMake(0, 20) duration:0.2];
            SKAction *factoryFall = [SKAction moveTo:CGPointMake(0, -1000) duration:0.5];
            SKAction *playSound = [SKAction performSelector:@selector(startSynchronizedPlaybackFall) onTarget:self];
            SKAction *factorySequence = [SKAction sequence:@[playSound,factoryBounce,factoryFall]];
            [factory runAction:factorySequence];
            
            SKAction *bushWait = [SKAction waitForDuration:0.3];
            SKAction *bushBounce = [SKAction moveTo:CGPointMake(0, 20) duration:0.2];
            SKAction *bushFall = [SKAction moveTo:CGPointMake(0, -1000) duration:0.5];
            SKAction *bushSequence = [SKAction sequence:@[bushWait,bushBounce,bushFall]];
            [bushes runAction:bushSequence];
            
            /*SKAction *settingsWait = [SKAction waitForDuration:0.5];
            SKAction *settingsbounce = [SKAction moveTo:CGPointMake(-65, -100) duration:0.1];
            SKAction *settingsFall = [SKAction moveTo:CGPointMake(-65, -1000) duration:0.2];
            SKAction *settingsSequence = [SKAction sequence:@[settingsWait,settingsbounce, settingsFall]];
            [settings runAction:settingsSequence];
            
            SKAction *settingsShadowWait = [SKAction waitForDuration:0.5];
            SKAction *settingsShadowbounce = [SKAction moveTo:CGPointMake(-75, -100) duration:0.1];
            SKAction *settingsShadowFall = [SKAction moveTo:CGPointMake(-75, -1000) duration:0.2];
            SKAction *settingsShadowSequence = [SKAction sequence:@[settingsShadowWait,settingsShadowbounce, settingsShadowFall]];
            [settingsShadow runAction:settingsShadowSequence];*/
            
            SKAction *vaultWait = [SKAction waitForDuration:0.7];
            SKAction *vaultBounce = [SKAction moveTo:CGPointMake(80, -10) duration:0.1];
            SKAction *vaultFall = [SKAction moveTo:CGPointMake(80, -600) duration:0.2];
            SKAction *vaultSequence = [SKAction sequence:@[vaultWait,vaultBounce,vaultFall]];
            [vault runAction:vaultSequence];
            
            SKAction *playWait = [SKAction waitForDuration:0.9];
            SKAction *playBounce = [SKAction moveTo:CGPointMake(-80, 20) duration:0.1];
            SKAction *playFall = [SKAction moveTo:CGPointMake(-80, -600) duration:0.2];
            SKAction *playSequence = [SKAction sequence:@[playWait,playBounce,playFall]];
            [play runAction:playSequence];
            
            SKAction *playShadowWait = [SKAction waitForDuration:0.9];
            SKAction *playShadowBounce = [SKAction moveTo:CGPointMake(-90, 20) duration:0.2];
            SKAction *playShadowFall = [SKAction moveTo:CGPointMake(-90, -600) duration:0.2];
            SKAction *playShadowSequence = [SKAction sequence:@[playShadowWait,playShadowBounce,playShadowFall]];
            [playShadow runAction:playShadowSequence];
            
            SKAction *shopWait = [SKAction waitForDuration:1.1];
            SKAction *shopBounce = [SKAction moveTo:CGPointMake(95, -140) duration:0.1];
            SKAction *shopFall = [SKAction moveTo:CGPointMake(95, -600) duration:0.2];
            SKAction *shopSequence = [SKAction sequence:@[shopWait,shopBounce,shopFall]];
            [shop runAction:shopSequence];
            
            SKAction *shopShadowWait = [SKAction waitForDuration:1.1];
            SKAction *shopShadowBounce = [SKAction moveTo:CGPointMake(85, -140) duration:0.2];
            SKAction *shopShadowFall = [SKAction moveTo:CGPointMake(85, -600) duration:0.2];
            SKAction *shopShadowSequence = [SKAction sequence:@[shopShadowWait,shopShadowBounce,shopShadowFall]];
            [shopShadow runAction:shopShadowSequence];
            
            SKAction *titleWait = [SKAction waitForDuration:1.3];
            SKAction *titleBounce = [SKAction moveTo:CGPointMake(0, 20) duration:0.1];
            SKAction *titleFall = [SKAction moveTo:CGPointMake(0, -1000) duration:0.2];
            SKAction *titleSequence = [SKAction sequence:@[titleWait,titleBounce,titleFall]];
            [title runAction:titleSequence];
            
            SKAction *tiny = [SKAction scaleTo:0.7 duration:0.2];
            SKAction *invisible = [SKAction scaleTo:0 duration:0.2];
            SKAction *seq = [SKAction sequence:@[tiny,invisible]];
            [factoryShadow runAction:seq];
            
            

            [self performSelector:@selector(goToArcadeMenu) withObject:nil afterDelay:2];
            
        }
        else if ([[node name] isEqualToString:@"QuickPlay"])
        {
            
            [clickSound play];
            [self runAction:[SKAction sequence:@[[SKAction waitForDuration:1],[SKAction runBlock:^{
                NSUserDefaults *defaults0 = [NSUserDefaults standardUserDefaults];
                beatObj = [defaults0 boolForKey:@"beatObj"];
                
                NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
                rankNumber = [defaults1 integerForKey:@"rankNumber"];
                NSLog(@"rankNumberQP:" @"%ld", (long)rankNumber);
                if (canPlay == YES) {
                    if (beatObj == YES) {
                        rankNumber++;
                    }
                    beatObj = NO;
                    NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
                    [defaults1 setInteger:rankNumber forKey:@"rankNumber"];
                    [defaults1 synchronize];
                    NSLog(@"rankNumberQP:" @"%ld", (long)rankNumber);
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setBool:beatObj forKey:@"beatObj"];
                    [defaults synchronize];
                    
                    [self.skView presentScene:nil];
                    
                    [windSound stop];
                    [popSound stop];
                    [popSound1 stop];
                    [popSound2 stop];
                    [popSound3 stop];
                    [popSound4 stop];
                    [swishSound stop];
                    [swishSound1 stop];
                    [swishSound2 stop];
                    [swishSound3 stop];
                    [swishSound4 stop];
                    [swishSound5 stop];
                    [swishSound6 stop];
                    
                }
                if (rankNumber < 27) {
                    [self performSelector:@selector(goToLoadingScreen) withObject:self afterDelay:0.125];
                } else {
                    [self performSelector:@selector(goToNormalMode) withObject:self afterDelay:0.125];
                }
            }]]]];
        }
        else if ([[node name] isEqualToString:@"SettingsButton"] & (self.isMoving == NO))
        {
            self.isMoving = YES;
            
            [clickSound play];
            
            SKAction *factoryBounce = [SKAction moveTo:CGPointMake(0, 20) duration:0.2];
            SKAction *factoryFall = [SKAction moveTo:CGPointMake(0, -1000) duration:0.5];
            SKAction *playSound = [SKAction performSelector:@selector(startSynchronizedPlaybackFall) onTarget:self];
            SKAction *factorySequence = [SKAction sequence:@[playSound,factoryBounce,factoryFall]];
            [factory runAction:factorySequence];
            
            SKAction *bushWait = [SKAction waitForDuration:0.3];
            SKAction *bushBounce = [SKAction moveTo:CGPointMake(0, 20) duration:0.2];
            SKAction *bushFall = [SKAction moveTo:CGPointMake(0, -1000) duration:0.5];
            SKAction *bushSequence = [SKAction sequence:@[bushWait,bushBounce,bushFall]];
            [bushes runAction:bushSequence];
            
            /*SKAction *settingsWait = [SKAction waitForDuration:0.5];
            SKAction *settingsbounce = [SKAction moveTo:CGPointMake(-65, -100) duration:0.1];
            SKAction *settingsFall = [SKAction moveTo:CGPointMake(-65, -1000) duration:0.2];
            SKAction *settingsSequence = [SKAction sequence:@[settingsWait,settingsbounce, settingsFall]];
            [settings runAction:settingsSequence];
            
            SKAction *settingsShadowWait = [SKAction waitForDuration:0.5];
            SKAction *settingsShadowbounce = [SKAction moveTo:CGPointMake(-75, -100) duration:0.1];
            SKAction *settingsShadowFall = [SKAction moveTo:CGPointMake(-75, -1000) duration:0.2];
            SKAction *settingsShadowSequence = [SKAction sequence:@[settingsShadowWait,settingsShadowbounce, settingsShadowFall]];
            [settingsShadow runAction:settingsShadowSequence];*/
            
            SKAction *vaultWait = [SKAction waitForDuration:0.7];
            SKAction *vaultBounce = [SKAction moveTo:CGPointMake(80, -10) duration:0.1];
            SKAction *vaultFall = [SKAction moveTo:CGPointMake(80, -600) duration:0.2];
            SKAction *vaultSequence = [SKAction sequence:@[vaultWait,vaultBounce,vaultFall]];
            [vault runAction:vaultSequence];
            
            SKAction *playWait = [SKAction waitForDuration:0.9];
            SKAction *playBounce = [SKAction moveTo:CGPointMake(-80, 20) duration:0.1];
            SKAction *playFall = [SKAction moveTo:CGPointMake(-80, -600) duration:0.2];
            SKAction *playSequence = [SKAction sequence:@[playWait,playBounce,playFall]];
            [play runAction:playSequence];
            
            SKAction *playShadowWait = [SKAction waitForDuration:0.9];
            SKAction *playShadowBounce = [SKAction moveTo:CGPointMake(-90, 20) duration:0.2];
            SKAction *playShadowFall = [SKAction moveTo:CGPointMake(-90, -600) duration:0.2];
            SKAction *playShadowSequence = [SKAction sequence:@[playShadowWait,playShadowBounce,playShadowFall]];
            [playShadow runAction:playShadowSequence];
            
            SKAction *shopWait = [SKAction waitForDuration:1.1];
            SKAction *shopBounce = [SKAction moveTo:CGPointMake(95, -140) duration:0.1];
            SKAction *shopFall = [SKAction moveTo:CGPointMake(95, -600) duration:0.2];
            SKAction *shopSequence = [SKAction sequence:@[shopWait,shopBounce,shopFall]];
            [shop runAction:shopSequence];
            SKAction *shopShadowWait = [SKAction waitForDuration:1.1];
            
            SKAction *shopShadowBounce = [SKAction moveTo:CGPointMake(85, -140) duration:0.2];
            SKAction *shopShadowFall = [SKAction moveTo:CGPointMake(85, -600) duration:0.2];
            SKAction *shopShadowSequence = [SKAction sequence:@[shopShadowWait,shopShadowBounce,shopShadowFall]];
            [shopShadow runAction:shopShadowSequence];
            
            SKAction *titleWait = [SKAction waitForDuration:1.3];
            SKAction *titleBounce = [SKAction moveTo:CGPointMake(0, 20) duration:0.1];
            SKAction *titleFall = [SKAction moveTo:CGPointMake(0, -1000) duration:0.2];
            SKAction *titleSequence = [SKAction sequence:@[titleWait,titleBounce,titleFall]];
            [title runAction:titleSequence];
            
            SKAction *tiny = [SKAction scaleTo:0.7 duration:0.2];
            SKAction *invisible = [SKAction scaleTo:0 duration:0.2];
            SKAction *seq = [SKAction sequence:@[tiny,invisible]];
            [factoryShadow runAction:seq];
            

            [self performSelector:@selector(gotoSettings) withObject:nil afterDelay:2];
            
        }
        else if ([[node name] isEqualToString:@"VaultButton"] & (self.isMoving == NO))
        {
            
            [shakeSound play];
            
            SKAction *sequence = [SKAction sequence:@[[SKAction rotateToAngle:0.27925268 duration:0.1],
                                                      [SKAction rotateToAngle:-0.27925268 duration:0.1]]];
            SKAction *repeatSequence = [SKAction repeatAction:sequence count:5];
            SKAction *normalAngle = [SKAction rotateToAngle:0 duration:0.1];
            SKAction *action = [SKAction sequence:@[repeatSequence,normalAngle]];
            [vault runAction:action];
            [vaultShadow runAction:action];
            NSLog(@"vault");
            
        }
        else if ([[node name] isEqualToString:@"ShopButton"] & (self.isMoving == NO))
        {
            self.isMoving = YES;
            [clickSound play];
            
            SKAction *factoryBounce = [SKAction moveTo:CGPointMake(0, 20) duration:0.2];
            SKAction *factoryFall = [SKAction moveTo:CGPointMake(0, -1000) duration:0.5];
            SKAction *playSound = [SKAction performSelector:@selector(startSynchronizedPlaybackFall) onTarget:self];
            SKAction *factorySequence = [SKAction sequence:@[playSound,factoryBounce,factoryFall]];
            [factory runAction:factorySequence];
            
            SKAction *bushWait = [SKAction waitForDuration:0.3];
            SKAction *bushBounce = [SKAction moveTo:CGPointMake(0, 20) duration:0.2];
            SKAction *bushFall = [SKAction moveTo:CGPointMake(0, -1000) duration:0.5];
            SKAction *bushSequence = [SKAction sequence:@[bushWait,bushBounce,bushFall]];
            [bushes runAction:bushSequence];
            
            /*SKAction *settingsWait = [SKAction waitForDuration:0.5];
            SKAction *settingsbounce = [SKAction moveTo:CGPointMake(-65, -100) duration:0.1];
            SKAction *settingsFall = [SKAction moveTo:CGPointMake(-65, -1000) duration:0.2];
            SKAction *settingsSequence = [SKAction sequence:@[settingsWait,settingsbounce, settingsFall]];
            [settings runAction:settingsSequence];
            
            SKAction *settingsShadowWait = [SKAction waitForDuration:0.5];
            SKAction *settingsShadowbounce = [SKAction moveTo:CGPointMake(-75, -100) duration:0.1];
            SKAction *settingsShadowFall = [SKAction moveTo:CGPointMake(-75, -1000) duration:0.2];
            SKAction *settingsShadowSequence = [SKAction sequence:@[settingsShadowWait,settingsShadowbounce, settingsShadowFall]];
            [settingsShadow runAction:settingsShadowSequence];*/
            
            SKAction *vaultWait = [SKAction waitForDuration:0.7];
            SKAction *vaultBounce = [SKAction moveTo:CGPointMake(80, -10) duration:0.1];
            SKAction *vaultFall = [SKAction moveTo:CGPointMake(80, -600) duration:0.2];
            SKAction *vaultSequence = [SKAction sequence:@[vaultWait,vaultBounce,vaultFall]];
            [vault runAction:vaultSequence];
            
            SKAction *playWait = [SKAction waitForDuration:0.9];
            SKAction *playBounce = [SKAction moveTo:CGPointMake(-80, 20) duration:0.1];
            SKAction *playFall = [SKAction moveTo:CGPointMake(-80, -600) duration:0.2];
            SKAction *playSequence = [SKAction sequence:@[playWait,playBounce,playFall]];
            [play runAction:playSequence];
            
            SKAction *playShadowWait = [SKAction waitForDuration:0.9];
            SKAction *playShadowBounce = [SKAction moveTo:CGPointMake(-90, 20) duration:0.2];
            SKAction *playShadowFall = [SKAction moveTo:CGPointMake(-90, -600) duration:0.2];
            SKAction *playShadowSequence = [SKAction sequence:@[playShadowWait,playShadowBounce,playShadowFall]];
            [playShadow runAction:playShadowSequence];
            
            SKAction *shopWait = [SKAction waitForDuration:1.1];
            SKAction *shopBounce = [SKAction moveTo:CGPointMake(95, -140) duration:0.1];
            SKAction *shopFall = [SKAction moveTo:CGPointMake(95, -600) duration:0.2];
            SKAction *shopSequence = [SKAction sequence:@[shopWait,shopBounce,shopFall]];
            [shop runAction:shopSequence];
            
            SKAction *shopShadowWait = [SKAction waitForDuration:1.1];
            SKAction *shopShadowBounce = [SKAction moveTo:CGPointMake(85, -140) duration:0.2];
            SKAction *shopShadowFall = [SKAction moveTo:CGPointMake(85, -600) duration:0.2];
            SKAction *shopShadowSequence = [SKAction sequence:@[shopShadowWait,shopShadowBounce,shopShadowFall]];
            [shopShadow runAction:shopShadowSequence];
            
            SKAction *titleWait = [SKAction waitForDuration:1.3];
            SKAction *titleBounce = [SKAction moveTo:CGPointMake(0, 20) duration:0.1];
            SKAction *titleFall = [SKAction moveTo:CGPointMake(0, -1000) duration:0.2];
            SKAction *titleSequence = [SKAction sequence:@[titleWait,titleBounce,titleFall]];
            [title runAction:titleSequence];
            
            SKAction *tiny = [SKAction scaleTo:0.7 duration:0.2];
            SKAction *invisible = [SKAction scaleTo:0 duration:0.2];
            SKAction *seq = [SKAction sequence:@[tiny,invisible]];
            [factoryShadow runAction:seq];
            
            [self.skView presentScene:nil];
            
            [self performSelector:@selector(goToShop) withObject:nil afterDelay:2];
            NSLog(@"Shop");
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
