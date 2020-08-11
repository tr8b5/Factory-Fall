//
//  FBLabelLogic.h
//  Factory Fall
//
//  Created by Willie on 2/28/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import <Foundation/Foundation.h>

BOOL boughtDP;
BOOL boughtTP;
BOOL boughtQP;
BOOL boughtEL1;
BOOL boughtEL2;
BOOL boughtEL3;
BOOL boughtHG10;
BOOL boughtHG20;
BOOL boughtHG30;
BOOL boughtHS10;
BOOL boughtHS20;
BOOL boughtHS30;

@interface FBLabelLogic : NSObject{
}
-(void)buyDPCheck;
-(void)buyTPCheck;
-(void)buyQPCheck;
-(void)buyEL1Check;
-(void)buyEL2Check;
-(void)buyEL3Check;
-(void)buyHG10Check;
-(void)buyHG20Check;
-(void)buyHG30Check;
-(void)buyHS10Check;
-(void)buyHS20Check;
-(void)buyHS30Check;
@property (nonatomic) BOOL canPurchase;
@end
