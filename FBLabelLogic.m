//
//  FBLabelLogic.m
//  Factory Fall
//
//  Created by Willie on 2/28/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import "FBLabelLogic.h"
#import "ShopLogic.h"
#import "Data.h"

@implementation FBLabelLogic
//------DoublePoint------//
-(void)didNotBuyDP {
    boughtDP = NO;
}
-(void)buyDPCheck {
    
    if (amountFB >= 3000) {
        ShopLogic *buy = [[ShopLogic alloc]init];
        [buy buyDP];
        boughtDP = YES;
    }
    if (amountFB < 3000) {
        NSLog(@"%ld", (long)amountFB);
        ShopLogic *dontBuy = [[ShopLogic alloc]init];
        [dontBuy cantBuyDP];
        [self performSelector:@selector(didNotBuyDP) withObject:self afterDelay:0.1];
    }
    
}
//------TriplePoint------//
-(void)didNotBuyTP {
    boughtTP = NO;
}
-(void)buyTPCheck {
    if (amountFB >= 6000) {
        ShopLogic *buy = [[ShopLogic alloc]init];
        [buy buyTP];
        boughtTP = YES;
    }
    if (amountFB < 6000) {
        NSLog(@"%ld", (long)amountFB);
        ShopLogic *dontBuy = [[ShopLogic alloc]init];
        [dontBuy cantBuyTP];
        [self performSelector:@selector(didNotBuyTP) withObject:self afterDelay:0.1];
    }
    
}
//------QuadPoint------//
-(void)didNotBuyQP {
    boughtQP = NO;
}
-(void)buyQPCheck {
    if (amountFB >= 9000) {
        ShopLogic *buy = [[ShopLogic alloc]init];
        [buy buyQP];
        boughtQP = YES;
    }
    if (amountFB < 9000) {
        NSLog(@"%ld", (long)amountFB);
        ShopLogic *dontBuy = [[ShopLogic alloc]init];
        [dontBuy cantBuyQP];
        [self performSelector:@selector(didNotBuyQP) withObject:self afterDelay:0.1];
    }
    
}
//------ExtraLife1------//
-(void)didNotBuyEL1 {
    boughtEL1 = NO;
}
-(void)buyEL1Check {
    if (amountFB >= 3000) {
        ShopLogic *buy = [[ShopLogic alloc]init];
        [buy buyEL1];
        boughtEL1 = YES;
    }
    if (amountFB < 3000) {
        NSLog(@"%ld", (long)amountFB);
        ShopLogic *dontBuy = [[ShopLogic alloc]init];
        [dontBuy cantBuyEL1];
        [self performSelector:@selector(didNotBuyEL1) withObject:self afterDelay:0.1];
    }
    
}
//------ExtraLife2------//
-(void)didNotBuyEL2 {
    boughtEL2 = NO;
}
-(void)buyEL2Check {
    if (amountFB >= 6000) {
        ShopLogic *buy = [[ShopLogic alloc]init];
        [buy buyEL2];
        boughtEL2 = YES;
    }
    if (amountFB < 6000) {
        NSLog(@"%ld", (long)amountFB);
        ShopLogic *dontBuy = [[ShopLogic alloc]init];
        [dontBuy cantBuyEL2];
        [self performSelector:@selector(didNotBuyEL2) withObject:self afterDelay:0.1];
    }
    
}
//------ExtraLife3------//
-(void)didNotBuyEL3 {
    boughtEL3 = NO;
}
-(void)buyEL3Check {
    if (amountFB >= 9000) {
        ShopLogic *buy = [[ShopLogic alloc]init];
        [buy buyEL3];
        boughtEL3 = YES;
    }
    if (amountFB < 9000) {
        NSLog(@"%ld", (long)amountFB);
        ShopLogic *dontBuy = [[ShopLogic alloc]init];
        [dontBuy cantBuyEL3];
        [self performSelector:@selector(didNotBuyEL3) withObject:self afterDelay:0.1];
    }
    
}
//------HourGlass10------//
-(void)didNotBuyHG10 {
    boughtHG10 = NO;
}
-(void)buyHG10Check {
    if (amountFB >= 6000) {
        ShopLogic *buy = [[ShopLogic alloc]init];
        [buy buyHG10];
        boughtHG10 = YES;
    }
    if (amountFB < 6000) {
        NSLog(@"%ld", (long)amountFB);
        ShopLogic *dontBuy = [[ShopLogic alloc]init];
        [dontBuy cantBuyHG10];
        [self performSelector:@selector(didNotBuyHG10) withObject:self afterDelay:0.1];
    }
    
}
//------HourGlass20------//
-(void)didNotBuyHG20 {
    boughtHG20 = NO;
}
-(void)buyHG20Check {
    if (amountFB >= 10000) {
        ShopLogic *buy = [[ShopLogic alloc]init];
        [buy buyHG20];
        boughtHG20 = YES;
    }
    if (amountFB < 10000) {
        NSLog(@"%ld", (long)amountFB);
        ShopLogic *dontBuy = [[ShopLogic alloc]init];
        [dontBuy cantBuyHG20];
        [self performSelector:@selector(didNotBuyHG20) withObject:self afterDelay:0.1];
    }
    
}
//------HourGlass30------//
-(void)didNotBuyHG30 {
    boughtHG30 = NO;
}
-(void)buyHG30Check {
    if (amountFB >= 20000) {
        ShopLogic *buy = [[ShopLogic alloc]init];
        [buy buyHG30];
        boughtHG30 = YES;
    }
    if (amountFB < 20000) {
        NSLog(@"%ld", (long)amountFB);
        ShopLogic *dontBuy = [[ShopLogic alloc]init];
        [dontBuy cantBuyHG30];
        [self performSelector:@selector(didNotBuyHG30) withObject:self afterDelay:0.1];
    }
    
}
//------HeadStart10------//
-(void)didNotBuyHS10 {
    boughtHS10 = NO;
}
-(void)buyHS10Check {
    if (amountFB >= 6000) {
        ShopLogic *buy = [[ShopLogic alloc]init];
        [buy buyHS10];
        boughtHS10 = YES;
    }
    if (amountFB < 6000) {
        NSLog(@"%ld", (long)amountFB);
        ShopLogic *dontBuy = [[ShopLogic alloc]init];
        [dontBuy cantBuyHS10];
        [self performSelector:@selector(didNotBuyHS10) withObject:self afterDelay:0.1];
    }
    
}
//------HeadStart20------//
-(void)didNotBuyHS20 {
    boughtHS20 = NO;
}
-(void)buyHS20Check {
    if (amountFB >= 10000) {
        ShopLogic *buy = [[ShopLogic alloc]init];
        [buy buyHS20];
        boughtHS20 = YES;
    }
    if (amountFB < 10000) {
        NSLog(@"%ld", (long)amountFB);
        ShopLogic *dontBuy = [[ShopLogic alloc]init];
        [dontBuy cantBuyHS20];
        [self performSelector:@selector(didNotBuyHS20) withObject:self afterDelay:0.1];
    }
    
}
//------HeadStart30------//
-(void)didNotBuyHS30 {
    boughtHS30 = NO;
}
-(void)buyHS30Check {
    if (amountFB >= 20000) {
        ShopLogic *buy = [[ShopLogic alloc]init];
        [buy buyHS30];
        boughtHS30 = YES;
    }
    if (amountFB < 20000) {
        NSLog(@"%ld", (long)amountFB);
        ShopLogic *dontBuy = [[ShopLogic alloc]init];
        [dontBuy cantBuyHS30];
        [self performSelector:@selector(didNotBuyHS30) withObject:self afterDelay:0.1];
    }
    
}

@end
