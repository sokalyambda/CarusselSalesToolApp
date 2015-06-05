//
//  CSTMakeCar.h
//  OpelHu
//
//  Created by AnatoliyDalekorey on 23.12.14.
//  Copyright (c) 2014 Thinkmobiles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSTMakeCar : NSObject

@property (assign) NSInteger ID;
@property (copy) NSString *title;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
