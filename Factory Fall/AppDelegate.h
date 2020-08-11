//
//  AppDelegate.h
//  Factory Fall
//
//  Created by Willie on 1/10/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <SpriteKit/SpriteKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate, AVAudioPlayerDelegate> {
    
    AVAudioPlayer *audioPlayer1;
    //SKTextureAtlas *mainMenuSprites;
    //SKTextureAtlas *arcadeSpritesOne;
    //SKTextureAtlas *arcadeSpritesTwo;
    //SKTextureAtlas *arcadeSpritesThree;
    //SKTextureAtlas *settingsSprites;
}

@property (strong, nonatomic) UIWindow *window;


@end

