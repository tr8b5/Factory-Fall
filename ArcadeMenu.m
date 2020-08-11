//
//  ArcadeMenu.m
//  Factory Fall
//
//  Created by Willie on 1/12/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import "ArcadeMenu.h"
#import "GameScene.h"
#import "NormalLogic.h"
#import "MainMenu.h"
#import "FactoryBucksLabel.h"
#import "RankLogic.h"
#import "GameViewController.h"
#import "Timer.h"
#import "NMPointsLabel.h"
#import "Settings.h"
#import "LoadingScreen.h"
#import "AtlastData.h"
#import <StoreKit/StoreKit.h>

#define IPHONE_4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )
#define IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IPHONE_6 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )
#define IPHONE_6_PLUS ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )

#define kAddClockRefillProductIdentifier @"XC.com.FluxFire.FactoryFall.ClockRefill"

@interface ArcadeMenu () <SKProductsRequestDelegate, SKPaymentTransactionObserver>

@property (strong, nonatomic) SKNode *gameLayer;
@property (strong, nonatomic) SKNode *spriteLayer;

//@property (strong, nonatomic) GameScene *Gscene;
//@property (strong, nonatomic) NormalLogic *logic;
//@property (strong, nonatomic) MainMenu *Mainscene;
//@property (strong, nonatomic) LoadingScreen *Lscene;
/*
 -Show 5 - 60 Minute wait once player loses enough challenges in a row Countdown.
 */

@end

@implementation ArcadeMenu {
    Timer *timerTime;
    Timer *clockLabel;
    NSString *formattedTimeString;
    NSDate *startDate;
    NSTimer *timerCountdown;
}



-(id)initWithSize:(CGSize)size {
    
    if ((self = [super initWithSize:size])) {
        
        self.anchorPoint = CGPointMake(0.5, 0.5);
        
        arcadeSpritesOne = [self textureAtlasNamed:@"ArcadeSpritesOne"];
        arcadeSpritesTwo = [self textureAtlasNamed:@"ArcadeSpritesTwo"];
        arcadeSpritesThree = [self textureAtlasNamed:@"ArcadeSpritesThree"];
        mainMenuSprites = [self textureAtlasNamed:@"MainMenuSprites"];
        
        backgroundTexture = [arcadeSpritesTwo textureNamed:@"FFArcadeSpace"];
        
        background = [SKSpriteNode spriteNodeWithTexture:backgroundTexture];
        background.size = CGSizeMake(background.frame.size.width/s, background.frame.size.height / s);
        [background setName:@"ArcadeSpace"];
        [self addChild:background];
        
        self.gameLayer = [SKNode node];
        [self addChild:self.gameLayer];
        
        CGPoint layerPosition = CGPointZero;
        
        self.spriteLayer = [SKNode node];
        self.spriteLayer.position = layerPosition;
        
        [self.gameLayer addChild:self.spriteLayer];
        
        
        NSLog(@"ArcadeMenu Open");
        
        RankLogic *gameCheck = [[RankLogic alloc]init];
        [gameCheck currentGame];
        
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        
        starsTexture = [arcadeSpritesTwo textureNamed:@"FFArcadeStars"];
        stars = [SKSpriteNode spriteNodeWithTexture:starsTexture];
        stars.position = CGPointMake(0, -350);
        stars.size = CGSizeMake(stars.frame.size.width/s, stars.frame.size.height / s);
        stars.zPosition = 2;
        
        [self.spriteLayer addChild:stars];
        
        SKAction *move1 = [SKAction moveToY:950 duration:15];
        SKAction *twinkle = [SKAction fadeAlphaTo:0.3 duration:1.7];
        SKAction *twinkle1 = [SKAction fadeAlphaTo:1 duration:1.7];
        SKAction *twinkleAction = [SKAction sequence:@[twinkle, twinkle1]];
        SKAction *twinkleReAction = [SKAction repeatAction:twinkleAction count:6.25];
        SKAction *move2 = [SKAction moveToY:-530 duration:0];
        SKAction *group2 = [SKAction group:@[move1,twinkleReAction]];
        SKAction *sequence1 = [SKAction sequence:@[move2, group2]];
        SKAction *repeat = [SKAction repeatActionForever:sequence1];
        SKAction *sequence15 = [SKAction sequence:@[move1, repeat]];
        [stars runAction:sequence15];
        
        stars1 = [SKSpriteNode spriteNodeWithTexture:starsTexture];
        stars1.position = CGPointMake(0, -600);
        stars1.zPosition = 2;
        stars1.size = CGSizeMake(stars1.frame.size.width/s, stars1.frame.size.height / s);
        [self.spriteLayer addChild:stars1];
        
        SKAction *wait = [SKAction waitForDuration:1];
        SKAction *move3 = [SKAction moveToY:950 duration:20];
        SKAction *twinkle3 = [SKAction fadeAlphaTo:0.3 duration:1.7];
        SKAction *twinkle4 = [SKAction fadeAlphaTo:1 duration:1.7];
        SKAction *twinkleAction3 = [SKAction sequence:@[twinkle3, twinkle4]];
        SKAction *twinkleReAction3 = [SKAction repeatAction:twinkleAction3 count:8.33];
        SKAction *move4 = [SKAction moveToY:-530 duration:0];
        SKAction *group4 = [SKAction group:@[move3, twinkleReAction3]];
        SKAction *sequence3 = [SKAction sequence:@[move4, group4]];
        SKAction *repeat3 = [SKAction repeatActionForever:sequence3];
        SKAction *seq5 = [SKAction sequence:@[wait,repeat3]];
        [stars1 runAction:seq5];
        
        filterTexture = [mainMenuSprites textureNamed:@"Filter"];
        
        filter = [SKSpriteNode spriteNodeWithTexture:filterTexture];
        filter.position = CGPointZero;
        filter.zPosition = 20;
        filter.size = CGSizeMake(filter.frame.size.width/s, filter.frame.size.height / s);
        [self.spriteLayer addChild:filter];
        
        borderTexture = [arcadeSpritesThree textureNamed:@"FFArcadeBorder"];
        
        border = [SKSpriteNode spriteNodeWithTexture:borderTexture];
        border.position = CGPointZero;
        border.zPosition = 2.1;
        border.size = CGSizeMake(border.frame.size.width/s, border.frame.size.height / s);
        [self.spriteLayer addChild:border];
        
        RankLogic *load = [[RankLogic alloc]init];
        [load loadRankValues];
        
        showLabel = YES;
        canPlayRank0 = YES;
        canPlayRank1 = YES;
        canPlayRank2 = YES;
        canPlayRank3 = YES;
        canPlayRank4 = YES;
        canPlayRank5 = YES;
        canPlayRank6 = YES;
        canPlayRank7 = YES;
        canPlayRank8 = YES;
        canPlayRank9 = YES;
        canPlayRank10 = YES;
        canPlayRank11 = YES;
        canPlayRank12 = YES;
        canPlayRank13 = YES;
        canPlayRank14 = YES;
        canPlayRank15 = YES;
        canPlayRank16 = YES;
        canPlayRank17 = YES;
        canPlayRank18 = YES;
        canPlayRank19 = YES;
        canPlayRank20 = YES;
        canPlayRank21 = YES;
        canPlayRank22 = YES;
        canPlayRank23 = YES;
        canPlayRank24 = YES;
        canPlayRank25 = YES;
        canPlayRank26 = YES;
        canPlayRank27 = YES;
        canPlayRank28 = YES;
        canPlayRank29 = YES;
        
        NSUserDefaults *defaults0 = [NSUserDefaults standardUserDefaults];
        beatObj = [defaults0 boolForKey:@"beatObj"];
        
        NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
        rankNumber = [defaults1 integerForKey:@"rankNumber"];
        
        NSLog(@"rankNumberAM:" @"%ld", (long)rankNumber);
        
        if (beatObj == YES) {
            rankNumber++;
            beatObj = NO;
            NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
            [defaults1 setInteger:rankNumber forKey:@"rankNumber"];
            [defaults1 synchronize];
            NSLog(@"rankNumberAM:" @"%ld", (long)rankNumber);
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setBool:beatObj forKey:@"beatObj"];
            [defaults synchronize];
        }
        
        /*beatTutorial = YES; // DELETE WHEN TUTORIAL MADE
        
        if (beatTutorial == NO) {
            canPlay = NO;
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setBool:canPlay forKey:@"canPlay"];
            [defaults synchronize];
        }
        if (beatTutorial == YES & currentGameNumber == 0) {
            canTaunt = YES;
            NSUserDefaults *defaultTaunt = [NSUserDefaults standardUserDefaults];
            [defaultTaunt setBool:canTaunt forKey:@"canTaunt"];
            [defaultTaunt synchronize];
            canPlay = YES;
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setBool:canPlay forKey:@"canPlay"];
            [defaults synchronize];
        }*/
        
        RankLogic *canPlayChk = [[RankLogic alloc]init];
        [canPlayChk canPlayCheck];
        
        NMPointsLabel *timerLabel = [NMPointsLabel pointsLabelWithFontNamed:@"DimitriSwank"];
        timerLabel.name = @"timerLabel";
        timerLabel.position = CGPointMake(self.frame.size.width/2.85, self.frame.size.height/2.2);
        timerLabel.fontSize = 17;
        timerLabel.zPosition = 1002.5;
        timerLabel.colorBlendFactor = 1;
        timerLabel.fontColor = [UIColor whiteColor];
        [self addChild:timerLabel];
        timerLabel.hidden = YES;
        
        NMPointsLabel *timerLabel2 = [NMPointsLabel pointsLabelWithFontNamed:@"Dimitri"];
        timerLabel2.name = @"timerLabel2";
        timerLabel2.position = CGPointMake(self.frame.size.width/2.85, self.frame.size.height/2.2);
        timerLabel2.fontSize = 17;
        timerLabel2.zPosition = 1002.4;
        timerLabel2.colorBlendFactor = 1;
        timerLabel2.fontColor = [UIColor blackColor];
        [self addChild:timerLabel2];
        timerLabel2.hidden = YES;
        
        [self showTimerCheck];
        
        NSString *sound = [[NSBundle mainBundle]pathForResource:@"ClickSound" ofType:@"wav"];
        clickSound = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        clickSound.delegate = self;
        
        NSString *sound1 = [[NSBundle mainBundle]pathForResource:@"dink" ofType:@"wav"];
        dink = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound1]  error:NULL];
        dink.delegate = self;
        
        NSString *sound2 = [[NSBundle mainBundle]pathForResource:@"ShakeSound" ofType:@"wav"];
        shakeSound = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound2]  error:NULL];
        shakeSound.delegate = self;
        
        
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
-(void)showTimeLeft {
    NMPointsLabel *timerLabel = (NMPointsLabel *)[self childNodeWithName:@"timerLabel"];
    NMPointsLabel *timerLabel2 = (NMPointsLabel *)[self childNodeWithName:@"timerLabel2"];
    timerLabel.hidden = NO;
    [timerLabel decrementTimerText:timerLabel.number];
    [timerLabel2 decrementTimerText:timerLabel2.number];
    
    [self showTimerCheck];
    if (timerLabel.number == 0) {
        [timerCountdown invalidate];
        [timerCountdown invalidate];
        SKAction *hideClock = [SKAction moveTo:CGPointMake(0, 50) duration:0.3];
        SKAction *clockSequence = [SKAction sequence:@[hideClock,[SKAction removeFromParent]]];
        [clockScreen runAction:clockSequence];
        SKAction *move1 = [SKAction sequence:@[[SKAction moveToY:self.frame.size.height * 1.05 duration:0.8],[SKAction removeFromParent]]];
        SKAction *move2 = [SKAction sequence:@[[SKAction moveToY:self.frame.size.height * 1.05 duration:0.8],[SKAction removeFromParent]]];
        SKAction *move3 = [SKAction sequence:@[[SKAction moveToY:self.frame.size.height * 1.05 duration:0.8],[SKAction removeFromParent]]];
        [bigClock runAction:move3];
        [clockBack runAction:move1];
        [clockBuyRFL runAction:move2];
        NMPointsLabel *timerLabel = (NMPointsLabel *)[self childNodeWithName:@"timerLabel"];
        NMPointsLabel *timerLabel2 = (NMPointsLabel *)[self childNodeWithName:@"timerLabel2"];
        SKAction *moveSeq = [SKAction moveTo:CGPointMake(self.frame.size.width/2.85, self.frame.size.height * 1.05) duration:0.3];
        [timerLabel runAction:moveSeq];
        [timerLabel2 runAction:moveSeq];
        
    }
    
}
-(void)countDown {
    
    self.secondsTime = self.secondsTime - 1;
    int minutes = self.secondsTime / 60;
    int seconds = self.secondsTime - (minutes * 60);
    int hour = minutes / 60;
    
    NSString *timerView = [NSString stringWithFormat:@"%02d:%02d:%02.0d", hour, minutes, seconds];
    timerTime.text = timerView;
}

-(void)didMoveToView:(SKView *)view {
    if (justOpened == YES || canPlay == NO) {
        [self machines];
    }
    if (justOpened == NO & canPlay == YES) {
        [self machines2];
        [self objectiveBoardSprites];
    }
    if (canPlay == NO) {
        
        NMPointsLabel *timerLabel = (NMPointsLabel *)[self childNodeWithName:@"timerLabel"];
        NMPointsLabel *timerLabel2 = (NMPointsLabel *)[self childNodeWithName:@"timerLabel2"];
        
        
        clockScreenTexture = [arcadeSpritesTwo textureNamed:@"FFArcadeClock"];
        
        clockScreen = [SKSpriteNode spriteNodeWithTexture:clockScreenTexture];
        clockScreen.position = CGPointMake(0, 50);
        clockScreen.zPosition = 5.5;
        clockScreen.name = @"Clock";
        clockScreen.size = CGSizeMake(clockScreen.frame.size.width/s, clockScreen.frame.size.height / s);
        
        [self.spriteLayer addChild:clockScreen];
        
        SKAction *clockWait = [SKAction waitForDuration:1.5];
        SKAction *showClock = [SKAction moveTo:CGPointZero duration:0.3];
        SKAction *clockSequence = [SKAction sequence:@[clockWait,showClock]];
        [clockScreen runAction:clockSequence];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDate *date1 = [NSDate date];
        NSDate *date2 = [defaults objectForKey:@"expirationDate"];
        NSTimeInterval secondsBetween = [date2 timeIntervalSinceDate:date1];
        
        
        [timerLabel setTimer:secondsBetween];
        [timerLabel2 setTimer:secondsBetween];
        
        timerCountdown = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showTimeLeft) userInfo:nil repeats:YES];
        
        timerLabel.hidden = NO;
        timerLabel2.hidden = NO;
        
        
    }
    //[self showClock];
}

-(void)showClock {
    
    [bigClock removeFromParent];
    [clockBack removeFromParent];
    [clockBuyRFL removeFromParent];
    NMPointsLabel *timerLabel = (NMPointsLabel *)[self childNodeWithName:@"timerLabel"];
    NMPointsLabel *timerLabel2 = (NMPointsLabel *)[self childNodeWithName:@"timerLabel2"];
    
    bigClockTexture = [arcadeSpritesTwo textureNamed:@"FFArcadeBigClock"];
    
    bigClock = [SKSpriteNode spriteNodeWithTexture:bigClockTexture];
    bigClock.position = CGPointZero;
    bigClock.zPosition = 20000;
    bigClock.size = CGSizeMake(bigClock.frame.size.width/s, bigClock.frame.size.height / s);
    [self.spriteLayer addChild:bigClock];
    
    clockBackTexture = [buttonSprites textureNamed:@"FFArcadeBigClockBack"];
    
    clockBack = [SKSpriteNode spriteNodeWithTexture:clockBackTexture];
    clockBack.position = CGPointMake(-self.frame.size.width/4.2, self.frame.size.height/2.38);
    clockBack.zPosition = 200001;
    clockBack.name = @"ClockBack";
    clockBack.size = CGSizeMake(clockBack.frame.size.width/s, clockBack.frame.size.height / s);
    [self.spriteLayer addChild:clockBack];
    
    clockBuyRFLTexture = [buttonSprites textureNamed:@"FFArcadeBigClockBuyRFL"];
    
    clockBuyRFL = [SKSpriteNode spriteNodeWithTexture:clockBuyRFLTexture];
    clockBuyRFL.position = CGPointMake(self.frame.size.width/4.2, self.frame.size.height/2.7);
    clockBuyRFL.zPosition = 200001;
    clockBuyRFL.name = @"ClockBuy";
    clockBuyRFL.size = CGSizeMake(clockBuyRFL.frame.size.width/s, clockBuyRFL.frame.size.height / s);
    [self.spriteLayer addChild:clockBuyRFL];
    
    SKAction *hideClock = [SKAction moveTo:CGPointMake(0, self.frame.size.height * 1.08) duration:1];
    [clockScreen runAction:hideClock];
    
    SKAction *moveLabel = [SKAction moveTo:CGPointMake(self.frame.size.width/2.85, self.frame.size.height * 2.2) duration:1];
    [timerLabel runAction:moveLabel];
    [timerLabel2 runAction:moveLabel];
    
    SKAction *move1 = [SKAction sequence:@[[SKAction moveToY:self.frame.size.height * 1.05 duration:0],[SKAction moveToY:self.frame.size.height/2.38 duration:0.8]]];
    SKAction *move2 = [SKAction sequence:@[[SKAction moveToY:self.frame.size.height * 1.05 duration:0],[SKAction moveToY:self.frame.size.height/2.7 duration:0.8]]];
    SKAction *move3 = [SKAction sequence:@[[SKAction moveToY:self.frame.size.height * 1.05 duration:0],[SKAction moveToY:0 duration:0.8]]];
    [bigClock runAction:move3];
    [clockBack runAction:move1];
    [clockBuyRFL runAction:move2];
    
}
-(void)dropSound {
    
        NSString *sound = [[NSBundle mainBundle]pathForResource:@"Drop" ofType:@"wav"];
        drop = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        drop.delegate = self;
        
        NSString *sound1 = [[NSBundle mainBundle]pathForResource:@"Drop" ofType:@"wav"];
        drop1 = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound1]  error:NULL];
        drop1.delegate = self;
        
        NSString *sound2 = [[NSBundle mainBundle]pathForResource:@"Drop" ofType:@"wav"];
        drop2 = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound2]  error:NULL];
        drop2.delegate = self;
        
        NSString *sound3 = [[NSBundle mainBundle]pathForResource:@"Drop" ofType:@"wav"];
        drop3 = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound3]  error:NULL];
        drop3.delegate = self;
        
        NSString *sound4 = [[NSBundle mainBundle]pathForResource:@"Drop" ofType:@"wav"];
        drop4 = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound4]  error:NULL];
        drop4.delegate = self;
        
        NSString *sound5 = [[NSBundle mainBundle]pathForResource:@"Drop" ofType:@"wav"];
        drop5 = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound5]  error:NULL];
        drop5.delegate = self;
        
        NSString *sound6 = [[NSBundle mainBundle]pathForResource:@"Drop" ofType:@"wav"];
        drop6 = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound6]  error:NULL];
        drop6.delegate = self;
        
        
        NSTimeInterval shortStartDelay = 0.2;
        NSTimeInterval shortStartDelay1 = 0.525;
        NSTimeInterval shortStartDelay2 = 0.8;
        NSTimeInterval shortStartDelay3 = 1.1;
        NSTimeInterval shortStartDelay4 = 1.4;
        NSTimeInterval shortStartDelay5 = 1.7;
        NSTimeInterval shortStartDelay6 = 2.0; // seconds
        NSTimeInterval now = drop.deviceCurrentTime;
        NSTimeInterval now1 = drop1.deviceCurrentTime;
        NSTimeInterval now2 = drop2.deviceCurrentTime;
        NSTimeInterval now3 = drop3.deviceCurrentTime;
        NSTimeInterval now4 = drop4.deviceCurrentTime;
        NSTimeInterval now5 = drop5.deviceCurrentTime;
        NSTimeInterval now6 = drop6.deviceCurrentTime;
        
        
        [drop       playAtTime: now + shortStartDelay];
        [drop1       playAtTime: now1 + shortStartDelay1];
        [drop2       playAtTime: now2 + shortStartDelay2];
        [drop3       playAtTime: now3 + shortStartDelay3];
        [drop4       playAtTime: now4 + shortStartDelay4];
        [drop5       playAtTime: now5 + shortStartDelay5];
        [drop6       playAtTime: now6 + shortStartDelay6];
    
    
    

    
}
-(void)theBigDrop {
    
    NSString *sound = [[NSBundle mainBundle]pathForResource:@"bigdrop" ofType:@"wav"];
    bigDrop = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
    bigDrop.delegate = self;
    [bigDrop play];
    
}
-(void)titleAnim {
    
#define FFARCADETITLE_ANIM_START @[ \
[SKTexture textureWithImageNamed:@"FFArcadeArcadeTitle1"], \
[SKTexture textureWithImageNamed:@"FFArcadeArcadeTitle2"], \
[SKTexture textureWithImageNamed:@"FFArcadeArcadeTitle3"], \
[SKTexture textureWithImageNamed:@"FFArcadeArcadeTitle4"], \
[SKTexture textureWithImageNamed:@"FFArcadeArcadeTitle5"], \
[SKTexture textureWithImageNamed:@"FFArcadeArcadeTitle6"]   \
]
    SKAction *textureWait = [SKAction waitForDuration:3];
    SKAction *tAction = [SKAction animateWithTextures:FFARCADETITLE_ANIM_START timePerFrame:0.1];
    SKAction *repeattAction = [SKAction repeatActionForever:tAction];
    SKAction *tSequence = [SKAction sequence:@[textureWait, repeattAction]];
    [ffArcadeTitle runAction:tSequence];
}
-(void)machines {
    
    normalMachineTexture = [buttonSprites textureNamed:@"FFArcadeFOVMachine"];
    
    normalMachine = [SKSpriteNode spriteNodeWithTexture:normalMachineTexture];
    normalMachine.position = CGPointMake(-115, 1000);
    normalMachine.size = CGSizeMake(normalMachine.frame.size.width/(s + 0.5), normalMachine.frame.size.height / (s + 0.5));
    normalMachine.name = @"NormalMachine";
    normalMachine.zPosition = 5.1;
    [self.spriteLayer addChild:normalMachine];
    
    tilePattern1Texture = [arcadeSpritesThree textureNamed:@"FFArcadeTilePattern1"];
    
    tilePattern1 = [SKSpriteNode spriteNodeWithTexture:tilePattern1Texture];
    tilePattern1.position = CGPointZero;
    tilePattern1.size = CGSizeMake(tilePattern1.frame.size.width/s, tilePattern1.frame.size.height / s);
    tilePattern1.zPosition = 3;
    [self.spriteLayer addChild:tilePattern1];
    
    rightTimeMachineTexture = [buttonSprites textureNamed:@"FFArcadeRightTimeMachine"];
    
    rightTimeMachine = [SKSpriteNode spriteNodeWithTexture:rightTimeMachineTexture];
    rightTimeMachine.position = CGPointMake(-47, 1000);
    rightTimeMachine.size = CGSizeMake(rightTimeMachine.frame.size.width/(s + 0.3), rightTimeMachine.frame.size.height / (s + 0.3));
    rightTimeMachine.name = @"RightTime";
    rightTimeMachine.zPosition = 5;
    [self.spriteLayer addChild:rightTimeMachine];
    
    foodOnlyMachineTexture = [buttonSprites textureNamed:@"FFArcadeFoodOnlyMachine"];
    
    foodOnlyMachine = [SKSpriteNode spriteNodeWithTexture:foodOnlyMachineTexture];
    foodOnlyMachine.position = CGPointMake(115, 1000);
    foodOnlyMachine.size = CGSizeMake(foodOnlyMachine.frame.size.width/(s + 0.3), foodOnlyMachine.frame.size.height / (s + 0.19));
    foodOnlyMachine.name = @"FoodOnly";
    foodOnlyMachine.zPosition = 5.1;
    [self.spriteLayer addChild:foodOnlyMachine];
    
    basketMachineTexture = [buttonSprites textureNamed:@"FFArcadeBasketModeMachine"];
    
    basketMachine = [SKSpriteNode spriteNodeWithTexture:basketMachineTexture];
    basketMachine.position = CGPointMake(45, 1000);
    basketMachine.size = CGSizeMake(basketMachine.frame.size.width/(s + 0.3), basketMachine.frame.size.height / (s + 0.3));
    basketMachine.name = @"BasketMode";
    basketMachine.zPosition = 5;
    [self.spriteLayer addChild:basketMachine];
    
    homeMachineTexture = [buttonSprites textureNamed:@"FFArcadeBigHomeButton"];
    
    homeMachine = [SKSpriteNode spriteNodeWithTexture:homeMachineTexture];
    homeMachine.position = CGPointMake(self.frame.size.width/3.4, 1000);
    homeMachine.size = CGSizeMake(homeMachine.frame.size.width/(s + 0.5), homeMachine.frame.size.height / (s + 0.5));
    homeMachine.name = @"HomeMachine";
    homeMachine.zPosition = 6;
    [self.spriteLayer addChild:homeMachine];
    
    backMachineTexture = [buttonSprites textureNamed:@"FFArcadeBigStatsButton"];
    
    backMachine = [SKSpriteNode spriteNodeWithTexture:backMachineTexture];
    backMachine.position = CGPointMake(-self.frame.size.width/3.4, 1000);
    backMachine.size = CGSizeMake(backMachine.frame.size.width/(s + 0.5), backMachine.frame.size.height / (s + 0.5));
    backMachine.name = @"StatsMachine";
    backMachine.zPosition = 6;
    [self.spriteLayer addChild:backMachine];
    
    ffArcadeTitleTexture = [arcadeSpritesTwo textureNamed:@"FFArcadeArcadeTitle1"];
    
    ffArcadeTitle = [SKSpriteNode spriteNodeWithTexture:ffArcadeTitleTexture];
    ffArcadeTitle.position = CGPointMake(0, 1000);
    ffArcadeTitle.size = CGSizeMake(ffArcadeTitle.frame.size.width/s, ffArcadeTitle.frame.size.height / s);
    ffArcadeTitle.zPosition = 5;
    [self.spriteLayer addChild:ffArcadeTitle];
    
    [self titleAnim];
    
    SKAction *moveNormalMachine = [SKAction moveTo:CGPointMake(-self.frame.size.width/3.4, self.frame.size.height/6) duration:0.5];
    SKAction *normalMachineBounce = [SKAction moveTo:CGPointMake(-self.frame.size.width/3.4, self.frame.size.height/5.2) duration:0.2];
    SKAction *playSound = [SKAction performSelector:@selector(dropSound) onTarget:self];
    SKAction *normalMachineFall = [SKAction moveTo:CGPointMake(-self.frame.size.width/3.4, self.frame.size.height/6) duration:0.2];
    SKAction *normalMachineSequence = [SKAction sequence:@[playSound,moveNormalMachine,normalMachineBounce,normalMachineFall]];
    [normalMachine runAction:normalMachineSequence];
    
    SKAction *rightTimeMachineWait = [SKAction waitForDuration:0.3];
    SKAction *moveRightTimeMachine = [SKAction moveTo:CGPointMake(-self.frame.size.width/8.5, self.frame.size.height/4.5) duration:0.5];
    SKAction *rightTimeMachineBounce = [SKAction moveTo:CGPointMake(-self.frame.size.width/8.5, self.frame.size.height/3.7) duration:0.2];
    SKAction *rightTimelMachineFall = [SKAction moveTo:CGPointMake(-self.frame.size.width/8.5, self.frame.size.height/4.5) duration:0.2];
    SKAction *rightTimeMachineSequence = [SKAction sequence:@[rightTimeMachineWait,moveRightTimeMachine,rightTimeMachineBounce,rightTimelMachineFall]];
    [rightTimeMachine runAction:rightTimeMachineSequence];
    
    SKAction *foodOnlyMachineWait = [SKAction waitForDuration:0.5];
    SKAction *moveFoodOnlyMachine = [SKAction moveTo:CGPointMake(self.frame.size.width/3.2, self.frame.size.height/6) duration:0.5];
    SKAction *foodOnlyMachineBounce = [SKAction moveTo:CGPointMake(self.frame.size.width/3.2, self.frame.size.height/5.2) duration:0.2];
    SKAction *foodOnlyMachineFall = [SKAction moveTo:CGPointMake(self.frame.size.width/3.2, self.frame.size.height/6) duration:0.2];
    SKAction *foodOnlyMachineSequence = [SKAction sequence:@[foodOnlyMachineWait,moveFoodOnlyMachine,foodOnlyMachineBounce,foodOnlyMachineFall]];
    [foodOnlyMachine runAction:foodOnlyMachineSequence];
    
    SKAction *basketModeMachineWait = [SKAction waitForDuration:0.7];
    SKAction *moveBasketModeMachine = [SKAction moveTo:CGPointMake(self.frame.size.width/9.5, self.frame.size.height/4.5) duration:0.5];
    SKAction *basketModeMachineBounce = [SKAction moveTo:CGPointMake(self.frame.size.width/9, self.frame.size.height/3.7) duration:0.2];
    SKAction *basketModeMachineFall = [SKAction moveTo:CGPointMake(self.frame.size.width/9.5, self.frame.size.height/4.5) duration:0.2];
    SKAction *basketModeMachineSequence = [SKAction sequence:@[basketModeMachineWait,moveBasketModeMachine,basketModeMachineBounce,basketModeMachineFall]];
    [basketMachine runAction:basketModeMachineSequence];
    
    SKAction *backMachineWait = [SKAction waitForDuration:1.1];
    SKAction *moveBackMachine = [SKAction moveTo:CGPointMake(-self.frame.size.width/2.85, -self.frame.size.height/3.8) duration:0.5];
    SKAction *backMachineBounce = [SKAction moveTo:CGPointMake(-self.frame.size.width/2.85, -self.frame.size.height/3.6) duration:0.2];
    SKAction *backMachineFall = [SKAction moveTo:CGPointMake(-self.frame.size.width/2.85, -self.frame.size.height/3.8) duration:0.2];
    SKAction *backMachineSequence = [SKAction sequence:@[backMachineWait,moveBackMachine,backMachineBounce,backMachineFall]];
    [backMachine runAction:backMachineSequence];
    
    SKAction *homeMachineWait = [SKAction waitForDuration:1.3];
    SKAction *moveHomeMachine = [SKAction moveTo:CGPointMake(self.frame.size.width/2.85, -self.frame.size.height/3.8) duration:0.5];
    SKAction *homeMachineBounce = [SKAction moveTo:CGPointMake(self.frame.size.width/2.85, -self.frame.size.height/3.6) duration:0.2];
    SKAction *homeMachineFall = [SKAction moveTo:CGPointMake(self.frame.size.width/2.85, -self.frame.size.height/3.8) duration:0.2];
    SKAction *homeMachineSequence = [SKAction sequence:@[homeMachineWait,moveHomeMachine,homeMachineBounce,homeMachineFall]];
    [homeMachine runAction:homeMachineSequence];
    
    SKAction *ffArcadeTitleWait = [SKAction waitForDuration:1.3];
    SKAction *moveFFArcadeTitle = [SKAction moveTo:CGPointZero duration:0.5];
    SKAction *ffArcadeTitleBounce = [SKAction moveTo:CGPointMake(0, 20) duration:0.2];
    SKAction *ffArcadeTitleFall = [SKAction moveTo:CGPointZero duration:0.2];
    SKAction *ffArcadeTitleSequence = [SKAction sequence:@[ffArcadeTitleWait,moveFFArcadeTitle,ffArcadeTitleBounce,ffArcadeTitleFall]];
    [ffArcadeTitle runAction:ffArcadeTitleSequence];
    
    NSArray *TitleTextures = @[[SKTexture textureWithImageNamed:@"FFArcadeTilePattern1"],
                               [SKTexture textureWithImageNamed:@"FFArcadeTilePattern2"],
                               [SKTexture textureWithImageNamed:@"FFArcadeTilePattern3"],
                               [SKTexture textureWithImageNamed:@"FFArcadeTilePattern4"]];
    SKAction *textureWait = [SKAction waitForDuration:3];
    SKAction *textureAnimate = [SKAction animateWithTextures:TitleTextures timePerFrame:0.35];
    SKAction *repeatTextureAnimateForever = [SKAction repeatActionForever:textureAnimate];
    SKAction *titleSequence = [SKAction sequence:@[textureWait,repeatTextureAnimateForever]];
    [tilePattern1 runAction:titleSequence];
    
    /*SKAction *statsSequence = [SKAction sequence:@[textureWait,[SKAction repeatActionForever:[SKAction animateWithTextures:Stats_Anim_START timePerFrame:0.083333333]]]];
    [backMachine runAction:statsSequence];*/
    
}
-(void)machines2 {
    
    machineUp = YES;
    
    tilePattern1Texture = [arcadeSpritesThree textureNamed:@"FFArcadeTilePattern1"];
    
    tilePattern1 = [SKSpriteNode spriteNodeWithTexture:tilePattern1Texture];
    tilePattern1.position = CGPointZero;
    tilePattern1.size = CGSizeMake(tilePattern1.frame.size.width/s, tilePattern1.frame.size.height / s);
    tilePattern1.zPosition = 3;
    [self.spriteLayer addChild:tilePattern1];
    
    rightTimeMachineTexture = [buttonSprites textureNamed:@"FFArcadeRightTimeMachine"];
    
    rightTimeMachine = [SKSpriteNode spriteNodeWithTexture:rightTimeMachineTexture];
    rightTimeMachine.position = CGPointMake(-self.frame.size.width/5.5, self.frame.size.height/4.5);
    rightTimeMachine.size = CGSizeMake(rightTimeMachine.frame.size.width/(s + 0.5), rightTimeMachine.frame.size.height / (s + 0.5));
    rightTimeMachine.name = @"RightTime";
    rightTimeMachine.zPosition = 5;
    [self.spriteLayer addChild:rightTimeMachine];
    
    foodOnlyMachineTexture = [buttonSprites textureNamed:@"FFArcadeFoodOnlyMachine"];
    
    foodOnlyMachine = [SKSpriteNode spriteNodeWithTexture:foodOnlyMachineTexture];
    foodOnlyMachine.position = CGPointMake(self.frame.size.width/3.2, self.frame.size.height/6.7);
    foodOnlyMachine.size = CGSizeMake(foodOnlyMachine.frame.size.width/(s + 0.5), foodOnlyMachine.frame.size.height/(s + 0.5));
    foodOnlyMachine.name = @"FoodOnly";
    foodOnlyMachine.zPosition = 5.1;
    [self.spriteLayer addChild:foodOnlyMachine];
    
    basketMachineTexture = [buttonSprites textureNamed:@"FFArcadeBasketModeMachine"];
    
    basketMachine = [SKSpriteNode spriteNodeWithTexture:basketMachineTexture];
    basketMachine.position = CGPointMake(self.frame.size.width/5.5, self.frame.size.height/4.5);
    basketMachine.size = CGSizeMake(basketMachine.frame.size.width/(s + 0.5), basketMachine.frame.size.height/(s + 0.5));
    basketMachine.name = @"BasketMode";
    basketMachine.zPosition = 5;
    [self.spriteLayer addChild:basketMachine];
    
    ffArcadeTitleTexture = [arcadeSpritesTwo textureNamed:@"FFArcadeArcadeTitle1"];
    
    ffArcadeTitle = [SKSpriteNode spriteNodeWithTexture:ffArcadeTitleTexture];
    ffArcadeTitle.position = CGPointMake(0, 0);
    ffArcadeTitle.size = CGSizeMake(ffArcadeTitle.frame.size.width/s, ffArcadeTitle.frame.size.height / s);
    ffArcadeTitle.zPosition = 5;
    [self.spriteLayer addChild:ffArcadeTitle];
    
    NSArray *TitleTextures = @[[SKTexture textureWithImageNamed:@"FFArcadeTilePattern1"],
                               [SKTexture textureWithImageNamed:@"FFArcadeTilePattern2"],
                               [SKTexture textureWithImageNamed:@"FFArcadeTilePattern3"],
                               [SKTexture textureWithImageNamed:@"FFArcadeTilePattern4"]];
    SKAction *textureWait = [SKAction waitForDuration:3];
    SKAction *textureAnimate = [SKAction animateWithTextures:TitleTextures timePerFrame:0.35];
    SKAction *repeatTextureAnimateForever = [SKAction repeatActionForever:textureAnimate];
    SKAction *titleSequence = [SKAction sequence:@[textureWait,repeatTextureAnimateForever]];
    [tilePattern1 runAction:titleSequence];
    
    //SKAction *statsSequence = [SKAction sequence:@[textureWait,[SKAction repeatActionForever:[SKAction animateWithTextures:Stats_Anim_START timePerFrame:0.083333333]]]];
     //[backMachine runAction:statsSequence];
    
}
-(void)showTimerCheck {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL timer = [defaults boolForKey:@"timer"];
    NSDate *expirationCheck = [defaults objectForKey:@"expirationDate"];
    
    if (timer) {
        NSDate *todaysDate = [NSDate date];
        NSComparisonResult result = [todaysDate compare:expirationCheck];
        
        if (result == NSOrderedAscending & canPlay == NO) {
            canPlay = NO;
        }
        else if (result == NSOrderedDescending) {
            NMPointsLabel *timerLabel = (NMPointsLabel *)[self childNodeWithName:@"timerLabel"];
            NMPointsLabel *timerLabel2 = (NMPointsLabel *)[self childNodeWithName:@"timerLabel2"];
            timerLabel.hidden = YES;
            timerLabel2.hidden = YES;
        }
    }
    
}
-(void)expirationChecks {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL timer = [defaults boolForKey:@"timer"];
    NSDate *expirationCheck = [defaults objectForKey:@"expirationDate"];
    
    if (timer) {
        NSDate *todaysDate = [NSDate date];
        NSComparisonResult result = [todaysDate compare:expirationCheck];
        
        if (result == NSOrderedAscending) {
            canPlay = NO;
        }
        else if (result == NSOrderedDescending) {
            RankLogic *reset = [[RankLogic alloc]init];
            [reset resetCurrentGameNumber];
            canPlay = YES;
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setBool:canPlay forKey:@"canPlay"];
            [defaults synchronize];
            
            if (clockScreen.hidden == NO) {
                SKAction *move1 = [SKAction moveToY:-10 duration:0.2];
                SKAction *move2 = [SKAction moveToY:100 duration:0.5];
                SKAction *sequence = [SKAction sequence:@[move1,move2]];
                [clockScreen runAction:sequence];
                clockScreen.hidden = YES;
            }
            
        }
    }
    
}
-(void)getDate {
    
    NSDate *todaysDate = [NSDate date];
    NSLog(@"%@",todaysDate);
}
-(void)waitTime {

    
    NSTimeInterval expiration = 1500;
    
    
    NSDate *expirationDate = [NSDate dateWithTimeIntervalSinceNow:expiration];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:expirationDate forKey:@"expirationDate"];
    [defaults setBool:YES forKey:@"timer"];
    [defaults synchronize];
    
}
-(void)removeOBJSprites {
    
    [r1O1 removeFromParent];
    [r1O2 removeFromParent];
    [r1O3 removeFromParent];
    [r2O1 removeFromParent];
    [r2O2 removeFromParent];
    [r2O3 removeFromParent];
    [r3O1 removeFromParent];
    [r3O2 removeFromParent];
    [r3O3 removeFromParent];
    [r4O1 removeFromParent];
    [r4O2 removeFromParent];
    [r4O3 removeFromParent];
    [r5O1 removeFromParent];
    [r5O2 removeFromParent];
    [r5O3 removeFromParent];
    [r6O1 removeFromParent];
    [r6O2 removeFromParent];
    [r6O3 removeFromParent];
    [r7O1 removeFromParent];
    [r7O2 removeFromParent];
    [r7O3 removeFromParent];
    [r8O1 removeFromParent];
    [r8O2 removeFromParent];
    [r8O3 removeFromParent];
    [r9O1 removeFromParent];
    [r9O2 removeFromParent];
    [r9O3 removeFromParent];
    [r10O1 removeFromParent];
    [r10O2 removeFromParent];
    [r10O3 removeFromParent];
    [playBack removeFromParent];
    [playForward removeFromParent];
    [aMCrown removeFromParent];
    [aMBlueMarlin removeFromParent];
    [aMBlueTang removeFromParent];
    [aMBlueWhale removeFromParent];
    [aMDolphin removeFromParent];
    [aMHermitCrab removeFromParent];
    [aMKillerWhale removeFromParent];
    [aMLock removeFromParent];
    [aMOctopus removeFromParent];
    [aMSeal removeFromParent];
    [aMShark removeFromParent];
    [aMShrimp removeFromParent];
    [aMStar1a removeFromParent];
    [aMStar2a removeFromParent];
    [aMstar3a removeFromParent];
    [aMStar1b removeFromParent];
    [aMStar2b removeFromParent];
    [aMstar3b removeFromParent];
    [aMStar1c removeFromParent];
    [aMStar2c removeFromParent];
    [aMstar3c removeFromParent];
    [aMStarHolders removeFromParent];
    [bFoVMachine removeFromParent];
    [aMPlaySpinModule removeFromParent];
    [aMPlayButton removeFromParent];
    [aMBackButton removeFromParent];
    [clockScreen removeFromParent];
    [shine removeFromParent];
    [rankNumbers removeFromParent];
    
    
}
-(void)foVUpAnimation {
    
    bFoVMachineTexture = [arcadeSpritesTwo textureNamed:@"FFArcadeBigFruitOrVeggyMachine"];
    
    bFoVMachine = [SKSpriteNode spriteNodeWithTexture:bFoVMachineTexture];
    bFoVMachine.position = CGPointMake(0, 2000);
    bFoVMachine.size = CGSizeMake(bFoVMachine.frame.size.width/s, bFoVMachine.frame.size.height / s);
    bFoVMachine.zPosition = 6;
    bFoVMachine.name = @"BFoVMachine";
    [self.spriteLayer addChild:bFoVMachine];
    
    SKAction *fovDown = [SKAction moveTo:CGPointMake(-self.frame.size.width/3.4, self.frame.size.height/6.8) duration:0.1];
    SKAction *fovUp = [SKAction moveTo:CGPointMake(-self.frame.size.width/3.4, 1000) duration:0.2];
    SKAction *play = [SKAction performSelector:@selector(theBigDrop) onTarget:self];
    SKAction *fovRemove = [SKAction removeFromParent];
    SKAction *fovSequence = [SKAction sequence:@[play,fovDown,fovUp,fovRemove]];
    [normalMachine runAction:fovSequence];
    
    SKAction *wait = [SKAction waitForDuration:1];
    SKAction *move = [SKAction moveTo:CGPointMake(-self.frame.size.width/5, -self.frame.size.height/3.8) duration:0.3];
    SKAction *moveTo = [SKAction moveTo:CGPointMake(-1000, 0) duration:0.5];
    SKAction *backRemove = [SKAction removeFromParent];
    SKAction *backSequence = [SKAction sequence:@[wait,move,moveTo,backRemove]];
    [backMachine runAction:backSequence];
    
    SKAction *wait1 = [SKAction waitForDuration:1];
    SKAction *move1 = [SKAction moveTo:CGPointMake(self.frame.size.width/5, -self.frame.size.height/3.8) duration:0.3];
    SKAction *moveTo1 = [SKAction moveTo:CGPointMake(1000, 0) duration:0.5];
    SKAction *homeRemove = [SKAction removeFromParent];
    SKAction *homeSequence = [SKAction sequence:@[wait1,move1,moveTo1,homeRemove]];
    [homeMachine runAction:homeSequence];
    
    SKAction *fovWait = [SKAction waitForDuration:1];
    SKAction *bFovDrop = [SKAction moveTo:CGPointMake(0, -30) duration:0.5];
    SKAction *bFoveBounce = [SKAction moveTo:CGPointMake(0, 30) duration:0.2];
    SKAction *bFovFall = [SKAction moveTo:CGPointZero duration:0.4];
    SKAction *removebFov = [SKAction removeFromParent];
    SKAction *bFovSequence = [SKAction sequence:@[fovWait,bFovDrop,bFoveBounce,bFovFall,removebFov]];
    [bFoVMachine runAction:bFovSequence];
    
    SKAction *waitObj = [SKAction waitForDuration:2.1];
    SKAction *showOBJS = [SKAction performSelector:@selector(menuScreen) onTarget:self];
    SKAction *objSequence = [SKAction sequence:@[waitObj,showOBJS]];
    [self runAction:objSequence];
    
    
    
    
    
    
}
-(void)menuScreen {
    machineUp = YES;
    
    normalMachineShadingTexture = [arcadeSpritesTwo textureNamed:@"FFArcadeBigFruitOrVeggyMachineShading"];
    
    normalMachineShading = [SKSpriteNode spriteNodeWithTexture:normalMachineShadingTexture];
    normalMachineShading.position = CGPointZero;
    normalMachineShading.size = CGSizeMake(normalMachineShading.frame.size.width/(s + 0.5), normalMachineShading.frame.size.height / (s + 0.5));
    normalMachineShading.zPosition = 15;
    [self.spriteLayer addChild:normalMachineShading];
    
    aMBackButtonTexture = [buttonSprites textureNamed:@"FFArcadeBackButton"];
    
    aMBackButton = [SKSpriteNode spriteNodeWithTexture:aMBackButtonTexture];
    aMBackButton.position = CGPointMake(-self.frame.size.width/3, self.frame.size.height/2.5);
    aMBackButton.size = CGSizeMake(aMBackButton.frame.size.width/s, aMBackButton.frame.size.height / s);
    aMBackButton.zPosition = 7;
    aMBackButton.name = @"AMBackButton";
    [self.spriteLayer addChild:aMBackButton];
    
    bFoVMachineTexture = [arcadeSpritesTwo textureNamed:@"FFArcadeBigFruitOrVeggyMachine"];
    
    bFoVMachine = [SKSpriteNode spriteNodeWithTexture:bFoVMachineTexture];
    bFoVMachine.position = CGPointZero;
    bFoVMachine.size = CGSizeMake(bFoVMachine.frame.size.width/s, bFoVMachine.frame.size.height / s);
    bFoVMachine.zPosition = 6;
    bFoVMachine.name = @"BFoVMachine";
    [self.spriteLayer addChild:bFoVMachine];
    
    fovIconTexture = [arcadeSpritesTwo textureNamed:@"FFArcadeFOVIcon"];
    
    fovIcon = [SKSpriteNode spriteNodeWithTexture:fovIconTexture];
    fovIcon.position = CGPointZero;
    fovIcon.size = CGSizeMake(fovIcon.frame.size.width/s, fovIcon.frame.size.height / s);
    fovIcon.zPosition = 7;
    [self.spriteLayer addChild:fovIcon];
    
    endlessButtonTexture = [buttonSprites textureNamed:@"FFArcadeEndlessModeButton"];
    
    endlessButton = [SKSpriteNode spriteNodeWithTexture:endlessButtonTexture];
    endlessButton.position = CGPointMake(0, self.frame.size.height/8);
    endlessButton.size = CGSizeMake(endlessButton.frame.size.width/s, endlessButton.frame.size.height / s);
    endlessButton.zPosition = 7.1;
    endlessButton.name = @"EndlessButton";
    [self.spriteLayer addChild:endlessButton];
    
    storyButtonTexture = [buttonSprites textureNamed:@"FFArcadeStoryModeButton"];
    
    storyButton = [SKSpriteNode spriteNodeWithTexture:storyButtonTexture];
    storyButton.position = CGPointMake(0, self.frame.size.height/5.5);
    storyButton.size = CGSizeMake(storyButton.frame.size.width/s, storyButton.frame.size.height / s);
    storyButton.zPosition = 7.1;
    storyButton.name = @"StoryButton";
    [self.spriteLayer addChild:storyButton];
    
}
-(void)goToEndlessMode {
    
}
-(void)playtheDrop {
    
    NSString *sound = [[NSBundle mainBundle]pathForResource:@"thedrop" ofType:@"wav"];
    theDrop = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
    theDrop.delegate = self;
    [theDrop play];
    
}
-(void)foVDownAnimation {
    
    justOpened = YES;
    machineUp = NO;
    
    normalMachineTexture = [buttonSprites textureNamed:@"FFArcadeFOVMachine"];
    
    normalMachine = [SKSpriteNode spriteNodeWithTexture:normalMachineTexture];
    normalMachine.position = CGPointMake(-115, 1000);
    normalMachine.size = CGSizeMake(normalMachine.frame.size.width/(s + 0.5), normalMachine.frame.size.height / (s + 0.5));
    normalMachine.name = @"NormalMachine";
    normalMachine.zPosition = 5.1;
    [self.spriteLayer addChild:normalMachine];
    
    homeMachineTexture = [buttonSprites textureNamed:@"FFArcadeBigHomeButton"];
    
    homeMachine = [SKSpriteNode spriteNodeWithTexture:homeMachineTexture];
    homeMachine.position = CGPointMake(1000, 0);
    homeMachine.size = CGSizeMake(homeMachine.frame.size.width/(s + 0.5), homeMachine.frame.size.height / (s + 0.5));
    homeMachine.name = @"HomeMachine";
    homeMachine.zPosition = 6;
    [self.spriteLayer addChild:homeMachine];
    
    backMachineTexture = [buttonSprites textureNamed:@"FFArcadeBigStatsButton"];
    
    backMachine = [SKSpriteNode spriteNodeWithTexture:backMachineTexture];
    backMachine.position = CGPointMake(-1000, 0);
    backMachine.size = CGSizeMake(backMachine.frame.size.width/(s + 0.5), backMachine.frame.size.height / (s + 0.5));
    backMachine.name = @"StatsMachine";
    backMachine.zPosition = 6;
    [self.spriteLayer addChild:backMachine];

    
    SKAction *fovWait = [SKAction waitForDuration:0.55];
    SKAction *fovDown = [SKAction moveTo:CGPointMake(-self.frame.size.width/3.4, self.frame.size.height/6) duration:0.16];
    SKAction *fovUpUp = [SKAction moveTo:CGPointMake(-self.frame.size.width/3.4, self.frame.size.height/6.8) duration:0.1];
    SKAction *fovBack = [SKAction moveTo:CGPointMake(-self.frame.size.width/3.4, self.frame.size.height/6) duration:0.2];
    SKAction *fovSequence = [SKAction sequence:@[fovWait,fovDown,fovUpUp,fovBack]];
    [normalMachine runAction:fovSequence];
    
    SKAction *move = [SKAction moveTo:CGPointMake(-1000, 0) duration:0.5];
    SKAction *playSound = [SKAction performSelector:@selector(playtheDrop) onTarget:self];
    SKAction *moveToTo = [SKAction moveTo:CGPointMake(-self.frame.size.width/2.75, -self.frame.size.height/3.8) duration:0.3];
    SKAction *moveToToTo = [SKAction moveTo:CGPointMake(-self.frame.size.width/2.85, -self.frame.size.height/3.8) duration:0.2];
    SKAction *backSequence = [SKAction sequence:@[move,playSound,moveToTo,moveToToTo]];
    [backMachine runAction:backSequence];
    
    SKAction *move1 = [SKAction moveTo:CGPointMake(1000, 0) duration:0.5];
    SKAction *move2 = [SKAction moveTo:CGPointMake(self.frame.size.width/2.95, -self.frame.size.height/3.8) duration:0.3];
    SKAction *move3 = [SKAction moveTo:CGPointMake(self.frame.size.width/2.85, -self.frame.size.height/3.8) duration:0.3];
    SKAction *homeSequence = [SKAction sequence:@[move1,move2,move3]];
    [homeMachine runAction:homeSequence];
    
    [self runAction:[SKAction performSelector:@selector(removeOBJSprites) onTarget:self]];
    
    SKAction *bFovStart = [SKAction moveTo:CGPointMake(0, 500) duration:0];
    SKAction *bFovDrop = [SKAction moveTo:CGPointMake(0, -30) duration:0.5];
    SKAction *removeFov = [SKAction removeFromParent];
    SKAction *bFovSequence = [SKAction sequence:@[bFovDrop,bFovStart,removeFov]];
    [bFoVMachine runAction:bFovSequence];
    
}
-(void)loadTextures {
    aMStar1aTexture = [arcadeSpritesTwo textureNamed:@"FFArcadeBronzeWinIcon1"];
    aMStar2aTexture = [arcadeSpritesTwo textureNamed:@"FFArcadeBronzeWinIcon2"];
    aMstar3aTexture = [arcadeSpritesTwo textureNamed:@"FFArcadeBronzeWinIcon3"];
    aMStar1bTexture = [arcadeSpritesTwo textureNamed:@"FFArcadeSilverWinIcon1"];
    aMStar2bTexture = [arcadeSpritesTwo textureNamed:@"FFArcadeSilverWinIcon2"];
    aMstar3bTexture = [arcadeSpritesTwo textureNamed:@"FFArcadeSilverWinIcon3"];
    aMStar1cTexture = [arcadeSpritesTwo textureNamed:@"FFArcadeGoldWinIcon1"];
    aMStar2cTexture = [arcadeSpritesTwo textureNamed:@"FFArcadeGoldWinIcon2"];
    aMstar3cTexture = [arcadeSpritesTwo textureNamed:@"FFArcadeGoldWinIcon3"];
    aMLockTexture = [arcadeSpritesTwo textureNamed:@"FFArcadeLock"];
    r1O1Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0001"];
    r1O2Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0002"];
    r1O3Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0003"];
    r2O1Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0004"];
    r2O2Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0005"];
    r2O3Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0006"];
    r3O1Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0007"];
    r3O2Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0008"];
    r3O3Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0009"];
    r4O1Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0010"];
    r4O2Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0011"];
    r4O3Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0012"];
    r5O1Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0013"];
    r5O2Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0014"];
    r5O3Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0015"];
    r6O1Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0016"];
    r6O2Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0017"];
    r6O3Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0018"];
    r7O1Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0019"];
    r7O2Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0020"];
    r7O3Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0021"];
    r8O1Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0022"];
    r8O2Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0023"];
    r8O3Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0024"];
    r9O1Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0025"];
    r9O2Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0026"];
    r9O3Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0027"];
    r10O1Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0028"];
    r10O2Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0029"];
    r10O3Texture = [arcadeSpritesOne textureNamed:@"FFArcadeOBJ0030"];
}
-(void)objectiveBoardSprites {
    
    NMPointsLabel *objLabel = [NMPointsLabel pointsLabelWithFontNamed:@"TrebuchetMS"];
    objLabel.name = @"objLabel";
    objLabel.position = CGPointMake(96.5, 305);
    objLabel.fontSize = 15;
    objLabel.zPosition = 1002.5;
    [self addChild:objLabel];
    objLabel.hidden = YES;
    
    [self removeOBJSprites];
    
    aMBackButtonTexture = [buttonSprites textureNamed:@"FFArcadeBackButton"];
    
    aMBackButton = [SKSpriteNode spriteNodeWithTexture:aMBackButtonTexture];
    aMBackButton.position = CGPointMake(-self.frame.size.width/3, self.frame.size.height/2.5);
    aMBackButton.size = CGSizeMake(aMBackButton.frame.size.width/s, aMBackButton.frame.size.height / s);
    aMBackButton.zPosition = 7;
    aMBackButton.name = @"AMBackButton";
    [self.spriteLayer addChild:aMBackButton];
    
    aMPlayButtonTexture = [buttonSprites textureNamed:@"FFArcadePlayButton"];
    
    aMPlayButton = [SKSpriteNode spriteNodeWithTexture:aMPlayButtonTexture];
    aMPlayButton.position = CGPointMake(5, -150);
    aMPlayButton.size = CGSizeMake(aMPlayButton.frame.size.width/s, aMPlayButton.frame.size.height / s);
    aMPlayButton.zPosition = 7;
    aMPlayButton.name = @"AMPlayButton";
    [self.spriteLayer addChild:aMPlayButton];
    
    shineTexture = [arcadeSpritesTwo textureNamed:@"FFArcadeIconShading"];
    
    shine = [SKSpriteNode spriteNodeWithTexture:shineTexture];
    shine.position = CGPointZero;
    shine.size = CGSizeMake(shine.frame.size.width/s, shine.frame.size.height / s);
    shine.zPosition = 6.44;
    [self.spriteLayer addChild:shine];
    
    /*aMPlaySpinModule = [SKSpriteNode spriteNodeWithImageNamed:@"AMPlaySpinModule"];
    aMPlaySpinModule.position = CGPointMake(0, -150);
    aMPlaySpinModule.zPosition = 6.9;
    aMPlaySpinModule.name = @"AMPlaySpinModule";
    [self.spriteLayer addChild:aMPlaySpinModule];*/
    
    SKAction *scaleFrom = [SKAction scaleTo:0.1 duration:0];
    SKAction *scaleTo = [SKAction scaleTo:1.3 duration:0.2];
    SKAction *scaleToTo = [SKAction scaleTo:1.0 duration:0.1];
    SKAction *sequence = [SKAction sequence:@[scaleFrom,scaleTo,scaleToTo]];
    [aMPlayButton runAction:sequence];
    //[aMPlaySpinModule runAction:sequence];
    
    SKAction *aMPlaySpinModuleSpin = [SKAction rotateByAngle:M_PI duration:5];
    [aMPlayButton runAction:[SKAction repeatActionForever:aMPlaySpinModuleSpin]];
    
    bFoVMachineTexture = [arcadeSpritesTwo textureNamed:@"FFArcadeBigFruitOrVeggyMachine"];
    
    bFoVMachine = [SKSpriteNode spriteNodeWithTexture:bFoVMachineTexture];
    bFoVMachine.position = CGPointZero;
    bFoVMachine.size = CGSizeMake(bFoVMachine.frame.size.width/s, bFoVMachine.frame.size.height / s);
    bFoVMachine.zPosition = 6;
    bFoVMachine.name = @"BFoVMachine";
    [self.spriteLayer addChild:bFoVMachine];
    
    playBackTexture = [buttonSprites textureNamed:@"FFArcadeBack"];
    
    playBack = [SKSpriteNode spriteNodeWithTexture:playBackTexture];
    playBack.position = CGPointMake(-self.frame.size.width/4, self.frame.size.height/4.5);
    playBack.size = CGSizeMake(playBack.frame.size.width/s, playBack.frame.size.height / s);
    playBack.zPosition = 7;
    playBack.name = @"PlayBack";
    [self.spriteLayer addChild:playBack];
    
    playForwardTexture = [buttonSprites textureNamed:@"FFArcadeForward"];
    
    playForward = [SKSpriteNode spriteNodeWithTexture:playForwardTexture];
    playForward.position = CGPointMake(self.frame.size.width/4, self.frame.size.height/4.5);
    playForward.size = CGSizeMake(playForward.frame.size.width/s, playForward.frame.size.height / s);
    playForward.zPosition = 7;
    playForward.name = @"PlayForward";
    [self.spriteLayer addChild:playForward];
    
    [self loadTextures];
    
    if (rankNumber == 0) {
        
        r1O1 = [SKSpriteNode spriteNodeWithTexture:r1O1Texture];
        r1O1.position = CGPointZero;
        r1O1.size = CGSizeMake(r1O1.frame.size.width/s, r1O1.frame.size.height / s);
        r1O1.zPosition = 6.3;
        [self.spriteLayer addChild:r1O1];
     
        if (bronze101 == YES) {
            
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze102 == YES) {
            
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze103 == YES) {
            
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver101 == YES) {
            
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            aMStar1b.size = CGSizeMake(aMStar1b.frame.size.width/s, aMStar1b.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver102 == YES) {
            
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver103 == YES) {
            
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.41;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold101 == YES) {
            
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold102 == YES) {
            
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold103 == YES) {
            
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
    }
    if (rankNumber == 1) {
        
        r1O2 = [SKSpriteNode spriteNodeWithTexture:r1O2Texture];
        r1O2.position = CGPointZero;
        r1O2.size = CGSizeMake(r1O2.frame.size.width/s, r1O2.frame.size.height / s);
        r1O2.zPosition = 6.3;
        [self.spriteLayer addChild:r1O2];
        
        if (bronze101 == YES) {
            
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze102 == YES) {
            
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze103 == YES) {
            
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver101 == YES) {
            
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            aMStar1b.size = CGSizeMake(aMStar1b.frame.size.width/s, aMStar1b.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver102 == YES) {
            
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver103 == YES) {
            
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.41;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold101 == YES) {
            
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold102 == YES) {
            
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold103 == YES) {
            
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank0 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.position = CGPointZero;
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
    }
    if (rankNumber == 2) {
        
        r1O3 = [SKSpriteNode spriteNodeWithTexture:r1O3Texture];
        r1O3.position = CGPointZero;
        r1O3.size = CGSizeMake(r1O3.frame.size.width/s, r1O3.frame.size.height / s);
        r1O3.zPosition = 6.3;
        [self.spriteLayer addChild:r1O3];
        
        if (bronze101 == YES) {
            
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze102 == YES) {
            
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze103 == YES) {
            
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver101 == YES) {
            
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            aMStar1b.size = CGSizeMake(aMStar1b.frame.size.width/s, aMStar1b.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver102 == YES) {
            
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver103 == YES) {
            
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.41;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold101 == YES) {
            
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold102 == YES) {
            
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold103 == YES) {
            
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank1 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.position = CGPointZero;
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
    }
    if (rankNumber == 3) {
        
        r2O1 = [SKSpriteNode spriteNodeWithTexture:r2O1Texture];
        r2O1.position = CGPointZero;
        r2O1.size = CGSizeMake(r2O1.frame.size.width/s, r2O1.frame.size.height / s);
        r2O1.zPosition = 6.3;
        [self.spriteLayer addChild:r2O1];
 
        if (bronze201 == YES) {
            
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze202 == YES) {
            
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze203 == YES) {
            
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver201 == YES) {
            
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            aMStar1b.size = CGSizeMake(aMStar1b.frame.size.width/s, aMStar1b.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver202 == YES) {
            
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver203 == YES) {
            
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.41;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold201 == YES) {
            
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold202 == YES) {
            
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold203 == YES) {
            
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank2 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.position = CGPointZero;
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
        
    }
    if (rankNumber == 4) {
        
        r2O2 = [SKSpriteNode spriteNodeWithTexture:r2O2Texture];
        r2O2.position = CGPointZero;
        r2O2.size = CGSizeMake(r2O2.frame.size.width/s, r2O2.frame.size.height / s);
        r2O2.zPosition = 6.3;
        [self.spriteLayer addChild:r2O2];
        
        if (bronze201 == YES) {
            
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze202 == YES) {
            
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze203 == YES) {
            
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver201 == YES) {
            
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            aMStar1b.size = CGSizeMake(aMStar1b.frame.size.width/s, aMStar1b.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver202 == YES) {
            
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver203 == YES) {
            
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.41;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold201 == YES) {
            
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold202 == YES) {
            
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold203 == YES) {
            
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank3 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.position = CGPointZero;
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
        
    }
    if (rankNumber == 5) {
        
        r2O3 = [SKSpriteNode spriteNodeWithTexture:r2O3Texture];
        r2O3.position = CGPointZero;
        r2O3.size = CGSizeMake(r2O3.frame.size.width/s, r2O3.frame.size.height / s);
        r2O3.zPosition = 6.3;
        [self.spriteLayer addChild:r2O3];
        
        if (bronze201 == YES) {
            
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze202 == YES) {
            
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze203 == YES) {
            
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver201 == YES) {
            
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            aMStar1b.size = CGSizeMake(aMStar1b.frame.size.width/s, aMStar1b.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver202 == YES) {
            
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver203 == YES) {
            
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.41;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold201 == YES) {
            
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold202 == YES) {
            
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold203 == YES) {
            
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank4 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.position = CGPointZero;
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
        
    }
    if (rankNumber == 6) {
        
        r3O1 = [SKSpriteNode spriteNodeWithTexture:r3O1Texture];
        r3O1.position = CGPointZero;
        r3O1.size = CGSizeMake(r3O1.frame.size.width/s, r3O1.frame.size.height / s);
        r3O1.zPosition = 6.3;
        [self.spriteLayer addChild:r3O1];
        
        if (bronze301 == YES) {
            
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze302 == YES) {
            
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze303 == YES) {
            
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver301 == YES) {
            
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            r2O3.size = CGSizeMake(r2O3.frame.size.width/s, r2O3.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver302 == YES) {
            
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver303 == YES) {
            
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.41;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold301 == YES) {
            
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold302 == YES) {
            
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold303 == YES) {
            
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank5 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.position = CGPointZero;
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
        
    }
    if (rankNumber == 7) {
        
        r3O2 = [SKSpriteNode spriteNodeWithTexture:r3O2Texture];
        r3O2.position = CGPointZero;
        r3O2.size = CGSizeMake(r3O2.frame.size.width/s, r3O2.frame.size.height / s);
        r3O2.zPosition = 6.3;
        [self.spriteLayer addChild:r3O2];
        
        if (bronze301 == YES) {
            
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze302 == YES) {
            
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze303 == YES) {
            
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver301 == YES) {
            
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            r2O3.size = CGSizeMake(r2O3.frame.size.width/s, r2O3.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver302 == YES) {
            
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver303 == YES) {
            
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.41;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold301 == YES) {
            
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold302 == YES) {
            
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold303 == YES) {
            
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank6 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.position = CGPointZero;
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
        
    }
    if (rankNumber == 8) {
        
        r3O3 = [SKSpriteNode spriteNodeWithTexture:r3O3Texture];
        r3O3.position = CGPointZero;
        r3O3.size = CGSizeMake(r3O3.frame.size.width/s, r3O3.frame.size.height / s);
        r3O3.zPosition = 6.3;
        [self.spriteLayer addChild:r3O3];
        
        if (bronze301 == YES) {
            
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze302 == YES) {
            
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze303 == YES) {
            
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver301 == YES) {
            
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            r2O3.size = CGSizeMake(r2O3.frame.size.width/s, r2O3.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver302 == YES) {
            
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver303 == YES) {
            
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.41;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold301 == YES) {
            
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold302 == YES) {
            
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold303 == YES) {
            
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank7 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.position = CGPointZero;
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
        
    }
    if (rankNumber == 9) {

        r4O1 = [SKSpriteNode spriteNodeWithTexture:r4O1Texture];
        r4O1.position = CGPointZero;
        r4O1.size = CGSizeMake(r4O1.frame.size.width/s, r4O1.frame.size.height / s);
        r4O1.zPosition = 6.3;
        [self.spriteLayer addChild:r4O1];
        
        if (bronze401 == YES) {
            
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze402 == YES) {
            
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze403 == YES) {
            
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver401 == YES) {
            
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            aMStar1b.size = CGSizeMake(aMStar1b.frame.size.width/s, aMStar1b.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver402 == YES) {
            
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver403 == YES) {
            
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.41;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold401 == YES) {
            
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold402 == YES) {
            
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold403 == YES) {
            
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank8 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.position = CGPointZero;
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
        
    }
    if (rankNumber == 10) {
        
        r4O2 = [SKSpriteNode spriteNodeWithTexture:r4O2Texture];
        r4O2.position = CGPointZero;
        r4O2.size = CGSizeMake(r4O2.frame.size.width/s, r4O2.frame.size.height / s);
        r4O2.zPosition = 6.3;
        [self.spriteLayer addChild:r4O2];
        
        if (bronze401 == YES) {
            
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze402 == YES) {
            
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze403 == YES) {
            
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver401 == YES) {
            
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            aMStar1b.size = CGSizeMake(aMStar1b.frame.size.width/s, aMStar1b.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver402 == YES) {
            
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver403 == YES) {
            
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.41;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold401 == YES) {
            
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold402 == YES) {
            
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold403 == YES) {
            
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank9 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.position = CGPointZero;
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
        
    }
    if (rankNumber == 11) {
        r4O3 = [SKSpriteNode spriteNodeWithTexture:r4O3Texture];
        r4O3.position = CGPointZero;
        r4O3.size = CGSizeMake(r4O3.frame.size.width/s, r4O3.frame.size.height / s);
        r4O3.zPosition = 6.3;
        [self.spriteLayer addChild:r4O3];
        
        if (bronze401 == YES) {
            
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze402 == YES) {
            
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze403 == YES) {
            
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver401 == YES) {
            
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            aMStar1b.size = CGSizeMake(aMStar1b.frame.size.width/s, aMStar1b.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver402 == YES) {
            
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver403 == YES) {
            
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.41;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold401 == YES) {
            
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold402 == YES) {
            
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold403 == YES) {
            
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank10 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.position = CGPointZero;
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
        
    }
    if (rankNumber == 12) {
        r5O1 = [SKSpriteNode spriteNodeWithTexture:r5O1Texture];
        r5O1.position = CGPointZero;
        r5O1.size = CGSizeMake(r5O1.frame.size.width/s, r5O1.frame.size.height / s);
        r5O1.zPosition = 6.3;
        [self.spriteLayer addChild:r5O1];
        
        if (bronze501 == YES) {
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze502 == YES) {
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze503 == YES) {
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver501 == YES) {
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            aMStar1b.size = CGSizeMake(aMStar1b.frame.size.width/s, aMStar1b.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver502 == YES) {
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver503 == YES) {
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.41;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold501 == YES) {
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold502 == YES) {
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold503 == YES) {
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank11 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.position = CGPointZero;
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
        
    }
    if (rankNumber == 13) {
        r5O2 = [SKSpriteNode spriteNodeWithTexture:r5O2Texture];
        r5O2.position = CGPointZero;
        r5O2.size = CGSizeMake(r5O2.frame.size.width/s, r5O2.frame.size.height / s);
        r5O2.zPosition = 6.3;
        [self.spriteLayer addChild:r5O2];
        
        if (bronze501 == YES) {
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze502 == YES) {
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze503 == YES) {
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver501 == YES) {
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            aMStar1b.size = CGSizeMake(aMStar1b.frame.size.width/s, aMStar1b.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver502 == YES) {
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver503 == YES) {
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.41;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold501 == YES) {
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold502 == YES) {
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold503 == YES) {
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank12 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.position = CGPointZero;
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
        
    }
    if (rankNumber == 14) {
        r5O3 = [SKSpriteNode spriteNodeWithTexture:r5O3Texture];
        r5O3.position = CGPointZero;
        r5O3.size = CGSizeMake(r5O3.frame.size.width/s, r5O3.frame.size.height / s);
        r5O3.zPosition = 6.3;
        [self.spriteLayer addChild:r5O3];
        
        if (bronze501 == YES) {
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze502 == YES) {
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze503 == YES) {
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver501 == YES) {
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            aMStar1b.size = CGSizeMake(aMStar1b.frame.size.width/s, aMStar1b.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver502 == YES) {
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver503 == YES) {
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.41;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold501 == YES) {
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold502 == YES) {
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold503 == YES) {
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank13 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.position = CGPointZero;
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
        
    }
    if (rankNumber == 15) {
        r6O1 = [SKSpriteNode spriteNodeWithTexture:r6O1Texture];
        r6O1.position = CGPointZero;
        r6O1.size = CGSizeMake(r6O1.frame.size.width/s, r6O1.frame.size.height / s);
        r6O1.zPosition = 6.3;
        [self.spriteLayer addChild:r6O1];

        if (bronze601 == YES) {
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze602 == YES) {
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze603 == YES) {
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver601 == YES) {
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            aMStar1b.size = CGSizeMake(aMStar1b.frame.size.width/s, aMStar1b.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver602 == YES) {
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver603 == YES) {
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.41;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold601 == YES) {
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold602 == YES) {
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold603 == YES) {
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank14 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.position = CGPointZero;
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
        
    }
    if (rankNumber == 16) {
        r6O2 = [SKSpriteNode spriteNodeWithTexture:r6O2Texture];
        r6O2.position = CGPointZero;
        r6O2.size = CGSizeMake(r6O2.frame.size.width/s, r6O2.frame.size.height / s);
        r6O2.zPosition = 6.3;
        [self.spriteLayer addChild:r6O2];
        
        if (bronze601 == YES) {
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze602 == YES) {
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze603 == YES) {
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver601 == YES) {
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            aMStar1b.size = CGSizeMake(aMStar1b.frame.size.width/s, aMStar1b.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver602 == YES) {
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver603 == YES) {
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.41;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold601 == YES) {
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold602 == YES) {
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold603 == YES) {
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank15 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.position = CGPointZero;
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
        
    }
    if (rankNumber == 17) {
        r6O3 = [SKSpriteNode spriteNodeWithTexture:r6O3Texture];
        r6O3.position = CGPointZero;
        r6O3.size = CGSizeMake(r6O3.frame.size.width/s, r6O3.frame.size.height / s);
        r6O3.zPosition = 6.3;
        [self.spriteLayer addChild:r6O3];
        
        if (bronze601 == YES) {
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze602 == YES) {
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze603 == YES) {
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver601 == YES) {
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            aMStar1b.size = CGSizeMake(aMStar1b.frame.size.width/s, aMStar1b.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver602 == YES) {
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver603 == YES) {
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.41;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold601 == YES) {
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold602 == YES) {
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold603 == YES) {
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank16 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.position = CGPointZero;
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
        
    }
    if (rankNumber == 18) {
        r7O1 = [SKSpriteNode spriteNodeWithTexture:r7O1Texture];
        r7O1.position = CGPointZero;
        r7O1.size = CGSizeMake(r7O1.frame.size.width/s, r7O1.frame.size.height / s);
        r7O1.zPosition = 6.3;
        [self.spriteLayer addChild:r7O1];
        
        if (bronze701 == YES) {
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze702 == YES) {
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze703 == YES) {
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver701 == YES) {
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            aMStar1b.size = CGSizeMake(aMStar1b.frame.size.width/s, aMStar1b.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver702 == YES) {
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver703 == YES) {
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.41;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold701 == YES) {
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold702 == YES) {
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold703 == YES) {
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank17 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.position = CGPointZero;
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
        
    }
    if (rankNumber == 19) {
        r7O2 = [SKSpriteNode spriteNodeWithTexture:r7O2Texture];
        r7O2.position = CGPointZero;
        r7O2.size = CGSizeMake(r7O2.frame.size.width/s, r7O2.frame.size.height / s);
        r7O2.zPosition = 6.3;
        [self.spriteLayer addChild:r7O2];
        
        if (bronze701 == YES) {
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze702 == YES) {
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze703 == YES) {
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver701 == YES) {
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            aMStar1b.size = CGSizeMake(aMStar1b.frame.size.width/s, aMStar1b.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver702 == YES) {
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver703 == YES) {
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.41;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold701 == YES) {
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold702 == YES) {
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold703 == YES) {
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank18 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.position = CGPointZero;
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
        
    }
    if (rankNumber == 20) {
        r7O3 = [SKSpriteNode spriteNodeWithTexture:r7O3Texture];
        r7O3.position = CGPointZero;
        r7O3.size = CGSizeMake(r7O3.frame.size.width/s, r7O3.frame.size.height / s);
        r7O3.zPosition = 6.3;
        [self.spriteLayer addChild:r7O3];
        
        if (bronze701 == YES) {
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze702 == YES) {
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze703 == YES) {
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver701 == YES) {
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            aMStar1b.size = CGSizeMake(aMStar1b.frame.size.width/s, aMStar1b.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver702 == YES) {
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver703 == YES) {
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.41;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold701 == YES) {
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold702 == YES) {
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold703 == YES) {
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank19 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.position = CGPointZero;
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
        
    }
    if (rankNumber == 21) {
        r8O1 = [SKSpriteNode spriteNodeWithTexture:r8O1Texture];
        r8O1.position = CGPointZero;
        r8O1.size = CGSizeMake(r8O1.frame.size.width/s, r8O1.frame.size.height / s);
        r8O1.zPosition = 6.3;
        [self.spriteLayer addChild:r8O1];
        
        if (bronze801 == YES) {
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze802 == YES) {
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze803 == YES) {
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver801 == YES) {
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            aMStar1b.size = CGSizeMake(aMStar1b.frame.size.width/s, aMStar1b.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver802 == YES) {
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver803 == YES) {
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold801 == YES) {
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold802 == YES) {
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold803 == YES) {
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank20 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.position = CGPointZero;
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
        
    }
    if (rankNumber == 22) {
        r8O2 = [SKSpriteNode spriteNodeWithTexture:r8O2Texture];
        r8O2.position = CGPointZero;
        r8O2.size = CGSizeMake(r8O2.frame.size.width/s, r8O2.frame.size.height / s);
        r8O2.zPosition = 6.3;
        [self.spriteLayer addChild:r8O2];
        
        if (bronze801 == YES) {
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze802 == YES) {
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze803 == YES) {
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver801 == YES) {
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            aMStar1b.size = CGSizeMake(aMStar1b.frame.size.width/s, aMStar1b.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver802 == YES) {
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver803 == YES) {
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold801 == YES) {
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold802 == YES) {
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold803 == YES) {
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank21 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.position = CGPointZero;
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
        
    }
    if (rankNumber == 23) {
        r8O3 = [SKSpriteNode spriteNodeWithTexture:r8O3Texture];
        r8O3.position = CGPointZero;
        r8O3.size = CGSizeMake(r8O3.frame.size.width/s, r8O3.frame.size.height / s);
        r8O3.zPosition = 6.3;
        [self.spriteLayer addChild:r8O3];
        
        if (bronze801 == YES) {
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze802 == YES) {
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze803 == YES) {
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver801 == YES) {
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            aMStar1b.size = CGSizeMake(aMStar1b.frame.size.width/s, aMStar1b.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver802 == YES) {
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver803 == YES) {
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold801 == YES) {
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold802 == YES) {
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold803 == YES) {
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank22 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.position = CGPointZero;
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
        
    }
    if (rankNumber == 24) {
        r9O1 = [SKSpriteNode spriteNodeWithTexture:r9O1Texture];
        r9O1.position = CGPointZero;
        r9O1.size = CGSizeMake(r9O1.frame.size.width/s, r9O1.frame.size.height / s);
        r9O1.zPosition = 6.3;
        [self.spriteLayer addChild:r9O1];
        
        if (bronze901 == YES) {
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze902 == YES) {
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze903 == YES) {
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver901 == YES) {
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            aMStar1b.size = CGSizeMake(aMStar1b.frame.size.width/s, aMStar1b.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver902 == YES) {
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver903 == YES) {
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.41;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold901 == YES) {
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold902 == YES) {
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold903 == YES) {
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank23 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.position = CGPointZero;
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
        
    }
    if (rankNumber == 25) {
        r9O2 = [SKSpriteNode spriteNodeWithTexture:r9O2Texture];
        r9O2.position = CGPointZero;
        r9O2.size = CGSizeMake(r9O2.frame.size.width/s, r9O2.frame.size.height / s);
        r9O2.zPosition = 6.3;
        [self.spriteLayer addChild:r9O2];
        
        if (bronze901 == YES) {
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze902 == YES) {
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze903 == YES) {
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver901 == YES) {
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            aMStar1b.size = CGSizeMake(aMStar1b.frame.size.width/s, aMStar1b.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver902 == YES) {
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver903 == YES) {
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.41;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold901 == YES) {
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold902 == YES) {
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold903 == YES) {
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank24 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.position = CGPointZero;
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
        
    }
    if (rankNumber == 26) {
        r9O3 = [SKSpriteNode spriteNodeWithTexture:r9O3Texture];
        r9O3.position = CGPointZero;
        r9O3.size = CGSizeMake(r9O3.frame.size.width/s, r9O3.frame.size.height / s);
        r9O3.zPosition = 6.3;
        [self.spriteLayer addChild:r9O3];
        
        if (bronze901 == YES) {
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze902 == YES) {
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze903 == YES) {
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver901 == YES) {
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            aMStar1b.size = CGSizeMake(aMStar1b.frame.size.width/s, aMStar1b.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver902 == YES) {
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver903 == YES) {
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.41;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold901 == YES) {
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold902 == YES) {
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold903 == YES) {
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank25 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.position = CGPointZero;
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
        
    }
    if (rankNumber == 27) {
        r10O1 = [SKSpriteNode spriteNodeWithTexture:r10O1Texture];
        r10O1.position = CGPointZero;
        r10O1.size = CGSizeMake(r10O1.frame.size.width/s, r10O1.frame.size.height / s);
        r10O1.zPosition = 6.3;
        [self.spriteLayer addChild:r10O1];
        
        if (bronze1001 == YES) {
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze1002 == YES) {
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze1003 == YES) {
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver1001 == YES) {
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            aMStar1b.size = CGSizeMake(aMStar1b.frame.size.width/s, aMStar1b.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver1002 == YES) {
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver1003 == YES) {
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.41;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold1001 == YES) {
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold1002 == YES) {
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold1003 == YES) {
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank26 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.position = CGPointZero;
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
        
    }
    if (rankNumber == 28) {
        r10O2 = [SKSpriteNode spriteNodeWithTexture:r10O2Texture];
        r10O2.position = CGPointZero;
        r10O2.size = CGSizeMake(r10O2.frame.size.width/s, r10O2.frame.size.height / s);
        r10O2.zPosition = 6.3;
        [self.spriteLayer addChild:r10O2];
        
        if (bronze1001 == YES) {
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze1002 == YES) {
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze1003 == YES) {
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver1001 == YES) {
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            aMStar1b.size = CGSizeMake(aMStar1b.frame.size.width/s, aMStar1b.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver1002 == YES) {
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver1003 == YES) {
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.41;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold1001 == YES) {
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold1002 == YES) {
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold1003 == YES) {
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank27 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.position = CGPointZero;
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
        
    }
    if (rankNumber == 29) {
        r10O3 = [SKSpriteNode spriteNodeWithTexture:r10O3Texture];
        r10O3.position = CGPointZero;
        r10O3.size = CGSizeMake(r10O3.frame.size.width/s, r10O3.frame.size.height / s);
        r10O3.zPosition = 6.3;
        [self.spriteLayer addChild:r10O3];
        
        if (bronze1001 == YES) {
            aMStar1a = [SKSpriteNode spriteNodeWithTexture:aMStar1aTexture];
            aMStar1a.position = CGPointZero;
            aMStar1a.size = CGSizeMake(aMStar1a.frame.size.width/s, aMStar1a.frame.size.height / s);
            aMStar1a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar1a];
        }
        if (bronze1002 == YES) {
            aMStar2a = [SKSpriteNode spriteNodeWithTexture:aMStar2aTexture];
            aMStar2a.position = CGPointZero;
            aMStar2a.size = CGSizeMake(aMStar2a.frame.size.width/s, aMStar2a.frame.size.height / s);
            aMStar2a.zPosition = 6.4;
            [self.spriteLayer addChild:aMStar2a];
        }
        if (bronze1003 == YES) {
            aMstar3a = [SKSpriteNode spriteNodeWithTexture:aMstar3aTexture];
            aMstar3a.position = CGPointZero;
            aMstar3a.size = CGSizeMake(aMstar3a.frame.size.width/s, aMstar3a.frame.size.height / s);
            aMstar3a.zPosition = 6.4;
            [self.spriteLayer addChild:aMstar3a];
        }
        if (silver1001 == YES) {
            aMStar1b = [SKSpriteNode spriteNodeWithTexture:aMStar1bTexture];
            aMStar1b.position = CGPointZero;
            aMStar1b.size = CGSizeMake(aMStar1b.frame.size.width/s, aMStar1b.frame.size.height / s);
            aMStar1b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar1b];
        }
        if (silver1002 == YES) {
            aMStar2b = [SKSpriteNode spriteNodeWithTexture:aMStar2bTexture];
            aMStar2b.position = CGPointZero;
            aMStar2b.size = CGSizeMake(aMStar2b.frame.size.width/s, aMStar2b.frame.size.height / s);
            aMStar2b.zPosition = 6.41;
            [self.spriteLayer addChild:aMStar2b];
        }
        if (silver1003 == YES) {
            aMstar3b = [SKSpriteNode spriteNodeWithTexture:aMstar3bTexture];
            aMstar3b.position = CGPointZero;
            aMstar3b.size = CGSizeMake(aMstar3b.frame.size.width/s, aMstar3b.frame.size.height / s);
            aMstar3b.zPosition = 6.41;
            [self.spriteLayer addChild:aMstar3b];
        }
        if (gold1001 == YES) {
            aMStar1c = [SKSpriteNode spriteNodeWithTexture:aMStar1cTexture];
            aMStar1c.position = CGPointZero;
            aMStar1c.size = CGSizeMake(aMStar1c.frame.size.width/s, aMStar1c.frame.size.height / s);
            aMStar1c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar1c];
        }
        if (gold1002 == YES) {
            aMStar2c = [SKSpriteNode spriteNodeWithTexture:aMStar2cTexture];
            aMStar2c.position = CGPointZero;
            aMStar2c.size = CGSizeMake(aMStar2c.frame.size.width/s, aMStar2c.frame.size.height / s);
            aMStar2c.zPosition = 6.42;
            [self.spriteLayer addChild:aMStar2c];
        }
        if (gold1003 == YES) {
            aMstar3c = [SKSpriteNode spriteNodeWithTexture:aMstar3cTexture];
            aMstar3c.position = CGPointZero;
            aMstar3c.size = CGSizeMake(aMstar3c.frame.size.width/s, aMstar3c.frame.size.height / s);
            aMstar3c.zPosition = 6.42;
            [self.spriteLayer addChild:aMstar3c];
        }
        if (canPlayRank28 == NO) {
            [aMPlayButton removeFromParent];
            [aMPlayButton removeAllActions];
            aMLock = [SKSpriteNode spriteNodeWithTexture:aMLockTexture];
            aMLock.position = CGPointZero;
            aMLock.size = CGSizeMake(aMLock.frame.size.width/s, aMLock.frame.size.height / s);
            aMLock.zPosition = 6.5;
            [self.spriteLayer addChild:aMLock];
        }
        
    }
    
}
- (void)buyRefillClock{
    NSLog(@"User requests 10 Lives");
    
    if([SKPaymentQueue canMakePayments]){
        NSLog(@"User can make payments");
        clockRefillPurchased = YES;
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kAddClockRefillProductIdentifier]];
        productsRequest.delegate = self;
        [productsRequest start];
        
    }
    else{
        NSLog(@"User cannot make payments");
        
    }
}
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    SKProduct *validProduct = nil;
    NSUInteger count = [response.products count];
    if (count > 0){
        validProduct = [response.products objectAtIndex:0];
        NSLog(@"Products Available!");
        [self purchase:validProduct];
    }
    else if(!validProduct){
        NSLog(@"No products available");
        //this is called if your product id is not valid, this shouldn't be called unless that happens.
    }
}
- (void)purchase:(SKProduct *)product
{
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    for(SKPaymentTransaction *transaction in transactions){
        switch(transaction.transactionState){
            case SKPaymentTransactionStatePurchasing: NSLog(@"Transaction state -> Purchasing");
                //called when the user is in the process of purchasing, do not add any of your own code here.
                break;
            case SKPaymentTransactionStatePurchased:
                //this is called when the user has successfully purchased the package (Cha-Ching!)
                if (clockRefillPurchased == YES) {
                    [self performSelector:@selector(clockRefill) withObject:self afterDelay:0.5];
                    clockRefillPurchased = NO;
                }
                //you can add your code for what you want to happen when the user buys the purchase here, for this tutorial we use removing ads
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                NSLog(@"Transaction state -> Purchased");
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"Transaction state -> Restored");
                //add the same code as you did from SKPaymentTransactionStatePurchased here
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                //called when the transaction does not finish
                if(transaction.error.code == SKErrorPaymentCancelled){
                    NSLog(@"Transaction state -> Cancelled");
                    clockRefillPurchased = NO;
                    NSLog(@"%@", transaction.error);
                    //the user cancelled the payment ;(
                }
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            default:
                break;
        }
    }
}
-(void)clockRefill {
    
    canPlay = YES;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:canPlay forKey:@"canPlay"];
    [defaults synchronize];
    
    RankLogic *upgradMXLLVL = [[RankLogic alloc]init];
    [upgradMXLLVL incrementMaxPlays];
    
    SKAction *hideClock = [SKAction moveTo:CGPointMake(0, 50) duration:0.3];
    SKAction *clockSequence = [SKAction sequence:@[hideClock,[SKAction removeFromParent]]];
    [clockScreen runAction:clockSequence];
    
    SKAction *move1 = [SKAction sequence:@[[SKAction moveToY:self.frame.size.height * 1.05 duration:0.8],[SKAction removeFromParent]]];
    SKAction *move2 = [SKAction sequence:@[[SKAction moveToY:self.frame.size.height * 1.05 duration:0.8],[SKAction removeFromParent]]];
    SKAction *move3 = [SKAction sequence:@[[SKAction moveToY:self.frame.size.height * 1.05 duration:0.8],[SKAction removeFromParent]]];
    [bigClock runAction:move3];
    [clockBack runAction:move1];
    [clockBuyRFL runAction:move2];
    
    NMPointsLabel *timerLabel = (NMPointsLabel *)[self childNodeWithName:@"timerLabel"];
    NMPointsLabel *timerLabel2 = (NMPointsLabel *)[self childNodeWithName:@"timerLabel2"];
    SKAction *moveSeq = [SKAction moveTo:CGPointMake(self.frame.size.width/2.85, self.frame.size.height * 1.05) duration:0.3];
    [timerLabel runAction:moveSeq];
    [timerLabel2 runAction:moveSeq];
    
    NSTimeInterval expiration = 0;
    
    
    NSDate *expirationDate = [NSDate dateWithTimeIntervalSinceNow:expiration];
    
    NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
    [defaults1 setObject:expirationDate forKey:@"expirationDate"];
    [defaults1 setBool:YES forKey:@"timer"];
    [defaults1 synchronize];
    
}
-(void)goToLoadingScreen {
    
    self.skView = (SKView *)self.view;
    [self.skView presentScene:nil];
    arcadeSpritesOne = nil;
    arcadeSpritesTwo = nil;
    arcadeSpritesThree = nil;
    // Create and configure the scene.
    LoadingScreen *Lscene = [LoadingScreen sceneWithSize:self.skView.bounds.size];
    self.scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [self.skView presentScene:Lscene];
    
}
-(void)goToNormalMode {
    
    self.skView = (SKView *)self.view;
    [self.skView presentScene:nil];
    arcadeSpritesOne = nil;
    arcadeSpritesTwo = nil;
    arcadeSpritesThree = nil;
    // Create and configure the scene.
    GameScene *Gscene = [GameScene sceneWithSize:self.skView.bounds.size];
    Gscene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Load the level.
    //NormalLogic *logic = [[NormalLogic alloc] init];
    //Gscene.logic = logic;
    
    // Present the scene.
    [self.skView presentScene:Gscene];
    
    
}


-(void)goToMainMenu {
    
    self.skView = (SKView *)self.view;
    [self.skView presentScene:nil];
    arcadeSpritesOne = nil;
    arcadeSpritesTwo = nil;
    arcadeSpritesThree = nil;
    // Create and configure the scene.
    MainMenu *Mainscene = [MainMenu sceneWithSize:self.skView.bounds.size];
    self.scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [self.skView presentScene:Mainscene];
    
}
-(void)rankIncrement {
    
    RankLogic *rankUp = [[RankLogic alloc]init];
    [rankUp incrementby1];
    
}
-(void)rankDecrement {
    
    RankLogic *rankDown = [[RankLogic alloc]init];
    [rankDown decrementby1];
    
}
-(void)handleNodesAtLocation:(CGPoint)location
{
    NSArray* nodes = [[self spriteLayer] nodesAtPoint:location];
    for(SKNode * node in nodes)
    {
        if ([[node name] isEqualToString:@"NormalMachine"] & (canPlay == YES))
        {
                [clickSound play];
                [self foVUpAnimation];
                NSLog(@"rank:" @"%li", (long)rankNumber);
           // arcadeSpritesOne = [self textureAtlasNamed:@"ArcadeSpritesOne"];
            
        }
        if ([[node name] isEqualToString:@"NormalMachine"] & (canPlay == NO))
        {
            machineUp = YES;
            [self expirationChecks];
            if (canPlay == YES) {
                [self foVUpAnimation];
                NSLog(@"rank:" @"%li", (long)rankNumber);
            }
            
            [shakeSound play];
            
            SKAction *sequence = [SKAction sequence:@[[SKAction rotateToAngle:0.27925268 duration:0.1],
                                                      [SKAction rotateToAngle:-0.27925268 duration:0.1]]];
            SKAction *repeatSequence = [SKAction repeatAction:sequence count:5];
            SKAction *normalAngle = [SKAction rotateToAngle:0 duration:0.1];
            SKAction *action = [SKAction sequence:@[repeatSequence,normalAngle]];
            [normalMachine runAction:action];
            
            [self showClock];
            
        }
        else if ([[node name] isEqualToString:@"HomeMachine"])
        {
            [self goToMainMenu];
            NSLog(@"Home");
        }
        else if ([[node name] isEqualToString:@"ClockBack"])
        {
            [clickSound play];
            SKAction *move1 = [SKAction sequence:@[[SKAction moveToY:self.frame.size.height * 1.05 duration:0.8],[SKAction removeFromParent]]];
            SKAction *move2 = [SKAction sequence:@[[SKAction moveToY:self.frame.size.height * 1.05 duration:0.8],[SKAction removeFromParent]]];
            SKAction *move3 = [SKAction sequence:@[[SKAction moveToY:self.frame.size.height * 1.05 duration:0.8],[SKAction removeFromParent]]];
            [bigClock runAction:move3];
            [clockBack runAction:move1];
            [clockBuyRFL runAction:move2];
            
            SKAction *clockWait = [SKAction waitForDuration:0.4];
            SKAction *showClock = [SKAction moveTo:CGPointZero duration:0.3];
            SKAction *clockSequence = [SKAction sequence:@[clockWait,showClock]];
            [clockScreen runAction:clockSequence];
            
            NMPointsLabel *timerLabel = (NMPointsLabel *)[self childNodeWithName:@"timerLabel"];
            NMPointsLabel *timerLabel2 = (NMPointsLabel *)[self childNodeWithName:@"timerLabel2"];
            
            SKAction *moveSeq = [SKAction sequence:@[[SKAction waitForDuration:0.4],[SKAction moveTo:CGPointMake(self.frame.size.width/2.85, self.frame.size.height/2.2) duration:0.3]]];
            
            [timerLabel runAction:moveSeq];
            [timerLabel2 runAction:moveSeq];
            
        }
        else if ([[node name] isEqualToString:@"ClockBuy"])
        {
            [dink play];
            [self buyRefillClock];
            
        }
        else if ([[node name] isEqualToString:@"StoryButton"])
        {

            [endlessButton removeFromParent];
            [storyButton removeFromParent];
            [fovIcon removeFromParent];
            
            [dink play];
            
            SKAction *waitObj = [SKAction waitForDuration:0.2];
            SKAction *showOBJS = [SKAction performSelector:@selector(objectiveBoardSprites) onTarget:self];
            SKAction *objSequence = [SKAction sequence:@[waitObj,showOBJS]];
            [self runAction:objSequence];
            
        }
        else if ([[node name] isEqualToString:@"PlayForward"])
        {
            if (rankNumber < 29) {
                
                [dink play];
                
                [self rankIncrement];
                [self objectiveBoardSprites];
            }
        }
        else if ([[node name] isEqualToString:@"PlayBack"])
        {
            if (rankNumber > 0) {
                
                [dink play];
                
                [self rankDecrement];
                [self objectiveBoardSprites];
            }
        }
        else if ([[node name] isEqualToString:@"AMPlayButton"])
        {
           
                [dink play];
            
                [self.skView presentScene:nil];
            if (rankNumber < 27) {
                [self goToLoadingScreen];
            } else {
                [self goToNormalMode];
            }
            
            
        }
        else if ([[node name] isEqualToString:@"AMBackButton"])
        {
            [clickSound play];
            [self foVDownAnimation];
            [endlessButton removeFromParent];
            [storyButton removeFromParent];
            [normalMachineShading removeFromParent];
            [fovIcon removeFromParent];
            arcadeSpritesOne = nil;
        }
        else if ([[node name] isEqualToString:@"StatsMachine"])
        {
            
            [clickSound play];
        }
        if ([[node name] isEqualToString:@"RightTime"] && machineUp == NO)
        {
            
            [shakeSound play];
            
            SKAction *sequence = [SKAction sequence:@[[SKAction rotateToAngle:0.27925268 duration:0.1],
                                                      [SKAction rotateToAngle:-0.27925268 duration:0.1]]];
            SKAction *repeatSequence = [SKAction repeatAction:sequence count:5];
            SKAction *normalAngle = [SKAction rotateToAngle:0 duration:0.1];
            SKAction *action = [SKAction sequence:@[repeatSequence,normalAngle]];
            [rightTimeMachine runAction:action];
            
        }
        if ([[node name] isEqualToString:@"BasketMode"] && machineUp == NO)
        {
            
            [shakeSound play];
            
            SKAction *sequence = [SKAction sequence:@[[SKAction rotateToAngle:0.27925268 duration:0.1],
                                                      [SKAction rotateToAngle:-0.27925268 duration:0.1]]];
            SKAction *repeatSequence = [SKAction repeatAction:sequence count:5];
            SKAction *normalAngle = [SKAction rotateToAngle:0 duration:0.1];
            SKAction *action = [SKAction sequence:@[repeatSequence,normalAngle]];
            [basketMachine runAction:action];
            
        }
        if ([[node name] isEqualToString:@"FoodOnly"] && machineUp == NO)
        {
            
            [shakeSound play];
            
            SKAction *sequence = [SKAction sequence:@[[SKAction rotateToAngle:0.27925268 duration:0.1],
                                                      [SKAction rotateToAngle:-0.27925268 duration:0.1]]];
            SKAction *repeatSequence = [SKAction repeatAction:sequence count:5];
            SKAction *normalAngle = [SKAction rotateToAngle:0 duration:0.1];
            SKAction *action = [SKAction sequence:@[repeatSequence,normalAngle]];
            [foodOnlyMachine runAction:action];
            
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
