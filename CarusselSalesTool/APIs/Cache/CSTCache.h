//
//  CSTCache.h
//  CarusselSalesTool
//
//  Created by AnatoliyDalekorey on 29.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Car.h"
#import "Prospect.h"

@interface CSTCache : NSObject

@property (strong, atomic) NSCache *carsList;
@property (strong, atomic) NSCache *prospectList;

- (Car *)getCarWithID:(NSNumber *)ID;

@end
