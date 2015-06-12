//
//  CSTProspect.m
//  CarusselSalesTool
//
//  Created by Eugenity on 26.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTProspect.h"

@implementation CSTProspect

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _ID = random()%60;
        _firstName = [NSString stringWithFormat:@"First Name %i", _ID];
        _lastName = [NSString stringWithFormat:@"Last Name %i", _ID];
        _town = [NSString stringWithFormat:@"Town %i", _ID];
        _born = [NSDate date];
        _carMatches = random()%100;
    }
    return self;
}

- (NSString *)fullName
{
    NSString *_fullName;
    _fullName = [NSString stringWithFormat:@"%@ %@", _firstName, _lastName];
    return _fullName;
}

@end
