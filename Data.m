//
//  Data.m
//  Factory Fall
//
//  Created by Willie on 8/7/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import "Data.h"
#import "ShopLogic.h"
#import "RankLogic.h"

@implementation Data


-(void)loadAmountFB {
    
    amountFB = [[NSUserDefaults standardUserDefaults] integerForKey:@"amountFB"];
    NSLog(@"FactoryBucks:" @"%ld", (long)amountFB);
    
}
-(void)saveAmountFB {
    
    amountFBData = [NSUserDefaults standardUserDefaults];
    [amountFBData setInteger:amountFB forKey:@"amountFB"];
    [amountFBData synchronize];
    
}

-(void)saveTopScore {
    
    if (rankNumber == 0 || rankNumber == 1 || rankNumber == 2) {
        
        highScore1 = scoreInput;
        
    NSUserDefaults *highScoreData = [NSUserDefaults standardUserDefaults];
    [highScoreData setInteger:highScore1 forKey:@"highScore1"];
    [highScoreData synchronize];
        NSLog(@"SavedHighScore:" @"%ld", (long)highScore1);
    }
    if (rankNumber == 3 || rankNumber == 4 || rankNumber == 5) {
        
        highScore2 = scoreInput;
        
        NSUserDefaults *highScoreData = [NSUserDefaults standardUserDefaults];
        [highScoreData setInteger:highScore2 forKey:@"highScore2"];
        [highScoreData synchronize];
        NSLog(@"SavedHighScore:" @"%ld", (long)highScore2);
        
    }
    if (rankNumber == 6 || rankNumber == 7 || rankNumber == 8) {
        
        highScore3 = scoreInput;
        
        NSUserDefaults *highScoreData = [NSUserDefaults standardUserDefaults];
        [highScoreData setInteger:highScore3 forKey:@"highScore3"];
        [highScoreData synchronize];
        NSLog(@"SavedHighScore:" @"%ld", (long)highScore3);
        
    }
    if (rankNumber == 9 || rankNumber == 10 || rankNumber == 11) {
        
        highScore4 = scoreInput;
        
        NSUserDefaults *highScoreData = [NSUserDefaults standardUserDefaults];
        [highScoreData setInteger:highScore4 forKey:@"highScore4"];
        [highScoreData synchronize];
        NSLog(@"SavedHighScore:" @"%ld", (long)highScore4);
        
    }
    if (rankNumber == 12 || rankNumber == 13 || rankNumber == 14) {
        
        highScore5 = scoreInput;
        
        NSUserDefaults *highScoreData = [NSUserDefaults standardUserDefaults];
        [highScoreData setInteger:highScore5 forKey:@"highScore5"];
        [highScoreData synchronize];
        NSLog(@"SavedHighScore:" @"%ld", (long)highScore5);
        
    }
    if (rankNumber == 15 || rankNumber == 16 || rankNumber == 17) {
        
        highScore6 = scoreInput;
        
        NSUserDefaults *highScoreData = [NSUserDefaults standardUserDefaults];
        [highScoreData setInteger:highScore6 forKey:@"highScore6"];
        [highScoreData synchronize];
        NSLog(@"SavedHighScore:" @"%ld", (long)highScore6);
        
    }
    if (rankNumber == 18 || rankNumber == 19 || rankNumber == 20) {
        
        highScore7 = scoreInput;
        
        NSUserDefaults *highScoreData = [NSUserDefaults standardUserDefaults];
        [highScoreData setInteger:highScore7 forKey:@"highScore7"];
        [highScoreData synchronize];
        NSLog(@"SavedHighScore:" @"%ld", (long)highScore7);
        
    }
    if (rankNumber == 21 || rankNumber == 22 || rankNumber == 23) {
        
        highScore8 = scoreInput;
        
        NSUserDefaults *highScoreData = [NSUserDefaults standardUserDefaults];
        [highScoreData setInteger:highScore8 forKey:@"highScore8"];
        [highScoreData synchronize];
        NSLog(@"SavedHighScore:" @"%ld", (long)highScore8);
        
    }
    if (rankNumber == 24 || rankNumber == 25 || rankNumber == 26) {
        
        highScore9 = scoreInput;
        
        NSUserDefaults *highScoreData = [NSUserDefaults standardUserDefaults];
        [highScoreData setInteger:highScore9 forKey:@"highScore9"];
        [highScoreData synchronize];
        NSLog(@"SavedHighScore:" @"%ld", (long)highScore9);
        
    }
    
}
-(void)loadTopScore {
    
    if (rankNumber == 0 || rankNumber == 1 || rankNumber == 2) {
        
    NSUserDefaults *highScoreData = [NSUserDefaults standardUserDefaults];
    highScore1 = [highScoreData integerForKey:@"highScore1"];
    NSLog(@"LoadedHighScore:" @"%ld", (long)highScore1);
        
        scoreInput = highScore1;
        
    }
    if (rankNumber == 3 || rankNumber == 4 || rankNumber == 5) {
        
        NSUserDefaults *highScoreData = [NSUserDefaults standardUserDefaults];
        highScore2 = [highScoreData integerForKey:@"highScore2"];
        NSLog(@"LoadedHighScore:" @"%ld", (long)highScore2);
        
        scoreInput = highScore2;
        
    }
    if (rankNumber == 6 || rankNumber == 7 || rankNumber == 8) {
        
        NSUserDefaults *highScoreData = [NSUserDefaults standardUserDefaults];
        highScore3 = [highScoreData integerForKey:@"highScore3"];
        NSLog(@"LoadedHighScore:" @"%ld", (long)highScore3);
        
        scoreInput = highScore3;
        
    }
    if (rankNumber == 9 || rankNumber == 10 || rankNumber == 11) {
        
        NSUserDefaults *highScoreData = [NSUserDefaults standardUserDefaults];
        highScore4 = [highScoreData integerForKey:@"highScore4"];
        NSLog(@"LoadedHighScore:" @"%ld", (long)highScore4);
        
        scoreInput = highScore4;
        
    }
    if (rankNumber == 12 || rankNumber == 13 || rankNumber == 14) {
        
        NSUserDefaults *highScoreData = [NSUserDefaults standardUserDefaults];
        highScore5 = [highScoreData integerForKey:@"highScore5"];
        NSLog(@"LoadedHighScore:" @"%ld", (long)highScore5);
        
        scoreInput = highScore5;
        
    }
    if (rankNumber == 15 || rankNumber == 16 || rankNumber == 17) {
        
        NSUserDefaults *highScoreData = [NSUserDefaults standardUserDefaults];
        highScore6 = [highScoreData integerForKey:@"highScore6"];
        NSLog(@"LoadedHighScore:" @"%ld", (long)highScore6);
        
        scoreInput = highScore6;
        
    }
    if (rankNumber == 18 || rankNumber == 19 || rankNumber == 20) {
        
        NSUserDefaults *highScoreData = [NSUserDefaults standardUserDefaults];
        highScore7 = [highScoreData integerForKey:@"highScore7"];
        NSLog(@"LoadedHighScore:" @"%ld", (long)highScore7);
        
        scoreInput = highScore7;
        
    }
    if (rankNumber == 21 || rankNumber == 22 || rankNumber == 23) {
        
        NSUserDefaults *highScoreData = [NSUserDefaults standardUserDefaults];
        highScore8 = [highScoreData integerForKey:@"highScore8"];
        NSLog(@"LoadedHighScore:" @"%ld", (long)highScore8);
        
        scoreInput = highScore8;
        
    }
    if (rankNumber == 24 || rankNumber == 25 || rankNumber == 26) {
        
        NSUserDefaults *highScoreData = [NSUserDefaults standardUserDefaults];
        highScore9 = [highScoreData integerForKey:@"highScore9"];
        NSLog(@"LoadedHighScore:" @"%ld", (long)highScore9);
        
        scoreInput = highScore9;
        
    }
    
}

@end
