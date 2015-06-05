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
        if (![dictionary[@"title"] isKindOfClass:[NSNull class]]) {
            _title = dictionary[@"title"];
        }
        _status = [dictionary[@"status"] integerValue];
        if (![dictionary[@"price"] isKindOfClass:[NSNull class]]) {
            _price = [dictionary[@"price"] integerValue];
        }
        if (![dictionary[@"discountPrice"] isKindOfClass:[NSNull class]]) {
            _discountPrice = [dictionary[@"discountPrice"] integerValue];
        }
        _mileage = [dictionary[@"mileage"] integerValue];
        _make = [[CSTMakeCar alloc] initWithDictionary:dictionary[@"make"]];
        _modelGroup = [[CSTModelGroup alloc] initWithDictionary:dictionary[@"modelGroup"]];
        _defaultImage = [[CSTImageCar alloc] initWithDictionary:dictionary[@"defaultImage"]];
        if (![dictionary[@"images"] isKindOfClass:[NSNull class]]) {
            NSMutableArray *tempList = [NSMutableArray new];
            for (NSDictionary *dic in dictionary[@"images"]) {
                [tempList addObject:[[CSTImageCar alloc] initWithDictionary:dic]];
            }
            _images = [tempList copy];
        }
    }
    return self;
}

@end
