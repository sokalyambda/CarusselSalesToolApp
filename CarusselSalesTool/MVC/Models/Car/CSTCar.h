//
//  CSTCar.h
//  OpelHu
//
//  Created by AnatoliyDalekorey on 22.12.14.
//  Copyright (c) 2014 Thinkmobiles. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "CSTMakeCar.h"
#import "CSTModelGroup.h"
#import "CSTImageCar.h"
#import "CSTColor.h"
#import "CSTTranssmision.h"
#import "CSTFuel.h"
#import "CSTBody.h"

@interface CSTCar : NSObject

@property (assign) NSInteger ID;
@property (strong) CSTMakeCar *make;
@property (strong) CSTModelGroup *modelGroup;
@property (copy) NSString *title;
@property (strong) CSTImageCar *defaultImage;
@property (strong) NSMutableArray *images;
@property (assign) NSInteger status;
@property (assign) NSInteger price;
@property (assign) NSInteger discountPrice;
@property (assign) NSInteger mileage;
@property (copy) NSString *dealerCode;
@property (strong) NSDate *created;
@property (strong) NSDate *updated;
@property (copy) NSString *modelType;
@property (copy) NSString *model;
@property (assign) NSInteger originalPrice;
@property (assign) NSInteger powerHp;
@property (assign) NSInteger powerKw;
@property (assign) NSInteger cylinders;
@property (copy) NSString *engineType;
@property (assign) NSInteger engineCcm;
@property (assign) NSInteger doors;
@property (assign) NSInteger seats;
@property (assign) NSInteger consumption;
@property (assign) NSInteger co2;
@property (strong) CSTColor *color;
@property (copy) NSString *colorExtra;
@property (copy) NSString *category;
@property (strong) CSTTranssmision *transsmision;
@property (strong) CSTFuel *fuel;
@property (strong) CSTBody *body;
@property (strong) NSDate *licenseDate;
@property (strong) NSDate *licenseDateYear;
@property (assign) BOOL withWarranty;
@property (assign) BOOL disabledSupport;
@property (assign) BOOL leasing;
@property (assign) BOOL vatReclaimable;
@property (copy) NSString *descriptions;
@property (copy) NSString *extra;
@property (copy) NSString *brandType;
@property (assign) NSInteger condition;
@property (copy) NSString *highlight;
@property (strong) CSTLocation *location;
@property (copy) NSString *jobNo;
@property (copy) NSString *vin;
@property (copy) NSString *importType;
@property (assign) CLLocationCoordinate2D geoLocation;
@property (assign) NSInteger distance;
@property (assign) BOOL noPrice;
@property (copy) NSString *tarifDate;
@property (copy) NSString *searchFlags;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
