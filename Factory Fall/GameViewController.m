//
//  GameViewController.m
//  Factory Fall
//
//  Created by Willie on 1/10/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"
#import "MainMenu.h"
#import "ArcadeMenu.h"
#import "UserName.h"
#import "Tutorial.h"
#import "Intro.h"
#import "Shop.h"
#import "Settings.h"
#import "AppDelegate.h"
#import "LoadingScreen.h"
#import "VictoryPrizeScreen.h"
#import "FruitOrVeggyLogic.h"
#import "RankLogic.h"
#import "ShopLogic.h"
#import <StoreKit/StoreKit.h>

#define IPHONE_4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )
#define IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IPHONE_6 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )
#define IPHONE_6_PLUS ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )

#define kAdd9kProductIdentifier @"XC.com.FluxFire.FactoryFall.9KFB"
#define kAdd30kProductIdentifier @"XC.com.FluxFire.FactoryFall.30KFB"
#define kAdd45kProductIdentifier @"XC.com.FluxFire.FactoryFall.45KFB"
#define kAdd75kProductIdentifier @"XC.com.FluxFire.FactoryFall.75KFB"
#define kAdd150kProductIdentifier @"XC.com.FluxFire.FactoryFall.150KFB"
#define kAdd300kProductIdentifier @"XC.com.FluxFire.FactoryFall.300KFB"
#define kAddClockRefillProductIdentifier @"XC.com.FluxFire.FactoryFall.ClockRefill"
#define kAddGodModePackProductIdentifier @"XC.com.FluxFire.FactoryFall.GodModePack"
#define kAddHelpProductIdentifier @"XC.com.FluxFire.FactoryFall.Help"
#define kAddInvinciblePackProductIdentifier @"XC.com.FluxFire.FactoryFall.InvinciblePack"
#define kAddRefillLivesProductIdentifier @"XC.com.FluxFire.FactoryFall.RefillLives"
#define kAddRetryFromLossProductIdentifier @"XC.com.FluxFire.FactoryFall.RetryFromLoss"
#define kAddRetryPlus10ProductIdentifier @"XC.com.FluxFire.FactoryFall.RetryPlus10"
#define kAddReviveProductIdentifier @"XC.com.FluxFire.FactoryFall.Revive"
#define kAddSafePackProductIdentifier @"XC.com.FluxFire.FactoryFall.SafePack"
#define kAddUpgradeLivesProductIdentifier @"XC.com.FluxFire.FactoryFall.UpgradeLives"

@class Settings;

@interface GameViewController()

//@property (strong, nonatomic) MainMenu *Mainscene;
@property (strong, nonatomic) ArcadeMenu *Ascene;
@property (strong, nonatomic) Tutorial *Tscence;
@property (strong, nonatomic) Intro *Iscene;
@property (strong, nonatomic) Shop *Sscene;
@property (strong, nonatomic) GameScene *Gscene;
@property (strong, nonatomic) Settings *Sescene;
@property (strong, nonatomic) LoadingScreen *Lscene;
@property (strong, nonatomic) VictoryPrizeScreen *Vscene;
//@property (nonatomic, strong)SKAudioNode *themeMus;

@property (weak) Settings *settings;
@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
        // Configure the view.

        SKView *skView = (SKView *)self.view;
        //skView.showsFPS = YES;
        //skView.showsNodeCount = YES;
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = YES;
        
        // Create and configure the scene.
        //self.Mainscene = [[MainMenu alloc]initWithSize:skView.bounds.size];
        //self.Mainscene = [MainMenu sceneWithSize:skView.bounds.size];
        //self.Mainscene.scaleMode = SKSceneScaleModeAspectFill;
        // Present the scene.
        //[skView presentScene:self.Mainscene];
    
    //[self buy9kClick];
    
    timesOpened = [[NSUserDefaults standardUserDefaults] integerForKey:@"timesOpened"];
    
    if (timesOpened == 0) {
        soundOn = YES;
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:soundOn forKey:@"soundOn"];
        [defaults synchronize];
    }
    [self musicValue];
    
    
    
    NSLog(@"Times Opened:" @"%li", (long)timesOpened);
    
    // Load Bools
    
    factoryBucks9kPurchased = NO;
    factoryBucks30kPurchased = NO;
    factoryBucks45kPurchased = NO;
    factoryBucks75kPurchased = NO;
    factoryBucks150kPurchased = NO;
    factoryBucks300kPurchased = NO;
    clockRefillPurchased = NO;
    godModePackPurchased = NO;
    helpPurchased = NO;
    invincibleModePurchased = NO;
    refillLivesPurchased = NO;
    retryFromLossPurchased = NO;
    retryPlus10Purchased = NO;
    revivePurchased = NO;
    safePackPurchased = NO;
    upgradeLivesPurchased = NO;
    justOpened = YES;
    tauntInt = 5;
    
    //_productTitle.hidden = YES;
    //_productDescription.hidden = YES;
    
}
-(void)musicValue {
    
    music = [[NSBundle mainBundle]pathForResource:@"WilliamCelebration" ofType:@"mp3"];
    audioPlayer1 = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:music]  error:NULL];
    audioPlayer1.delegate = self;
    audioPlayer1.numberOfLoops = -1;
    audioPlayer1.volume = 0.4;
    
    soundOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"soundOn"];
    
    if (soundOn == YES) {
        [audioPlayer1 play];
    }
    if (soundOn == NO) {
        [audioPlayer1 stop];
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    /*self.logoLoad.animationImages = [NSArray arrayWithObjects:
                                     [UIImage imageNamed:@"FluxFireLogoLoading"],
                                     [UIImage imageNamed:@"FluxFireLogoLoading1"],
                                     [UIImage imageNamed:@"FluxFireLogoLoading2"],
                                     [UIImage imageNamed:@"FluxFireLogoLoading3"],nil];
    [self.logoLoad setAnimationRepeatCount:1000000];
    self.logoLoad.animationDuration = 4;
    [self.logoLoad startAnimating];*/
    
    
    /*mainMenuSprites = [self textureAtlasNamed:@"MainMenuSprites"];
    arcadeSpritesOne = [self textureAtlasNamed:@"ArcadeSpritesOne"];
    arcadeSpritesTwo = [self textureAtlasNamed:@"ArcadeSpritesTwo"];
    arcadeSpritesThree = [self textureAtlasNamed:@"ArcadeSpritesThree"];
    settingsSprites = [self textureAtlasNamed:@"SettingsSprites"];
    buttonSprites = [self textureAtlasNamed:@"ButtonSprites"];
    ThroneSprites = [self textureAtlasNamed:@"ThroneSprites"];
    loadingScreenSprites = [self textureAtlasNamed:@"LoadingScreenSprites"];
    loadingScreenSprites1 = [self textureAtlasNamed:@"LoadingScreenSprites1"];
    loadingScreenSprites2 = [self textureAtlasNamed:@"LoadingScreenSpites2"];
    loadingScreenSprites3 = [self textureAtlasNamed:@"LoadingScreenSprites3"];
    loadingScreenSprites4 = [self textureAtlasNamed:@"LoadingScreenSprites4"];
    shopSprites = [self textureAtlasNamed:@"ShopSprites"];*/
    
        /*dispatch_async(dispatch_get_main_queue(), ^{
            [self.logoBackground removeFromSuperview];
            [self.logoFluxFire removeFromSuperview];
            [self.logoLoad removeFromSuperview];
            [self.logoText removeFromSuperview];
        });*/
        
        FruitOrVeggyLogic *loadData = [[FruitOrVeggyLogic alloc]init];
        [loadData loadInitialData];
        
        SKView *skView = (SKView *)self.view;
        
        MainMenu *Mainscene = [[MainMenu alloc]initWithSize:skView.bounds.size];
        
        [skView presentScene: Mainscene];
    
    
}
/*-(void)firePop {
    
    self.logoFluxFire.transform = CGAffineTransformMakeScale(0.0f, 0.0f);
}*/

- (BOOL)shouldAutorotate
{
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
    NSLog(@"CrashWarning");
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}
-(UserName *)readUserNameObjectWithKey:(NSString *)key
{
    NSData *userNameObject = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    UserName *userName = [NSKeyedUnarchiver unarchiveObjectWithData:userNameObject];
    return userName;
}
- (SKTextureAtlas *)textureAtlasNamed:(NSString *)fileName
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if( [ [ UIScreen mainScreen ] respondsToSelector: @selector( nativeBounds ) ] )
        {
            if (IPHONE_4) {
                
                fileName = [NSString stringWithFormat:@"%@", fileName];
                
            }
            if (IPHONE_5) {
                
                fileName = [NSString stringWithFormat:@"%@-568", fileName];
                
            }else if (IPHONE_6) {
                
                fileName = [NSString stringWithFormat:@"%@-667", fileName];
                
            } else if (IPHONE_6_PLUS) {
                
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

@end
