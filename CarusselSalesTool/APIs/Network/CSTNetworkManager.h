//
//  CSTNetworkManager.h
//  CarusselSalesTool
//
//  Created by AnatoliyDalekorey on 29.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#import "CSTCompany.h"
#import "CSTCar.h"
#import "CSTImageCar.h"
#import "CSTTask.h"
#import "CSTProspect.h"

typedef void(^SuccessBlock)(BOOL success, NSError *error);
typedef void(^IntBlock)(NSInteger count, NSError *error);
typedef void(^CompanyBlock)(BOOL success, CSTCompany *company, NSError *error);
typedef void(^CarBlock)(CSTCar *car, NSError *error);
typedef void(^CarListBlock)(NSArray *carList, NSError *error);
typedef void(^ImageCarBlock)(BOOL success, CSTImageCar *image);

typedef void(^TasksListBlock)(NSArray *tasksList, NSError *error);

typedef void(^ProspectsListBlock)(NSArray *prospectsList, NSError *error);

@interface CSTNetworkManager : AFHTTPSessionManager

//cars
- (void)signInWithUserName:(NSString *)userName password:(NSString *)password withResult:(CompanyBlock)result;
- (void)getCarsCount:(IntBlock)result;
- (void)getCarListForRow:(NSInteger)row pageSize:(NSInteger)pageSize parameter:(NSDictionary *)parameters result:(CarListBlock)result;
- (void)getCarWithID:(NSInteger)ID result:(CarBlock)result;
- (void)postImage:(UIImage *)image withID:(NSInteger)ID result:(ImageCarBlock)result;

//tasks
- (void)getTasksList:(TasksListBlock)result;

//prospects
- (void)getProspectsList:(ProspectsListBlock)result;

@end
