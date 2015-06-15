//
//  CSTCompany.h
//  OpelHu
//
//  Created by AnatoliyDalekorey on 22.12.14.
//  Copyright (c) 2014 Thinkmobiles. All rights reserved.
//

#import "CSTLocation.h"
#import "CSTMappingProtocol.h"

@interface CSTCompany : NSObject <CSTMappingProtocol>

@property (copy) NSString *firstName;
@property (copy) NSString *lastName;
@property (copy) NSString *companyName;
@property (copy) NSArray *dealerCodes;
@property (copy) NSArray *location;

@end
