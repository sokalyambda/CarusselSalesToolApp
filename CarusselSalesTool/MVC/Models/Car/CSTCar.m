//
//  CSTCar.m
//  OpelHu
//
//  Created by AnatoliyDalekorey on 22.12.14.
//  Copyright (c) 2014 Thinkmobiles. All rights reserved.
//

#import "CSTCar.h"

@implementation CSTCar

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _ID = [dictionary[@"id"] integerValue];
        _make = [[CSTMakeCar alloc] initWithDictionary:dictionary[@"make"]];
        _modelGroup = [[CSTModelGroup alloc] initWithDictionary:dictionary[@"modelGroup"]];
        if (![dictionary[@"title"] isKindOfClass:[NSNull class]]) {
            _title = dictionary[@"title"];
        }
        _defaultImage = [[CSTImageCar alloc] initWithDictionary:dictionary[@"defaultImage"]];
        if (![dictionary[@"images"] isKindOfClass:[NSNull class]]) {
            NSMutableArray *tempList = [NSMutableArray new];
            for (NSDictionary *dic in dictionary[@"images"]) {
                [tempList addObject:[[CSTImageCar alloc] initWithDictionary:dic]];
            }
            _images = [tempList copy];
        }
        _status = [dictionary[@"status"] integerValue];
        if (![dictionary[@"price"] isKindOfClass:[NSNull class]]) {
            _price = [dictionary[@"price"] integerValue];
        }
        if (![dictionary[@"discountPrice"] isKindOfClass:[NSNull class]]) {
            _discountPrice = [dictionary[@"discountPrice"] integerValue];
        }
        _mileage = [dictionary[@"mileage"] integerValue];
        if (![dictionary[@"dealerCode"] isKindOfClass:[NSNull class]]) {
            _dealerCode = dictionary[@"dealerCode"];
        }
        if (![dictionary[@"created"] isKindOfClass:[NSNull class]]) {
            _created = [NSDate dateWithTimeIntervalSinceNow:[dictionary[@"created"] integerValue]/1000];
        }
        if (![dictionary[@"updated"] isKindOfClass:[NSNull class]]) {
            _updated = [NSDate dateWithTimeIntervalSinceNow:[dictionary[@"updated"] integerValue]/1000];
        }
        if (![dictionary[@"modelType"] isKindOfClass:[NSNull class]]) {
            _modelType = dictionary[@"modelType"];
        }
        if (![dictionary[@"model"] isKindOfClass:[NSNull class]]) {
            _model = dictionary[@"model"];
        }
        if (![dictionary[@"originalPrice"] isKindOfClass:[NSNull class]]) {
            _originalPrice = [dictionary[@"originalPrice"] integerValue];
        }
        if (![dictionary[@"powerHp"] isKindOfClass:[NSNull class]]) {
            _powerHp = [dictionary[@"powerHp"] integerValue];
        }
        if (![dictionary[@"powerKw"] isKindOfClass:[NSNull class]]) {
            _powerKw = [dictionary[@"powerKw"] integerValue];
        }
        if (![dictionary[@"cylinders"] isKindOfClass:[NSNull class]]) {
            _cylinders = [dictionary[@"cylinders"] integerValue];
        }
        if (![dictionary[@"engineType"] isKindOfClass:[NSNull class]]) {
            _engineType = dictionary[@"engineType"];
        }
        if (![dictionary[@"engineCcm"] isKindOfClass:[NSNull class]]) {
            _engineCcm = [dictionary[@"engineCcm"] integerValue];
        }
        if (![dictionary[@"doors"] isKindOfClass:[NSNull class]]) {
            _doors = [dictionary[@"doors"] integerValue];
        }
        if (![dictionary[@"seats"] isKindOfClass:[NSNull class]]) {
            _seats = [dictionary[@"seats"] integerValue];
        }
        if (![dictionary[@"consumption"] isKindOfClass:[NSNull class]]) {
            _consumption = [dictionary[@"consumption"] integerValue];
        }
        if (![dictionary[@"co2"] isKindOfClass:[NSNull class]]) {
            _co2 = [dictionary[@"co2"] integerValue];
        }
        if (![dictionary[@"color"] isKindOfClass:[NSNull class]]) {
            _color = [[CSTColor alloc] initWithDictionary:dictionary[@"color"]];
        }        
        if (![dictionary[@"colorExtra"] isKindOfClass:[NSNull class]]) {
            _colorExtra = dictionary[@"colorExtra"];
        }
        if (![dictionary[@"category"] isKindOfClass:[NSNull class]]) {
            _category = dictionary[@"category"];
        }
        _transsmision = [[CSTTranssmision alloc] initWithDictionary:dictionary[@"transsmision"]];
        _fuel = [[CSTFuel alloc] initWithDictionary:dictionary[@"fuel"]];
        _body = [[CSTBody alloc] initWithDictionary:dictionary[@"body"]];
        if (![dictionary[@"licenseDate"] isKindOfClass:[NSNull class]]) {
            _licenseDate = [NSDate dateWithTimeIntervalSinceNow:[dictionary[@"licenseDate"] integerValue]/1000];
        }
        if (![dictionary[@"licenseDateYear"] isKindOfClass:[NSNull class]]) {
            _licenseDateYear = [NSDate dateWithTimeIntervalSinceNow:[dictionary[@"licenseDateYear"] integerValue]/1000];
        }
        if (![dictionary[@"withWarranty"] isKindOfClass:[NSNull class]]) {
            _withWarranty = [dictionary[@"withWarranty"] boolValue];
        }
        if (![dictionary[@"disabledSupport"] isKindOfClass:[NSNull class]]) {
            _disabledSupport = [dictionary[@"disabledSupport"] boolValue];
        }
        if (![dictionary[@"leasing"] isKindOfClass:[NSNull class]]) {
            _leasing = [dictionary[@"leasing"] boolValue];
        }
        if (![dictionary[@"vatReclaimable"] isKindOfClass:[NSNull class]]) {
            _vatReclaimable = [dictionary[@"vatReclaimable"] boolValue];
        }
        if (![dictionary[@"descriptions"] isKindOfClass:[NSNull class]]) {
            _descriptions = dictionary[@"descriptions"];
        }
        if (![dictionary[@"extra"] isKindOfClass:[NSNull class]]) {
            _extra = dictionary[@"extra"];
        }
        if (![dictionary[@"brandType"] isKindOfClass:[NSNull class]]) {
            _brandType = dictionary[@"brandType"];
        }
        if (![dictionary[@"condition"] isKindOfClass:[NSNull class]]) {
            _condition = [dictionary[@"condition"] integerValue];
        }
        if (![dictionary[@"highlight"] isKindOfClass:[NSNull class]]) {
            _highlight = dictionary[@"highlight"];
        }
        if (![dictionary[@"location"] isKindOfClass:[NSNull class]]) {
            _location = [[CSTLocation alloc] initWithDictionary:dictionary[@"location"]];
        }        
        if (![dictionary[@"jobNo"] isKindOfClass:[NSNull class]]) {
            _jobNo = dictionary[@"jobNo"];
        }
        if (![dictionary[@"vin"] isKindOfClass:[NSNull class]]) {
            _vin = dictionary[@"vin"];
        }
        if (![dictionary[@"importType"] isKindOfClass:[NSNull class]]) {
            _importType = dictionary[@"importType"];
        }
        if (![dictionary[@"geoLocation"] isKindOfClass:[NSNull class]]) {
            NSArray *location = [dictionary[@"geoLocation"] componentsSeparatedByString:@","];
            _geoLocation.latitude = [location[0] doubleValue];
            _geoLocation.latitude = [location[1] doubleValue];
        }
        if (![dictionary[@"distance"] isKindOfClass:[NSNull class]]) {
            _distance = [dictionary[@"distance"] integerValue];
        }
        if (![dictionary[@"noPrice"] isKindOfClass:[NSNull class]]) {
            _noPrice = [dictionary[@"noPrice"] boolValue];
        }
        if (![dictionary[@"tarifDate"] isKindOfClass:[NSNull class]]) {
            _tarifDate = dictionary[@"tarifDate"];
        }
        if (![dictionary[@"searchFlags"] isKindOfClass:[NSNull class]]) {
            _searchFlags = dictionary[@"searchFlags"];
        }
    }
    return self;
}

@end
