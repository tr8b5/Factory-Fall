//
//  UserName.m
//  Factory Fall
//
//  Created by Willie on 4/9/15.
//  Copyright (c) 2015 Fluxfire. All rights reserved.
//

#import "UserName.h"

@implementation UserName
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self != nil) {
        self.userName = [aDecoder decodeObjectForKey:@"userNamer"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[self userName] forKey:@"userName"];
}
@end
