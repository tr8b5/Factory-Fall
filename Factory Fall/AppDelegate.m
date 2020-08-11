//
//  AppDelegate.m
//  Factory Fall
//
//  Created by Willie on 1/10/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import "AppDelegate.h"
#import "Settings.h"
#import "ArcadeMenu.h"
#import "RankLogic.h"
#import "GameViewController.h"

@interface AppDelegate ()
@property (strong, nonatomic) ArcadeMenu *FFArcade;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /*themeMus = [[SKAudioNode alloc] initWithFileNamed:@"WilliamCelebration.mp3"];
    themeMus.autoplayLooped = true;
    [themeMus runAction:[SKAction play]];*/
    
    //Settings *onoroff = [[Settings alloc]init];
    //[onoroff loadSoundOnOrOff];
    //[self addChild:themeMus];
    
    
    /*music = [[NSBundle mainBundle]pathForResource:@"WilliamCelebration" ofType:@"mp3"];
    audioPlayer1 = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:music]  error:NULL];
    audioPlayer1.delegate = self;
    audioPlayer1.numberOfLoops = -1;
    audioPlayer1.volume = 0.1;
    [audioPlayer1 play];
    [audioPlayer1 pause];*/
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    
   /* NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    canPlay = [defaults boolForKey:@"canPlay"];
    
    if (canPlay == NO) {
        ArcadeMenu *updateTimer = [[ArcadeMenu alloc]init];
        [updateTimer showTimerCheck];
    }*/
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    
   /* NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    canPlay = [defaults boolForKey:@"canPlay"];
    
    if (canPlay == NO) {
        ArcadeMenu *updateTimer = [[ArcadeMenu alloc]init];
        [updateTimer showTimerCheck];
    }*/
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
@end
