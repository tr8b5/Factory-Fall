//
//  Shop.m
//  Factory Fall
//
//  Created by Willie on 2/22/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import "Shop.h"
#import "GameScene.h"
#import "MainMenu.h"
#import "ShopLogic.h"
#import "FactoryBucksLabel.h"
#import "FBLabelLogic.h"
#import "PowerUpAmountsLabel.h"
#import "Data.h"
#import "GameViewController.h"
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

@interface Shop () <SKProductsRequestDelegate, SKPaymentTransactionObserver>

@property (strong, nonatomic) SKNode *gameLayer;
@property (strong, nonatomic) SKNode *spriteLayer;

//@property (strong, nonatomic) GameScene *Gscene;
//@property (strong, nonatomic) MainMenu *Mainscene;
//@property (strong, nonatomic) ShopLogic *shopLogic;
//@property (strong, nonatomic) FactoryBucksLabel *FBLogic;
//@property (strong, nonatomic) FBLabelLogic *FBLLogic;
//@property (strong, nonatomic) GameViewController *Gview;

@end

@implementation Shop

-(id)initWithSize:(CGSize)size {
    
    if ((self = [super initWithSize:size])) {
        
        self.anchorPoint = CGPointMake(0.5, 0.5);
        
        shopSprites = [self textureAtlasNamed:@"ShopSprites"];
        
        backgroundTexture = [shopSprites textureNamed:@"ShopBackground"];
        
        background = [SKSpriteNode spriteNodeWithTexture:backgroundTexture];
        background.size = CGSizeMake(background.frame.size.width/s, background.frame.size.height / s);
        [background setName:@"ShopBackGround"];
        [self addChild:background];
        
        self.gameLayer = [SKNode node];
        [self addChild:self.gameLayer];
        
        CGPoint layerPosition = CGPointZero;
        
        self.spriteLayer = [SKNode node];
        self.spriteLayer.position = layerPosition;
        
        [self.gameLayer addChild:self.spriteLayer];
        
        filterTexture = [shopSprites textureNamed:@"Filter2"];
        
        filter = [SKSpriteNode spriteNodeWithTexture:filterTexture];
        filter.position = CGPointZero;
        filter.size = CGSizeMake(filter.frame.size.width/s, filter.frame.size.height / s);
        filter.zPosition = 20;
        [self.spriteLayer addChild:filter];
        
        [self menuSprites];
        
        [self labels];
        
        NSString *sound = [[NSBundle mainBundle]pathForResource:@"ClickSound" ofType:@"wav"];
        clickSound = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:sound]  error:NULL];
        clickSound.delegate = self;
        
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

-(void)labels {
    ShopLogic *loadDP = [[ShopLogic alloc]init];
    [loadDP loadDPInteger];
    
    PowerUpAmountsLabel *powerUpsLabel = [PowerUpAmountsLabel powerUpsLabelWithFontNamed:@"DimitriSwank"];
    powerUpsLabel.name = @"powerUpsLabel";
    powerUpsLabel.position = CGPointMake(-self.frame.size.width/19, -self.frame.size.height/2.415);
    powerUpsLabel.zPosition = 6.1;
    powerUpsLabel.fontSize = 30;
    powerUpsLabel.fontColor = [UIColor blackColor];
    powerUpsLabel.colorBlendFactor = 1;
    [powerUpsLabel setPoints:DPInteger];
    [self addChild:powerUpsLabel];
    
    powerUpsLabel.hidden = YES;
    
    PowerUpAmountsLabel *powerUpsLabel2 = [PowerUpAmountsLabel powerUpsLabelWithFontNamed:@"Dimitri"];
    powerUpsLabel2.name = @"powerUpsLabel2";
    powerUpsLabel2.position = CGPointMake(-self.frame.size.width/19, -self.frame.size.height/2.415);
    powerUpsLabel2.zPosition = 6;
    powerUpsLabel2.fontSize = 30;
    [powerUpsLabel2 setPoints:DPInteger];
    [self addChild:powerUpsLabel2];
    
    powerUpsLabel2.hidden = YES;
    
    ShopLogic *loadTP = [[ShopLogic alloc]init];
    [loadTP loadTPInteger];
    
    PowerUpAmountsLabel *tpLabel = [PowerUpAmountsLabel powerUpsLabelWithFontNamed:@"DimitriSwank"];
    tpLabel.name = @"tpLabel";
    tpLabel.position = CGPointMake(-self.frame.size.width/19, -self.frame.size.height/5.6);
    tpLabel.zPosition = 6.1;
    tpLabel.fontSize = 30;
    tpLabel.fontColor = [UIColor blackColor];
    tpLabel.colorBlendFactor = 1;
    [tpLabel setPoints:TPInteger];
    [self addChild:tpLabel];
    
    tpLabel.hidden = YES;
    
    PowerUpAmountsLabel *tpLabel2 = [PowerUpAmountsLabel powerUpsLabelWithFontNamed:@"Dimitri"];
    tpLabel2.name = @"tpLabel2";
    tpLabel2.position = CGPointMake(-self.frame.size.width/19, -self.frame.size.height/5.6);
    tpLabel2.zPosition = 6;
    tpLabel2.fontSize = 30;
    [tpLabel2 setPoints:TPInteger];
    [self addChild:tpLabel2];
    
    tpLabel2.hidden = YES;
    
    ShopLogic *loadQP = [[ShopLogic alloc]init];
    [loadQP loadQPInteger];
    
    PowerUpAmountsLabel *qpLabel = [PowerUpAmountsLabel powerUpsLabelWithFontNamed:@"DimitriSwank"];
    qpLabel.name = @"qpLabel";
    qpLabel.position = CGPointMake(-self.frame.size.width/19, self.frame.size.height/17);
    qpLabel.zPosition = 6.1;
    qpLabel.fontSize = 30;
    qpLabel.fontColor = [UIColor blackColor];
    qpLabel.colorBlendFactor = 1;
    [qpLabel setPoints:QPInteger];
    [self addChild:qpLabel];
    
    qpLabel.hidden = YES;
    
    PowerUpAmountsLabel *qpLabel2 = [PowerUpAmountsLabel powerUpsLabelWithFontNamed:@"Dimitri"];
    qpLabel2.name = @"qpLabel2";
    qpLabel2.position = CGPointMake(-self.frame.size.width/19, self.frame.size.height/17);
    qpLabel2.zPosition = 6;
    qpLabel2.fontSize = 30;
    [qpLabel2 setPoints:QPInteger];
    [self addChild:qpLabel2];
    
    qpLabel2.hidden = YES;
    
    ShopLogic *loadEL1 = [[ShopLogic alloc]init];
    [loadEL1 loadEL1Integer];
    
    PowerUpAmountsLabel *el1Label = [PowerUpAmountsLabel powerUpsLabelWithFontNamed:@"DimitriSwank"];
    el1Label.name = @"el1Label";
    el1Label.position = CGPointMake(-self.frame.size.width/19, -self.frame.size.height/2.415);
    el1Label.zPosition = 6.1;
    el1Label.fontSize = 30;
    el1Label.fontColor = [UIColor blackColor];
    el1Label.colorBlendFactor = 1;
    [el1Label setPoints:EL1Integer];
    [self addChild:el1Label];
    
    el1Label.hidden = YES;
    
    PowerUpAmountsLabel *el1Label2 = [PowerUpAmountsLabel powerUpsLabelWithFontNamed:@"Dimitri"];
    el1Label2.name = @"el1Label2";
    el1Label2.position = CGPointMake(-self.frame.size.width/19, -self.frame.size.height/2.415);
    el1Label2.zPosition = 6;
    el1Label2.fontSize = 30;
    [el1Label2 setPoints:EL1Integer];
    [self addChild:el1Label2];
    
    el1Label2.hidden = YES;
    
    ShopLogic *loadEL2 = [[ShopLogic alloc]init];
    [loadEL2 loadEL2Integer];
    
    PowerUpAmountsLabel *el2Label = [PowerUpAmountsLabel powerUpsLabelWithFontNamed:@"DimitriSwank"];
    el2Label.name = @"el2Label";
    el2Label.position = CGPointMake(-self.frame.size.width/19, -self.frame.size.height/5.6);
    el2Label.zPosition = 6.1;
    el2Label.fontSize = 30;
    el2Label.fontColor = [UIColor blackColor];
    el2Label.colorBlendFactor = 1;
    [el2Label setPoints:EL2Integer];
    [self addChild:el2Label];
    
    el2Label.hidden = YES;
    
    PowerUpAmountsLabel *el2Label2 = [PowerUpAmountsLabel powerUpsLabelWithFontNamed:@"Dimitri"];
    el2Label2.name = @"el2Label2";
    el2Label2.position = CGPointMake(-self.frame.size.width/19, -self.frame.size.height/5.6);
    el2Label2.zPosition = 6;
    el2Label2.fontSize = 30;
    [el2Label2 setPoints:EL2Integer];
    [self addChild:el2Label2];
    
    el2Label2.hidden = YES;
    
    ShopLogic *loadEL3 = [[ShopLogic alloc]init];
    [loadEL3 loadEL3Integer];
    
    PowerUpAmountsLabel *el3Label = [PowerUpAmountsLabel powerUpsLabelWithFontNamed:@"DimitriSwank"];
    el3Label.name = @"el3Label";
    el3Label.position = CGPointMake(-self.frame.size.width/19, self.frame.size.height/17);
    el3Label.zPosition = 6.1;
    el3Label.fontSize = 30;
    el3Label.fontColor = [UIColor blackColor];
    el3Label.colorBlendFactor = 1;
    [el3Label setPoints:EL3Integer];
    [self addChild:el3Label];
    
    el3Label.hidden = YES;
    
    PowerUpAmountsLabel *el3Label2 = [PowerUpAmountsLabel powerUpsLabelWithFontNamed:@"Dimitri"];
    el3Label2.name = @"el3Label2";
    el3Label2.position = CGPointMake(-self.frame.size.width/19, self.frame.size.height/17);
    el3Label2.zPosition = 6;
    el3Label2.fontSize = 30;
    [el3Label2 setPoints:EL3Integer];
    [self addChild:el3Label2];
    
    el3Label2.hidden = YES;
    
    ShopLogic *loadHG10 = [[ShopLogic alloc]init];
    [loadHG10 loadHG10Integer];
    
    PowerUpAmountsLabel *hg10Label = [PowerUpAmountsLabel powerUpsLabelWithFontNamed:@"DimitriSwank"];
    hg10Label.name = @"hg10Label";
    hg10Label.position = CGPointMake(-self.frame.size.width/19, -self.frame.size.height/2.415);
    hg10Label.zPosition = 6.1;
    hg10Label.fontSize = 30;
    hg10Label.fontColor = [UIColor blackColor];
    hg10Label.colorBlendFactor = 1;
    [hg10Label setPoints:HG10Integer];
    [self addChild:hg10Label];
    
    hg10Label.hidden = YES;
    
    PowerUpAmountsLabel *hg10Label2 = [PowerUpAmountsLabel powerUpsLabelWithFontNamed:@"Dimitri"];
    hg10Label2.name = @"hg10Label2";
    hg10Label2.position = CGPointMake(-self.frame.size.width/19, -self.frame.size.height/2.415);
    hg10Label2.zPosition = 6;
    hg10Label2.fontSize = 30;
    [hg10Label2 setPoints:HG10Integer];
    [self addChild:hg10Label2];
    
    hg10Label2.hidden = YES;
    
    ShopLogic *loadHG20 = [[ShopLogic alloc]init];
    [loadHG20 loadHG20Integer];
    
    PowerUpAmountsLabel *hg20Label = [PowerUpAmountsLabel powerUpsLabelWithFontNamed:@"DimitriSwank"];
    hg20Label.name = @"hg20Label";
    hg20Label.position = CGPointMake(-self.frame.size.width/19, -self.frame.size.height/5.6);
    hg20Label.zPosition = 6.1;
    hg20Label.fontSize = 30;
    hg20Label.fontColor = [UIColor blackColor];
    hg20Label.colorBlendFactor = 1;
    [hg20Label setPoints:HG20Integer];
    [self addChild:hg20Label];
    
    hg20Label.hidden = YES;
    
    PowerUpAmountsLabel *hg20Label2 = [PowerUpAmountsLabel powerUpsLabelWithFontNamed:@"Dimitri"];
    hg20Label2.name = @"hg20Label2";
    hg20Label2.position = CGPointMake(-self.frame.size.width/19, -self.frame.size.height/5.6);
    hg20Label2.zPosition = 6;
    hg20Label2.fontSize = 30;
    [hg20Label2 setPoints:HG20Integer];
    [self addChild:hg20Label2];
    
    hg20Label2.hidden = YES;
    
    ShopLogic *loadHG30 = [[ShopLogic alloc]init];
    [loadHG30 loadHG30Integer];
    
    PowerUpAmountsLabel *hg30Label = [PowerUpAmountsLabel powerUpsLabelWithFontNamed:@"DimitriSwank"];
    hg30Label.name = @"hg30Label";
    hg30Label.position = CGPointMake(-self.frame.size.width/19, self.frame.size.height/17);
    hg30Label.zPosition = 6.1;
    hg30Label.fontSize = 30;
    hg30Label.fontColor = [UIColor blackColor];
    hg30Label.colorBlendFactor = 1;
    [hg30Label setPoints:HG30Integer];
    [self addChild:hg30Label];
    
    hg30Label.hidden = YES;
    
    PowerUpAmountsLabel *hg30Label2 = [PowerUpAmountsLabel powerUpsLabelWithFontNamed:@"Dimitri"];
    hg30Label2.name = @"hg30Label2";
    hg30Label2.position = CGPointMake(-self.frame.size.width/19, self.frame.size.height/17);
    hg30Label2.zPosition = 6;
    hg30Label2.fontSize = 30;
    [hg30Label2 setPoints:HG30Integer];
    [self addChild:hg30Label2];
    
    hg30Label2.hidden = YES;
    
    ShopLogic *loadHS10 = [[ShopLogic alloc]init];
    [loadHS10 loadHS10Integer];
    
    PowerUpAmountsLabel *hs10Label = [PowerUpAmountsLabel powerUpsLabelWithFontNamed:@"DimitriSwank"];
    hs10Label.name = @"hs10Label";
    hs10Label.position = CGPointMake(-self.frame.size.width/19, -self.frame.size.height/2.415);
    hs10Label.zPosition = 6.1;
    hs10Label.fontSize = 30;
    hs10Label.fontColor = [UIColor blackColor];
    hs10Label.colorBlendFactor = 1;
    [hs10Label setPoints:HS10Integer];
    [self addChild:hs10Label];
    
    hs10Label.hidden = YES;
    
    PowerUpAmountsLabel *hs10Label2 = [PowerUpAmountsLabel powerUpsLabelWithFontNamed:@"Dimitri"];
    hs10Label2.name = @"hs10Label2";
    hs10Label2.position = CGPointMake(-self.frame.size.width/19, -self.frame.size.height/2.415);
    hs10Label2.zPosition = 6;
    hs10Label2.fontSize = 30;
    [hs10Label2 setPoints:HS10Integer];
    [self addChild:hs10Label2];
    
    hs10Label2.hidden = YES;
    
    ShopLogic *loadHS20 = [[ShopLogic alloc]init];
    [loadHS20 loadHS20Integer];
    
    PowerUpAmountsLabel *hs20Label = [PowerUpAmountsLabel powerUpsLabelWithFontNamed:@"DimitriSwank"];
    hs20Label.name = @"hs20Label";
    hs20Label.position = CGPointMake(-self.frame.size.width/19, -self.frame.size.height/5.6);
    hs20Label.zPosition = 6.1;
    hs20Label.fontSize = 30;
    hs20Label.fontColor = [UIColor blackColor];
    hs20Label.colorBlendFactor = 1;
    [hs20Label setPoints:HS20Integer];
    [self addChild:hs20Label];
    
    hs20Label.hidden = YES;
    
    PowerUpAmountsLabel *hs20Label2 = [PowerUpAmountsLabel powerUpsLabelWithFontNamed:@"Dimitri"];
    hs20Label2.name = @"hs20Label2";
    hs20Label2.position = CGPointMake(-self.frame.size.width/19, -self.frame.size.height/5.6);
    hs20Label2.zPosition = 6;
    hs20Label2.fontSize = 30;
    [hs20Label2 setPoints:HS20Integer];
    [self addChild:hs20Label2];
    
    hs20Label2.hidden = YES;
    
    ShopLogic *loadHS30 = [[ShopLogic alloc]init];
    [loadHS30 loadHS30Integer];
    
    PowerUpAmountsLabel *hs30Label = [PowerUpAmountsLabel powerUpsLabelWithFontNamed:@"DimitriSwank"];
    hs30Label.name = @"hs30Label";
    hs30Label.position = CGPointMake(-self.frame.size.width/19, self.frame.size.height/17);
    hs30Label.zPosition = 6.1;
    hs30Label.fontSize = 30;
    hs30Label.fontColor = [UIColor blackColor];
    hs30Label.colorBlendFactor = 1;
    [hs30Label setPoints:HS30Integer];
    [self addChild:hs30Label];
    
    hs30Label.hidden = YES;
    
    PowerUpAmountsLabel *hs30Label2 = [PowerUpAmountsLabel powerUpsLabelWithFontNamed:@"Dimitri"];
    hs30Label2.name = @"hs30Label2";
    hs30Label2.position = CGPointMake(-self.frame.size.width/19, self.frame.size.height/17);
    hs30Label2.zPosition = 6;
    hs30Label2.fontSize = 30;
    [hs30Label2 setPoints:HS30Integer];
    [self addChild:hs30Label2];
    
    hs30Label2.hidden = YES;
    
    
    
}
-(void)menuSprites  {
    
    homeTexture = [buttonSprites textureNamed:@"ShopHomeButton"];
    
    home = [SKSpriteNode spriteNodeWithTexture:homeTexture];
    home.position = CGPointMake(-self.frame.size.width/2.7, -self.frame.size.height/2.4);
    home.size = CGSizeMake(home.frame.size.width/s, home.frame.size.height /s);
    home.zPosition = 3;
    home.name = @"HomeButton";
    [self.spriteLayer addChild:home];
    
    sidePMTexture = [buttonSprites textureNamed:@"ShopPMButton"];
    
    sidePM = [SKSpriteNode spriteNodeWithTexture:sidePMTexture];
    sidePM.position = CGPointMake(-self.frame.size.width/2.7, self.frame.size.height/4.4);
    sidePM.size = CGSizeMake(sidePM.frame.size.width/s, sidePM.frame.size.height / s);
    sidePM.zPosition = 3;
    sidePM.name = @"PointsMultiplier";
    [self.spriteLayer addChild:sidePM];
    
    sideSRTexture = [buttonSprites textureNamed:@"ShopSRButton"];
    
    sideSR = [SKSpriteNode spriteNodeWithTexture:sideSRTexture];
    sideSR.position = CGPointMake(-self.frame.size.width/2.7, self.frame.size.height/9);
    sideSR.size = CGSizeMake(sideSR.frame.size.width/s, sideSR.frame.size.height / s);
    sideSR.zPosition = 3;
    sideSR.name = @"SpeedReducer";
    [self.spriteLayer addChild:sideSR];
    
    sideELTexture = [buttonSprites textureNamed:@"ShopELButton"];
    
    sideEL = [SKSpriteNode spriteNodeWithTexture:sideELTexture];
    sideEL.position = CGPointMake(-self.frame.size.width/2.7, -5);
    sideEL.size = CGSizeMake(sideEL.frame.size.width/s, sideEL.frame.size.height / s);
    sideEL.zPosition = 3;
    sideEL.name = @"ExtraLives";
    [self.spriteLayer addChild:sideEL];
    
    sideHSTexture = [buttonSprites textureNamed:@"ShopHSButton"];
    
    sideHS = [SKSpriteNode spriteNodeWithTexture:sideHSTexture];
    sideHS.position = CGPointMake(-self.frame.size.width/2.7, -self.frame.size.height/8);
    sideHS.size = CGSizeMake(sideHS.frame.size.width/s, sideHS.frame.size.height / s);
    sideHS.zPosition = 3;
    sideHS.name = @"HeadStart";
    [self.spriteLayer addChild:sideHS];
    
    sideCSTexture = [buttonSprites textureNamed:@"ShopCSButton"];
    
    sideCS = [SKSpriteNode spriteNodeWithTexture:sideCSTexture];
    sideCS.position = CGPointMake(-self.frame.size.width/2.7, -self.frame.size.height/4);
    sideCS.size = CGSizeMake(sideCS.frame.size.width/s, sideCS.frame.size.height / s);
    sideCS.zPosition = 3;
    sideCS.name = @"PackageDeals";
    [self.spriteLayer addChild:sideCS];
    
    sideFBTexture = [buttonSprites textureNamed:@"ShopFBButton"];
    
    sideFB = [SKSpriteNode spriteNodeWithTexture:sideFBTexture];
    sideFB.position = CGPointMake(-self.frame.size.width/2.7, self.frame.size.height/2.9);
    sideFB.size = CGSizeMake(sideFB.frame.size.width/s, sideFB.frame.size.height / s);
    sideFB.zPosition = 3;
    sideFB.name = @"FactoryBucksButton";
    [self.spriteLayer addChild:sideFB];
    
    shopBoardTexture = [shopSprites textureNamed:@"ShopBoard"];
    
    shopBoard = [SKSpriteNode spriteNodeWithTexture:shopBoardTexture];
    shopBoard.position = CGPointMake(300, 0);
    shopBoard.size = CGSizeMake(shopBoard.frame.size.width/s, shopBoard.frame.size.height / s);
    shopBoard.zPosition = 2;
    [self.spriteLayer addChild:shopBoard];
    
    shopMoneyBoardTexture = [shopSprites textureNamed:@"ShopMoneyBoard"];
    
    shopMoneyBoard = [SKSpriteNode spriteNodeWithTexture:shopMoneyBoardTexture];
    shopMoneyBoard.position = CGPointMake(300, 0);
    shopMoneyBoard.size = CGSizeMake(shopMoneyBoard.frame.size.width/s, shopMoneyBoard.frame.size.height / s);
    shopMoneyBoard.zPosition = 4;
    [self.spriteLayer addChild:shopMoneyBoard];
    
    buy300KButtonTexture = [buttonSprites textureNamed:@"ShopBuyButton"];
    
    buy300KButton = [SKSpriteNode spriteNodeWithTexture:buy300KButtonTexture];
    buy300KButton.position = CGPointMake(self.frame.size.width/10, self.frame.size.height/8);
    buy300KButton.size = CGSizeMake(buy300KButton.frame.size.width/s, buy300KButton.frame.size.height / s);
    buy300KButton.zPosition = 5;
    buy300KButton.name = @"Buy300K";
    [self.spriteLayer addChild:buy300KButton];
    
    buy150KButtonTexture = [buttonSprites textureNamed:@"ShopBuyButton"];
    
    buy150KButton = [SKSpriteNode spriteNodeWithTexture:buy150KButtonTexture];
    buy150KButton.position = CGPointMake(self.frame.size.width/10, 0);
    buy150KButton.size = CGSizeMake(buy150KButton.frame.size.width/s, buy150KButton.frame.size.height / s);
    buy150KButton.zPosition = 5;
    buy150KButton.name = @"Buy150K";
    [self.spriteLayer addChild:buy150KButton];
    
    buy75KButtonTexture = [buttonSprites textureNamed:@"ShopBuyButton"];
    
    buy75KButton = [SKSpriteNode spriteNodeWithTexture:buy75KButtonTexture];
    buy75KButton.position = CGPointMake(self.frame.size.width/10, -self.frame.size.height/8.5);
    buy75KButton.size = CGSizeMake(buy75KButton.frame.size.width/s, buy75KButton.frame.size.height / s);
    buy75KButton.zPosition = 5;
    buy75KButton.name = @"Buy75K";
    [self.spriteLayer addChild:buy75KButton];
    
    buy45KButtonTexture = [buttonSprites textureNamed:@"ShopBuyButton"];
    
    buy45KButton = [SKSpriteNode spriteNodeWithTexture:buy45KButtonTexture];
    buy45KButton.position = CGPointMake(self.frame.size.width/10, -self.frame.size.height/4.4);
    buy45KButton.size = CGSizeMake(buy45KButton.frame.size.width/s, buy45KButton.frame.size.height / s);
    buy45KButton.zPosition = 5;
    buy45KButton.name = @"Buy45K";
    [self.spriteLayer addChild:buy45KButton];
    
    buy30KButtonTexture = [buttonSprites textureNamed:@"ShopBuyButton"];
    
    buy30KButton = [SKSpriteNode spriteNodeWithTexture:buy30KButtonTexture];
    buy30KButton.position = CGPointMake(self.frame.size.width/10, -self.frame.size.height/3.1);
    buy30KButton.size = CGSizeMake(buy30KButton.frame.size.width/s, buy30KButton.frame.size.height / s);
    buy30KButton.zPosition = 5;
    buy30KButton.name = @"Buy30K";
    [self.spriteLayer addChild:buy30KButton];
    
    buy9KButtonTexture = [buttonSprites textureNamed:@"ShopBuyButton"];
    
    buy9KButton = [SKSpriteNode spriteNodeWithTexture:buy9KButtonTexture];
    buy9KButton.position = CGPointMake(self.frame.size.width/10, -self.frame.size.height/2.35);
    buy9KButton.size = CGSizeMake(buy9KButton.frame.size.width/s, buy9KButton.frame.size.height / s);
    buy9KButton.zPosition = 5;
    buy9KButton.name = @"Buy9K";
    [self.spriteLayer addChild:buy9KButton];
    
    robotHeadTexture = [shopSprites textureNamed:@"ShopRobotHead"];
    
    robotHead = [SKSpriteNode spriteNodeWithTexture:robotHeadTexture];
    robotHead.position = CGPointMake(300, 0);
    robotHead.size = CGSizeMake(robotHead.frame.size.width/s, robotHead.frame.size.height / s);
    robotHead.zPosition = 4.5;
    [self.spriteLayer addChild:robotHead];
    
    
    SKAction *moveWait = [SKAction waitForDuration:0.5];
    SKAction *moveLeft = [SKAction moveBy:CGVectorMake(100, 0) duration:0.3];
    SKAction *leftBounce = [SKAction moveBy:CGVectorMake(-13, 0) duration:0.2];
    SKAction *leftSequence = [SKAction sequence:@[moveWait,moveLeft,leftBounce]];
    [sidePH runAction:leftSequence];
    
    SKAction *moveRight = [SKAction moveBy:CGVectorMake(-320, 0) duration:0.3];
    SKAction *rightBounce = [SKAction moveBy:CGVectorMake(20, 0) duration:0.2];
    SKAction *rightSequence = [SKAction sequence:@[moveWait,moveRight,rightBounce]];
    [shopBoard runAction:rightSequence];
    [shopMoneyBoard runAction:rightSequence];
    [robotHead runAction:rightSequence];
    
    SKAction *move = [SKAction sequence:@[[SKAction moveToX:self.frame.size.width duration:0],
                                           [SKAction moveToX:self.frame.size.width/9 duration:0.3],
                                           [SKAction moveToX:self.frame.size.width/10 duration:0.2]]];
    
    [buy300KButton runAction:move];
    [buy150KButton runAction:move];
    [buy45KButton runAction:move];
    [buy75KButton runAction:move];
    [buy30KButton runAction:move];
    [buy9KButton runAction:move];
    
    [self viewFBLabel];
    
}
-(void)removePowerUpSprite {
    
    [shopELBoard removeFromParent];
    [shopMoneyBoard removeFromParent];
    [shopPMBoard removeFromParent];
    [shopHSBoard removeFromParent];
    [shopSRBoard removeFromParent];
    [shopMoneyBoard removeFromParent];
    [buy300KButton removeFromParent];
    [buy150KButton removeFromParent];
    [buy45KButton removeFromParent];
    [buy75KButton removeFromParent];
    [buy30KButton removeFromParent];
    [buy9KButton removeFromParent];
    [factoryBucks20K removeFromParent];
    [factoryBucks10K removeFromParent];
    [factoryBucks6K removeFromParent];
    [factoryBucks9K removeFromParent];
    [factoryBucks3K removeFromParent];
    [robotHead removeFromParent];
    [shopPDBoard removeFromParent];
    [buySafePack removeFromParent];
    [buyInvisiblePack removeFromParent];
    [buyGodPack removeFromParent];
    PowerUpAmountsLabel *el1Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"el1Label"];
    el1Label.hidden = YES;
    PowerUpAmountsLabel *el2Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"el2Label"];
    el2Label.hidden = YES;
    PowerUpAmountsLabel *el3Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"el3Label"];
    el3Label.hidden = YES;
    PowerUpAmountsLabel *hs10Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs10Label"];
    hs10Label.hidden = YES;
    PowerUpAmountsLabel *hs20Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs20Label"];
    hs20Label.hidden = YES;
    PowerUpAmountsLabel *hs30Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs30Label"];
    hs30Label.hidden = YES;
    PowerUpAmountsLabel *powerUpsLabel = (PowerUpAmountsLabel *)[self childNodeWithName:@"powerUpsLabel"];
    powerUpsLabel.hidden = YES;
    PowerUpAmountsLabel *tpLabel = (PowerUpAmountsLabel *)[self childNodeWithName:@"tpLabel"];
    tpLabel.hidden = YES;
    PowerUpAmountsLabel *qpLabel = (PowerUpAmountsLabel *)[self childNodeWithName:@"qpLabel"];
    qpLabel.hidden = YES;
    PowerUpAmountsLabel *hg10Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg10Label"];
    hg10Label.hidden = YES;
    PowerUpAmountsLabel *hg20Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg20Label"];
    hg20Label.hidden = YES;
    PowerUpAmountsLabel *hg30Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg30Label"];
    hg30Label.hidden = YES;
    PowerUpAmountsLabel *powerUpsLabel2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"powerUpsLabel2"];
    powerUpsLabel2.hidden = YES;
    PowerUpAmountsLabel *tpLabel2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"tpLabel2"];
    tpLabel2.hidden = YES;
    PowerUpAmountsLabel *qpLabel2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"qpLabel2"];
    qpLabel2.hidden = YES;
    PowerUpAmountsLabel *el1Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"el1Label2"];
    el1Label2.hidden = YES;
    PowerUpAmountsLabel *el2Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"el2Label2"];
    el2Label2.hidden = YES;
    PowerUpAmountsLabel *el3Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"el3Label2"];
    el3Label2.hidden = YES;
    PowerUpAmountsLabel *hg10Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg10Label2"];
    hg10Label2.hidden = YES;
    PowerUpAmountsLabel *hg20Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg20Label2"];
    hg20Label2.hidden = YES;
    PowerUpAmountsLabel *hg30Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg30Label2"];
    hg30Label2.hidden = YES;
    PowerUpAmountsLabel *hs10Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs10Label2"];
    hs10Label2.hidden = YES;
    PowerUpAmountsLabel *hs20Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs20Label2"];
    hs20Label2.hidden = YES;
    PowerUpAmountsLabel *hs30Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs30Label2"];
    hs30Label2.hidden = YES;
}

-(void)elScreen {
    [self removePowerUpSprite];
    
    shopELBoardTexture = [shopSprites textureNamed:@"ShopELBoard"];
    
    shopELBoard = [SKSpriteNode spriteNodeWithTexture:shopELBoardTexture];
    shopELBoard.position = CGPointZero;
    shopELBoard.size = CGSizeMake(shopELBoard.frame.size.width/s, shopELBoard.frame.size.height / s);
    shopELBoard.zPosition = 4;
    [self.spriteLayer addChild:shopELBoard];
    
    factoryBucks9KTexture = [buttonSprites textureNamed:@"FFGameScenePauseMenuBuyEL3"];
    
    factoryBucks9K = [SKSpriteNode spriteNodeWithTexture:factoryBucks9KTexture];
    factoryBucks9K.position = CGPointMake(self.frame.size.width/4, self.frame.size.height/15);
    factoryBucks9K.size = CGSizeMake(factoryBucks9K.frame.size.width/s, factoryBucks9K.frame.size.height / s);
    factoryBucks9K.zPosition = 5;
    factoryBucks9K.name = @"Buy3ExtraLivesButton";
    [self.spriteLayer addChild:factoryBucks9K];
    
    factoryBucks6KTexture = [buttonSprites textureNamed:@"FFGameScenePauseMenuBuyEL2"];
    
    factoryBucks6K = [SKSpriteNode spriteNodeWithTexture:factoryBucks6KTexture];
    factoryBucks6K.position = CGPointMake(self.frame.size.width/4, -self.frame.size.height/5.7);
    factoryBucks6K.size = CGSizeMake(factoryBucks6K.frame.size.width/s, factoryBucks6K.frame.size.height / s);
    factoryBucks6K.zPosition = 5;
    factoryBucks6K.name = @"Buy2ExtraLivesButton";
    [self.spriteLayer addChild:factoryBucks6K];
    
    factoryBucks3KTexture = [buttonSprites textureNamed:@"FFGameScenePauseMenuBuyEL1"];
    
    factoryBucks3K = [SKSpriteNode spriteNodeWithTexture:factoryBucks3KTexture];
    factoryBucks3K.position = CGPointMake(self.frame.size.width/4, -self.frame.size.height/2.4);
    factoryBucks3K.size = CGSizeMake(factoryBucks3K.frame.size.width/s, factoryBucks3K.frame.size.height / s);
    factoryBucks3K.zPosition = 5;
    factoryBucks3K.name = @"Buy1ExtraLivesButton";
    [self.spriteLayer addChild:factoryBucks3K];
    
    robotHeadTexture = [shopSprites textureNamed:@"ShopRobotHead"];
    
    robotHead = [SKSpriteNode spriteNodeWithTexture:robotHeadTexture];
    robotHead.position = CGPointZero;
    robotHead.size = CGSizeMake(robotHead.frame.size.width/s, robotHead.frame.size.height / s);
    robotHead.zPosition = 4.5;
    [self.spriteLayer addChild:robotHead];
    
    PowerUpAmountsLabel *el1Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"el1Label"];
    el1Label.hidden = NO;
    PowerUpAmountsLabel *el2Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"el2Label"];
    el2Label.hidden = NO;
    PowerUpAmountsLabel *el3Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"el3Label"];
    el3Label.hidden = NO;
    PowerUpAmountsLabel *el1Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"el1Label2"];
    el1Label2.hidden = NO;
    PowerUpAmountsLabel *el2Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"el2Label2"];
    el2Label2.hidden = NO;
    PowerUpAmountsLabel *el3Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"el3Label2"];
    el3Label2.hidden = NO;
    
}
-(void)fbScreen {
    [self removePowerUpSprite];
    
    shopMoneyBoardTexture = [shopSprites textureNamed:@"ShopMoneyBoard"];
    
    shopMoneyBoard = [SKSpriteNode spriteNodeWithTexture:shopMoneyBoardTexture];
    shopMoneyBoard.position = CGPointZero;
    shopMoneyBoard.size = CGSizeMake(shopMoneyBoard.frame.size.width/s, shopMoneyBoard.frame.size.height / s);
    shopMoneyBoard.zPosition = 4;
    [self.spriteLayer addChild:shopMoneyBoard];
    
    buy300KButtonTexture = [buttonSprites textureNamed:@"ShopBuyButton"];
    
    buy300KButton = [SKSpriteNode spriteNodeWithTexture:buy300KButtonTexture];
    buy300KButton.position = CGPointMake(self.frame.size.width/10, self.frame.size.height/8);
    buy300KButton.size = CGSizeMake(buy300KButton.frame.size.width/s, buy300KButton.frame.size.height / s);
    buy300KButton.zPosition = 5;
    buy300KButton.name = @"Buy300K";
    [self.spriteLayer addChild:buy300KButton];
    
    buy150KButtonTexture = [buttonSprites textureNamed:@"ShopBuyButton"];
    
    buy150KButton = [SKSpriteNode spriteNodeWithTexture:buy150KButtonTexture];
    buy150KButton.position = CGPointMake(self.frame.size.width/10, 0);
    buy150KButton.size = CGSizeMake(buy150KButton.frame.size.width/s, buy150KButton.frame.size.height / s);
    buy150KButton.zPosition = 5;
    buy150KButton.name = @"Buy150K";
    [self.spriteLayer addChild:buy150KButton];
    
    buy75KButtonTexture = [buttonSprites textureNamed:@"ShopBuyButton"];
    
    buy75KButton = [SKSpriteNode spriteNodeWithTexture:buy75KButtonTexture];
    buy75KButton.position = CGPointMake(self.frame.size.width/10, -self.frame.size.height/8.5);
    buy75KButton.size = CGSizeMake(buy75KButton.frame.size.width/s, buy75KButton.frame.size.height / s);
    buy75KButton.zPosition = 5;
    buy75KButton.name = @"Buy75K";
    [self.spriteLayer addChild:buy75KButton];
    
    buy45KButtonTexture = [buttonSprites textureNamed:@"ShopBuyButton"];
    
    buy45KButton = [SKSpriteNode spriteNodeWithTexture:buy45KButtonTexture];
    buy45KButton.position = CGPointMake(self.frame.size.width/10, -self.frame.size.height/4.4);
    buy45KButton.size = CGSizeMake(buy45KButton.frame.size.width/s, buy45KButton.frame.size.height / s);
    buy45KButton.zPosition = 5;
    buy45KButton.name = @"Buy45K";
    [self.spriteLayer addChild:buy45KButton];
    
    buy30KButtonTexture = [buttonSprites textureNamed:@"ShopBuyButton"];
    
    buy30KButton = [SKSpriteNode spriteNodeWithTexture:buy30KButtonTexture];
    buy30KButton.position = CGPointMake(self.frame.size.width/10, -self.frame.size.height/3.1);
    buy30KButton.size = CGSizeMake(buy30KButton.frame.size.width/s, buy30KButton.frame.size.height / s);
    buy30KButton.zPosition = 5;
    buy30KButton.name = @"Buy30K";
    [self.spriteLayer addChild:buy30KButton];
    
    buy9KButtonTexture = [buttonSprites textureNamed:@"ShopBuyButton"];
    
    buy9KButton = [SKSpriteNode spriteNodeWithTexture:buy9KButtonTexture];
    buy9KButton.position = CGPointMake(self.frame.size.width/10, -self.frame.size.height/2.35);
    buy9KButton.size = CGSizeMake(buy9KButton.frame.size.width/s, buy9KButton.frame.size.height / s);
    buy9KButton.zPosition = 5;
    buy9KButton.name = @"Buy9K";
    [self.spriteLayer addChild:buy9KButton];
    
    robotHeadTexture = [shopSprites textureNamed:@"ShopRobotHead"];
    
    robotHead = [SKSpriteNode spriteNodeWithTexture:robotHeadTexture];
    robotHead.position = CGPointZero;
    robotHead.size = CGSizeMake(robotHead.frame.size.width/s, robotHead.frame.size.height / s);
    robotHead.zPosition = 4.5;
    [self.spriteLayer addChild:robotHead];
    
}
-(void)pmScreen {
    [self removePowerUpSprite];
    
    shopPMBoardTexture = [shopSprites textureNamed:@"ShopPMBoard"];
    
    shopPMBoard = [SKSpriteNode spriteNodeWithTexture:shopPMBoardTexture];
    shopPMBoard.position = CGPointZero;
    shopPMBoard.size = CGSizeMake(shopPMBoard.frame.size.width/s, shopPMBoard.frame.size.height / s);
    shopPMBoard.zPosition = 4;
    [self.spriteLayer addChild:shopPMBoard];
    
    factoryBucks9KTexture = [buttonSprites textureNamed:@"FFGameScenePauseMenuBuySR30"];
    
    factoryBucks9K = [SKSpriteNode spriteNodeWithTexture:factoryBucks9KTexture];
    factoryBucks9K.position = CGPointMake(self.frame.size.width/4, self.frame.size.height/15);
    factoryBucks9K.size = CGSizeMake(factoryBucks9K.frame.size.width/s, factoryBucks9K.frame.size.height / s);
    factoryBucks9K.zPosition = 5;
    factoryBucks9K.name = @"BuyQuadPointsButton";
    [self.spriteLayer addChild:factoryBucks9K];
    
    factoryBucks6KTexture = [buttonSprites textureNamed:@"FFGameScenePauseMenuBuySR20"];
    
    factoryBucks6K = [SKSpriteNode spriteNodeWithTexture:factoryBucks6KTexture];
    factoryBucks6K.position = CGPointMake(self.frame.size.width/4, -self.frame.size.height/5.7);
    factoryBucks6K.size = CGSizeMake(factoryBucks6K.frame.size.width/s, factoryBucks6K.frame.size.height / s);
    factoryBucks6K.zPosition = 5;
    factoryBucks6K.name = @"BuyTriplePointsButton";
    [self.spriteLayer addChild:factoryBucks6K];
    
    factoryBucks3KTexture = [buttonSprites textureNamed:@"FFGameScenePauseMenuBuySR10"];
    
    factoryBucks3K = [SKSpriteNode spriteNodeWithTexture:factoryBucks3KTexture];
    factoryBucks3K.position = CGPointMake(self.frame.size.width/4, -self.frame.size.height/2.4);
    factoryBucks3K.size = CGSizeMake(factoryBucks3K.frame.size.width/s, factoryBucks3K.frame.size.height / s);
    factoryBucks3K.zPosition = 5;
    factoryBucks3K.name = @"BuyDoublePointsButton";
    [self.spriteLayer addChild:factoryBucks3K];
    
    robotHeadTexture = [shopSprites textureNamed:@"ShopRobotHead"];
    
    robotHead = [SKSpriteNode spriteNodeWithTexture:robotHeadTexture];
    robotHead.size = CGSizeMake(robotHead.frame.size.width/s, robotHead.frame.size.height / s);
    robotHead.position = CGPointZero;
    robotHead.zPosition = 4.5;
    [self.spriteLayer addChild:robotHead];
    
    PowerUpAmountsLabel *powerUpsLabel = (PowerUpAmountsLabel *)[self childNodeWithName:@"powerUpsLabel"];
    powerUpsLabel.hidden = NO;
    PowerUpAmountsLabel *tpLabel = (PowerUpAmountsLabel *)[self childNodeWithName:@"tpLabel"];
    tpLabel.hidden = NO;
    PowerUpAmountsLabel *qpLabel = (PowerUpAmountsLabel *)[self childNodeWithName:@"qpLabel"];
    qpLabel.hidden = NO;
    PowerUpAmountsLabel *powerUpsLabel2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"powerUpsLabel2"];
    powerUpsLabel2.hidden = NO;
    PowerUpAmountsLabel *tpLabel2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"tpLabel2"];
    tpLabel2.hidden = NO;
    PowerUpAmountsLabel *qpLabel2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"qpLabel2"];
    qpLabel2.hidden = NO;
    
}
-(void)hsScreen {
    [self removePowerUpSprite];
    
    shopHSBoardTexture = [shopSprites textureNamed:@"ShopHSBoard"];
    
    shopHSBoard = [SKSpriteNode spriteNodeWithTexture:shopHSBoardTexture];
    shopHSBoard.position = CGPointZero;
    shopHSBoard.size = CGSizeMake(shopHSBoard.frame.size.width/s, shopHSBoard.frame.size.height / s);
    shopHSBoard.zPosition = 4;
    [self.spriteLayer addChild:shopHSBoard];
    
    factoryBucks9KTexture = [buttonSprites textureNamed:@"FFGameScenePauseMenuBuyTR30"];
    
    factoryBucks9K = [SKSpriteNode spriteNodeWithTexture:factoryBucks9KTexture];
    factoryBucks9K.position = CGPointMake(self.frame.size.width/4, self.frame.size.height/15);
    factoryBucks9K.size = CGSizeMake(factoryBucks9K.frame.size.width/s, factoryBucks9K.frame.size.height / s);
    factoryBucks9K.zPosition = 5;
    factoryBucks9K.name = @"BuyHeadStart30Button";
    [self.spriteLayer addChild:factoryBucks9K];
    
    factoryBucks6KTexture = [buttonSprites textureNamed:@"FFGameScenePauseMenuBuyTR20"];
    
    factoryBucks6K = [SKSpriteNode spriteNodeWithTexture:factoryBucks6KTexture];
    factoryBucks6K.position = CGPointMake(self.frame.size.width/4, -self.frame.size.height/5.7);
    factoryBucks6K.size = CGSizeMake(factoryBucks6K.frame.size.width/s, factoryBucks6K.frame.size.height / s);
    factoryBucks6K.zPosition = 5;
    factoryBucks6K.name = @"BuyHeadStart20Button";
    [self.spriteLayer addChild:factoryBucks6K];
    
    factoryBucks3KTexture = [buttonSprites textureNamed:@"FFGameScenePauseMenuBuyTR10"];
    
    factoryBucks3K = [SKSpriteNode spriteNodeWithTexture:factoryBucks3KTexture];
    factoryBucks3K.position = CGPointMake(self.frame.size.width/4, -self.frame.size.height/2.4);
    factoryBucks3K.size = CGSizeMake(factoryBucks3K.frame.size.width/s, factoryBucks3K.frame.size.height / s);
    factoryBucks3K.zPosition = 5;
    factoryBucks3K.name = @"BuyHeadStart10Button";
    [self.spriteLayer addChild:factoryBucks3K];
    
    robotHeadTexture = [shopSprites textureNamed:@"ShopRobotHead"];
    
    robotHead = [SKSpriteNode spriteNodeWithTexture:robotHeadTexture];
    robotHead.position = CGPointZero;
    robotHead.size = CGSizeMake(robotHead.frame.size.width/s, robotHead.frame.size.height / s);
    robotHead.zPosition = 4.5;
    [self.spriteLayer addChild:robotHead];
    PowerUpAmountsLabel *hs10Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs10Label"];
    hs10Label.hidden = NO;
    
    PowerUpAmountsLabel *hs20Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs20Label"];
    hs20Label.hidden = NO;
    
    PowerUpAmountsLabel *hs30Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs30Label"];
    hs30Label.hidden = NO;
    
    PowerUpAmountsLabel *hs10Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs10Label2"];
    hs10Label2.hidden = NO;
    
    PowerUpAmountsLabel *hs20Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs20Label2"];
    hs20Label2.hidden = NO;
    
    PowerUpAmountsLabel *hs30Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs30Label2"];
    hs30Label2.hidden = NO;
}
-(void)srScreen {
    [self removePowerUpSprite];
    
    shopSRBoardTexture = [shopSprites textureNamed:@"ShopSRBoard"];
    
    shopSRBoard = [SKSpriteNode spriteNodeWithTexture:shopSRBoardTexture];
    shopSRBoard.position = CGPointZero;
    shopSRBoard.size = CGSizeMake(shopSRBoard.frame.size.width/s, shopSRBoard.frame.size.height / s);
    shopSRBoard.zPosition = 4;
    [self.spriteLayer addChild:shopSRBoard];
    
    factoryBucks20KTexture = [buttonSprites textureNamed:@"FFGameScenePauseMenuBuyQP"];
    
    factoryBucks20K = [SKSpriteNode spriteNodeWithTexture:factoryBucks20KTexture];
    factoryBucks20K.position = CGPointMake(self.frame.size.width/4, self.frame.size.height/15);
    factoryBucks20K.size = CGSizeMake(factoryBucks20K.frame.size.width/s, factoryBucks20K.frame.size.height / s);
    factoryBucks20K.zPosition = 5;
    factoryBucks20K.name = @"BuySpeedReduction30";
    [self.spriteLayer addChild:factoryBucks20K];
    
    factoryBucks10KTexture = [buttonSprites textureNamed:@"FFGameScenePauseMenuBuyTP"];
    
    factoryBucks10K = [SKSpriteNode spriteNodeWithTexture:factoryBucks10KTexture];
    factoryBucks10K.position = CGPointMake(self.frame.size.width/4, -self.frame.size.height/5.7);
    factoryBucks10K.size = CGSizeMake(factoryBucks10K.frame.size.width/s, factoryBucks10K.frame.size.height / s);
    factoryBucks10K.zPosition = 5;
    factoryBucks10K.name = @"BuySpeedReduction20";
    [self.spriteLayer addChild:factoryBucks10K];
    
    factoryBucks6KTexture = [buttonSprites textureNamed:@"FFGameScenePauseMenuBuyDP"];
    
    factoryBucks6K = [SKSpriteNode spriteNodeWithTexture:factoryBucks6KTexture];
    factoryBucks6K.position = CGPointMake(self.frame.size.width/4, -self.frame.size.height/2.4);
    factoryBucks6K.size = CGSizeMake(factoryBucks6K.frame.size.width/s, factoryBucks6K.frame.size.height / s);
    factoryBucks6K.zPosition = 5;
    factoryBucks6K.name = @"BuySpeedReduction10";
    [self.spriteLayer addChild:factoryBucks6K];
    
    robotHeadTexture = [shopSprites textureNamed:@"ShopRobotHead"];
    
    robotHead = [SKSpriteNode spriteNodeWithTexture:robotHeadTexture];
    robotHead.position = CGPointZero;
    robotHead.size = CGSizeMake(robotHead.frame.size.width/s, robotHead.frame.size.height / s);
    robotHead.zPosition = 4.5;
    [self.spriteLayer addChild:robotHead];
    
    PowerUpAmountsLabel *hg10Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg10Label"];
    hg10Label.hidden = NO;
    
    PowerUpAmountsLabel *hg20Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg20Label"];
    hg20Label.hidden = NO;
    
    PowerUpAmountsLabel *hg30Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg30Label"];
    hg30Label.hidden = NO;
    
    PowerUpAmountsLabel *hg10Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg10Label2"];
    hg10Label2.hidden = NO;
    
    PowerUpAmountsLabel *hg20Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg20Label2"];
    hg20Label2.hidden = NO;
    
    PowerUpAmountsLabel *hg30Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg30Label2"];
    hg30Label2.hidden = NO;
}
-(void)pdScreen {
    
    [self removePowerUpSprite];
    
    shopPDBoardTexture = [shopSprites textureNamed:@"ShopPDBoard"];
    
    shopPDBoard = [SKSpriteNode spriteNodeWithTexture:shopPDBoardTexture];
    shopPDBoard.position = CGPointZero;
    shopPDBoard.size = CGSizeMake(shopPDBoard.frame.size.width/s, shopPDBoard.frame.size.height / s);
    shopPDBoard.zPosition = 4;
    [self.spriteLayer addChild:shopPDBoard];
    
    buySafePackTexture = [buttonSprites textureNamed:@"ShopBuyButton"];
    
    buySafePack = [SKSpriteNode spriteNodeWithTexture:buySafePackTexture];
    buySafePack.position = CGPointMake(self.frame.size.width/4, self.frame.size.height/15);
    buySafePack.size = CGSizeMake(buySafePack.frame.size.width/s, buySafePack.frame.size.height / s);
    buySafePack.zPosition = 5;
    buySafePack.name = @"buySafePack";
    [self.spriteLayer addChild:buySafePack];
    
    buyInvisiblePackTexture = [buttonSprites textureNamed:@"ShopBuyButton"];
    
    buyInvisiblePack = [SKSpriteNode spriteNodeWithTexture:buyInvisiblePackTexture];
    buyInvisiblePack.position = CGPointMake(self.frame.size.width/4, -self.frame.size.height/5.7);
    buyInvisiblePack.size = CGSizeMake(buyInvisiblePack.frame.size.width/s, buyInvisiblePack.frame.size.height / s);
    buyInvisiblePack.zPosition = 5;
    buyInvisiblePack.name = @"buyInvisiblePack";
    [self.spriteLayer addChild:buyInvisiblePack];
    
    buyGodPackTexture = [buttonSprites textureNamed:@"ShopBuyButton"];
    
    buyGodPack = [SKSpriteNode spriteNodeWithTexture:buyGodPackTexture];
    buyGodPack.position = CGPointMake(self.frame.size.width/4, -self.frame.size.height/2.4);
    buyGodPack.size = CGSizeMake(buyGodPack.frame.size.width/s, buyGodPack.frame.size.height / s);
    buyGodPack.zPosition = 5;
    buyGodPack.name = @"buyGodPack";
    [self.spriteLayer addChild:buyGodPack];
    
    robotHeadTexture = [shopSprites textureNamed:@"ShopRobotHead"];
    
    robotHead = [SKSpriteNode spriteNodeWithTexture:robotHeadTexture];
    robotHead.position = CGPointZero;
    robotHead.size = CGSizeMake(robotHead.frame.size.width/s, robotHead.frame.size.height / s);
    robotHead.zPosition = 4.5;
    [self.spriteLayer addChild:robotHead];
    
}
-(void)removeSPrites {
    
    
    
    PowerUpAmountsLabel *powerUpsLabel = (PowerUpAmountsLabel *)[self childNodeWithName:@"powerUpsLabel"];
    powerUpsLabel.hidden = YES;
    
    PowerUpAmountsLabel *tpLabel = (PowerUpAmountsLabel *)[self childNodeWithName:@"tpLabel"];
    tpLabel.hidden = YES;
    
    PowerUpAmountsLabel *qpLabel = (PowerUpAmountsLabel *)[self childNodeWithName:@"qpLabel"];
    qpLabel.hidden = YES;
    
    PowerUpAmountsLabel *el1Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"el1Label"];
    el1Label.hidden = YES;
    
    PowerUpAmountsLabel *el2Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"el2Label"];
    el2Label.hidden = YES;
    
    PowerUpAmountsLabel *el3Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"el3Label"];
    el3Label.hidden = YES;
    
    PowerUpAmountsLabel *hg10Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg10Label"];
    hg10Label.hidden = YES;
    
    PowerUpAmountsLabel *hg20Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg20Label"];
    hg20Label.hidden = YES;
    
    PowerUpAmountsLabel *hg30Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg30Label"];
    hg30Label.hidden = YES;
    
    PowerUpAmountsLabel *hs10Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs10Label"];
    hs10Label.hidden = YES;
    
    PowerUpAmountsLabel *hs20Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs20Label"];
    hs20Label.hidden = YES;
    
    PowerUpAmountsLabel *hs30Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs30Label"];
    hs30Label.hidden = YES;
    
    PowerUpAmountsLabel *powerUpsLabel2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"powerUpsLabel2"];
    powerUpsLabel2.hidden = YES;
    
    PowerUpAmountsLabel *tpLabel2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"tpLabel2"];
    tpLabel2.hidden = YES;
    
    PowerUpAmountsLabel *qpLabel2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"qpLabel2"];
    qpLabel2.hidden = YES;
    
    PowerUpAmountsLabel *el1Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"el1Label2"];
    el1Label2.hidden = YES;
    
    PowerUpAmountsLabel *el2Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"el2Label2"];
    el2Label2.hidden = YES;
    
    PowerUpAmountsLabel *el3Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"el3Label2"];
    el3Label2.hidden = YES;
    
    PowerUpAmountsLabel *hg10Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg10Label2"];
    hg10Label2.hidden = YES;
    
    PowerUpAmountsLabel *hg20Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg20Label2"];
    hg20Label2.hidden = YES;
    
    PowerUpAmountsLabel *hg30Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg30Label2"];
    hg30Label2.hidden = YES;
    
    PowerUpAmountsLabel *hs10Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs10Label2"];
    hs10Label2.hidden = YES;
    
    PowerUpAmountsLabel *hs20Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs20Label2"];
    hs20Label2.hidden = YES;
    
    PowerUpAmountsLabel *hs30Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs30Label2"];
    hs30Label2.hidden = YES;
}

-(void)buy1DoublePoint {
    FBLabelLogic *FBAmountCheck = [[FBLabelLogic alloc]init];
    [FBAmountCheck buyDPCheck];
    if (boughtDP == YES) {
        boughtDP = NO;
        PowerUpAmountsLabel *powerUpsLabel = (PowerUpAmountsLabel *)[self childNodeWithName:@"powerUpsLabel"];
        PowerUpAmountsLabel *powerUpsLabel2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"powerUpsLabel2"];
        
        [powerUpsLabel setPoints:powerUpsLabel.number + 1];
        [powerUpsLabel2 setPoints:powerUpsLabel2.number + 1];
        
        ShopLogic *saveDP = [[ShopLogic alloc]init];
        [saveDP loadDPInteger];
        
        FactoryBucksLabel *amountLabel = (FactoryBucksLabel *)[self childNodeWithName:@"amountLabel"];
        FactoryBucksLabel *kasbE = (FactoryBucksLabel *)[self childNodeWithName:@"kasbE"];
        
        [amountLabel setPoints:amountLabel.amount - 3000];
        [kasbE setPoints:kasbE.amount - 3000];
        
        FactoryBucksLabel *decrement3000 = [[FactoryBucksLabel alloc]init];
        [decrement3000 decrementBy3000];
        
        Data *save = [[Data alloc]init];
        [save saveAmountFB];
    }
}
-(void)buy1TriplePoint {
    
    FBLabelLogic *FBAmountCheck = [[FBLabelLogic alloc]init];
    [FBAmountCheck buyTPCheck];
    if (boughtTP == YES) {
        boughtTP = NO;
        PowerUpAmountsLabel *tpLabel = (PowerUpAmountsLabel *)[self childNodeWithName:@"tpLabel"];
        PowerUpAmountsLabel *tpLabel2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"tpLabel2"];
        
        [tpLabel setPoints:tpLabel.number + 1];
        [tpLabel2 setPoints:tpLabel2.number + 1];
        
        ShopLogic *saveTP = [[ShopLogic alloc]init];
        [saveTP loadTPInteger];
        
        FactoryBucksLabel *amountLabel = (FactoryBucksLabel *)[self childNodeWithName:@"amountLabel"];
        FactoryBucksLabel *kasbE = (FactoryBucksLabel *)[self childNodeWithName:@"kasbE"];
        
        [amountLabel setPoints:amountLabel.amount - 6000];
        [kasbE setPoints:kasbE.amount - 6000];
        
        FactoryBucksLabel *decrement6000 = [[FactoryBucksLabel alloc]init];
        [decrement6000 decrementBy6000];
        
        Data *save = [[Data alloc]init];
        [save saveAmountFB];
    }
    
}
-(void)buy1QuadPoint {
    
    FBLabelLogic *FBAmountCheck = [[FBLabelLogic alloc]init];
    [FBAmountCheck buyQPCheck];
    if (boughtQP == YES) {
        boughtQP = NO;
        PowerUpAmountsLabel *qpLabel = (PowerUpAmountsLabel *)[self childNodeWithName:@"qpLabel"];
        PowerUpAmountsLabel *qpLabel2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"qpLabel2"];
        
        [qpLabel setPoints:qpLabel.number + 1];
        [qpLabel2 setPoints:qpLabel2.number + 1];
        
        ShopLogic *saveQP = [[ShopLogic alloc]init];
        [saveQP loadQPInteger];
        
        FactoryBucksLabel *amountLabel = (FactoryBucksLabel *)[self childNodeWithName:@"amountLabel"];
        FactoryBucksLabel *kasbE = (FactoryBucksLabel *)[self childNodeWithName:@"kasbE"];
        
        [amountLabel setPoints:amountLabel.amount - 9000];
        [kasbE setPoints:kasbE.amount - 9000];
        
        FactoryBucksLabel *decrement9000 = [[FactoryBucksLabel alloc]init];
        [decrement9000 decrementBy9000];
        
        Data *save = [[Data alloc]init];
        [save saveAmountFB];
    }
}
-(void)buy1ExtraLife1 {
    
    FBLabelLogic *FBAmountCheck = [[FBLabelLogic alloc]init];
    [FBAmountCheck buyEL1Check];
    if (boughtEL1 == YES) {
        boughtEL1 = NO;
        PowerUpAmountsLabel *el1Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"el1Label"];
        PowerUpAmountsLabel *el1Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"el1Label2"];
        
        [el1Label setPoints:el1Label.number + 1];
        [el1Label2 setPoints:el1Label2.number + 1];
        
        ShopLogic *saveEL1 = [[ShopLogic alloc]init];
        [saveEL1 loadEL1Integer];
        
        FactoryBucksLabel *amountLabel = (FactoryBucksLabel *)[self childNodeWithName:@"amountLabel"];
        FactoryBucksLabel *kasbE = (FactoryBucksLabel *)[self childNodeWithName:@"kasbE"];
        
        [amountLabel setPoints:amountLabel.amount - 3000];
        [kasbE setPoints:kasbE.amount - 3000];
        
        FactoryBucksLabel *decrement3000 = [[FactoryBucksLabel alloc]init];
        [decrement3000 decrementBy3000];
        
        Data *save = [[Data alloc]init];
        [save saveAmountFB];
    }
}
-(void)buy1ExtraLife2 {
    
    FBLabelLogic *FBAmountCheck = [[FBLabelLogic alloc]init];
    [FBAmountCheck buyEL2Check];
    if (boughtEL2 == YES) {
        boughtEL2 = NO;
        PowerUpAmountsLabel *el2Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"el2Label"];
        PowerUpAmountsLabel *el2Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"el2Label2"];
        
        [el2Label setPoints:el2Label.number + 1];
        [el2Label2 setPoints:el2Label2.number + 1];
        
        ShopLogic *saveEL2 = [[ShopLogic alloc]init];
        [saveEL2 loadEL2Integer];
        
        FactoryBucksLabel *amountLabel = (FactoryBucksLabel *)[self childNodeWithName:@"amountLabel"];
        FactoryBucksLabel *kasbE = (FactoryBucksLabel *)[self childNodeWithName:@"kasbE"];
        
        [amountLabel setPoints:amountLabel.amount - 6000];
        [kasbE setPoints:kasbE.amount - 6000];
        
        FactoryBucksLabel *decrement6000 = [[FactoryBucksLabel alloc]init];
        [decrement6000 decrementBy6000];
        
        Data *save = [[Data alloc]init];
        [save saveAmountFB];
    }
}
-(void)buy1ExtraLife3 {
    
    FBLabelLogic *FBAmountCheck = [[FBLabelLogic alloc]init];
    [FBAmountCheck buyEL3Check];
    if (boughtEL3 == YES) {
        boughtEL3 = NO;
        PowerUpAmountsLabel *el3Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"el3Label"];
        PowerUpAmountsLabel *el3Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"el3Label2"];
        
        [el3Label setPoints:el3Label.number + 1];
        [el3Label2 setPoints:el3Label2.number + 1];
        
        ShopLogic *saveEL3 = [[ShopLogic alloc]init];
        [saveEL3 loadEL3Integer];
        
        FactoryBucksLabel *amountLabel = (FactoryBucksLabel *)[self childNodeWithName:@"amountLabel"];
        FactoryBucksLabel *kasbE = (FactoryBucksLabel *)[self childNodeWithName:@"kasbE"];
        
        [amountLabel setPoints:amountLabel.amount - 9000];
        [kasbE setPoints:kasbE.amount - 9000];
        
        FactoryBucksLabel *decrement9000 = [[FactoryBucksLabel alloc]init];
        [decrement9000 decrementBy9000];
        
        Data *save = [[Data alloc]init];
        [save saveAmountFB];
    }
}
-(void)buy1HourGlass10 {
    
    FBLabelLogic *FBAmountCheck = [[FBLabelLogic alloc]init];
    [FBAmountCheck buyHG10Check];
    if (boughtHG10 == YES) {
        boughtHG10 = NO;
        PowerUpAmountsLabel *hg10Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg10Label"];
        PowerUpAmountsLabel *hg10Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg10Label2"];
        
        [hg10Label setPoints:hg10Label.number + 1];
        [hg10Label2 setPoints:hg10Label2.number + 1];
        
        ShopLogic *saveHG10 = [[ShopLogic alloc]init];
        [saveHG10 loadHG10Integer];
        
        FactoryBucksLabel *amountLabel = (FactoryBucksLabel *)[self childNodeWithName:@"amountLabel"];
        FactoryBucksLabel *kasbE = (FactoryBucksLabel *)[self childNodeWithName:@"kasbE"];
        
        [amountLabel setPoints:amountLabel.amount - 6000];
        [kasbE setPoints:kasbE.amount - 6000];
        
        FactoryBucksLabel *decrement6000 = [[FactoryBucksLabel alloc]init];
        [decrement6000 decrementBy6000];
        
        Data *save = [[Data alloc]init];
        [save saveAmountFB];
    }
}
-(void)buy1HourGlass20 {
    
    FBLabelLogic *FBAmountCheck = [[FBLabelLogic alloc]init];
    [FBAmountCheck buyHG20Check];
    if (boughtHG20 == YES) {
        boughtHG20 = NO;
        PowerUpAmountsLabel *hg20Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg20Label"];
        PowerUpAmountsLabel *hg20Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg20Label2"];
        
        [hg20Label setPoints:hg20Label.number + 1];
        [hg20Label2 setPoints:hg20Label2.number + 1];
        
        ShopLogic *saveHG20 = [[ShopLogic alloc]init];
        [saveHG20 loadHG20Integer];
        
        FactoryBucksLabel *amountLabel = (FactoryBucksLabel *)[self childNodeWithName:@"amountLabel"];
        FactoryBucksLabel *kasbE = (FactoryBucksLabel *)[self childNodeWithName:@"kasbE"];
        
        [amountLabel setPoints:amountLabel.amount - 10000];
        [kasbE setPoints:kasbE.amount - 10000];
        
        FactoryBucksLabel *decrement10000 = [[FactoryBucksLabel alloc]init];
        [decrement10000 decrementBy10000];
        
        Data *save = [[Data alloc]init];
        [save saveAmountFB];
    }
}
-(void)buy1HourGlass30 {
    
    FBLabelLogic *FBAmountCheck = [[FBLabelLogic alloc]init];
    [FBAmountCheck buyHG30Check];
    if (boughtHG30 == YES) {
        boughtHG30 = NO;
        PowerUpAmountsLabel *hg30Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg30Label"];
        PowerUpAmountsLabel *hg30Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg30Label2"];
        
        [hg30Label setPoints:hg30Label.number + 1];
        [hg30Label2 setPoints:hg30Label2.number + 1];
        
        ShopLogic *saveHG30 = [[ShopLogic alloc]init];
        [saveHG30 loadHG30Integer];
        
        FactoryBucksLabel *amountLabel = (FactoryBucksLabel *)[self childNodeWithName:@"amountLabel"];
        FactoryBucksLabel *kasbE = (FactoryBucksLabel *)[self childNodeWithName:@"kasbE"];
        
        [amountLabel setPoints:amountLabel.amount - 20000];
        [kasbE setPoints:kasbE.amount - 20000];
        
        FactoryBucksLabel *decrement20000 = [[FactoryBucksLabel alloc]init];
        [decrement20000 decrementBy20000];
        
        Data *save = [[Data alloc]init];
        [save saveAmountFB];
    }
}
-(void)buy1HeadStart10 {
    
    FBLabelLogic *FBAmountCheck = [[FBLabelLogic alloc]init];
    [FBAmountCheck buyHS10Check];
    if (boughtHS10 == YES) {
        boughtHS10 = NO;
        PowerUpAmountsLabel *hs10Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs10Label"];
        PowerUpAmountsLabel *hs10Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs10Label2"];
        
        [hs10Label setPoints:hs10Label.number + 1];
        [hs10Label2 setPoints:hs10Label2.number + 1];
        
        ShopLogic *saveHS10 = [[ShopLogic alloc]init];
        [saveHS10 loadHS10Integer];
        
        FactoryBucksLabel *amountLabel = (FactoryBucksLabel *)[self childNodeWithName:@"amountLabel"];
        FactoryBucksLabel *kasbE = (FactoryBucksLabel *)[self childNodeWithName:@"kasbE"];
        
        [amountLabel setPoints:amountLabel.amount - 6000];
        [kasbE setPoints:kasbE.amount - 6000];
        
        FactoryBucksLabel *decrement6000 = [[FactoryBucksLabel alloc]init];
        [decrement6000 decrementBy6000];
        
        Data *save = [[Data alloc]init];
        [save saveAmountFB];
    }
}
-(void)buy1HeadStart20 {
    
    FBLabelLogic *FBAmountCheck = [[FBLabelLogic alloc]init];
    [FBAmountCheck buyHS20Check];
    if (boughtHS20 == YES) {
        boughtHS20 = NO;
        PowerUpAmountsLabel *hs20Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs20Label"];
        PowerUpAmountsLabel *hs20Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs20Label2"];
        
        [hs20Label setPoints:hs20Label.number + 1];
        [hs20Label2 setPoints:hs20Label2.number + 1];
        
        ShopLogic *saveHS20 = [[ShopLogic alloc]init];
        [saveHS20 loadHS20Integer];
        
        FactoryBucksLabel *amountLabel = (FactoryBucksLabel *)[self childNodeWithName:@"amountLabel"];
        FactoryBucksLabel *kasbE = (FactoryBucksLabel *)[self childNodeWithName:@"kasbE"];
        
        [amountLabel setPoints:amountLabel.amount - 10000];
        [kasbE setPoints:kasbE.amount - 10000];
        
        FactoryBucksLabel *decrement10000 = [[FactoryBucksLabel alloc]init];
        [decrement10000 decrementBy10000];
        
        Data *save = [[Data alloc]init];
        [save saveAmountFB];
    }
}
-(void)buy1HeadStart30 {
    
    FBLabelLogic *FBAmountCheck = [[FBLabelLogic alloc]init];
    [FBAmountCheck buyHS30Check];
    if (boughtHS30 == YES) {
        boughtHS30 = NO;
        PowerUpAmountsLabel *hs30Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs30Label"];
        PowerUpAmountsLabel *hs30Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs30Label2"];
        
        [hs30Label setPoints:hs30Label.number + 1];
        [hs30Label2 setPoints:hs30Label2.number + 1];
        
        ShopLogic *saveHS30 = [[ShopLogic alloc]init];
        [saveHS30 loadHS30Integer];
        
        
        FactoryBucksLabel *amountLabel = (FactoryBucksLabel *)[self childNodeWithName:@"amountLabel"];
        FactoryBucksLabel *kasbE = (FactoryBucksLabel *)[self childNodeWithName:@"kasbE"];
        
        [amountLabel setPoints:amountLabel.amount - 20000];
        [kasbE setPoints:kasbE.amount - 20000];
        
        FactoryBucksLabel *decrement20000 = [[FactoryBucksLabel alloc]init];
        [decrement20000 decrementBy20000];
        
        Data *save = [[Data alloc]init];
        [save saveAmountFB];
        

    }
}
-(void)viewFBLabel {
    
    Data *FBCount = [[Data alloc]init];
    [FBCount loadAmountFB];
    
    FactoryBucksLabel *amountLabel = [FactoryBucksLabel FBLabelWithFontNamed:@"DimitriSwank"];
    amountLabel.name = @"amountLabel";
    amountLabel.position = CGPointMake(self.frame.size.width/5, self.frame.size.height/2.25);
    amountLabel.zPosition = 100.1;
    amountLabel.fontSize = 20;
    amountLabel.fontColor = [UIColor blackColor];
    amountLabel.colorBlendFactor = 1;
    [amountLabel setPoints:amountFB];
    [self addChild:amountLabel];
    
    FactoryBucksLabel *kasbE = [FactoryBucksLabel FBLabelWithFontNamed:@"Dimitri"];
    kasbE.name = @"kasbE";
    kasbE.position = CGPointMake(self.frame.size.width/5, self.frame.size.height/2.25);
    kasbE.zPosition = 100;
    kasbE.fontSize = 20;
    kasbE.fontColor = [UIColor whiteColor];
    kasbE.colorBlendFactor = 1;
    [kasbE setPoints:amountFB];
    [self addChild:kasbE];
    
    //SKAction *moveWait = [SKAction waitForDuration:0.5];
    //SKAction *moveRight = [SKAction moveBy:CGVectorMake(-320, 0) duration:0.3];
    //SKAction *rightBounce = [SKAction moveBy:CGVectorMake(20, 0) duration:0.2];
    //SKAction *rightSequence = [SKAction sequence:@[moveWait,moveRight,rightBounce]];
    //[amountLabel runAction:rightSequence];
    //[kasbE runAction:rightSequence];
    
    NSLog(@"FacotryBucks:" @"%ld", (long)amountFB);
}
-(void)increment9000 {
    
    FactoryBucksLabel *amountLabel = (FactoryBucksLabel *)[self childNodeWithName:@"amountLabel"];
    FactoryBucksLabel *kasbE = (FactoryBucksLabel *)[self childNodeWithName:@"kasbE"];
    
    [amountLabel setPoints:amountLabel.amount + 9000];
    [kasbE setPoints:kasbE.amount + 9000];
    
    FactoryBucksLabel *increment9000 = [[FactoryBucksLabel alloc]init];
    [increment9000 incrementBy9000];
    
    Data *save = [[Data alloc]init];
    [save saveAmountFB];
    factoryBucks9kPurchased = NO;
}
-(void)increment30000 {
    
    FactoryBucksLabel *amountLabel = (FactoryBucksLabel *)[self childNodeWithName:@"amountLabel"];
    FactoryBucksLabel *kasbE = (FactoryBucksLabel *)[self childNodeWithName:@"kasbE"];
    
    [amountLabel setPoints:amountLabel.amount + 30000];
    [kasbE setPoints:kasbE.amount + 30000];
    
    FactoryBucksLabel *increment30000 = [[FactoryBucksLabel alloc]init];
    [increment30000 incrementBy30000];
    
    Data *save = [[Data alloc]init];
    [save saveAmountFB];
    
}
-(void)increment45000 {
    
    FactoryBucksLabel *amountLabel = (FactoryBucksLabel *)[self childNodeWithName:@"amountLabel"];
    FactoryBucksLabel *kasbE = (FactoryBucksLabel *)[self childNodeWithName:@"kasbE"];
    
    [amountLabel setPoints:amountLabel.amount + 45000];
    [kasbE setPoints:kasbE.amount + 45000];
    
    FactoryBucksLabel *increment45000 = [[FactoryBucksLabel alloc]init];
    [increment45000 incrementBy45000];
    
    Data *save = [[Data alloc]init];
    [save saveAmountFB];
    
}
-(void)increment75000 {
    
    FactoryBucksLabel *amountLabel = (FactoryBucksLabel *)[self childNodeWithName:@"amountLabel"];
    FactoryBucksLabel *kasbE = (FactoryBucksLabel *)[self childNodeWithName:@"kasbE"];
    
    [amountLabel setPoints:amountLabel.amount + 75000];
    [kasbE setPoints:kasbE.amount + 75000];
    
    FactoryBucksLabel *increment75000 = [[FactoryBucksLabel alloc]init];
    [increment75000 incrementBy75000];
    
    Data *save = [[Data alloc]init];
    [save saveAmountFB];
    
}
-(void)increment150000 {
    
    FactoryBucksLabel *amountLabel = (FactoryBucksLabel *)[self childNodeWithName:@"amountLabel"];
    FactoryBucksLabel *kasbE = (FactoryBucksLabel *)[self childNodeWithName:@"kasbE"];
    
    [amountLabel setPoints:amountLabel.amount + 150000];
    [kasbE setPoints:kasbE.amount + 150000];
    
    FactoryBucksLabel *increment150000 = [[FactoryBucksLabel alloc]init];
    [increment150000 incrementBy150000];
    
    Data *save = [[Data alloc]init];
    [save saveAmountFB];
    
}
-(void)increment300000 {
    
    FactoryBucksLabel *amountLabel = (FactoryBucksLabel *)[self childNodeWithName:@"amountLabel"];
    FactoryBucksLabel *kasbE = (FactoryBucksLabel *)[self childNodeWithName:@"kasbE"];
    
    [amountLabel setPoints:amountLabel.amount + 300000];
    [kasbE setPoints:kasbE.amount + 300000];
    
    FactoryBucksLabel *increment300000 = [[FactoryBucksLabel alloc]init];
    [increment300000 incrementBy300000];
    
    Data *save = [[Data alloc]init];
    [save saveAmountFB];
    
}
-(void)godModePack {
    
    ShopLogic *godPack = [[ShopLogic alloc]init];
    [godPack buyGodPack];
    
    PowerUpAmountsLabel *tpLabel = (PowerUpAmountsLabel *)[self childNodeWithName:@"tpLabel"];
    PowerUpAmountsLabel *tpLabel2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"tpLabel2"];
    
    [tpLabel setPoints:tpLabel.number + 3];
    [tpLabel2 setPoints:tpLabel2.number + 3];
    
    ShopLogic *saveTP = [[ShopLogic alloc]init];
    [saveTP loadTPInteger];
    
    PowerUpAmountsLabel *qpLabel = (PowerUpAmountsLabel *)[self childNodeWithName:@"qpLabel"];
    PowerUpAmountsLabel *qpLabel2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"qpLabel2"];
    
    [qpLabel setPoints:qpLabel.number + 7];
    [qpLabel2 setPoints:qpLabel2.number + 7];
    
    ShopLogic *saveQP = [[ShopLogic alloc]init];
    [saveQP loadQPInteger];
    
    PowerUpAmountsLabel *el2Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"el2Label"];
    PowerUpAmountsLabel *el2Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"el2Label2"];
    
    [el2Label setPoints:el2Label.number + 3];
    [el2Label2 setPoints:el2Label2.number + 3];
    
    ShopLogic *saveEL2 = [[ShopLogic alloc]init];
    [saveEL2 loadEL2Integer];
    
    PowerUpAmountsLabel *el3Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"el3Label"];
    PowerUpAmountsLabel *el3Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"el3Label2"];
    
    [el3Label setPoints:el3Label.number + 7];
    [el3Label2 setPoints:el3Label2.number + 7];
    
    ShopLogic *saveEL3 = [[ShopLogic alloc]init];
    [saveEL3 loadEL3Integer];
    
    PowerUpAmountsLabel *hg20Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg20Label"];
    PowerUpAmountsLabel *hg20Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg20Label2"];
    
    [hg20Label setPoints:hg20Label.number + 3];
    [hg20Label2 setPoints:hg20Label2.number + 3];
    
    ShopLogic *saveHG20 = [[ShopLogic alloc]init];
    [saveHG20 loadHG20Integer];
    
    PowerUpAmountsLabel *hg30Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg30Label"];
    PowerUpAmountsLabel *hg30Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg30Label2"];
    
    [hg30Label setPoints:hg30Label.number + 7];
    [hg30Label2 setPoints:hg30Label2.number + 7];
    
    ShopLogic *saveHG30 = [[ShopLogic alloc]init];
    [saveHG30 loadHG30Integer];
    
    PowerUpAmountsLabel *hs20Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs20Label"];
    PowerUpAmountsLabel *hs20Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs20Label2"];
    
    [hs20Label setPoints:hs20Label.number + 3];
    [hs20Label2 setPoints:hs20Label2.number + 3];
    
    ShopLogic *saveHS20 = [[ShopLogic alloc]init];
    [saveHS20 loadHS20Integer];
    
    PowerUpAmountsLabel *hs30Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs30Label"];
    PowerUpAmountsLabel *hs30Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs30Label2"];
    
    [hs30Label setPoints:hs30Label.number + 7];
    [hs30Label2 setPoints:hs30Label2.number + 7];
    
    ShopLogic *saveHS30 = [[ShopLogic alloc]init];
    [saveHS30 loadHS30Integer];
    
}
-(void)safePack {
    
    ShopLogic *SafePack = [[ShopLogic alloc]init];
    [SafePack buySafePack];
    
    PowerUpAmountsLabel *powerUpsLabel = (PowerUpAmountsLabel *)[self childNodeWithName:@"powerUpsLabel"];
    PowerUpAmountsLabel *powerUpsLabel2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"powerUpsLabel2"];
    
    [powerUpsLabel setPoints:powerUpsLabel.number + 7];
    [powerUpsLabel2 setPoints:powerUpsLabel2.number + 7];
    
    ShopLogic *saveDP = [[ShopLogic alloc]init];
    [saveDP loadDPInteger];
    
    PowerUpAmountsLabel *tpLabel = (PowerUpAmountsLabel *)[self childNodeWithName:@"tpLabel"];
    PowerUpAmountsLabel *tpLabel2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"tpLabel2"];
    
    [tpLabel setPoints:tpLabel.number + 3];
    [tpLabel2 setPoints:tpLabel2.number + 3];
    
    ShopLogic *saveTP = [[ShopLogic alloc]init];
    [saveTP loadTPInteger];
    
    PowerUpAmountsLabel *el1Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"el1Label"];
    PowerUpAmountsLabel *el1Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"el1Label2"];
    
    [el1Label setPoints:el1Label.number + 7];
    [el1Label2 setPoints:el1Label2.number + 7];
    
    ShopLogic *saveEL1 = [[ShopLogic alloc]init];
    [saveEL1 loadEL1Integer];
    
    PowerUpAmountsLabel *el2Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"el2Label"];
    PowerUpAmountsLabel *el2Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"el2Label2"];
    
    [el2Label setPoints:el2Label.number + 3];
    [el2Label2 setPoints:el2Label2.number + 3];
    
    PowerUpAmountsLabel *hg10Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg10Label"];
    PowerUpAmountsLabel *hg10Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg10Label2"];
    
    [hg10Label setPoints:hg10Label.number + 7];
    [hg10Label2 setPoints:hg10Label2.number + 7];
    
    ShopLogic *saveHG10 = [[ShopLogic alloc]init];
    [saveHG10 loadHG10Integer];
    
    PowerUpAmountsLabel *hg20Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg20Label"];
    PowerUpAmountsLabel *hg20Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg20Label2"];
    
    [hg20Label setPoints:hg20Label.number + 3];
    [hg20Label2 setPoints:hg20Label2.number + 3];
    
    ShopLogic *saveHG20 = [[ShopLogic alloc]init];
    [saveHG20 loadHG20Integer];
    
    PowerUpAmountsLabel *hs10Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs10Label"];
    PowerUpAmountsLabel *hs10Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs10Label2"];
    
    [hs10Label setPoints:hs10Label.number + 7];
    [hs10Label2 setPoints:hs10Label2.number + 7];
    
    ShopLogic *saveHS10 = [[ShopLogic alloc]init];
    [saveHS10 loadHS10Integer];
    
    PowerUpAmountsLabel *hs20Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs20Label"];
    PowerUpAmountsLabel *hs20Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs20Label2"];
    
    [hs20Label setPoints:hs20Label.number + 3];
    [hs20Label2 setPoints:hs20Label2.number + 3];
    
    ShopLogic *saveHS20 = [[ShopLogic alloc]init];
    [saveHS20 loadHS20Integer];
    
}
-(void)invinciblePack {
    
    ShopLogic *invinsiblePack = [[ShopLogic alloc]init];
    [invinsiblePack buyInvinsiblePack];
    
    PowerUpAmountsLabel *powerUpsLabel = (PowerUpAmountsLabel *)[self childNodeWithName:@"powerUpsLabel"];
    PowerUpAmountsLabel *powerUpsLabel2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"powerUpsLabel2"];
    
    [powerUpsLabel setPoints:powerUpsLabel.number + 3];
    [powerUpsLabel2 setPoints:powerUpsLabel2.number + 3];
    
    ShopLogic *saveDP = [[ShopLogic alloc]init];
    [saveDP loadDPInteger];
    
    PowerUpAmountsLabel *tpLabel = (PowerUpAmountsLabel *)[self childNodeWithName:@"tpLabel"];
    PowerUpAmountsLabel *tpLabel2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"tpLabel2"];
    
    [tpLabel setPoints:tpLabel.number + 7];
    [tpLabel2 setPoints:tpLabel2.number + 7];
    
    ShopLogic *saveTP = [[ShopLogic alloc]init];
    [saveTP loadTPInteger];
    
    PowerUpAmountsLabel *el1Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"el1Label"];
    PowerUpAmountsLabel *el1Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"el1Label2"];
    
    [el1Label setPoints:el1Label.number + 3];
    [el1Label2 setPoints:el1Label2.number + 3];
    
    ShopLogic *saveEL1 = [[ShopLogic alloc]init];
    [saveEL1 loadEL1Integer];
    
    PowerUpAmountsLabel *el2Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"el2Label"];
    PowerUpAmountsLabel *el2Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"el2Label2"];
    
    [el2Label setPoints:el2Label.number + 7];
    [el2Label2 setPoints:el2Label2.number + 7];
    
    PowerUpAmountsLabel *hg10Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg10Label"];
    PowerUpAmountsLabel *hg10Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg10Label2"];
    
    [hg10Label setPoints:hg10Label.number + 3];
    [hg10Label2 setPoints:hg10Label2.number + 3];
    
    ShopLogic *saveHG10 = [[ShopLogic alloc]init];
    [saveHG10 loadHG10Integer];
    
    PowerUpAmountsLabel *hg20Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg20Label"];
    PowerUpAmountsLabel *hg20Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hg20Label2"];
    
    [hg20Label setPoints:hg20Label.number + 7];
    [hg20Label2 setPoints:hg20Label2.number + 7];
    
    ShopLogic *saveHG20 = [[ShopLogic alloc]init];
    [saveHG20 loadHG20Integer];
    
    PowerUpAmountsLabel *hs10Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs10Label"];
    PowerUpAmountsLabel *hs10Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs10Label2"];
    
    [hs10Label setPoints:hs10Label.number + 3];
    [hs10Label2 setPoints:hs10Label2.number + 3];
    
    ShopLogic *saveHS10 = [[ShopLogic alloc]init];
    [saveHS10 loadHS10Integer];
    
    PowerUpAmountsLabel *hs20Label = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs20Label"];
    PowerUpAmountsLabel *hs20Label2 = (PowerUpAmountsLabel *)[self childNodeWithName:@"hs20Label2"];
    
    [hs20Label setPoints:hs20Label.number + 7];
    [hs20Label2 setPoints:hs20Label2.number + 7];
    
    ShopLogic *saveHS20 = [[ShopLogic alloc]init];
    [saveHS20 loadHS20Integer];
    
}
-(void)goToMainMenu {
    
    self.skView = (SKView *)self.view;
    [self.skView presentScene:nil];
    shopSprites = nil;
    // Create and configure the scene.
    MainMenu *Mainscene = [MainMenu sceneWithSize:self.skView.bounds.size];
    self.scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [self.skView presentScene:Mainscene];
    
}
-(void)handleNodesAtLocation:(CGPoint)location
{
    /*if a player constantly clicks the buy button then it will buy that object and the lable will go negative, fix this problem*/
    NSArray* nodes = [[self spriteLayer] nodesAtPoint:location];
    for(SKNode * node in nodes)
    {
        if ([[node name] isEqualToString:@"HomeButton"])
        {
            [clickSound play];
            [self goToMainMenu];
            NSLog(@"Home");
        }
        else if ([[node name] isEqualToString:@"PackageDeals"])
        {
            [clickSound play];
            [self pdScreen];
            NSLog(@"");
        }
        else if ([[node name] isEqualToString:@"BuyDoublePointsButton"])
        {
            [clickSound play];
            [self buy1DoublePoint];
            NSLog(@"");
        }
        else if ([[node name] isEqualToString:@"BuyTriplePointsButton"])
        {
            [clickSound play];
            [self buy1TriplePoint];
            NSLog(@"");
        }
        else if ([[node name] isEqualToString:@"BuyQuadPointsButton"])
        {
            [clickSound play];
            [self buy1QuadPoint];
            NSLog(@"");
        }
        else if ([[node name] isEqualToString:@"Buy1ExtraLivesButton"])
        {
            [clickSound play];
            [self buy1ExtraLife1];
        }
        else if ([[node name] isEqualToString:@"Buy2ExtraLivesButton"])
        {
            [clickSound play];
            [self buy1ExtraLife2];
        }
        else if ([[node name] isEqualToString:@"Buy3ExtraLivesButton"])
        {
            [clickSound play];
            [self buy1ExtraLife3];
        }
        else if ([[node name] isEqualToString:@"BuySpeedReduction10"])
        {
            [clickSound play];
            [self buy1HourGlass10];
        }
        else if ([[node name] isEqualToString:@"BuySpeedReduction20"])
        {
            [clickSound play];
            [self buy1HourGlass20];
        }
        else if ([[node name] isEqualToString:@"BuySpeedReduction30"])
        {
            [clickSound play];
            [self buy1HourGlass30];
        }
        else if ([[node name] isEqualToString:@"BuyHeadStart10Button"])
        {
            [clickSound play];
            [self buy1HeadStart10];
        }
        else if ([[node name] isEqualToString:@"BuyHeadStart20Button"])
        {
            [clickSound play];
            [self buy1HeadStart20];
        }
        else if ([[node name] isEqualToString:@"BuyHeadStart30Button"])
        {
            [clickSound play];
            [self buy1HeadStart30];
        }
        else if ([[node name] isEqualToString:@"Buy9K"])
        {
            [clickSound play];
            [self buy9kClick];
        }
        else if ([[node name] isEqualToString:@"Buy30K"])
        {
            [clickSound play];
            [self buy30kClick];
        }
        else if ([[node name] isEqualToString:@"Buy75K"])
        {
            [clickSound play];
            [self buy75kClick];
        }
        else if ([[node name] isEqualToString:@"Buy45K"])
        {
            [clickSound play];
            [self buy45kClick];
        }
        else if ([[node name] isEqualToString:@"Buy150K"])
        {
            [clickSound play];
            [self buy150kClick];
        }
        else if ([[node name] isEqualToString:@"Buy300K"])
        {
            [clickSound play];
            [self buy300kClick];
        }
        else if ([[node name] isEqualToString:@"PointsMultiplier"])
        {
            [clickSound play];
            [self pmScreen];
        }
        else if ([[node name] isEqualToString:@"SpeedReducer"])
        {
            [clickSound play];
            [self srScreen];
        }
        else if ([[node name] isEqualToString:@"ExtraLives"])
        {
            [clickSound play];
            [self elScreen];
        }
        else if ([[node name] isEqualToString:@"HeadStart"])
        {
            [clickSound play];
            [self hsScreen];
        }
        else if ([[node name] isEqualToString:@"FactoryBucksButton"])
        {
            [clickSound play];
            [self fbScreen];
        }
        else if ([[node name] isEqualToString:@"buySafePack"])
        {
            [clickSound play];
            [self buySafePackClick];
            
        }
        else if ([[node name] isEqualToString:@"buyInvisiblePack"])
        {
            [clickSound play];
            [self buyInvincibleModeClick];
            
        }
        else if ([[node name] isEqualToString:@"buyGodPack"])
        {
            [clickSound play];
            [self buyGodModePackClick];
            
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

- (void)buy9kClick{
    
    NSLog(@"User requests 9000 Factory Bucks");
    
    if([SKPaymentQueue canMakePayments]){
        NSLog(@"User can make payments");
        factoryBucks9kPurchased = YES;
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kAdd9kProductIdentifier]];
        productsRequest.delegate = self;
        [productsRequest start];
        
    }
    else{
        NSLog(@"User cannot make payments, enable in app purchases in settings");
        
    }
}
- (void)buy30kClick{
    NSLog(@"User requests 30000 Factory Bucks");
    
    if([SKPaymentQueue canMakePayments]){
        NSLog(@"User can make payments");
        factoryBucks30kPurchased = YES;
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kAdd30kProductIdentifier]];
        productsRequest.delegate = self;
        [productsRequest start];
        
    }
    else{
        NSLog(@"User cannot make payments");
        
    }
}
- (void)buy45kClick{
    NSLog(@"User requests 45000 Factory Bucks");
    
    if([SKPaymentQueue canMakePayments]){
        NSLog(@"User can make payments");
        factoryBucks45kPurchased = YES;
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kAdd45kProductIdentifier]];
        productsRequest.delegate = self;
        [productsRequest start];
        
    }
    else{
        NSLog(@"User cannot make payments");
        
    }
}
- (void)buy75kClick{
    NSLog(@"User requests 75000 Factory Bucks");
    
    if([SKPaymentQueue canMakePayments]){
        NSLog(@"User can make payments");
        factoryBucks75kPurchased = YES;
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kAdd75kProductIdentifier]];
        productsRequest.delegate = self;
        [productsRequest start];
        
    }
    else{
        NSLog(@"User cannot make payments");
        
    }
}
- (void)buy150kClick{
    NSLog(@"User requests 150000 Factory Bucks");
    
    if([SKPaymentQueue canMakePayments]){
        NSLog(@"User can make payments");
        factoryBucks150kPurchased = YES;
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kAdd150kProductIdentifier]];
        productsRequest.delegate = self;
        [productsRequest start];
        
    }
    else{
        NSLog(@"User cannot make payments");
        
    }
}
- (void)buy300kClick{
    NSLog(@"User requests 300000 Factory Bucks");
    
    if([SKPaymentQueue canMakePayments]){
        NSLog(@"User can make payments");
        factoryBucks300kPurchased = YES;
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kAdd300kProductIdentifier]];
        productsRequest.delegate = self;
        [productsRequest start];
        
    }
    else{
        NSLog(@"User cannot make payments");
        
    }
}
- (void)buyClockRefillClick{
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
- (void)buyGodModePackClick{
    NSLog(@"User requests God Mode Pack");
    
    if([SKPaymentQueue canMakePayments]){
        NSLog(@"User can make payments");
        godModePackPurchased = YES;
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kAddGodModePackProductIdentifier]];
        productsRequest.delegate = self;
        [productsRequest start];
        
    }
    else{
        NSLog(@"User cannot make payments");
        
    }
}
- (void)buyHelpClick{
    NSLog(@"User requests Help");
    
    if([SKPaymentQueue canMakePayments]){
        NSLog(@"User can make payments");
        helpPurchased = YES;
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kAddHelpProductIdentifier]];
        productsRequest.delegate = self;
        [productsRequest start];
        
    }
    else{
        NSLog(@"User cannot make payments");
        
    }
}
- (void)buyInvincibleModeClick{
    NSLog(@"User requests Invincible Mode Pack");
    
    if([SKPaymentQueue canMakePayments]){
        NSLog(@"User can make payments");
        invincibleModePurchased = YES;
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kAddInvinciblePackProductIdentifier]];
        productsRequest.delegate = self;
        [productsRequest start];
        
    }
    else{
        NSLog(@"User cannot make payments");
        
    }
}
- (void)buyRefillLivesClick{
    NSLog(@"User requests 10 Lives");
    
    if([SKPaymentQueue canMakePayments]){
        NSLog(@"User can make payments");
        refillLivesPurchased = YES;
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kAddRefillLivesProductIdentifier]];
        productsRequest.delegate = self;
        [productsRequest start];
        
    }
    else{
        NSLog(@"User cannot make payments");
        
    }
}
- (void)buyRetryFromLossClick{
    NSLog(@"User requests retry From Loss");
    
    if([SKPaymentQueue canMakePayments]){
        NSLog(@"User can make payments");
        retryFromLossPurchased = YES;
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kAddRetryFromLossProductIdentifier]];
        productsRequest.delegate = self;
        [productsRequest start];
        
    }
    else{
        NSLog(@"User cannot make payments");
        
    }
}
- (void)buyRetryPlus10Click{
    NSLog(@"User requests retry From Loss Plus 10 Lives");
    
    if([SKPaymentQueue canMakePayments]){
        NSLog(@"User can make payments");
        retryPlus10Purchased = YES;
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kAddRetryPlus10ProductIdentifier]];
        productsRequest.delegate = self;
        [productsRequest start];
        
    }
    else{
        NSLog(@"User cannot make payments");
        
    }
}
- (void)buyReviveClick{
    NSLog(@"User requests revive");
    
    if([SKPaymentQueue canMakePayments]){
        NSLog(@"User can make payments");
        revivePurchased = YES;
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kAddReviveProductIdentifier]];
        productsRequest.delegate = self;
        [productsRequest start];
        
    }
    else{
        NSLog(@"User cannot make payments");
        
    }
}
- (void)buySafePackClick{
    NSLog(@"User requests safe pack");
    
    if([SKPaymentQueue canMakePayments]){
        NSLog(@"User can make payments");
        safePackPurchased = YES;
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kAddSafePackProductIdentifier]];
        productsRequest.delegate = self;
        [productsRequest start];
        
    }
    else{
        NSLog(@"User cannot make payments");
        
    }
}
- (void)buyUpgradeLivesClick{
    NSLog(@"User requests 10 Lives");
    
    if([SKPaymentQueue canMakePayments]){
        NSLog(@"User can make payments");
        upgradeLivesPurchased = YES;
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kAddUpgradeLivesProductIdentifier]];
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
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    for(SKPaymentTransaction *transaction in transactions){
        switch(transaction.transactionState){
            case SKPaymentTransactionStatePurchasing: NSLog(@"Transaction state -> Purchasing");
                //called when the user is in the process of purchasing, do not add any of your own code here.
                break;
            case SKPaymentTransactionStatePurchased:
                //this is called when the user has successfully purchased the package (Cha-Ching!)
                if (factoryBucks9kPurchased == YES) {
                    [self performSelector:@selector(increment9000) withObject:self afterDelay:0.5];
                    factoryBucks9kPurchased = NO;
                }
                if (factoryBucks30kPurchased == YES) {
                    [self performSelector:@selector(increment30000) withObject:self afterDelay:0.5];
                    factoryBucks30kPurchased = NO;
                }
                if (factoryBucks45kPurchased == YES) {
                    [self performSelector:@selector(increment45000) withObject:self afterDelay:0.5];
                    factoryBucks45kPurchased = NO;
                }
                if (factoryBucks75kPurchased == YES) {
                    [self performSelector:@selector(increment75000) withObject:self afterDelay:0.5];
                    factoryBucks75kPurchased = NO;
                }
                if (factoryBucks150kPurchased == YES) {
                    [self performSelector:@selector(increment150000) withObject:self afterDelay:0.5];
                    factoryBucks150kPurchased = NO;
                }
                if (factoryBucks300kPurchased == YES) {
                    [self performSelector:@selector(increment300000) withObject:self afterDelay:0.5];
                    factoryBucks300kPurchased = NO;
                }
                if (godModePackPurchased == YES) {
                    [self performSelector:@selector(godModePack) withObject:self afterDelay:0.5];
                    godModePackPurchased = NO;
                }
                if (invincibleModePurchased == YES) {
                    [self performSelector:@selector(invinciblePack) withObject:self afterDelay:0.5];
                    invincibleModePurchased = NO;
                }
                if (safePackPurchased == YES) {
                    [self performSelector:@selector(safePack) withObject:self afterDelay:0.5];
                    safePackPurchased = NO;
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
                    NSLog(@"%@", transaction.error);
                    //the user cancelled the payment ;(
                }
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            default:
                break;
        }
    }
}
@end
