//
//  CSTModelGroup.h
//  OpelHu
//
//  Created by AnatoliyDalekorey on 23.12.14.
//  Copyright (c) 2014 Thinkmobiles. All rights reserved.
//

@interface CSTModelGroup : NSObject

@property (assign) NSInteger ID;
@property (copy) NSString *title;
@property (assign, nonatomic) BOOL showModels;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
