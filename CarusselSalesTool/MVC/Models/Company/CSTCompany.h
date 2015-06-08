//
//  CSTCompany.h
//  OpelHu
//
//  Created by AnatoliyDalekorey on 22.12.14.
//  Copyright (c) 2014 Thinkmobiles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSTLocation.h"

@interface CSTCompany : NSObject

@property (copy) NSString *firstName;
@property (copy) NSString *lastName;
@property (copy) NSString *companyName;
@property (copy) NSArray *dealerCodes;
@property (copy) NSArray *location;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
