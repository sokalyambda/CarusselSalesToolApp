//
//  CSTTask.h
//  CarusselSalesTool
//
//  Created by AnatoliyDalekorey on 10.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSTTask : NSObject

@property (assign) NSInteger ID;
@property (assign) NSInteger prospectID;
@property (strong) NSString *prospectName;
@property (strong) NSDate *date;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
