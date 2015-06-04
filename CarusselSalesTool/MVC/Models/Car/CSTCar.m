//
//  CSTCar.m
//  OpelHu
//
//  Created by AnatoliyDalekorey on 22.12.14.
//  Copyright (c) 2014 Thinkmobiles. All rights reserved.
//

#import "CSTCar.h"

@implementation CSTCar

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _ID = [dictionary[@"id"] integerValue];
        _title = dictionary[@"title"];
        _status = [dictionary[@"status"] integerValue];
        _price = [dictionary[@"price"] integerValue];
        _discountPrice = [dictionary[@"discountPrice"] integerValue];
        _mileage = [dictionary[@"mileage"] integerValue];
    }
    return self;
}

@end
