//
//  CSTMakeCar.m
//  OpelHu
//
//  Created by AnatoliyDalekorey on 23.12.14.
//  Copyright (c) 2014 Thinkmobiles. All rights reserved.
//

#import "CSTMakeCar.h"

@implementation CSTMakeCar

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
