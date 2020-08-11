//
//  RankLogic.m
//  Factory Fall
//
//  Created by Willie on 3/1/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import "RankLogic.h"
#import "GameScene.h"
#import "LoadingScreen.h"
#import "ArcadeMenu.h"
#import "GameViewController.h"

@implementation RankLogic

-(void)currentRank {
    
     NSLog(@"rankNumberRL:" @"%ld", (long)rankNumber);
    
}
-(void)saveCurrentRank {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:rankNumber forKey:@"rankNumber"];
    [defaults synchronize];
}
-(void)loadCurrentRank {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    rankNumber = [defaults integerForKey:@"rankNumber"];
    
}
-(void)incrementby1 {
    
    rankNumber += 1;
    [self saveCurrentRank];
    [self loadCurrentRank];
    NSLog(@"RankNumber+:" @"%ld", (long)rankNumber);
}
-(void)decrementby1 {
    
    rankNumber -= 1;
    [self saveCurrentRank];
    [self loadCurrentRank];
    NSLog(@"RankNumber-:" @"%ld", (long)rankNumber);
}

-(void)currentGame {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL timer = [defaults boolForKey:@"timer"];
    NSDate *expirationCheck = [defaults objectForKey:@"expirationDate"];
    
    if (currentGameNumber <= 4 & maxPlaysLvl == 0) {
        canPlay = YES;
    }
    if (currentGameNumber <= 9 & maxPlaysLvl == 1) {
        canPlay = YES;
    }
    if (currentGameNumber > 4 & maxPlaysLvl == 0) {
        canPlay = NO;
    }
    if (currentGameNumber > 9 & maxPlaysLvl == 1) {
        canPlay = NO;
    }
    if ((timer) & (canPlay == NO)) {
        NSDate *todaysDate = [NSDate date];
        NSComparisonResult result = [todaysDate compare:expirationCheck];
        
        if (result == NSOrderedAscending) {
            canPlay = NO;
        }
        else if (result == NSOrderedDescending) {
            [self resetCurrentGameNumber];
            canPlay = YES;
        }
    }
    [defaults setBool:canPlay forKey:@"canPlay"];
    [defaults synchronize];
    
    canPlay = [defaults boolForKey:@"canPlay"];
    
    NSLog(canPlay? @"YES" : @"NO");
    
    NSLog(@"CurrentGameNumberRL:" @"%ld", (long)currentGameNumber);
}
-(void)resetCurrentGameNumber {
    currentGameNumber = 0;
    [self saveCurrentGameNumber];
    [self loadCurrentGameNumber];
    helpActivated = NO;
    [self saveHelpActivated];
    
}
-(void)saveCurrentGameNumber {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:currentGameNumber forKey:@"currentGameNumber"];
    [defaults synchronize];
}
-(void)loadCurrentGameNumber {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    currentGameNumber = [defaults integerForKey:@"currentGameNumber"];
}
-(void)increment1 {
    
    [self loadCurrentGameNumber];
    currentGameNumber += 1;
    [self saveCurrentGameNumber];
    
}
-(void)decrement1 {
    
    [self loadCurrentGameNumber];
    currentGameNumber -= 1;
    [self saveCurrentGameNumber];
    
}
-(void)saveCurrentMaxPlaysLvl {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:maxPlaysLvl forKey:@"maxPlaysLvl"];
    [defaults synchronize];
}
-(void)loadCurrentMaxPlaysLvl {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    maxPlaysLvl = [defaults integerForKey:@"maxPlaysLvl"];
}

-(void)incrementMaxPlays {
    [self loadCurrentMaxPlaysLvl];
    maxPlaysLvl = 1;
    currentGameNumber = 0;
    [self saveCurrentMaxPlaysLvl];
    
    [self saveCurrentGameNumber];
    [self loadCurrentGameNumber];
    helpActivated = NO;
    [self saveHelpActivated];
}
-(void)payCheckSave {
    
    NSUserDefaults *defaults500 = [NSUserDefaults standardUserDefaults];
    [defaults500 setBool:pay500 forKey:@"pay500"];
    [defaults500 synchronize];
    
    NSUserDefaults *defaults750 = [NSUserDefaults standardUserDefaults];
    [defaults750 setBool:pay750 forKey:@"pay750"];
    [defaults750 synchronize];
    
    NSUserDefaults *defaults1000 = [NSUserDefaults standardUserDefaults];
    [defaults1000 setBool:pay1000 forKey:@"pay1000"];
    [defaults1000 synchronize];
    
    NSUserDefaults *defaults2000 = [NSUserDefaults standardUserDefaults];
    [defaults2000 setBool:pay2000 forKey:@"pay2000"];
    [defaults2000 synchronize];
    
    NSUserDefaults *defaults3000 = [NSUserDefaults standardUserDefaults];
    [defaults3000 setBool:pay3000 forKey:@"pay3000"];
    [defaults3000 synchronize];
    
    NSUserDefaults *defaults4000 = [NSUserDefaults standardUserDefaults];
    [defaults4000 setBool:pay4000 forKey:@"pay4000"];
    [defaults4000 synchronize];
    
    NSUserDefaults *defaults5000 = [NSUserDefaults standardUserDefaults];
    [defaults5000 setBool:pay5000 forKey:@"pay5000"];
    [defaults5000 synchronize];
    
    NSUserDefaults *defaults6000 = [NSUserDefaults standardUserDefaults];
    [defaults6000 setBool:pay6000 forKey:@"pay6000"];
    [defaults6000 synchronize];
    
    NSUserDefaults *defaults7000 = [NSUserDefaults standardUserDefaults];
    [defaults7000 setBool:pay7000 forKey:@"pay7000"];
    [defaults7000 synchronize];
    
    NSUserDefaults *defaults8000 = [NSUserDefaults standardUserDefaults];
    [defaults8000 setBool:pay8000 forKey:@"pay8000"];
    [defaults8000 synchronize];
    
    NSUserDefaults *defaults9000 = [NSUserDefaults standardUserDefaults];
    [defaults9000 setBool:pay9000 forKey:@"pay9000"];
    [defaults9000 synchronize];
}
-(void)payCheckLoad {
    
    NSUserDefaults *defaults500 = [NSUserDefaults standardUserDefaults];
    pay500 = [defaults500 boolForKey:@"pay500"];
    
    NSUserDefaults *defaults750 = [NSUserDefaults standardUserDefaults];
    pay750 = [defaults750 boolForKey:@"pay750"];
    
    NSUserDefaults *defaults1000 = [NSUserDefaults standardUserDefaults];
    pay1000 = [defaults1000 boolForKey:@"pay1000"];
    
    NSUserDefaults *defaults2000 = [NSUserDefaults standardUserDefaults];
    pay2000 = [defaults2000 boolForKey:@"pay2000"];
    
    NSUserDefaults *defaults3000 = [NSUserDefaults standardUserDefaults];
    pay3000 = [defaults3000 boolForKey:@"pay3000"];
    
    NSUserDefaults *defaults4000 = [NSUserDefaults standardUserDefaults];
    pay4000 = [defaults4000 boolForKey:@"pay4000"];
    
    NSUserDefaults *defaults5000 = [NSUserDefaults standardUserDefaults];
    pay5000 = [defaults5000 boolForKey:@"pay5000"];
    
    NSUserDefaults *defaults6000 = [NSUserDefaults standardUserDefaults];
    pay6000 = [defaults6000 boolForKey:@"pay6000"];
    
    NSUserDefaults *defaults7000 = [NSUserDefaults standardUserDefaults];
    pay7000 = [defaults7000 boolForKey:@"pay7000"];
    
    NSUserDefaults *defaults8000 = [NSUserDefaults standardUserDefaults];
    pay8000 = [defaults8000 boolForKey:@"pay8000"];
    
    NSUserDefaults *defaults9000 = [NSUserDefaults standardUserDefaults];
    pay9000 = [defaults9000 boolForKey:@"pay9000"];
    
}
-(void)saveRankValues {
    
    NSUserDefaults *defaultsB0 = [NSUserDefaults standardUserDefaults];
    [defaultsB0 setBool:bronze101 forKey:@"bronze101"];
    [defaultsB0 synchronize];
    
    NSUserDefaults *defaultsB1 = [NSUserDefaults standardUserDefaults];
    [defaultsB1 setBool:bronze102 forKey:@"bronze102"];
    [defaultsB1 synchronize];
    
    NSUserDefaults *defaultsB2 = [NSUserDefaults standardUserDefaults];
    [defaultsB2 setBool:bronze103 forKey:@"bronze103"];
    [defaultsB2 synchronize];
    
    NSUserDefaults *defaultsB3 = [NSUserDefaults standardUserDefaults];
    [defaultsB3 setBool:bronze201 forKey:@"bronze201"];
    [defaultsB3 synchronize];
    
    NSUserDefaults *defaultsB4 = [NSUserDefaults standardUserDefaults];
    [defaultsB4 setBool:bronze202 forKey:@"bronze202"];
    [defaultsB4 synchronize];
    
    NSUserDefaults *defaultsB5 = [NSUserDefaults standardUserDefaults];
    [defaultsB5 setBool:bronze203 forKey:@"bronze203"];
    [defaultsB5 synchronize];
    
    NSUserDefaults *defaultsB6 = [NSUserDefaults standardUserDefaults];
    [defaultsB6 setBool:bronze301 forKey:@"bronze301"];
    [defaultsB6 synchronize];
    
    NSUserDefaults *defaultsB7 = [NSUserDefaults standardUserDefaults];
    [defaultsB7 setBool:bronze302 forKey:@"bronze302"];
    [defaultsB7 synchronize];
    
    NSUserDefaults *defaultsB8 = [NSUserDefaults standardUserDefaults];
    [defaultsB8 setBool:bronze303 forKey:@"bronze303"];
    [defaultsB8 synchronize];
    
    NSUserDefaults *defaultsB9 = [NSUserDefaults standardUserDefaults];
    [defaultsB9 setBool:bronze401 forKey:@"bronze401"];
    [defaultsB9 synchronize];
    
    NSUserDefaults *defaultsB10 = [NSUserDefaults standardUserDefaults];
    [defaultsB10 setBool:bronze402 forKey:@"bronze402"];
    [defaultsB10 synchronize];
    
    NSUserDefaults *defaultsB11 = [NSUserDefaults standardUserDefaults];
    [defaultsB11 setBool:bronze403 forKey:@"bronze403"];
    [defaultsB11 synchronize];
    
    NSUserDefaults *defaultsB12 = [NSUserDefaults standardUserDefaults];
    [defaultsB12 setBool:bronze501 forKey:@"bronze501"];
    [defaultsB12 synchronize];
    
    NSUserDefaults *defaultsB13 = [NSUserDefaults standardUserDefaults];
    [defaultsB13 setBool:bronze502 forKey:@"bronze502"];
    [defaultsB13 synchronize];
    
    NSUserDefaults *defaultsB14 = [NSUserDefaults standardUserDefaults];
    [defaultsB14 setBool:bronze503 forKey:@"bronze503"];
    [defaultsB14 synchronize];
    
    NSUserDefaults *defaultsB15 = [NSUserDefaults standardUserDefaults];
    [defaultsB15 setBool:bronze601 forKey:@"bronze601"];
    [defaultsB15 synchronize];
    
    NSUserDefaults *defaultsB16 = [NSUserDefaults standardUserDefaults];
    [defaultsB16 setBool:bronze602 forKey:@"bronze602"];
    [defaultsB16 synchronize];
    
    NSUserDefaults *defaultsB17 = [NSUserDefaults standardUserDefaults];
    [defaultsB17 setBool:bronze603 forKey:@"bronze603"];
    [defaultsB17 synchronize];
    
    NSUserDefaults *defaultsB18 = [NSUserDefaults standardUserDefaults];
    [defaultsB18 setBool:bronze701 forKey:@"bronze701"];
    [defaultsB18 synchronize];
    
    NSUserDefaults *defaultsB19 = [NSUserDefaults standardUserDefaults];
    [defaultsB19 setBool:bronze702 forKey:@"bronze702"];
    [defaultsB19 synchronize];
    
    NSUserDefaults *defaultsB20 = [NSUserDefaults standardUserDefaults];
    [defaultsB20 setBool:bronze703 forKey:@"bronze703"];
    [defaultsB20 synchronize];
    
    NSUserDefaults *defaultsB21 = [NSUserDefaults standardUserDefaults];
    [defaultsB21 setBool:bronze801 forKey:@"bronze801"];
    [defaultsB21 synchronize];
    
    NSUserDefaults *defaultsB22 = [NSUserDefaults standardUserDefaults];
    [defaultsB22 setBool:bronze802 forKey:@"bronze802"];
    [defaultsB22 synchronize];
    
    NSUserDefaults *defaultsB23 = [NSUserDefaults standardUserDefaults];
    [defaultsB23 setBool:bronze803 forKey:@"bronze803"];
    [defaultsB23 synchronize];
    
    NSUserDefaults *defaultsB24 = [NSUserDefaults standardUserDefaults];
    [defaultsB24 setBool:bronze901 forKey:@"bronze901"];
    [defaultsB24 synchronize];
    
    NSUserDefaults *defaultsB25 = [NSUserDefaults standardUserDefaults];
    [defaultsB25 setBool:bronze902 forKey:@"bronze902"];
    [defaultsB25 synchronize];
    
    NSUserDefaults *defaultsB26 = [NSUserDefaults standardUserDefaults];
    [defaultsB26 setBool:bronze903 forKey:@"bronze903"];
    [defaultsB26 synchronize];
    
    NSUserDefaults *defaultsB27 = [NSUserDefaults standardUserDefaults];
    [defaultsB27 setBool:bronze1001 forKey:@"bronze1001"];
    [defaultsB27 synchronize];
    
    NSUserDefaults *defaultsB28 = [NSUserDefaults standardUserDefaults];
    [defaultsB28 setBool:bronze1002 forKey:@"bronze1002"];
    [defaultsB28 synchronize];
    
    NSUserDefaults *defaultsB29 = [NSUserDefaults standardUserDefaults];
    [defaultsB29 setBool:bronze1003 forKey:@"bronze1003"];
    [defaultsB29 synchronize];
    
    
    
    
    NSUserDefaults *defaultsS0 = [NSUserDefaults standardUserDefaults];
    [defaultsS0 setBool:silver101 forKey:@"silver101"];
    [defaultsS0 synchronize];
    
    NSUserDefaults *defaultsS1 = [NSUserDefaults standardUserDefaults];
    [defaultsS1 setBool:silver102 forKey:@"silver102"];
    [defaultsS1 synchronize];
    
    NSUserDefaults *defaultsS2 = [NSUserDefaults standardUserDefaults];
    [defaultsS2 setBool:silver103 forKey:@"silver103"];
    [defaultsS2 synchronize];
    
    NSUserDefaults *defaultsS3 = [NSUserDefaults standardUserDefaults];
    [defaultsS3 setBool:silver201 forKey:@"silver201"];
    [defaultsS3 synchronize];
    
    NSUserDefaults *defaultsS4 = [NSUserDefaults standardUserDefaults];
    [defaultsS4 setBool:silver202 forKey:@"silver202"];
    [defaultsS4 synchronize];
    
    NSUserDefaults *defaultsS5 = [NSUserDefaults standardUserDefaults];
    [defaultsS5 setBool:silver203 forKey:@"silver203"];
    [defaultsS5 synchronize];
    
    NSUserDefaults *defaultsS6 = [NSUserDefaults standardUserDefaults];
    [defaultsS6 setBool:silver301 forKey:@"silver301"];
    [defaultsS6 synchronize];
    
    NSUserDefaults *defaultsS7 = [NSUserDefaults standardUserDefaults];
    [defaultsS7 setBool:silver302 forKey:@"silver302"];
    [defaultsS7 synchronize];
    
    NSUserDefaults *defaultsS8 = [NSUserDefaults standardUserDefaults];
    [defaultsS8 setBool:silver303 forKey:@"silver303"];
    [defaultsS8 synchronize];
    
    NSUserDefaults *defaultsS9 = [NSUserDefaults standardUserDefaults];
    [defaultsS9 setBool:silver401 forKey:@"silver401"];
    [defaultsS9 synchronize];
    
    NSUserDefaults *defaultsS10 = [NSUserDefaults standardUserDefaults];
    [defaultsS10 setBool:silver402 forKey:@"silver402"];
    [defaultsS10 synchronize];
    
    NSUserDefaults *defaultsS11 = [NSUserDefaults standardUserDefaults];
    [defaultsS11 setBool:silver403 forKey:@"silver403"];
    [defaultsS11 synchronize];
    
    NSUserDefaults *defaultsS12 = [NSUserDefaults standardUserDefaults];
    [defaultsS12 setBool:silver501 forKey:@"silver501"];
    [defaultsS12 synchronize];
    
    NSUserDefaults *defaultsS13 = [NSUserDefaults standardUserDefaults];
    [defaultsS13 setBool:silver502 forKey:@"silver502"];
    [defaultsS13 synchronize];
    
    NSUserDefaults *defaultsS14 = [NSUserDefaults standardUserDefaults];
    [defaultsS14 setBool:silver503 forKey:@"silver503"];
    [defaultsS14 synchronize];
    
    NSUserDefaults *defaultsS15 = [NSUserDefaults standardUserDefaults];
    [defaultsS15 setBool:silver601 forKey:@"silver601"];
    [defaultsS15 synchronize];
    
    NSUserDefaults *defaultsS16 = [NSUserDefaults standardUserDefaults];
    [defaultsS16 setBool:silver602 forKey:@"silver602"];
    [defaultsS16 synchronize];
    
    NSUserDefaults *defaultsS17 = [NSUserDefaults standardUserDefaults];
    [defaultsS17 setBool:silver603 forKey:@"silver603"];
    [defaultsS17 synchronize];
    
    NSUserDefaults *defaultsS18 = [NSUserDefaults standardUserDefaults];
    [defaultsS18 setBool:silver701 forKey:@"silver701"];
    [defaultsS18 synchronize];
    
    NSUserDefaults *defaultsS19 = [NSUserDefaults standardUserDefaults];
    [defaultsS19 setBool:silver702 forKey:@"silver702"];
    [defaultsS19 synchronize];
    
    NSUserDefaults *defaultsS20 = [NSUserDefaults standardUserDefaults];
    [defaultsS20 setBool:silver703 forKey:@"silver703"];
    [defaultsS20 synchronize];
    
    NSUserDefaults *defaultsS21 = [NSUserDefaults standardUserDefaults];
    [defaultsS21 setBool:silver801 forKey:@"silver801"];
    [defaultsS21 synchronize];
    
    NSUserDefaults *defaultsS22 = [NSUserDefaults standardUserDefaults];
    [defaultsS22 setBool:silver802 forKey:@"silver802"];
    [defaultsS22 synchronize];
    
    NSUserDefaults *defaultsS23 = [NSUserDefaults standardUserDefaults];
    [defaultsS23 setBool:silver803 forKey:@"silver803"];
    [defaultsS23 synchronize];
    
    NSUserDefaults *defaultsS24 = [NSUserDefaults standardUserDefaults];
    [defaultsS24 setBool:silver901 forKey:@"silver901"];
    [defaultsS24 synchronize];
    
    NSUserDefaults *defaultsS25 = [NSUserDefaults standardUserDefaults];
    [defaultsS25 setBool:silver902 forKey:@"silver902"];
    [defaultsS25 synchronize];
    
    NSUserDefaults *defaultsS26 = [NSUserDefaults standardUserDefaults];
    [defaultsS26 setBool:silver903 forKey:@"silver903"];
    [defaultsS26 synchronize];
    
    NSUserDefaults *defaultsS27 = [NSUserDefaults standardUserDefaults];
    [defaultsS27 setBool:silver1001 forKey:@"silver1001"];
    [defaultsS27 synchronize];
    
    NSUserDefaults *defaultsS28 = [NSUserDefaults standardUserDefaults];
    [defaultsS28 setBool:silver1002 forKey:@"silver1002"];
    [defaultsS28 synchronize];
    
    NSUserDefaults *defaultsS29 = [NSUserDefaults standardUserDefaults];
    [defaultsS29 setBool:silver1003 forKey:@"silver1003"];
    [defaultsS29 synchronize];
    
    
    
    
    NSUserDefaults *defaultsG0 = [NSUserDefaults standardUserDefaults];
    [defaultsG0 setBool:gold101 forKey:@"gold101"];
    [defaultsG0 synchronize];
    
    NSUserDefaults *defaultsG1 = [NSUserDefaults standardUserDefaults];
    [defaultsG1 setBool:gold102 forKey:@"gold102"];
    [defaultsG1 synchronize];
    
    NSUserDefaults *defaultsG2 = [NSUserDefaults standardUserDefaults];
    [defaultsG2 setBool:gold103 forKey:@"gold103"];
    [defaultsG2 synchronize];
    
    NSUserDefaults *defaultsG3 = [NSUserDefaults standardUserDefaults];
    [defaultsG3 setBool:gold201 forKey:@"gold201"];
    [defaultsG3 synchronize];
    
    NSUserDefaults *defaultsG4 = [NSUserDefaults standardUserDefaults];
    [defaultsG4 setBool:gold202 forKey:@"gold202"];
    [defaultsG4 synchronize];
    
    NSUserDefaults *defaultsG5 = [NSUserDefaults standardUserDefaults];
    [defaultsG5 setBool:gold203 forKey:@"gold203"];
    [defaultsG5 synchronize];
    
    NSUserDefaults *defaultsG6 = [NSUserDefaults standardUserDefaults];
    [defaultsG6 setBool:gold301 forKey:@"gold301"];
    [defaultsG6 synchronize];
    
    NSUserDefaults *defaultsG7 = [NSUserDefaults standardUserDefaults];
    [defaultsG7 setBool:gold302 forKey:@"gold302"];
    [defaultsG7 synchronize];
    
    NSUserDefaults *defaultsG8 = [NSUserDefaults standardUserDefaults];
    [defaultsG8 setBool:gold303 forKey:@"gold303"];
    [defaultsG8 synchronize];
    
    NSUserDefaults *defaultsG9 = [NSUserDefaults standardUserDefaults];
    [defaultsG9 setBool:gold401 forKey:@"gold401"];
    [defaultsG9 synchronize];
    
    NSUserDefaults *defaultsG10 = [NSUserDefaults standardUserDefaults];
    [defaultsG10 setBool:gold402 forKey:@"gold402"];
    [defaultsG10 synchronize];
    
    NSUserDefaults *defaultsG11 = [NSUserDefaults standardUserDefaults];
    [defaultsG11 setBool:gold403 forKey:@"gold403"];
    [defaultsG11 synchronize];
    
    NSUserDefaults *defaultsG12 = [NSUserDefaults standardUserDefaults];
    [defaultsG12 setBool:gold501 forKey:@"gold501"];
    [defaultsG12 synchronize];
    
    NSUserDefaults *defaultsG13 = [NSUserDefaults standardUserDefaults];
    [defaultsG13 setBool:gold502 forKey:@"gold502"];
    [defaultsG13 synchronize];
    
    NSUserDefaults *defaultsG14 = [NSUserDefaults standardUserDefaults];
    [defaultsG14 setBool:gold503 forKey:@"gold503"];
    [defaultsG14 synchronize];
    
    NSUserDefaults *defaultsG15 = [NSUserDefaults standardUserDefaults];
    [defaultsG15 setBool:gold601 forKey:@"gold601"];
    [defaultsG15 synchronize];
    
    NSUserDefaults *defaultsG16 = [NSUserDefaults standardUserDefaults];
    [defaultsG16 setBool:gold602 forKey:@"gold602"];
    [defaultsG16 synchronize];
    
    NSUserDefaults *defaultsG17 = [NSUserDefaults standardUserDefaults];
    [defaultsG17 setBool:gold603 forKey:@"gold603"];
    [defaultsG17 synchronize];
    
    NSUserDefaults *defaultsG18 = [NSUserDefaults standardUserDefaults];
    [defaultsG18 setBool:gold701 forKey:@"gold701"];
    [defaultsG18 synchronize];
    
    NSUserDefaults *defaultsG19 = [NSUserDefaults standardUserDefaults];
    [defaultsG19 setBool:gold702 forKey:@"gold702"];
    [defaultsG19 synchronize];
    
    NSUserDefaults *defaultsG20 = [NSUserDefaults standardUserDefaults];
    [defaultsG20 setBool:gold703 forKey:@"gold703"];
    [defaultsG20 synchronize];
    
    NSUserDefaults *defaultsG21 = [NSUserDefaults standardUserDefaults];
    [defaultsG21 setBool:gold801 forKey:@"gold801"];
    [defaultsG21 synchronize];
    
    NSUserDefaults *defaultsG22 = [NSUserDefaults standardUserDefaults];
    [defaultsG22 setBool:gold802 forKey:@"gold802"];
    [defaultsG22 synchronize];

    NSUserDefaults *defaultsG23 = [NSUserDefaults standardUserDefaults];
    [defaultsG23 setBool:gold803 forKey:@"gold803"];
    [defaultsG23 synchronize];
    
    NSUserDefaults *defaultsG24 = [NSUserDefaults standardUserDefaults];
    [defaultsG24 setBool:gold901 forKey:@"gold901"];
    [defaultsG24 synchronize];
    
    NSUserDefaults *defaultsG25 = [NSUserDefaults standardUserDefaults];
    [defaultsG25 setBool:gold902 forKey:@"gold902"];
    [defaultsG25 synchronize];
    
    NSUserDefaults *defaultsG26 = [NSUserDefaults standardUserDefaults];
    [defaultsG26 setBool:gold903 forKey:@"gold903"];
    [defaultsG26 synchronize];
    
    NSUserDefaults *defaultsG27 = [NSUserDefaults standardUserDefaults];
    [defaultsG27 setBool:gold1001 forKey:@"gold1001"];
    [defaultsG27 synchronize];
    
    NSUserDefaults *defaultsG28 = [NSUserDefaults standardUserDefaults];
    [defaultsG28 setBool:gold1002 forKey:@"gold1002"];
    [defaultsG28 synchronize];
    
    NSUserDefaults *defaultsG29 = [NSUserDefaults standardUserDefaults];
    [defaultsG29 setBool:gold1003 forKey:@"gold1003"];
    [defaultsG29 synchronize];
}
-(void)loadRankValues {
    
    NSUserDefaults *defaultsB0 = [NSUserDefaults standardUserDefaults];
    bronze101 = [defaultsB0 boolForKey:@"bronze101"];
    
    NSUserDefaults *defaultsB1 = [NSUserDefaults standardUserDefaults];
    bronze102 = [defaultsB1 boolForKey:@"bronze102"];
    
    NSUserDefaults *defaultsB2 = [NSUserDefaults standardUserDefaults];
    bronze103 = [defaultsB2 boolForKey:@"bronze103"];
    
    NSUserDefaults *defaultsB3 = [NSUserDefaults standardUserDefaults];
    bronze201 = [defaultsB3 boolForKey:@"bronze201"];
    
    NSUserDefaults *defaultsB4 = [NSUserDefaults standardUserDefaults];
    bronze202 = [defaultsB4 boolForKey:@"bronze202"];
    
    NSUserDefaults *defaultsB5 = [NSUserDefaults standardUserDefaults];
    bronze203 = [defaultsB5 boolForKey:@"bronze203"];
    
    NSUserDefaults *defaultsB6 = [NSUserDefaults standardUserDefaults];
    bronze301 = [defaultsB6 boolForKey:@"bronze301"];
    
    NSUserDefaults *defaultsB7 = [NSUserDefaults standardUserDefaults];
    bronze302 = [defaultsB7 boolForKey:@"bronze302"];
    
    NSUserDefaults *defaultsB8 = [NSUserDefaults standardUserDefaults];
    bronze303 = [defaultsB8 boolForKey:@"bronze303"];
    
    NSUserDefaults *defaultsB9 = [NSUserDefaults standardUserDefaults];
    bronze401 = [defaultsB9 boolForKey:@"bronze401"];
    
    NSUserDefaults *defaultsB10 = [NSUserDefaults standardUserDefaults];
    bronze402 = [defaultsB10 boolForKey:@"bronze402"];
    
    NSUserDefaults *defaultsB11 = [NSUserDefaults standardUserDefaults];
    bronze403 = [defaultsB11 boolForKey:@"bronze403"];
    
    NSUserDefaults *defaultsB12 = [NSUserDefaults standardUserDefaults];
    bronze501 = [defaultsB12 boolForKey:@"bronze501"];
    
    NSUserDefaults *defaultsB13 = [NSUserDefaults standardUserDefaults];
    bronze502 = [defaultsB13 boolForKey:@"bronze502"];
    
    NSUserDefaults *defaultsB14 = [NSUserDefaults standardUserDefaults];
    bronze503 = [defaultsB14 boolForKey:@"bronze503"];
    
    NSUserDefaults *defaultsB15 = [NSUserDefaults standardUserDefaults];
    bronze601 = [defaultsB15 boolForKey:@"bronze601"];
    
    NSUserDefaults *defaultsB16 = [NSUserDefaults standardUserDefaults];
    bronze602 = [defaultsB16 boolForKey:@"bronze602"];
    
    NSUserDefaults *defaultsB17 = [NSUserDefaults standardUserDefaults];
    bronze603 = [defaultsB17 boolForKey:@"bronze603"];
    
    NSUserDefaults *defaultsB18 = [NSUserDefaults standardUserDefaults];
    bronze701 = [defaultsB18 boolForKey:@"bronze701"];
    
    NSUserDefaults *defaultsB19 = [NSUserDefaults standardUserDefaults];
    bronze702 = [defaultsB19 boolForKey:@"bronze702"];
    
    NSUserDefaults *defaultsB20 = [NSUserDefaults standardUserDefaults];
    bronze703 = [defaultsB20 boolForKey:@"bronze703"];
    
    NSUserDefaults *defaultsB21 = [NSUserDefaults standardUserDefaults];
    bronze801 = [defaultsB21 boolForKey:@"bronze801"];
    
    NSUserDefaults *defaultsB22 = [NSUserDefaults standardUserDefaults];
    bronze802 = [defaultsB22 boolForKey:@"bronze802"];
    
    NSUserDefaults *defaultsB23 = [NSUserDefaults standardUserDefaults];
    bronze803 = [defaultsB23 boolForKey:@"bronze803"];
    
    NSUserDefaults *defaultsB24 = [NSUserDefaults standardUserDefaults];
    bronze901 = [defaultsB24 boolForKey:@"bronze901"];
    
    NSUserDefaults *defaultsB25 = [NSUserDefaults standardUserDefaults];
    bronze902 = [defaultsB25 boolForKey:@"bronze902"];
    
    NSUserDefaults *defaultsB26 = [NSUserDefaults standardUserDefaults];
    bronze903 = [defaultsB26 boolForKey:@"bronze903"];
    
    NSUserDefaults *defaultsB27 = [NSUserDefaults standardUserDefaults];
    bronze1001 = [defaultsB27 boolForKey:@"bronze1001"];
    
    NSUserDefaults *defaultsB28 = [NSUserDefaults standardUserDefaults];
    bronze1002 = [defaultsB28 boolForKey:@"bronze1002"];
    
    NSUserDefaults *defaultsB29 = [NSUserDefaults standardUserDefaults];
    bronze1003 = [defaultsB29 boolForKey:@"bronze1003"];
    
    
    
    
    NSUserDefaults *defaultsS0 = [NSUserDefaults standardUserDefaults];
    silver101 = [defaultsS0 boolForKey:@"silver101"];
    
    NSUserDefaults *defaultsS1 = [NSUserDefaults standardUserDefaults];
    silver102 = [defaultsS1 boolForKey:@"silver102"];
    
    NSUserDefaults *defaultsS2 = [NSUserDefaults standardUserDefaults];
    silver103 = [defaultsS2 boolForKey:@"silver103"];
    
    NSUserDefaults *defaultsS3 = [NSUserDefaults standardUserDefaults];
    silver201 = [defaultsS3 boolForKey:@"silver201"];
    
    NSUserDefaults *defaultsS4 = [NSUserDefaults standardUserDefaults];
    silver202 = [defaultsS4 boolForKey:@"silver202"];
    
    NSUserDefaults *defaultsS5 = [NSUserDefaults standardUserDefaults];
    silver203 = [defaultsS5 boolForKey:@"silver203"];
    
    NSUserDefaults *defaultsS6 = [NSUserDefaults standardUserDefaults];
    silver301 = [defaultsS6 boolForKey:@"silver301"];
    
    NSUserDefaults *defaultsS7 = [NSUserDefaults standardUserDefaults];
    silver302 = [defaultsS7 boolForKey:@"silver302"];
    
    NSUserDefaults *defaultsS8 = [NSUserDefaults standardUserDefaults];
    silver303 = [defaultsS8 boolForKey:@"silver303"];
    
    NSUserDefaults *defaultsS9 = [NSUserDefaults standardUserDefaults];
    silver401 = [defaultsS9 boolForKey:@"silver401"];
    
    NSUserDefaults *defaultsS10 = [NSUserDefaults standardUserDefaults];
    silver402 = [defaultsS10 boolForKey:@"silver402"];
    
    NSUserDefaults *defaultsS11 = [NSUserDefaults standardUserDefaults];
    silver403 = [defaultsS11 boolForKey:@"silver403"];
    
    NSUserDefaults *defaultsS12 = [NSUserDefaults standardUserDefaults];
    silver501 = [defaultsS12 boolForKey:@"silver501"];
    
    NSUserDefaults *defaultsS13 = [NSUserDefaults standardUserDefaults];
    silver502 = [defaultsS13 boolForKey:@"silver502"];
    
    NSUserDefaults *defaultsS14 = [NSUserDefaults standardUserDefaults];
    silver503 = [defaultsS14 boolForKey:@"silver503"];
    
    NSUserDefaults *defaultsS15 = [NSUserDefaults standardUserDefaults];
    silver601 = [defaultsS15 boolForKey:@"silver601"];
    
    NSUserDefaults *defaultsS16 = [NSUserDefaults standardUserDefaults];
    silver602 = [defaultsS16 boolForKey:@"silver602"];
    
    NSUserDefaults *defaultsS17 = [NSUserDefaults standardUserDefaults];
    silver603 = [defaultsS17 boolForKey:@"silver603"];
    
    NSUserDefaults *defaultsS18 = [NSUserDefaults standardUserDefaults];
    silver701 = [defaultsS18 boolForKey:@"silver701"];
    
    NSUserDefaults *defaultsS19 = [NSUserDefaults standardUserDefaults];
    silver702 = [defaultsS19 boolForKey:@"silver702"];
    
    NSUserDefaults *defaultsS20 = [NSUserDefaults standardUserDefaults];
    silver703 = [defaultsS20 boolForKey:@"silver703"];
    
    NSUserDefaults *defaultsS21 = [NSUserDefaults standardUserDefaults];
    silver801 = [defaultsS21 boolForKey:@"silver801"];
    
    NSUserDefaults *defaultsS22 = [NSUserDefaults standardUserDefaults];
    silver802 = [defaultsS22 boolForKey:@"silver802"];
    
    NSUserDefaults *defaultsS23 = [NSUserDefaults standardUserDefaults];
    silver803 = [defaultsS23 boolForKey:@"silver803"];
    
    NSUserDefaults *defaultsS24 = [NSUserDefaults standardUserDefaults];
    silver901 = [defaultsS24 boolForKey:@"silver901"];
    
    NSUserDefaults *defaultsS25 = [NSUserDefaults standardUserDefaults];
    silver902 = [defaultsS25 boolForKey:@"silver902"];
    
    NSUserDefaults *defaultsS26 = [NSUserDefaults standardUserDefaults];
    silver903 = [defaultsS26 boolForKey:@"silver903"];
    
    NSUserDefaults *defaultsS27 = [NSUserDefaults standardUserDefaults];
    silver1001 = [defaultsS27 boolForKey:@"silver1001"];
    
    NSUserDefaults *defaultsS28 = [NSUserDefaults standardUserDefaults];
    silver1002 = [defaultsS28 boolForKey:@"silver1002"];
    
    NSUserDefaults *defaultsS29 = [NSUserDefaults standardUserDefaults];
    silver1003 = [defaultsS29 boolForKey:@"silver1003"];
    
    
    
    
    NSUserDefaults *defaultsG0 = [NSUserDefaults standardUserDefaults];
    gold101 = [defaultsG0 boolForKey:@"gold101"];
    
    NSUserDefaults *defaultsG1 = [NSUserDefaults standardUserDefaults];
    gold102 = [defaultsG1 boolForKey:@"gold102"];
    
    NSUserDefaults *defaultsG2 = [NSUserDefaults standardUserDefaults];
    gold103 = [defaultsG2 boolForKey:@"gold103"];
    
    NSUserDefaults *defaultsG3 = [NSUserDefaults standardUserDefaults];
    gold201 = [defaultsG3 boolForKey:@"gold201"];
    
    NSUserDefaults *defaultsG4 = [NSUserDefaults standardUserDefaults];
    gold202 = [defaultsG4 boolForKey:@"gold202"];
    
    NSUserDefaults *defaultsG5 = [NSUserDefaults standardUserDefaults];
    gold203 = [defaultsG5 boolForKey:@"gold203"];
    
    NSUserDefaults *defaultsG6 = [NSUserDefaults standardUserDefaults];
    gold301 = [defaultsG6 boolForKey:@"gold301"];
    
    NSUserDefaults *defaultsG7 = [NSUserDefaults standardUserDefaults];
    gold302 = [defaultsG7 boolForKey:@"gold302"];
    
    NSUserDefaults *defaultsG8 = [NSUserDefaults standardUserDefaults];
    gold303 = [defaultsG8 boolForKey:@"gold303"];
    
    NSUserDefaults *defaultsG9 = [NSUserDefaults standardUserDefaults];
    gold401 = [defaultsG9 boolForKey:@"gold401"];
    
    NSUserDefaults *defaultsG10 = [NSUserDefaults standardUserDefaults];
    gold402 = [defaultsG10 boolForKey:@"gold402"];
    
    NSUserDefaults *defaultsG11 = [NSUserDefaults standardUserDefaults];
    gold403 = [defaultsG11 boolForKey:@"gold403"];
    
    NSUserDefaults *defaultsG12 = [NSUserDefaults standardUserDefaults];
    gold501 = [defaultsG12 boolForKey:@"gold501"];
    
    NSUserDefaults *defaultsG13 = [NSUserDefaults standardUserDefaults];
    gold502 = [defaultsG13 boolForKey:@"gold502"];
    
    NSUserDefaults *defaultsG14 = [NSUserDefaults standardUserDefaults];
    gold503 = [defaultsG14 boolForKey:@"gold503"];
    
    NSUserDefaults *defaultsG15 = [NSUserDefaults standardUserDefaults];
    gold601 = [defaultsG15 boolForKey:@"gold601"];
    
    NSUserDefaults *defaultsG16 = [NSUserDefaults standardUserDefaults];
    gold602 = [defaultsG16 boolForKey:@"gold602"];
    
    NSUserDefaults *defaultsG17 = [NSUserDefaults standardUserDefaults];
    gold603 = [defaultsG17 boolForKey:@"gold603"];
    
    NSUserDefaults *defaultsG18 = [NSUserDefaults standardUserDefaults];
    gold701 = [defaultsG18 boolForKey:@"gold701"];
    
    NSUserDefaults *defaultsG19 = [NSUserDefaults standardUserDefaults];
    gold702 = [defaultsG19 boolForKey:@"gold702"];
    
    NSUserDefaults *defaultsG20 = [NSUserDefaults standardUserDefaults];
    gold703 = [defaultsG20 boolForKey:@"gold703"];
    
    NSUserDefaults *defaultsG21 = [NSUserDefaults standardUserDefaults];
    gold801 = [defaultsG21 boolForKey:@"gold801"];
    
    NSUserDefaults *defaultsG22 = [NSUserDefaults standardUserDefaults];
    gold802 = [defaultsG22 boolForKey:@"gold802"];
    
    NSUserDefaults *defaultsG23 = [NSUserDefaults standardUserDefaults];
    gold803 = [defaultsG23 boolForKey:@"gold803"];
    
    NSUserDefaults *defaultsG24 = [NSUserDefaults standardUserDefaults];
    gold901 = [defaultsG24 boolForKey:@"gold901"];
    
    NSUserDefaults *defaultsG25 = [NSUserDefaults standardUserDefaults];
    gold902 = [defaultsG25 boolForKey:@"gold902"];
    
    NSUserDefaults *defaultsG26 = [NSUserDefaults standardUserDefaults];
    gold903 = [defaultsG26 boolForKey:@"gold903"];
    
    NSUserDefaults *defaultsG27 = [NSUserDefaults standardUserDefaults];
    gold1001 = [defaultsG27 boolForKey:@"gold1001"];
    
    NSUserDefaults *defaultsG28 = [NSUserDefaults standardUserDefaults];
    gold1002 = [defaultsG28 boolForKey:@"gold1002"];
    
    NSUserDefaults *defaultsG29 = [NSUserDefaults standardUserDefaults];
    gold1003 = [defaultsG29 boolForKey:@"gold1003"];
    
}
-(void)tauntCheck {
    
    if (bronze101 == YES || silver101 == YES || gold101 == YES) {
        canTaunt = NO;
    }
    if (bronze102 == YES || silver102 == YES || gold102 == YES) {
        canTaunt = YES;
    }
    if (bronze103 == YES || silver103 == YES || gold103 == YES) {
        canTaunt = YES;
    }
    if (bronze201 == YES || silver201 == YES || gold201 == YES) {
        canTaunt = YES;
    }
    if (bronze202 == YES || silver202 == YES || gold202 == YES) {
        canTaunt = YES;
    }
    if (bronze203 == YES || silver203 == YES || gold203 == YES) {
        canTaunt = YES;
    }
    if (bronze301 == YES || silver301 == YES || gold301 == YES) {
        canTaunt = YES;
    }
    if (bronze302 == YES || silver302 == YES || gold302 == YES) {
        canTaunt = YES;
    }
    if (bronze303 == YES || silver303 == YES || gold303 == YES) {
        canTaunt = YES;
    }
    if (bronze401 == YES || silver401 == YES || gold401 == YES) {
        canTaunt = YES;
    }
    if (bronze402 == YES || silver402 == YES || gold402 == YES) {
        canTaunt = YES;
    }
    if (bronze403 == YES || silver403 == YES || gold403 == YES) {
        canTaunt = YES;
    }
    if (bronze501 == YES || silver501 == YES || gold501 == YES) {
        canTaunt = YES;
    }
    if (bronze502 == YES || silver502 == YES || gold502 == YES) {
        canTaunt = YES;
    }
    if (bronze503 == YES || silver503 == YES || gold503 == YES) {
        canTaunt = YES;
    }
    if (bronze601 == YES || silver601 == YES || gold601 == YES) {
        canTaunt = YES;
    }
    if (bronze602 == YES || silver602 == YES || gold602 == YES) {
        canTaunt = YES;
    }
    if (bronze603 == YES || silver603 == YES || gold603 == YES) {
        canTaunt = YES;
    }
    if (bronze701 == YES || silver701 == YES || gold701 == YES) {
        canTaunt = YES;
    }
    if (bronze702 == YES || silver702 == YES || gold702 == YES) {
        canTaunt = YES;
    }
    if (bronze703 == YES || silver703 == YES || gold703 == YES) {
        canTaunt = YES;
    }
    if (bronze801 == YES || silver801 == YES || gold801 == YES) {
        canTaunt = YES;
    }
    if (bronze802 == YES || silver802 == YES || gold802 == YES) {
        canTaunt = YES;
    }
    if (bronze803 == YES || silver803 == YES || gold803 == YES) {
        canTaunt = YES;
    }
    if (bronze901 == YES || silver901 == YES || gold901 == YES) {
        canTaunt = YES;
    }
    if (bronze902 == YES || silver902 == YES || gold902 == YES) {
        canTaunt = YES;
    }
    if (bronze903 == YES || silver903 == YES || gold903 == YES) {
        canTaunt = YES;
    }
    if (bronze1001 == YES || silver1001 == YES || gold1001 == YES) {
        canTaunt = YES;
    }
    if (bronze1002 == YES || silver1002 == YES || gold1002 == YES) {
        canTaunt = YES;
    }
    
    
    if (bronze102 == NO) {
        canPay = YES;
    }
    if (bronze103 == NO) {
        canPay = YES;
    }
    if (bronze201 == NO) {
        canPay = YES;
    }
    if (bronze202 == NO) {
        canPay = YES;
    }
    if (bronze203 == NO) {
        canPay = YES;
    }
    if (bronze301 == NO) {
        canPay = YES;
    }
    if (bronze302 == NO) {
        canPay = YES;
    }
    if (bronze303 == NO) {
        canPay = YES;
    }
    if (bronze401 == NO) {
        canPay = YES;
    }
    if (bronze402 == NO) {
        canPay = YES;
    }
    if (bronze403 == NO) {
        canPay = YES;
    }
    if (bronze501 == NO) {
        canPay = YES;
    }
    if (bronze502 == NO) {
        canPay = YES;
    }
    if (bronze503 == NO) {
        canPay = YES;
    }
    if (bronze601 == NO) {
        canPay = YES;
    }
    if (bronze602 == NO) {
        canPay = YES;
    }
    if (bronze603 == NO) {
        canPay = YES;
    }
    if (bronze701 == NO) {
        canPay = YES;
    }
    if (bronze702 == NO) {
        canPay = YES;
    }
    if (bronze703 == NO) {
        canPay = YES;
    }
    if (bronze801 == NO) {
        canPay = YES;
    }
    if (bronze802 == NO) {
        canPay = YES;
    }
    if (bronze803 == NO) {
        canPay = YES;
    }
    if (bronze901 == NO) {
        canPay = YES;
    }
    if (bronze902 == NO) {
        canPay = YES;
    }
    if (bronze903 == NO) {
        canPay = YES;
    }
    if (bronze1001 == NO) {
        canPay = YES;
    }
    if (bronze1002 == NO) {
        canPay = YES;
    }
    if (bronze1003 == NO) {
        canPay = YES;
    }
    
    if (silver101 == NO) {
        canPay = YES;
    }
    if (silver102 == NO) {
        canPay = YES;
    }
    if (silver103 == NO) {
        canPay = YES;
    }
    if (silver201 == NO) {
        canPay = YES;
    }
    if (silver202 == NO) {
        canPay = YES;
    }
    if (silver203 == NO) {
        canPay = YES;
    }
    if (silver301 == NO) {
        canPay = YES;
    }
    if (silver302 == NO) {
        canPay = YES;
    }
    if (silver303 == NO) {
        canPay = YES;
    }
    if (silver401 == NO) {
        canPay = YES;
    }
    if (silver402 == NO) {
        canPay = YES;
    }
    if (silver403 == NO) {
        canPay = YES;
    }
    if (silver501 == NO) {
        canPay = YES;
    }
    if (silver502 == NO) {
        canPay = YES;
    }
    if (silver503 == NO) {
        canPay = YES;
    }
    if (silver601 == NO) {
        canPay = YES;
    }
    if (silver602 == NO) {
        canPay = YES;
    }
    if (silver603 == NO) {
        canPay = YES;
    }
    if (silver701 == NO) {
        canPay = YES;
    }
    if (silver702 == NO) {
        canPay = YES;
    }
    if (silver703 == NO) {
        canPay = YES;
    }
    if (silver801 == NO) {
        canPay = YES;
    }
    if (silver802 == NO) {
        canPay = YES;
    }
    if (silver803 == NO) {
        canPay = YES;
    }
    if (silver901 == NO) {
        canPay = YES;
    }
    if (silver902 == NO) {
        canPay = YES;
    }
    if (silver903 == NO) {
        canPay = YES;
    }
    if (silver1001 == NO) {
        canPay = YES;
    }
    if (silver1002 == NO) {
        canPay = YES;
    }
    if (silver1003 == NO) {
        canPay = YES;
    }
    
    if (gold101 == NO) {
        canPay = YES;
    }
    if (gold102 == NO) {
        canPay = YES;
    }
    if (gold103 == NO) {
        canPay = YES;
    }
    if (gold201 == NO) {
        canPay = YES;
    }
    if (gold202 == NO) {
        canPay = YES;
    }
    if (gold203 == NO) {
        canPay = YES;
    }
    if (gold301 == NO) {
        canPay = YES;
    }
    if (gold302 == NO) {
        canPay = YES;
    }
    if (gold303 == NO) {
        canPay = YES;
    }
    if (gold401 == NO) {
        canPay = YES;
    }
    if (gold402 == NO) {
        canPay = YES;
    }
    if (gold403 == NO) {
        canPay = YES;
    }
    if (gold501 == NO) {
        canPay = YES;
    }
    if (gold502 == NO) {
        canPay = YES;
    }
    if (gold503 == NO) {
        canPay = YES;
    }
    if (gold601 == NO) {
        canPay = YES;
    }
    if (gold602 == NO) {
        canPay = YES;
    }
    if (gold603 == NO) {
        canPay = YES;
    }
    if (gold701 == NO) {
        canPay = YES;
    }
    if (gold702 == NO) {
        canPay = YES;
    }
    if (gold703 == NO) {
        canPay = YES;
    }
    if (gold801 == NO) {
        canPay = YES;
    }
    if (gold802 == NO) {
        canPay = YES;
    }
    if (gold803 == NO) {
        canPay = YES;
    }
    if (gold901 == NO) {
        canPay = YES;
    }
    if (gold902 == NO) {
        canPay = YES;
    }
    if (gold903 == NO) {
        canPay = YES;
    }
    if (gold1001 == NO) {
        canPay = YES;
    }
    if (gold1002 == NO) {
        canPay = YES;
    }
    if (gold1003 == NO) {
        canPay = YES;
    }
    
}
-(void)canBlinkLogic {
    
    if (rankNumber == 0 & ab1 == YES) {
        canBlinkOBJ = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        ab1 = [Defaults integerForKey:@"ab1"];
        
    }
    if (rankNumber == 0 & bb1 == YES) {
        canBlinkFoods = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        bb1 = [Defaults integerForKey:@"bb1"];
        
    }
    if (rankNumber == 1 & b2 == YES) {
        canBlinkOBJ = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        b2 = [Defaults integerForKey:@"b2"];
        
    }
    if (rankNumber == 2 & b3 == YES) {
        canBlinkOBJ = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        b3 = [Defaults integerForKey:@"b3"];
        
    }
    if (rankNumber == 3 & ab4 == YES) {
        canBlinkOBJ = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        ab4 = [Defaults integerForKey:@"ab4"];
        
    }
    if (rankNumber == 3 & bb4 == YES) {
        canBlinkFoods = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        bb4 = [Defaults integerForKey:@"bb4"];
        
    }
    if (rankNumber == 4 & b5 == YES) {
        canBlinkOBJ = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        b5 = [Defaults integerForKey:@"b5"];
        
    }
    if (rankNumber == 5 & b6 == YES) {
        canBlinkOBJ = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        b6 = [Defaults integerForKey:@"b6"];
        
    }
    if (rankNumber == 6 & ab7 == YES) {
        canBlinkOBJ = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        ab7 = [Defaults integerForKey:@"ab7"];
        
    }
    if (rankNumber == 6 & bb7 == YES) {
        canBlinkFoods = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        bb7 = [Defaults integerForKey:@"bb7"];
        
    }
    if (rankNumber == 7 & b8 == YES) {
        canBlinkOBJ = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        b8 = [Defaults integerForKey:@"b8"];
        
    }
    if (rankNumber == 8 & b9 == YES) {
        canBlinkOBJ = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        b9 = [Defaults integerForKey:@"b9"];
        
    }
    if (rankNumber == 9 & ab10 == YES) {
        canBlinkOBJ = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        ab10 = [Defaults integerForKey:@"ab10"];
        
    }
    if (rankNumber == 9 & bb10 == YES) {
        canBlinkFoods = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        bb10 = [Defaults integerForKey:@"bb10"];
        
    }
    if (rankNumber == 10 & b11 == YES) {
        canBlinkOBJ = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        b11 = [Defaults integerForKey:@"b11"];
        
    }
    if (rankNumber == 11 & b12 == YES) {
        canBlinkOBJ = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        b12 = [Defaults integerForKey:@"b12"];
        
    }
    if (rankNumber == 12 & ab13 == YES) {
        canBlinkOBJ = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        ab13 = [Defaults integerForKey:@"ab13"];
        
    }
    if (rankNumber == 12 & bb13 == YES) {
        canBlinkFoods = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        bb13 = [Defaults integerForKey:@"bb13"];
        
    }
    if (rankNumber == 13 & b14 == YES) {
        canBlinkOBJ = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        b14 = [Defaults integerForKey:@"b14"];
        
    }
    if (rankNumber == 14 & b15 == YES) {
        canBlinkOBJ = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        b15 = [Defaults integerForKey:@"b15"];
        
    }
    if (rankNumber == 15 & ab16 == YES) {
        canBlinkOBJ = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        ab16 = [Defaults integerForKey:@"ab16"];
        
    }
    if (rankNumber == 15 & bb16 == YES) {
        canBlinkFoods = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        bb16 = [Defaults integerForKey:@"bb16"];
        
    }
    if (rankNumber == 16 & b17 == YES) {
        canBlinkOBJ = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        b17 = [Defaults integerForKey:@"b17"];
        
    }
    if (rankNumber == 17 & b18 == YES) {
        canBlinkOBJ = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        b18 = [Defaults integerForKey:@"b18"];
        
    }
    if (rankNumber == 18 & ab19 == YES) {
        canBlinkOBJ = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        ab19 = [Defaults integerForKey:@"ab19"];
        
    }
    if (rankNumber == 18 & bb19 == YES) {
        canBlinkFoods = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        bb19 = [Defaults integerForKey:@"bb19"];
        
    }
    if (rankNumber == 19 & b20 == YES) {
        canBlinkOBJ = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        b20 = [Defaults integerForKey:@"b20"];
        
    }
    if (rankNumber == 20 & b21 == YES) {
        canBlinkOBJ = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        b21 = [Defaults integerForKey:@"b21"];
        
    }
    if (rankNumber == 21 & ab22 == YES) {
        canBlinkOBJ = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        ab22 = [Defaults integerForKey:@"ab22"];
        
    }
    if (rankNumber == 21 & bb22 == YES) {
        canBlinkFoods = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        bb22 = [Defaults integerForKey:@"bb22"];
        
    }
    if (rankNumber == 22 & b23 == YES) {
        canBlinkOBJ = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        b23 = [Defaults integerForKey:@"b23"];
        
    }
    if (rankNumber == 23 & b24 == YES) {
        canBlinkOBJ = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        b24 = [Defaults integerForKey:@"b24"];
        
    }
    if (rankNumber == 24 & ab25 == YES) {
        canBlinkOBJ = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        ab25 = [Defaults integerForKey:@"ab25"];
        
    }
    if (rankNumber == 24 & bb25 == YES) {
        canBlinkFoods = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        bb25 = [Defaults integerForKey:@"bb25"];
        
    }
    if (rankNumber == 25 & b26 == YES) {
        canBlinkOBJ = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        b26 = [Defaults integerForKey:@"b26"];
        
    }
    if (rankNumber == 26 & b27 == YES) {
        canBlinkOBJ = NO;
        NSUserDefaults *Defaults = [NSUserDefaults standardUserDefaults];
        b27 = [Defaults integerForKey:@"b27"];
        
    }
}
-(void)didBlinkLogic {
    
    
    
    if (rankNumber == 0 & ab1 == NO & clickOB == YES) {
        canBlinkOBJ = YES;
        ab1 = YES;
        NSUserDefaults *ab1Data = [NSUserDefaults standardUserDefaults];
        [ab1Data setBool:ab1 forKey:@"ab1"];
        [ab1Data synchronize];
        
    }
    if (rankNumber == 0 & bb1 == NO & clickFB == YES) {
        canBlinkFoods = YES;
        bb1 = YES;
        NSUserDefaults *bb1Data = [NSUserDefaults standardUserDefaults];
        [bb1Data setBool:bb1 forKey:@"bb1"];
        [bb1Data synchronize];
        
    }
    if (rankNumber == 1 & b2 == NO) {
        canBlinkOBJ = YES;
        b2 = YES;
        NSUserDefaults *b2Data = [NSUserDefaults standardUserDefaults];
        [b2Data setBool:b2 forKey:@"b2"];
        [b2Data synchronize];
        
    }
    if (rankNumber == 2 & b3 == NO) {
        canBlinkOBJ = YES;
        b3 = YES;
        NSUserDefaults *b3Data = [NSUserDefaults standardUserDefaults];
        [b3Data setBool:b3 forKey:@"b3"];
        [b3Data synchronize];
        
    }
    if (rankNumber == 3 & ab4 == NO & clickOB == YES) {
        canBlinkOBJ = YES;
        ab4 = YES;
        NSUserDefaults *ab4Data = [NSUserDefaults standardUserDefaults];
        [ab4Data setBool:ab4 forKey:@"ab4"];
        [ab4Data synchronize];
        
    }
    if (rankNumber == 3 & bb4 == NO & clickFB == YES) {
        canBlinkFoods = YES;
        bb4 = YES;
        NSUserDefaults *bb4Data = [NSUserDefaults standardUserDefaults];
        [bb4Data setBool:bb4 forKey:@"bb4"];
        [bb4Data synchronize];
        
    }
    if (rankNumber == 4 & b5 == NO) {
        canBlinkOBJ = YES;
        b5 = YES;
        NSUserDefaults *b5Data = [NSUserDefaults standardUserDefaults];
        [b5Data setBool:b5 forKey:@"b5"];
        [b5Data synchronize];
        
    }
    if (rankNumber == 5 & b6 == NO) {
        canBlinkOBJ = YES;
        b6 = YES;
        NSUserDefaults *b6Data = [NSUserDefaults standardUserDefaults];
        [b6Data setBool:b6 forKey:@"b6"];
        [b6Data synchronize];
        
    }
    if (rankNumber == 6 & ab7 == NO & clickOB == YES) {
        canBlinkOBJ = YES;
        ab7 = YES;
        NSUserDefaults *ab7Data = [NSUserDefaults standardUserDefaults];
        [ab7Data setBool:ab7 forKey:@"ab7"];
        [ab7Data synchronize];
        
    }
    if (rankNumber == 6 & bb7 == NO & clickFB == YES) {
        canBlinkFoods = YES;
        ab7 = YES;
        NSUserDefaults *bb7Data = [NSUserDefaults standardUserDefaults];
        [bb7Data setBool:bb7 forKey:@"bb7"];
        [bb7Data synchronize];
        
    }
    if (rankNumber == 7 & b8 == NO) {
        canBlinkOBJ = YES;
        b8 = YES;
        NSUserDefaults *b8Data = [NSUserDefaults standardUserDefaults];
        [b8Data setBool:b8 forKey:@"b8"];
        [b8Data synchronize];
        
    }
    if (rankNumber == 8 & b9 == NO) {
        canBlinkOBJ = YES;
        b9 = YES;
        NSUserDefaults *b9Data = [NSUserDefaults standardUserDefaults];
        [b9Data setBool:b9 forKey:@"b9"];
        [b9Data synchronize];
        
    }
    if (rankNumber == 9 & ab10 == NO & clickOB == YES) {
        canBlinkOBJ = YES;
        ab10 = YES;
        NSUserDefaults *ab10Data = [NSUserDefaults standardUserDefaults];
        [ab10Data setBool:ab10 forKey:@"ab10"];
        [ab10Data synchronize];
        
    }
    if (rankNumber == 9 & bb10 == NO & clickFB == YES) {
        canBlinkFoods = YES;
        bb10 = YES;
        NSUserDefaults *bb10Data = [NSUserDefaults standardUserDefaults];
        [bb10Data setBool:bb10 forKey:@"bb10"];
        [bb10Data synchronize];
        
    }
    if (rankNumber == 10 & b11 == NO) {
        canBlinkOBJ = YES;
        b11 = YES;
        NSUserDefaults *b11Data = [NSUserDefaults standardUserDefaults];
        [b11Data setBool:b11 forKey:@"b11"];
        [b11Data synchronize];
        
    }
    if (rankNumber == 11 & b12 == NO) {
        canBlinkOBJ = YES;
        b12 = YES;
        NSUserDefaults *b12Data = [NSUserDefaults standardUserDefaults];
        [b12Data setBool:b12 forKey:@"b12"];
        [b12Data synchronize];
        
    }
    if (rankNumber == 12 & ab13 == NO & clickOB == YES) {
        canBlinkOBJ = YES;
        ab13 = YES;
        NSUserDefaults *ab13Data = [NSUserDefaults standardUserDefaults];
        [ab13Data setBool:ab13 forKey:@"ab13"];
        [ab13Data synchronize];
        
    }
    if (rankNumber == 12 & bb13 == NO & clickFB == YES) {
        canBlinkFoods = YES;
        bb13 = YES;
        NSUserDefaults *bb13Data = [NSUserDefaults standardUserDefaults];
        [bb13Data setBool:bb13 forKey:@"bb13"];
        [bb13Data synchronize];
        
    }
    if (rankNumber == 13 & b14 == NO) {
        canBlinkOBJ = YES;
        b14 = YES;
        NSUserDefaults *b14Data = [NSUserDefaults standardUserDefaults];
        [b14Data setBool:b14 forKey:@"b14"];
        [b14Data synchronize];
        
    }
    if (rankNumber == 14 & b15 == NO) {
        canBlinkOBJ = YES;
        b15 = YES;
        NSUserDefaults *b15Data = [NSUserDefaults standardUserDefaults];
        [b15Data setBool:b15 forKey:@"b15"];
        [b15Data synchronize];
        
    }
    if (rankNumber == 15 & ab16 == NO & clickOB == YES) {
        canBlinkOBJ = YES;
        ab16 = YES;
        NSUserDefaults *ab16Data = [NSUserDefaults standardUserDefaults];
        [ab16Data setBool:ab16 forKey:@"ab16"];
        [ab16Data synchronize];
        
    }
    if (rankNumber == 15 & bb16 == NO & clickFB == YES) {
        canBlinkFoods = YES;
        bb16 = YES;
        NSUserDefaults *bb16Data = [NSUserDefaults standardUserDefaults];
        [bb16Data setBool:bb16 forKey:@"bb16"];
        [bb16Data synchronize];
        
    }
    if (rankNumber == 16 & b17 == NO) {
        canBlinkOBJ = YES;
        b17 = YES;
        NSUserDefaults *b17Data = [NSUserDefaults standardUserDefaults];
        [b17Data setBool:b17 forKey:@"b17"];
        [b17Data synchronize];
        
    }
    if (rankNumber == 17 & b18 == NO) {
        canBlinkOBJ = YES;
        b18 = YES;
        NSUserDefaults *b18Data = [NSUserDefaults standardUserDefaults];
        [b18Data setBool:b18 forKey:@"b18"];
        [b18Data synchronize];
        
    }
    if (rankNumber == 18 & ab19 == NO & clickOB == YES) {
        canBlinkOBJ = YES;
        ab19 = YES;
        NSUserDefaults *ab19Data = [NSUserDefaults standardUserDefaults];
        [ab19Data setBool:ab19 forKey:@"ab19"];
        [ab19Data synchronize];
        
    }
    if (rankNumber == 18 & bb19 == NO & clickFB == YES) {
        canBlinkFoods = YES;
        bb19 = YES;
        NSUserDefaults *bb19Data = [NSUserDefaults standardUserDefaults];
        [bb19Data setBool:bb19 forKey:@"bb19"];
        [bb19Data synchronize];
        
    }
    if (rankNumber == 19 & b20 == NO) {
        canBlinkOBJ = YES;
        b20 = YES;
        NSUserDefaults *b20Data = [NSUserDefaults standardUserDefaults];
        [b20Data setBool:b20 forKey:@"b20"];
        [b20Data synchronize];
        
    }
    if (rankNumber == 20 & b21 == NO) {
        canBlinkOBJ = YES;
        b21 = YES;
        NSUserDefaults *b21Data = [NSUserDefaults standardUserDefaults];
        [b21Data setBool:b21 forKey:@"b21"];
        [b21Data synchronize];
        
    }
    if (rankNumber == 21 & ab22 == NO & clickOB == YES) {
        canBlinkOBJ = YES;
        ab22 = YES;
        NSUserDefaults *ab22Data = [NSUserDefaults standardUserDefaults];
        [ab22Data setBool:ab22 forKey:@"ab22"];
        [ab22Data synchronize];
        
    }
    if (rankNumber == 21 & bb22 == NO & clickFB == YES) {
        canBlinkFoods = YES;
        bb22 = YES;
        NSUserDefaults *bb22Data = [NSUserDefaults standardUserDefaults];
        [bb22Data setBool:bb22 forKey:@"bb22"];
        [bb22Data synchronize];
        
    }
    if (rankNumber == 22 & b23 == NO) {
        canBlinkOBJ = YES;
        b23 = YES;
        NSUserDefaults *b23Data = [NSUserDefaults standardUserDefaults];
        [b23Data setBool:b23 forKey:@"b23"];
        [b23Data synchronize];
        
    }
    if (rankNumber == 23 & b24 == NO) {
        canBlinkOBJ = YES;
        b24 = YES;
        NSUserDefaults *b24Data = [NSUserDefaults standardUserDefaults];
        [b24Data setBool:b24 forKey:@"b24"];
        [b24Data synchronize];
        
    }
    if (rankNumber == 24 & ab25 == NO & clickOB == YES) {
        canBlinkOBJ = YES;
        ab25 = YES;
        NSUserDefaults *ab25Data = [NSUserDefaults standardUserDefaults];
        [ab25Data setBool:ab25 forKey:@"ab25"];
        [ab25Data synchronize];
        
    }
    if (rankNumber == 24 & bb25 == NO & clickFB == YES) {
        canBlinkFoods = YES;
        bb25 = YES;
        NSUserDefaults *bb25Data = [NSUserDefaults standardUserDefaults];
        [bb25Data setBool:bb25 forKey:@"bb25"];
        [bb25Data synchronize];
        
    }
    if (rankNumber == 25 & b26 == NO) {
        canBlinkOBJ = YES;
        b26 = YES;
        NSUserDefaults *b26Data = [NSUserDefaults standardUserDefaults];
        [b26Data setBool:b26 forKey:@"b26"];
        [b26Data synchronize];
        
    }
    if (rankNumber == 26 & b27 == NO) {
        canBlinkOBJ = YES;
        b27 = YES;
        NSUserDefaults *b27Data = [NSUserDefaults standardUserDefaults];
        [b27Data setBool:b27 forKey:@"b27"];
        [b27Data synchronize];
        
    }
    
}

-(void)saveHelpActivated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:helpActivated forKey:@"helpActivated"];
    [defaults synchronize];
}
-(void)loadHelpActivated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    helpActivated = [defaults boolForKey:@"helpActivated"];
}
-(void)canPlayCheck {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    canPlay = [defaults boolForKey:@"canPlay"];
    
    //---Level 1
    
    if (bronze101 == YES || silver101 == YES || gold101 == YES) {
        canPlayRank0 = YES;
    }
    if (bronze102 == YES || silver102 == YES || gold102 == YES) {
        canPlayRank1 = YES;
    }
    if (bronze103 == YES || silver103 == YES || gold103 == YES) {
        canPlayRank2 = YES;
    }
    
    //---Level 2
    
    if (bronze201 == YES || silver201 == YES || gold201 == YES) {
        canPlayRank3 = YES;
    }
    if (bronze202 == YES || silver202 == YES || gold202 == YES) {
        canPlayRank4 = YES;
    }
    if (bronze203 == YES || silver203 == YES || gold203 == YES) {
        canPlayRank5 = YES;
    }
    
    //---Level 3
    
    if (bronze301 == YES || silver301 == YES || gold301 == YES) {
        canPlayRank6 = YES;
    }
    if (bronze302 == YES || silver302 == YES || gold302 == YES) {
        canPlayRank7 = YES;
    }
    if (bronze303 == YES || silver303 == YES || gold303 == YES) {
        canPlayRank8 = YES;
    }
    
    //---Level 4
    
    if (bronze401 == YES || silver401 == YES || gold401 == YES) {
        canPlayRank9 = YES;
    }
    if (bronze402 == YES || silver402 == YES || gold402 == YES) {
        canPlayRank10 = YES;
    }
    if (bronze403 == YES || silver403 == YES || gold403 == YES) {
        canPlayRank11 = YES;
    }
    
    //---Level 5
    
    if (bronze501 == YES || silver501 == YES || gold501 == YES) {
        canPlayRank12 = YES;
    }
    if (bronze502 == YES || silver502 == YES || gold502 == YES) {
        canPlayRank13 = YES;
    }
    if (bronze503 == YES || silver503 == YES || gold503 == YES) {
        canPlayRank14 = YES;
    }
    
    //---Level 6
    
    if (bronze601 == YES || silver601 == YES || gold601 == YES) {
        canPlayRank15 = YES;
    }
    if (bronze602 == YES || silver602 == YES || gold602 == YES) {
        canPlayRank16 = YES;
    }
    if (bronze603 == YES || silver603 == YES || gold603 == YES) {
        canPlayRank17 = YES;
    }
    
    //---Level 7
    
    if (bronze701 == YES || silver701 == YES || gold701 == YES) {
        canPlayRank18 = YES;
    }
    if (bronze702 == YES || silver702 == YES || gold702 == YES) {
        canPlayRank19 = YES;
    }
    if (bronze703 == YES || silver703 == YES || gold703 == YES) {
        canPlayRank20 = YES;
    }
    
    //---Level 8
    
    if (bronze801 == YES || silver801 == YES || gold801 == YES) {
        canPlayRank21 = YES;
    }
    if (bronze802 == YES || silver802 == YES || gold802 == YES) {
        canPlayRank22 = YES;
    }
    if (bronze803 == YES || silver803 == YES || gold803 == YES) {
        canPlayRank23 = YES;
    }
    
    //---Level 9
    
    if (bronze901 == YES || silver901 == YES || gold901 == YES) {
        canPlayRank24 = YES;
    }
    if (bronze902 == YES || silver902 == YES || gold902 == YES) {
        canPlayRank25 = YES;
    }
    if (bronze903 == YES || silver903 == YES || gold903 == YES) {
        canPlayRank26 = YES;
    }
    
    //---Level 10
    
    if (bronze1001 == YES || silver1001 == YES || gold1001 == YES) {
        canPlayRank27 = YES;
    }
    if (bronze1002 == YES || silver1002 == YES || gold1002 == YES) {
        canPlayRank28 = YES;
    }
    if (bronze1002 == YES || silver1002 == YES || gold1002 == YES) {
        canPlayRank29 = YES;
    }
    
}

-(void)bossBattleArraySprites {
    
    
    energy = @[
                        @"ReggyEnergyBar1",
                        @"ReggyEnergyBar2",
                        @"ReggyEnergyBar3",
                        @"ReggyEnergyBar4",
                        @"ReggyEnergyBar5",
                        @"ReggyEnergyBar6",
                        @"ReggyEnergyBar7",
                        @"ReggyEnergyBar8",
                        @"ReggyEnergyBar9",
                        @"ReggyEnergyBar10",
                        @"ReggyEnergyBar11",
                        @"ReggyEnergyBar12",
                        @"ReggyEnergyBar13",
                        @"ReggyEnergyBar14",
                        @"ReggyEnergyBar15",
                        @"ReggyEnergyBar16",
                        @"ReggyEnergyBar17",
                        @"ReggyEnergyBar18",
                        @"ReggyEnergyBar19",
                        @"ReggyEnergyBar20",
                        @"ReggyEnergyBar21",
                        @"ReggyEnergyBar22",
                        @"ReggyEnergyBar23",
                        @"ReggyEnergyBar24",
                        @"ReggyEnergyBar25",
                        @"ReggyEnergyBar26",
                        @"ReggyEnergyBar27",
                        @"ReggyEnergyBar28",
                        @"ReggyEnergyBar29",
                        @"ReggyEnergyBar30",
                        @"ReggyEnergyBar31",
                        @"ReggyEnergyBar32",
                        @"ReggyEnergyBar33",
                        @"ReggyEnergyBar34",
                        @"ReggyEnergyBar35",
                        @"ReggyEnergyBar36",
                        @"ReggyEnergyBar37",
                        @"ReggyEnergyBar38",
                        @"ReggyEnergyBar39",
                        @"ReggyEnergyBar40",
                        @"ReggyEnergyBar41",
                        @"ReggyEnergyBar42",
                        @"ReggyEnergyBar43",
                        @"ReggyEnergyBar44",
                        @"ReggyEnergyBar45",
                        @"ReggyEnergyBar46",
                        @"ReggyEnergyBar47",
                        @"ReggyEnergyBar48",
                        @"ReggyEnergyBar49",
                        @"ReggyEnergyBar50",
                        @"ReggyEnergyBar51",
                        @"ReggyEnergyBar52",
                        @"ReggyEnergyBar53",
                        @"ReggyEnergyBar54",
                        @"ReggyEnergyBar55",
                        @"ReggyEnergyBar56",
                        @"ReggyEnergyBar57",
                        @"ReggyEnergyBar58",
                        @"ReggyEnergyBar59",
                        @"ReggyEnergyBar60",
                        @"ReggyEnergyBar61",
                        @"ReggyEnergyBar62",
                        @"ReggyEnergyBar63",
                        @"ReggyEnergyBar64",
                        @"ReggyEnergyBar65",
                        @"ReggyEnergyBar66",
                        @"ReggyEnergyBar67",
                        @"ReggyEnergyBar68",
                        @"ReggyEnergyBar69",
                        @"ReggyEnergyBar70",
                        @"ReggyEnergyBar71",
                        @"ReggyEnergyBar72",
                        @"ReggyEnergyBar73",
                        @"ReggyEnergyBar74",
                        @"ReggyEnergyBar75",
                        @"ReggyEnergyBar76",
                        @"ReggyEnergyBar77",
                        @"ReggyEnergyBar78",
                        @"ReggyEnergyBar79",
                        @"ReggyEnergyBar80",
                        @"ReggyEnergyBar81",
                        @"ReggyEnergyBar82",
                        @"ReggyEnergyBar83",
                        @"ReggyEnergyBar84",
                        @"ReggyEnergyBar85",
                        @"ReggyEnergyBar86",
                        @"ReggyEnergyBar87",
                        @"ReggyEnergyBar88",
                        @"ReggyEnergyBar89",
                        @"ReggyEnergyBar90",
                        @"ReggyEnergyBar91",
                        @"ReggyEnergyBar92",
                        @"ReggyEnergyBar93",
                        @"ReggyEnergyBar94",
                        @"ReggyEnergyBar95",
                        @"ReggyEnergyBar96",
                        @"ReggyEnergyBar97",
                        @"ReggyEnergyBar98",
                        @"ReggyEnergyBar99",
                        @"ReggyEnergyBar100"
                        ];
    
    

    
    reggyHP = @[
                @"HealthBar1",
                @"HealthBar2",
                @"HealthBar3",
                @"HealthBar4",
                @"HealthBar5",
                @"HealthBar6",
                @"HealthBar7",
                @"HealthBar8",
                @"HealthBar9",
                @"HealthBar10",
                @"HealthBar11",
                @"HealthBar12",
                @"HealthBar13",
                @"HealthBar14",
                @"HealthBar15",
                @"HealthBar16",
                @"HealthBar17",
                @"HealthBar18",
                @"HealthBar19",
                @"HealthBar20",
                @"HealthBar21",
                @"HealthBar22",
                @"HealthBar23",
                @"HealthBar24",
                @"HealthBar25",
                @"HealthBar26",
                @"HealthBar27",
                @"HealthBar28",
                @"HealthBar29",
                @"HealthBar30",
                @"HealthBar31",
                @"HealthBar32",
                @"HealthBar33",
                @"HealthBar34",
                @"HealthBar35",
                @"HealthBar36",
                @"HealthBar37",
                @"HealthBar38",
                @"HealthBar39",
                @"HealthBar40",
                @"HealthBar41",
                @"HealthBar42",
                @"HealthBar43",
                @"HealthBar44",
                @"HealthBar45",
                @"HealthBar46",
                @"HealthBar47",
                @"HealthBar48",
                @"HealthBar49",
                @"HealthBar50",
                @"HealthBar51",
                @"HealthBar52",
                @"HealthBar53",
                @"HealthBar54",
                @"HealthBar55",
                @"HealthBar56",
                @"HealthBar57",
                @"HealthBar58",
                @"HealthBar59",
                @"HealthBar60",
                @"HealthBar61",
                @"HealthBar62",
                @"HealthBar63",
                @"HealthBar64",
                @"HealthBar65",
                @"HealthBar66",
                @"HealthBar67",
                @"HealthBar68",
                @"HealthBar69",
                @"HealthBar70",
                @"HealthBar71",
                @"HealthBar72",
                @"HealthBar73",
                @"HealthBar74",
                @"HealthBar75",
                @"HealthBar76",
                @"HealthBar77",
                @"HealthBar78",
                @"HealthBar80",
                @"HealthBar81",
                @"HealthBar82",
                @"HealthBar83",
                @"HealthBar84",
                @"HealthBar85",
                @"HealthBar86",
                @"HealthBar87",
                @"HealthBar88",
                @"HealthBar89",
                @"HealthBar90",
                @"HealthBar91",
                @"HealthBar92",
                @"HealthBar93",
                @"HealthBar94",
                @"HealthBar95",
                @"HealthBar96",
                @"HealthBar97",
                @"HealthBar98",
                @"HealthBar99",
                @"HealthBar100",
                @"HealthBar101",
                @"HealthBar102",
                @"HealthBar103",
                @"HealthBar104",
                @"HealthBar105",
                @"HealthBar106",
                @"HealthBar107",
                @"HealthBar108",
                @"HealthBar109",
                @"HealthBar110",
                @"HealthBar111",
                @"HealthBar112",
                @"HealthBar113",
                @"HealthBar114",
                @"HealthBar115",
                @"HealthBar116",
                @"HealthBar117",
                @"HealthBar118",
                @"HealthBar119",
                @"HealthBar120",
                @"HealthBar121",
                @"HealthBar122",
                @"HealthBar123",
                @"HealthBar124",
                @"HealthBar125",
                @"HealthBar126",
                @"HealthBar127",
                @"HealthBar128",
                @"HealthBar129",
                @"HealthBar130",
                @"HealthBar131",
                @"HealthBar132",
                @"HealthBar133",
                @"HealthBar134",
                @"HealthBar135",
                @"HealthBar136",
                @"HealthBar137",
                @"HealthBar138",
                @"HealthBar139",
                @"HealthBar140",
                @"HealthBar141",
                @"HealthBar142",
                @"HealthBar143",
                @"HealthBar144",
                @"HealthBar145",
                @"HealthBar146",
                @"HealthBar147",
                @"HealthBar148",
                @"HealthBar149",
                @"HealthBar150",
                @"HealthBar151",
                @"HealthBar152",
                @"HealthBar153",
                @"HealthBar154",
                @"HealthBar155",
                @"HealthBar156",
                @"HealthBar157",
                @"HealthBar158",
                @"HealthBar159",
                @"HealthBar160",
                @"HealthBar161",
                @"HealthBar162",
                @"HealthBar163",
                @"HealthBar164",
                @"HealthBar165",
                @"HealthBar166",
                @"HealthBar167",
                @"HealthBar168",
                @"HealthBar169",
                @"HealthBar170",
                @"HealthBar171",
                @"HealthBar172",
                @"HealthBar173",
                @"HealthBar174",
                @"HealthBar175",
                @"HealthBar176",
                @"HealthBar177",
                @"HealthBar178",
                @"HealthBar179",
                @"HealthBar180",
                @"HealthBar181",
                @"HealthBar182",
                @"HealthBar183",
                @"HealthBar184",
                @"HealthBar185",
                @"HealthBar186",
                @"HealthBar187",
                @"HealthBar188",
                @"HealthBar189",
                @"HealthBar190",
                @"HealthBar191",
                @"HealthBar192",
                @"HealthBar193",
                @"HealthBar194",
                @"HealthBar195",
                @"HealthBar196",
                @"HealthBar197",
                @"HealthBar198",
                @"HealthBar199",
                @"HealthBar200",
                @"HealthBar201",
                @"HealthBar202",
                @"HealthBar203",
                @"HealthBar204",
                @"HealthBar205",
                @"HealthBar206",
                @"HealthBar207",
                @"HealthBar208",
                @"HealthBar209",
                @"HealthBar210",
                @"HealthBar211",
                @"HealthBar212",
                @"HealthBar213",
                @"HealthBar214",
                @"HealthBar215",
                @"HealthBar216",
                @"HealthBar217",
                @"HealthBar218",
                @"HealthBar219",
                @"HealthBar220",
                @"HealthBar221",
                @"HealthBar222",
                @"HealthBar223",
                @"HealthBar224",
                @"HealthBar225",
                @"HealthBar226",
                @"HealthBar227",
                @"HealthBar228",
                @"HealthBar229",
                @"HealthBar230",
                @"HealthBar231",
                @"HealthBar232",
                @"HealthBar233",
                @"HealthBar234",
                @"HealthBar235",
                @"HealthBar236",
                @"HealthBar237",
                @"HealthBar238",
                @"HealthBar239",
                @"HealthBar240",
                @"HealthBar241",
                @"HealthBar242",
                @"HealthBar243",
                @"HealthBar244",
                @"HealthBar245",
                @"HealthBar246",
                @"HealthBar247",
                @"HealthBar248",
                @"HealthBar249",
                @"HealthBar250",
                @"HealthBar251",
                @"HealthBar252",
                @"HealthBar253",
                @"HealthBar254",
                @"HealthBar255",
                @"HealthBar256",
                @"HealthBar257",
                @"HealthBar258",
                @"HealthBar259",
                @"HealthBar260",
                @"HealthBar261",
                @"HealthBar262",
                @"HealthBar263",
                @"HealthBar264",
                @"HealthBar265",
                @"HealthBar266",
                @"HealthBar267",
                @"HealthBar268",
                @"HealthBar269",
                @"HealthBar270",
                @"HealthBar271",
                @"HealthBar272",
                @"HealthBar273",
                @"HealthBar274",
                @"HealthBar275",
                @"HealthBar276",
                @"HealthBar277",
                @"HealthBar278",
                @"HealthBar279",
                @"HealthBar280",
                @"HealthBar281",
                @"HealthBar282",
                @"HealthBar283",
                @"HealthBar284",
                @"HealthBar285",
                @"HealthBar286",
                @"HealthBar287",
                @"HealthBar288",
                @"HealthBar289",
                @"HealthBar290",
                @"HealthBar291",
                @"HealthBar292",
                @"HealthBar293",
                @"HealthBar294",
                @"HealthBar295",
                @"HealthBar296",
                @"HealthBar297",
                @"HealthBar298",
                @"HealthBar299",
                @"HealthBar300",
                @"HealthBar301",
                @"HealthBar302",
                @"HealthBar303",
                @"HealthBar304",
                @"HealthBar305",
                @"HealthBar306",
                @"HealthBar307",
                @"HealthBar308",
                @"HealthBar309",
                @"HealthBar310",
                @"HealthBar311",
                @"HealthBar312",
                @"HealthBar313",
                @"HealthBar314",
                @"HealthBar315",
                @"HealthBar316",
                @"HealthBar317",
                @"HealthBar318",
                @"HealthBar319",
                @"HealthBar320",
                @"HealthBar321",
                @"HealthBar322",
                @"HealthBar323",
                @"HealthBar324",
                @"HealthBar325",
                @"HealthBar326",
                @"HealthBar327",
                @"HealthBar328",
                @"HealthBar329",
                @"HealthBar330",
                @"HealthBar331",
                @"HealthBar332",
                @"HealthBar333",
                @"HealthBar334",
                @"HealthBar335",
                @"HealthBar336",
                @"HealthBar337",
                @"HealthBar338",
                @"HealthBar339",
                @"HealthBar340",
                @"HealthBar341",
                @"HealthBar342",
                @"HealthBar343",
                @"HealthBar344",
                @"HealthBar345",
                @"HealthBar346",
                @"HealthBar347",
                @"HealthBar348",
                @"HealthBar349",
                @"HealthBar350",
                @"HealthBar351",
                @"HealthBar352",
                @"HealthBar353",
                @"HealthBar354",
                @"HealthBar355",
                @"HealthBar356",
                @"HealthBar357",
                @"HealthBar358",
                @"HealthBar359",
                @"HealthBar360",
                @"HealthBar361",
                @"HealthBar362",
                @"HealthBar363",
                @"HealthBar364",
                @"HealthBar365",
                @"HealthBar366",
                @"HealthBar367",
                @"HealthBar368",
                @"HealthBar369",
                @"HealthBar370",
                @"HealthBar371",
                @"HealthBar372",
                @"HealthBar373",
                @"HealthBar374",
                @"HealthBar375",
                @"HealthBar376",
                @"HealthBar377",
                @"HealthBar378",
                @"HealthBar379",
                @"HealthBar380",
                @"HealthBar381",
                @"HealthBar382",
                @"HealthBar383",
                @"HealthBar384",
                @"HealthBar385",
                @"HealthBar386",
                @"HealthBar387",
                @"HealthBar388",
                @"HealthBar389",
                @"HealthBar390",
                @"HealthBar391",
                @"HealthBar392",
                @"HealthBar393",
                @"HealthBar394",
                @"HealthBar395",
                @"HealthBar396",
                @"HealthBar397",
                @"HealthBar398",
                @"HealthBar399",
                @"HealthBar400"
                ];
    
                            humanHPArray = @[
                              @"HumanHealth1",
                              @"HumanHealth2",
                              @"HumanHealth3",
                              @"HumanHealth4",
                              @"HumanHealth5",
                              @"HumanHealth6",
                              @"HumanHealth7",
                              @"HumanHealth8",
                              @"HumanHealth9",
                              @"HumanHealth10",
                              @"HumanHealth11"
                              ];
    
}
-(void)foodsTextures {
    
    if (rankNumber == 0 || rankNumber == 1 || rankNumber == 2) {
        
        foodArray = @[
                      @"Apple",
                      @"RedBellPepper",
                      @"Broccoli",
                      @"Carrot",
                      @"Orange",
                      @"Pear",
                      @"Watermelon",
                      @"Corn",
                      @"Potato",
                      @"Banana"
                         ];
        
    }
    if (rankNumber == 3 || rankNumber == 4 || rankNumber == 5) {
        
        foodArray = @[
                      @"Pomegranite",
                      @"Cherry",
                      @"Coconut",
                      @"GreenGrapes",
                      @"ChiliPepper",
                      @"Celery",
                      @"Onion",
                      @"Kiwi",
                      @"Rutabaga",
                      @"CherryPie",
                      @"BrusselSprouts",
                      @"Pizza"
                      ];
        
    }
    if (rankNumber == 6 || rankNumber == 7 || rankNumber == 8) {
        
        foodArray = @[
                      @"PineApple",
                      @"Asparaus",
                      @"Avocado",
                      @"BeetrRoot",
                      @"Lime",
                      @"ButternutSquash",
                      @"Clementines",
                      @"StrawBerry",
                      @"DelicataSquash",
                      @"Garlic",
                      @"IceCream",
                      @"Chips",
                      @"Twix"
                      ];
        
    }
    if (rankNumber == 9 || rankNumber == 10 || rankNumber == 11) {
        
        foodArray = @[
                      @"Radish",
                      @"EggPlant",
                      @"Nectarine",
                      @"Mushroom",
                      @"Fig",
                      @"YellowBellPepper",
                      @"Pumpkin",
                      @"Lettuce",
                      @"Mango",
                      @"Lemon",
                      @"Guava",
                      @"Jelly",
                      @"LoliPop"
                      ];
        
    }
    if (rankNumber == 12 || rankNumber == 13 || rankNumber == 14) {
        
        foodArray = @[
                      @"VictoriaPlum",
                      @"Beet",
                      @"Cardoon",
                      @"Cucumber",
                      @"Turnip",
                      @"PeanutButter",
                      @"CupCake",
                      @"Eugenia",
                      @"GingerRoot",
                      @"GalioMuskMelon",
                      @"Peanut",
                      @"Tomato",
                      @"Quince"
                      ];
        
    }
    if (rankNumber == 15 || rankNumber == 16 || rankNumber == 17) {
        
        foodArray = @[
                      @"Ugli",
                      @"HoneyDewMelon",
                      @"BokChoy",
                      @"Cassava",
                      @"CollardGreens",
                      @"CornDog",
                      @"Twinky",
                      @"Pickle",
                      @"Zucini",
                      @"Diakon",
                      @"Olives",
                      @"GingerRoot",
                      @"SourSop"
                      ];
        
    }
    if (rankNumber == 18 || rankNumber == 19 || rankNumber == 20) {
        
        foodArray = @[
                      @"Chayote",
                      @"Cilantro",
                      @"Citron",
                      @"Dasheen",
                      @"Achoccha",
                      @"Artichoke",
                      @"GreenChilliPepper",
                      @"AsianRadish",
                      @"SugarApple",
                      @"Ackee",
                      @"Brownie",
                      @"Taco",
                      @"Burger",
                      @"Cake"
                      ];
        
    }
    if (rankNumber == 21 || rankNumber == 22 || rankNumber == 23) {
        
        foodArray = @[
                      @"Endive",
                      @"Yam",
                      @"Fennel",
                      @"Leek",
                      @"Steak",
                      @"HotDog",
                      @"Butter",
                      @"HornedCucumber",
                      @"Durain",
                      @"MangoSteen",
                      @"Cherimoya",
                      @"MonsteraDeliciosa",
                      @"Oca"
                      ];
        
    }
    if (rankNumber == 24 || rankNumber == 25 || rankNumber == 26) {
        
        foodArray = @[
                      @"Kahlrabi",
                      @"Salsify",
                      @"Celeriac",
                      @"Moniac",
                      @"Sunchok",
                      @"AguajeFruit",
                      @"JackFruit",
                      @"Capuaca",
                      @"Pepino",
                      @"DragonFruit",
                      @"Candy",
                      @"Chicken",
                      @"ChimiChunga",
                      @"RiceKrispy"
                      ];
        
    }
    if (rankNumber == 27 || rankNumber == 28 || rankNumber == 29) {
        
        foodArray = @[
                      @"Apple",
                      @"RedBellPepper",
                      @"Broccoli",
                      @"Carrot",
                      @"Orange",
                      @"Pear",
                      @"Watermelon",
                      @"Corn",
                      @"Potato",
                      @"Banana",
                      @"Pomegranite",
                      @"Cherry",
                      @"Coconut",
                      @"GreenGrapes",
                      @"ChiliPepper",
                      @"Celery",
                      @"Onion",
                      @"Kiwi",
                      @"Rutabaga",
                      @"CherryPie",
                      @"BrusselSprouts",
                      @"Pizza",
                      @"PineApple",
                      @"Asparaus",
                      @"Avocado",
                      @"BeetrRoot",
                      @"Lime",
                      @"ButternutSquash",
                      @"Clementines",
                      @"StrawBerry",
                      @"DelicataSquash",
                      @"Garlic",
                      @"IceCream",
                      @"Chips",
                      @"Twix",
                      @"Radish",
                      @"EggPlant",
                      @"Nectarine",
                      @"Mushroom",
                      @"Fig",
                      @"YellowBellPepper",
                      @"Pumpkin",
                      @"Lettuce",
                      @"Mango",
                      @"Lemon",
                      @"Guava",
                      @"Jelly",
                      @"LoliPop",
                      @"VictoriaPlum",
                      @"Beet",
                      @"Cardoon",
                      @"Cucumber",
                      @"Turnip",
                      @"PeanutButter",
                      @"CupCake",
                      @"Eugenia",
                      @"GingerRoot",
                      @"GalioMuskMelon",
                      @"Peanut",
                      @"Tomato",
                      @"Quince",
                      @"Ugli",
                      @"HoneyDewMelon",
                      @"BokChoy",
                      @"Cassava",
                      @"CollardGreens",
                      @"CornDog",
                      @"Twinky",
                      @"Pickle",
                      @"Zucini",
                      @"Diakon",
                      @"Olives",
                      @"GingerRoot",
                      @"SourSop",
                      @"Chayote",
                      @"Cilantro",
                      @"Citron",
                      @"Dasheen",
                      @"Achoccha",
                      @"Artichoke",
                      @"GreenChilliPepper",
                      @"AsianRadish",
                      @"SugarApple",
                      @"Ackee",
                      @"Brownie",
                      @"Taco",
                      @"Burger",
                      @"Cake",
                      @"Endive",
                      @"Yam",
                      @"Fennel",
                      @"Leek",
                      @"Steak",
                      @"HotDog",
                      @"Butter",
                      @"HornedCucumber",
                      @"Durain",
                      @"MangoSteen",
                      @"Cherimoya",
                      @"MonsteraDeliciosa",
                      @"Oca",
                      @"Kahlrabi",
                      @"Salsify",
                      @"Celeriac",
                      @"Moniac",
                      @"Sunchok",
                      @"AguajeFruit",
                      @"JackFruit",
                      @"Capuaca",
                      @"Pepino",
                      @"DragonFruit",
                      @"Candy",
                      @"Chicken",
                      @"ChimiChunga",
                      @"RiceKrispy"
                      ];
        
    }
    
}
-(void)blinkData {
    
    NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
    cantLock1Blink = [defaults1 boolForKey:@"cantLock1Blink"];
    
    NSUserDefaults *defaults2 = [NSUserDefaults standardUserDefaults];
    cantLock2Blink = [defaults2 boolForKey:@"cantLock2Blink"];
    
    NSUserDefaults *defaults3 = [NSUserDefaults standardUserDefaults];
    cantLock3Blink = [defaults3 boolForKey:@"cantLock3Blink"];
}
-(void)initialPowerUpCode {
    
}

@end
