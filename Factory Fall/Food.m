//
//  Food.m
//  practice
//
//  Created by Willie on 12/24/14.
//  Copyright (c) 2014 Fluxfire. All rights reserved.
//

#import "Food.h"


@implementation Food
+ (id)Food
{
    
    return 0;
}

- (NSString *)spriteName {
    static NSString * const spriteNames[] = {
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
    };
    
    return spriteNames[self.foodType - 1];
}
- (NSString *)spriteName1 {
    static NSString * const spriteNames[] = {
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
        
    };
    
    return spriteNames[self.foodType - 1];
}
- (NSString *)spriteName2 {
    static NSString * const spriteNames[] = {
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
        
    };
    
    return spriteNames[self.foodType - 1];
}
- (NSString *)spriteName3 {
    static NSString * const spriteNames[] = {
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
        
    };
    
    return spriteNames[self.foodType - 1];
}

- (NSString *)spriteName4 {
    static NSString * const spriteNames[] = {
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
        
    };
    
    return spriteNames[self.foodType - 1];
}
- (NSString *)spriteName5 {
    static NSString * const spriteNames[] = {
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
        
    };
    
    return spriteNames[self.foodType - 1];
}
- (NSString *)spriteName6 {
    static NSString * const spriteNames[] = {
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
        
    };
    
    return spriteNames[self.foodType - 1];
}
- (NSString *)spriteName7 {
    static NSString * const spriteNames[] = {
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
        
    };
    
    return spriteNames[self.foodType - 1];
}
- (NSString *)spriteName8 {
    static NSString * const spriteNames[] = {
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
        @"RiceKrispy",
    };
    
    return spriteNames[self.foodType - 1];
}
- (NSString *)spriteName9 {
    static NSString * const spriteNames[] = {
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
        @"RiceKrispy",
    };
    
    return spriteNames[self.foodType - 1];
}
- (NSString *)spriteName10 {
    static NSString * const spriteNames[] = {
        @"Pomegranite",
        @"Cherry",
        @"Coconut",
        @"Lemon",
        @"Grapes",
        @"Mango",
        @"Onion",
        //@"EggPlant",
        //@"Tomato",
        //@"Radish",
        //@"ChilliPepper",
        //@"Garlic",
        //@"Pie",
        //@"Cake",
        //@"Pizza",
        //@"CheeseBurger",
    };
    
    return spriteNames[self.foodType - 1];
}
- (NSString *)spriteName11 {
    static NSString * const spriteNames[] = {
        @"Pomegranite",
        @"Cherry",
        @"Coconut",
        @"Lemon",
        @"Grapes",
        @"Mango",
        @"Onion",
        //@"EggPlant",
        //@"Tomato",
        //@"Radish",
        //@"ChilliPepper",
        //@"Garlic",
        //@"Pie",
        //@"Cake",
        //@"Pizza",
        //@"CheeseBurger",
    };
    
    return spriteNames[self.foodType - 1];
}
- (NSString *)spriteName12 {
    static NSString * const spriteNames[] = {
        @"Pomegranite",
        @"Cherry",
        @"Coconut",
        @"Lemon",
        @"Grapes",
        @"Mango",
        @"Onion",
        //@"EggPlant",
        //@"Tomato",
        //@"Radish",
        //@"ChilliPepper",
        //@"Garlic",
        //@"Pie",
        //@"Cake",
        //@"Pizza",
        //@"CheeseBurger",
    };
    
    return spriteNames[self.foodType - 1];
}
- (NSString *)description {
    return [NSString stringWithFormat:@"type:%ld square:(%ld)", (long)self.foodType,(long)self.spawn];
            }
@end
