//
//  OHLocation.m
//  OpelHu
//
//  Created by AnatoliyDalekorey on 10.01.15.
//  Copyright (c) 2015 Thinkmobiles. All rights reserved.
//

#import "CSTLocation.h"

@implementation CSTLocation

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _ID = [dictionary[@"id"] integerValue];
        _title = dictionary[@"title"];
    }
    return self;
}

@end
