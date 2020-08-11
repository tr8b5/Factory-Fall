//
//  Food.h
//  practice
//
//  Created by Willie on 12/24/14.
//  Copyright (c) 2014 Fluxfire. All rights reserved.
//

#import <Foundation/Foundation.h>
@import SpriteKit;

static const NSUInteger NumFoodTypes = 10;
static const NSUInteger NumFoodTypes1 = 12;
static const NSUInteger NumFoodTypes2 = 13;
static const NSUInteger NumFoodTypes3 = 13;
static const NSUInteger NumFoodTypes4 = 13;
static const NSUInteger NumFoodTypes5 = 13;
static const NSUInteger NumFoodTypes6 = 14;
static const NSUInteger NumFoodTypes7 = 13;
static const NSUInteger NumFoodTypes8 = 14;
static const NSUInteger NumFoodTypes9 = 116;
static const NSUInteger NumFoodTypes10 = 27;
static const NSUInteger NumFoodTypes11 = 32;

@interface Food : NSObject


@property (nonatomic) NSUInteger spawn;
@property (nonatomic) NSUInteger foodType;
@property (nonatomic) SKSpriteNode *sprite;



- (NSString *)spriteName;
- (NSString *)spriteName1;
- (NSString *)spriteName2;
- (NSString *)spriteName3;
- (NSString *)spriteName4;
- (NSString *)spriteName5;
- (NSString *)spriteName6;
- (NSString *)spriteName7;
- (NSString *)spriteName8;
- (NSString *)spriteName9;
- (NSString *)spriteName10;
- (NSString *)spriteName11;
@end
