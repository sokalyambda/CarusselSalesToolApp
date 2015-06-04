//
//  CSTLogin.m
//  OpelHu
//
//  Created by AnatoliyDalekorey on 22.12.14.
//  Copyright (c) 2014 Thinkmobiles. All rights reserved.
//

#import "CSTCompany.h"
#import "CSTLocation.h"

@implementation CSTCompany

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _firstName = dictionary[@"firstName"];
        _lastName = dictionary[@"lastName"];
        _companyName = dictionary[@"companyName"];
        _dealerCodes = dictionary[@"dealerCodes"];
        _location = dictionary[@"locations"];
    }
    return self;
}

@end
