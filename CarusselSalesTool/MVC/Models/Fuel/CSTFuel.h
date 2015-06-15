//
//  CSTFuel.h
//  CarusselSalesTool
//
//  Created by AnatoliyDalekorey on 15.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSTFuel : NSObject

@property (assign) NSInteger ID;
@property (copy) NSString *title;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
