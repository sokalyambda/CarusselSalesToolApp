//
//  CSTTask.m
//  CarusselSalesTool
//
//  Created by AnatoliyDalekorey on 10.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTTask.h"

@implementation CSTTask

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _ID = random()%20;
        _prospectID = random()%40;
        _prospectName = [NSString stringWithFormat:@"User %li", _prospectID];
        _date = [NSDate date];
    }
    return self;
}

@end
