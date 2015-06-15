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
        if (![dictionary[@"id"] isKindOfClass:[NSNull class]]) {
            _ID = [dictionary[@"id"] integerValue];
        }
        if (![dictionary[@"title"] isKindOfClass:[NSNull class]]) {
            _title = dictionary[@"title"];
        }
    }
    return self;
}

@end
