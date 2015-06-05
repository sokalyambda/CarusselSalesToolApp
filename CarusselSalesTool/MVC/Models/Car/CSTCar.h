//
//  CSTCar.h
//  OpelHu
//
//  Created by AnatoliyDalekorey on 22.12.14.
//  Copyright (c) 2014 Thinkmobiles. All rights reserved.
//

#import "CSTMakeCar.h"
#import "CSTModelGroup.h"
#import "CSTImageCar.h"

@interface CSTCar : NSObject

@property (assign) NSInteger ID;
@property (copy) NSString *title;
@property (assign) NSInteger status;
@property (assign) NSInteger price;
@property (assign) NSInteger discountPrice;
@property (assign) NSInteger mileage;
@property (strong) CSTMakeCar *make;
@property (strong) CSTModelGroup *modelGroup;
@property (strong) CSTImageCar *defaultImage;
@property (strong) NSMutableArray *images;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
