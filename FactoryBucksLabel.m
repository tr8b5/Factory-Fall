//
//  FactoryBucksLabel.m
//  Factory Fall
//
//  Created by Willie on 2/25/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import "FactoryBucksLabel.h"
#import "FBLabelLogic.h"
#import "Data.h"

@implementation FactoryBucksLabel
+(id)FBLabelWithFontNamed:(NSString *)fontName
{
    
    FactoryBucksLabel *amountLabel = [FactoryBucksLabel labelNodeWithFontNamed:fontName];
    amountLabel.text = @"0";
    amountLabel.amount = amountFB;
    
    return amountLabel;
}

-(void)incrementAmount {
    
    amountFB += payAprox;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)incrementBy500 {
    amountFB += 500;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)incrementBy750 {
    amountFB += 750;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)incrementBy1000 {
    amountFB += 1000;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)incrementBy1250 {
    amountFB += 1250;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)incrementBy2000 {
    amountFB += 2000;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)incrementBy3000 {
    amountFB += 3000;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)incrementBy4000 {
    amountFB += 4000;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)incrementBy5500 {
    amountFB += 5500;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)incrementBy6000 {
    amountFB += 6000;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)incrementBy7000 {
    amountFB += 7000;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)incrementBy8000 {
    amountFB += 8000;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)incrementBy8500 {
    amountFB += 8500;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)incrementBy9000 {
    amountFB += 9000;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)incrementBy30000 {
    amountFB += 30000;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)incrementBy5000 {
    amountFB += 5000;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)incrementBy10000 {
    amountFB += 10000;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)incrementBy27000 {
    amountFB += 27000;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)incrementBy45000 {
    amountFB += 45000;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)incrementBy50000 {
    amountFB += 50000;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)incrementBy72000 {
    amountFB += 72000;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)incrementBy75000 {
    amountFB += 75000;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)incrementBy100000 {
    amountFB += 100000;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)incrementBy144000 {
    amountFB += 144000;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)incrementBy150000 {
    amountFB += 150000;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)incrementBy300000 {
    amountFB += 300000;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)decrementBy1000{
    amountFB -= 1000;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)decrementBy3000 {
    amountFB -= 3000;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)decrementBy6000 {
    amountFB -= 6000;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)decrementBy9000 {
    amountFB -= 9000;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)decrementBy10000 {
    amountFB -= 10000;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}
-(void)decrementBy20000 {
    amountFB -= 20000;
    self.text = [NSString stringWithFormat:@"%li", (long)amountFB];
}


-(void)setPoints:(NSInteger)points {
    self.amount = points;
    self.text = [NSString stringWithFormat:@"%li", (long)self.amount];
}
@end
