//
//  CSTImageCar.h
//  OpelHu
//
//  Created by AnatoliyDalekorey on 23.12.14.
//  Copyright (c) 2014 Thinkmobiles. All rights reserved.
//

#import "CSTMappingProtocol.h"

@interface CSTImageCar : NSObject <CSTMappingProtocol>

@property (assign) NSInteger ID;
@property (copy) NSString *thumbnailUrl;
@property (copy) NSString *mediumUrl;
@property (copy) NSString *origUrl;
@property (assign) NSInteger orderIndex;

@end
