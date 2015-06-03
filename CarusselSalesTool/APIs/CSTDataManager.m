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
    }
    return self;
}

- (void)signInWithUserName:(NSString *)userName password:(NSString *)password withResult:(SuccessBlock)result
{
    [self.network signInWithUserName:userName password:password withResult:result];
}

@end
