//
//  CSTBaseModel.m
//  CarusselSalesTool
//
//  Created by AnatoliyDalekorey on 15.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTBaseModel.h"

@implementation CSTBaseModel

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
