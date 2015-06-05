//
//  CSTImageCar.m
//  OpelHu
//
//  Created by AnatoliyDalekorey on 23.12.14.
//  Copyright (c) 2014 Thinkmobiles. All rights reserved.
//

#import "CSTImageCar.h"

@implementation CSTImageCar

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _ID = [dictionary[@"id"] integerValue];
        _thumbnailUrl = dictionary[@"thumbnailUrl"];
        _mediumUrl = dictionary[@"mediumUrl"];
        _origUrl = dictionary[@"origUrl"];
        _orderIndex = [dictionary[@"orderIndex"] integerValue];
    }
    return self;
}

@end
