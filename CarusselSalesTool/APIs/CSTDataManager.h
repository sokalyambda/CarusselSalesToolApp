//
//  CSTDataManager.h
//  CarusselSalesTool
//
//  Created by AnatoliyDalekorey on 29.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CSTNetworkManager.h"
#import "CSTCache.h"

#import "CSTApiConstants.h"

@interface CSTDataManager : NSObject

@property (strong, atomic, readonly) NSDictionary *statusCar;
@property (strong, atomic, readonly) CSTCompany *companyInfo;

+ (CSTDataManager *)sharedInstance;

- (void)signInWithUserName:(NSString *)userName password:(NSString *)password withResult:(SuccessBlock)result;
- (void)getCarsCount:(IntBlock)result;
- (void)getCarListForRow:(NSInteger)row pageSize:(NSInteger)pageSize parameter:(NSDictionary *)parameters result:(CarListBlock)result;
- (void)getCarWithID:(NSInteger)ID result:(CarBlock)result;
- (void)postImage:(UIImage *)image withID:(NSInteger)ID result:(ImageCarBlock)result;

- (void)getTasksList:(TasksListBlock)result;

@end
