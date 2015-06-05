//
//  CSTNetworkManager.m
//  CarusselSalesTool
//
//  Created by AnatoliyDalekorey on 29.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTNetworkManager.h"

NSString *const baseURLString = @"http://mobileimageuploader.hu.opel.carusseldwt.com";

@implementation CSTNetworkManager

- (instancetype)init
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    self = [super initWithBaseURL:baseURL];
    if (self) {
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    return self;
}

- (void)signInWithUserName:(NSString *)userName password:(NSString *)password withResult:(SuccessBlock)result
{
    NSDictionary *parameter = @{@"j_username" : userName,
                                @"j_password": password};
    [self POST:@"/vacs-rest/j_spring_security_check" parameters:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
#warning need implement user profile
        CSTCompany *company = [[CSTCompany alloc] initWithDictionary:responseObject];
        return result(YES, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        return result(NO, error);
    }];
}

- (void)getCarListWithParameters:(NSArray *)parameters result:(CarListBlock)result
{
    [self GET:@"/vacs-rest/vehicle/list?rowIndex=0&pageSize=10" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *listCard = [NSMutableArray new];
        for (NSDictionary *dic in responseObject) {
            [listCard addObject:[[CSTCar alloc] initWithDictionary:dic]];
        }
        return result([listCard copy], nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        return result(NO, error);
    }];
}

- (void)getCarWithID:(NSInteger)ID result:(CarBlock)result
{
    return result([CSTCar new], nil);
}

@end
