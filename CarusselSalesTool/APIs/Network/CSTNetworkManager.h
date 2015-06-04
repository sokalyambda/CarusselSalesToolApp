//
//  CSTNetworkManager.h
//  CarusselSalesTool
//
//  Created by AnatoliyDalekorey on 29.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Car.h"

typedef void(^SuccessBlock)(BOOL success, NSString *error);
typedef void(^CarBlock)(Car *car, NSString *error);
typedef void(^CarListBlock)(NSArray *carList, NSString *error);

@interface CSTNetworkManager : NSObject

- (void)signInWithUserName:(NSString *)userName password:(NSString *)password withResult:(SuccessBlock)result;
- (void)getCarListWithParameters:(NSArray *)parameters result:(CarListBlock)result;
- (void)getCarWithID:(NSInteger)ID result:(CarBlock)result;

@end
