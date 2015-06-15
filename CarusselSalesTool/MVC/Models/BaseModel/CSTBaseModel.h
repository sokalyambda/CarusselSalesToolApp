//
//  CSTBaseModel.h
//  CarusselSalesTool
//
//  Created by AnatoliyDalekorey on 15.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTMappingProtocol.h"

@interface CSTBaseModel : NSObject <CSTMappingProtocol>

@property (assign) NSInteger ID;
@property (copy) NSString *title;

@end
