//
//  CSTNetworkManager.m
//  CarusselSalesTool
//
//  Created by AnatoliyDalekorey on 29.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTNetworkManager.h"

//NSString *const baseURLString = @"http://mobileimageuploader.hu.opel.carusseldwt.com";
NSString *const baseURLString = @"http://mobileapp.vacs.hu.opel.dwt.carusselgroup.com";

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

#pragma mark - SignIn

- (void)signInWithUserName:(NSString *)userName password:(NSString *)password withResult:(CompanyBlock)result
{
    NSDictionary *parameter = @{@"j_username" : userName,
                                @"j_password": password};
    [self POST:@"/j_spring_security_check" parameters:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
        CSTCompany *company = [[CSTCompany alloc] initWithDictionary:responseObject];
        return result(YES, company, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        return result(NO, nil, error);
    }];
}

#pragma mark - Cars

- (void)getCarsCount:(IntBlock)result
{
    [self POST:@"/vehicle/count" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        return result((NSInteger)responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        return result(0, error);
    }];
}

- (void)getCarListForRow:(NSInteger)row pageSize:(NSInteger)pageSize parameter:(NSDictionary *)parameters result:(CarListBlock)result
{
    NSMutableDictionary *parameterToGet;
    if (parameters) {
        parameterToGet = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    } else {
        parameterToGet = [[NSMutableDictionary alloc] init];
    }
    [parameterToGet setObject:@(row) forKey:@"rowIndex"];
    [parameterToGet setObject:@(pageSize) forKey:@"pageSize"];
    [self GET:@"/vehicle/list" parameters:parameterToGet success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *listCard = [NSMutableArray new];
        for (NSDictionary *dic in responseObject) {
            [listCard addObject:[[CSTCar alloc] initWithDictionary:dic]];
        }
        return result([listCard copy], nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        return result(nil, error);
    }];
}

- (void)getCarWithID:(NSInteger)ID result:(CarBlock)result
{
    [self GET:[NSString stringWithFormat:@"/vacs-rest/vehicle/%i", ID] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        return result([[CSTCar alloc] initWithDictionary:responseObject], nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        return result(nil, error);
    }];
}

- (void)postImage:(UIImage *)image withID:(NSInteger)ID result:(ImageCarBlock)result
{
    NSDictionary *parameters = @{
                                       @"vehicleId" : @(ID),
                                       //@"photoId" : @224959,
                                       //@"imgIdx" : @2,
                                       @"defaultImage" : @"true"
                                       };
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    
    [self POST:@"/vehicle/upload" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        return result(YES, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        return result(NO, nil);
    }];
}

#pragma mark - Tasks List

- (void)getTasksList:(TasksListBlock)result
{
    NSMutableArray *taskList = [NSMutableArray new];
    for (int i = 0; i < 3; i++) {
        [taskList addObject:[[CSTTask alloc] initWithDictionary:nil]];
    }
    return result([taskList copy], nil);
}

#pragma mark - Prospects

- (void)getProspectsList:(ProspectsListBlock)result
{
    NSMutableArray *prospectList = [NSMutableArray new];
    for (int i = 0; i < 6; i++) {
        [prospectList addObject:[[CSTProspect alloc] initWithDictionary:nil]];
    }
    return result([prospectList copy], nil);
}


@end
