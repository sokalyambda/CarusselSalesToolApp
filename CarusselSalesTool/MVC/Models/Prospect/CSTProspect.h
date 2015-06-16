//
//  CSTProspect.h
//  CarusselSalesTool
//
//  Created by Eugenity on 26.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTMappingProtocol.h"

@interface CSTProspect : NSObject <CSTMappingProtocol>

@property (assign, readonly) NSInteger ID;
@property (assign) NSString *firstName;
@property (assign) NSString *lastName;
@property (strong, readonly) NSString *fullName;
@property (strong) NSString *town;
@property (strong) NSDate *born;
@property (assign) NSInteger carMatches;

@end
