//
//  Car.h
//  CarusselSalesTool
//
//  Created by Eugenity on 26.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject

@property (strong, nonatomic) NSString *model;
@property (strong, nonatomic) NSString *vinNumber;
@property (strong, nonatomic) NSString *fuelType;
@property (strong, nonatomic) NSString *bodyType;
@property (strong, nonatomic) NSString *yearFrom;

@property (strong, nonatomic) NSNumber *price;
@property (strong, nonatomic) NSNumber *mileage;
@property (strong, nonatomic) NSNumber *perfomance;
@property (strong, nonatomic) NSNumber *displacement;

@property (strong, nonatomic) NSArray *images;

@end
