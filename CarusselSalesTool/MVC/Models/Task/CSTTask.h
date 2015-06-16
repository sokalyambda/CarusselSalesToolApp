//
//  CSTTask.h
//  CarusselSalesTool
//
//  Created by AnatoliyDalekorey on 10.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTMappingProtocol.h"

@interface CSTTask : NSObject <CSTMappingProtocol>

@property (assign) NSInteger ID;
@property (assign) NSInteger prospectID;
@property (strong) NSString *prospectName;
@property (strong) NSDate *date;

@end
