//
//  NormalLogic.m
//  practice
//
//  Created by Willie on 12/24/14.
//  Copyright (c) 2014 Fluxfire. All rights reserved.
//

#import "NormalLogic.h"


@implementation NormalLogic {
    Food *_foods[NumSpawns];
    
    
}
- (NSSet *)shuffle {
    
    return [self createInitialFoods];
    
}

- (NSSet *)createInitialFoods {
    NSMutableSet *set = [NSMutableSet set];
    
    //1
    for (NSInteger spawn = 0; spawn < NumSpawns; spawn++){
        
            // 2
            NSUInteger foodType = arc4random_uniform(NumFoodTypes) + 1;
            
                //3
            Food *food = [self createFoodAtSpawn:spawn withType:foodType];
                
            // 4
            [set addObject:food];
        
        
        
    }
    return set;
}
- (Food *)createFoodAtSpawn:(NSInteger)spawn withType:(NSInteger)foodType {
    Food *food = [[Food alloc] init];
    food.foodType = foodType;
    food.spawn = spawn;
    _foods[spawn] = food;
    return food;
}
- (NSSet *)shuffle1 {
    
    return [self createInitialFoods1];
    
}
- (NSSet *)createInitialFoods1 {
    NSMutableSet *set = [NSMutableSet set];
    
    //1
    for (NSInteger spawn = 0; spawn < NumSpawns; spawn++){
        
        // 2
        NSUInteger foodType = arc4random_uniform(NumFoodTypes1) + 1;
        
        //3
        Food *food1 = [self createFoodAtSpawn:spawn withType:foodType];
        
        // 4
        [set addObject:food1];
        
        
        
    }
    return set;
}
- (NSSet *)shuffle2 {
    
    return [self createInitialFoods2];
    
}
- (NSSet *)createInitialFoods2 {
    NSMutableSet *set = [NSMutableSet set];
    
    //1
    for (NSInteger spawn = 0; spawn < NumSpawns; spawn++){
        
        // 2
        NSUInteger foodType = arc4random_uniform(NumFoodTypes2) + 1;
        
        //3
        Food *food2 = [self createFoodAtSpawn:spawn withType:foodType];
        
        // 4
        [set addObject:food2];
        
        
        
    }
    return set;
}
- (NSSet *)shuffle3 {
    
    return [self createInitialFoods3];
    
}
- (NSSet *)createInitialFoods3 {
    NSMutableSet *set = [NSMutableSet set];
    
    //1
    for (NSInteger spawn = 0; spawn < NumSpawns; spawn++){
        
        // 2
        NSUInteger foodType = arc4random_uniform(NumFoodTypes3) + 1;
        
        //3
        Food *food3 = [self createFoodAtSpawn:spawn withType:foodType];
        
        // 4
        [set addObject:food3];
        
        
        
    }
    return set;
}
- (NSSet *)shuffle4 {
    
    return [self createInitialFoods4];
    
}
- (NSSet *)createInitialFoods4 {
    NSMutableSet *set = [NSMutableSet set];
    
    //1
    for (NSInteger spawn = 0; spawn < NumSpawns; spawn++){
        
        // 2
        NSUInteger foodType = arc4random_uniform(NumFoodTypes4) + 1;
        
        //3
        Food *food4 = [self createFoodAtSpawn:spawn withType:foodType];
        
        // 4
        [set addObject:food4];
        
        
        
    }
    return set;
}
- (NSSet *)shuffle5 {
    
    return [self createInitialFoods5];
    
}
- (NSSet *)createInitialFoods5 {
    NSMutableSet *set = [NSMutableSet set];
    
    //1
    for (NSInteger spawn = 0; spawn < NumSpawns; spawn++){
        
        // 2
        NSUInteger foodType = arc4random_uniform(NumFoodTypes5) + 1;
        
        //3
        Food *food5 = [self createFoodAtSpawn:spawn withType:foodType];
        
        // 4
        [set addObject:food5];
        
        
        
    }
    return set;
}
- (NSSet *)shuffle6 {
    
    return [self createInitialFoods6];
    
}
- (NSSet *)createInitialFoods6 {
    NSMutableSet *set = [NSMutableSet set];
    
    //1
    for (NSInteger spawn = 0; spawn < NumSpawns; spawn++){
        
        // 2
        NSUInteger foodType = arc4random_uniform(NumFoodTypes6) + 1;
        
        //3
        Food *food6 = [self createFoodAtSpawn:spawn withType:foodType];
        
        // 4
        [set addObject:food6];
        
        
        
    }
    return set;
}
- (NSSet *)shuffle7 {
    
    return [self createInitialFoods7];
    
}
- (NSSet *)createInitialFoods7 {
    NSMutableSet *set = [NSMutableSet set];
    
    //1
    for (NSInteger spawn = 0; spawn < NumSpawns; spawn++){
        
        // 2
        NSUInteger foodType = arc4random_uniform(NumFoodTypes7) + 1;
        
        //3
        Food *food7 = [self createFoodAtSpawn:spawn withType:foodType];
        
        // 4
        [set addObject:food7];
        
        
        
    }
    return set;
}
- (NSSet *)shuffle8 {
    
    return [self createInitialFoods8];
    
}
- (NSSet *)createInitialFoods8 {
    NSMutableSet *set = [NSMutableSet set];
    
    //1
    for (NSInteger spawn = 0; spawn < NumSpawns; spawn++){
        
        // 2
        NSUInteger foodType = arc4random_uniform(NumFoodTypes8) + 1;
        
        //3
        Food *food8 = [self createFoodAtSpawn:spawn withType:foodType];
        
        // 4
        [set addObject:food8];
        
        
        
    }
    return set;
}
- (NSSet *)shuffle9 {
    
    return [self createInitialFoods9];
    
}
- (NSSet *)createInitialFoods9 {
    NSMutableSet *set = [NSMutableSet set];
    
    //1
    for (NSInteger spawn = 0; spawn < NumSpawns; spawn++){
        
        // 2
        NSUInteger foodType = arc4random_uniform(NumFoodTypes9) + 1;
        
        //3
        Food *food9 = [self createFoodAtSpawn:spawn withType:foodType];
        
        // 4
        [set addObject:food9];
        
        
        
    }
    return set;
}
- (NSSet *)shuffle10 {
    
    return [self createInitialFoods10];
    
}
- (NSSet *)createInitialFoods10 {
    NSMutableSet *set = [NSMutableSet set];
    
    //1
    for (NSInteger spawn = 0; spawn < NumSpawns; spawn++){
        
        // 2
        NSUInteger foodType = arc4random_uniform(NumFoodTypes10) + 1;
        
        //3
        Food *food10 = [self createFoodAtSpawn:spawn withType:foodType];
        
        // 4
        [set addObject:food10];
        
        
        
    }
    return set;
}
- (NSSet *)shuffle11 {
    
    return [self createInitialFoods11];
    
}
- (NSSet *)createInitialFoods11 {
    NSMutableSet *set = [NSMutableSet set];
    
    //1
    for (NSInteger spawn = 0; spawn < NumSpawns; spawn++){
        
        // 2
        NSUInteger foodType = arc4random_uniform(NumFoodTypes11) + 1;
        
        //3
        Food *food11 = [self createFoodAtSpawn:spawn withType:foodType];
        
        // 4
        [set addObject:food11];
        
        
        
    }
    return set;
}

/*- (Food *)createFoodAtSpawn1:(NSInteger)spawn withType:(NSInteger)foodType {
    Food *food = [[Food alloc] init];
    food.foodType = foodType;
    food.spawn = spawn;
    _foods[spawn] = food;
    return food;
}*/

@end
