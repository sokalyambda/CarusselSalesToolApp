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

- (void)signInWithUserName:(NSString *)userName password:(NSString *)password withResult:(CompanyBlock)result
{
    NSDictionary *parameter = @{@"j_username" : userName,
                                @"j_password": password};
    [self POST:@"/vacs-rest/j_spring_security_check" parameters:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
        CSTCompany *company = [[CSTCompany alloc] initWithDictionary:responseObject];
        return result(YES, company, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        return result(NO, nil, error);
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
    [self GET:@"/vacs-rest/vehicle/list" parameters:parameterToGet success:^(NSURLSessionDataTask *task, id responseObject) {
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
    [self GET:[NSString stringWithFormat:@"/vacs-rest/vehicle/%li", ID] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
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
    
    [self POST:@"/vacs-rest/vehicle/upload" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        return result(YES, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        return result(NO, nil);
    }];
//    AFHTTPRequestOperation *operation = [self POST:@"/vacs-rest/vehicle/upload" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        //do not put image inside parameters dictionary as I did, but append it!
//        [formData appendPartWithFileData:imageData name:@"file" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
//        return result(YES, responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
//        return result(NO, nil);
//    }];
//    [operation start];
}

@end
