//
//  CSTCache.m
//  CarusselSalesTool
//
//  Created by AnatoliyDalekorey on 29.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTCache.h"

@implementation CSTCache

- (instancetype)init
{
    self = [super init];
    if (self) {
        _carsList = [NSCache new];
        _prospectList = [NSCache new];
    }
    return self;
}

- (Car *)getCarWithID:(NSNumber *)ID
{
    Car *car = [self.carsList objectForKey:ID];
    return car;
}

@end
