//
//  CSTLocation.h
//  OpelHu
//
//  Created by AnatoliyDalekorey on 10.01.15.
//  Copyright (c) 2015 Thinkmobiles. All rights reserved.
//

@interface CSTLocation : NSObject

@property (assign) NSInteger ID;
@property (copy) NSString *title;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
