//
//  CSTDataManager.m
//  CarusselSalesTool
//
//  Created by AnatoliyDalekorey on 29.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTDataManager.h"

@interface CSTDataManager ()

@property (strong, nonatomic) CSTNetworkManager *network;
@property (strong, nonatomic) CSTCache *cache;

@end

@implementation CSTDataManager

+ (CSTDataManager *)sharedInstance
{
    static CSTDataManager *singletonObject = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletonObject = [[self alloc] init];
        
    });
    return singletonObject;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _network = [CSTNetworkManager new];
        _cache = [CSTCache new];
        
        _statusCar = @{@0: @"Used",
                       @1: @"Demo",
                       @2: @"New"};
    }
    return self;
}

- (void)signInWithUserName:(NSString *)userName password:(NSString *)password withResult:(SuccessBlock)result
{
    [self.network signInWithUserName:userName password:password withResult:^(BOOL success, CSTCompany *company, NSError *error) {
        _companyInfo = company;
        return result(success, error);
    }];
}

- (void)getCarListForRow:(NSInteger)row pageSize:(NSInteger)pageSize parameter:(NSDictionary *)parameters result:(CarListBlock)result
{
    [self.network getCarListForRow:row pageSize:pageSize parameter:parameters result:^(NSArray *carList, NSError *error) {
        return result(carList, error);
    }];
}

- (void)getCarWithID:(NSInteger)ID result:(CarBlock)result
{
    CSTCar *car = [_cache getCarWithID:@(ID)];
    if (!car) {
        [self.network getCarWithID:ID result:^(CSTCar *car, NSError *error) {
            [self.cache.carsList setObject:car forKey:@(ID)];
            return result(car, error);
        }];
    } else {
        return result(car, nil);
    }
}

@end
