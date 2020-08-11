//
//  GameViewController.h
//  Factory Fall
//

//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>
#import <StoreKit/StoreKit.h>

SKTextureAtlas *mainMenuSprites;
SKTextureAtlas *settingsSprites;
SKTextureAtlas *buttonSprites;
AVAudioPlayer *audioPlayer1;
SKAudioNode *themeMus;
NSString *music;

BOOL showLabel;
BOOL justOpened;
int s;
NSInteger timesOpened;
BOOL reggyBotDefeated;
BOOL showTutorial;

//In App Purchase Bool Values

BOOL factoryBucks9kPurchased;
BOOL factoryBucks30kPurchased;
BOOL factoryBucks45kPurchased;
BOOL factoryBucks75kPurchased;
BOOL factoryBucks150kPurchased;
BOOL factoryBucks300kPurchased;
BOOL clockRefillPurchased;
BOOL godModePackPurchased;
BOOL helpPurchased;
BOOL invincibleModePurchased;
BOOL refillLivesPurchased;
BOOL retryFromLossPurchased;
BOOL retryPlus10Purchased;
BOOL revivePurchased;
BOOL safePackPurchased;
BOOL upgradeLivesPurchased;

BOOL playValue;


typedef NS_ENUM(NSInteger, thisDeviceClass) {
    
    thisDeviceClass_iPhone,
    thisDeviceClass_iPhoneRetina,
    thisDeviceClass_iPhone5,
    thisDeviceClass_iPhone6,
    thisDeviceClass_iPhone6plus,
    
    // we can add new devices when we become aware of them
    
    thisDeviceClass_iPad,
    thisDeviceClass_iPadRetina,
    
    
    thisDeviceClass_unknown
};

thisDeviceClass currentDeviceClass();

@interface UIImage (DeviceSpecificMedia)

+ (instancetype )imageForDeviceWithName:(NSString *)fileName;

@end
@interface GameViewController : UIViewController <UITextFieldDelegate, AVAudioPlayerDelegate> {
    IBOutlet UITextField *Label;
    //AVAudioPlayer *audioPlayer1;
    AVAudioPlayer *phrase;
    SKAction *musicAct;
}
-(void)musicValue;
//-(void)playTheme;
//@property (weak, nonatomic) IBOutlet UIImageView * logoBackground;
//@property (weak, nonatomic) IBOutlet UIImageView * logoFluxFire;
//@property (weak, nonatomic) IBOutlet UIImageView * logoLoad;
//@property (weak, nonatomic) IBOutlet UIImageView * logoText;
//@property (nonatomic, strong) SKTextureAtlas *mainMenuSprites;
//@property (nonatomic, strong) SKTextureAtlas *arcadeSpritesOne;
//@property (nonatomic, strong) SKTextureAtlas *arcadeSpritesTwo;
//@property (nonatomic, strong) SKTextureAtlas *arcadeSpritesThree;
//@property (nonatomic, strong) SKTextureAtlas *settingsSprites;
@property (nonatomic, retain) AVAudioPlayer *audioPlayer1;

//-(void)firePop;

@end
