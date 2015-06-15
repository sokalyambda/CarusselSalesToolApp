//
//  CSTColor.h
//  CarusselSalesTool
//
//  Created by AnatoliyDalekorey on 15.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

@interface CSTColor : NSObject

@property (assign) NSInteger ID;
@property (copy) NSString *title;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
