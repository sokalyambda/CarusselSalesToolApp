//
//  CSTCache.h
//  CarusselSalesTool
//
//  Created by AnatoliyDalekorey on 29.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTCar.h"
#import "Prospect.h"
#import "CSTCompany.h"

@interface CSTCache : NSObject

@property (strong, atomic) NSCache *carsList;
@property (strong, atomic) NSCache *prospectList;

- (CSTCar *)getCarWithID:(NSNumber *)ID;

@end
