//
//  CSTNetworkManager.m
//  CarusselSalesTool
//
//  Created by AnatoliyDalekorey on 29.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTNetworkManager.h"

@implementation CSTNetworkManager

- (void)signInWithUserName:(NSString *)userName password:(NSString *)password withResult:(SuccessBlock)result
{
    return result(YES, nil);
}

- (void)getCarListWithParameters:(NSArray *)parameters result:(CarListBlock)result
{
    return result (@[[Car new], [Car new], [Car new]], nil);
}

- (void)getCarWithID:(NSInteger)ID result:(CarBlock)result
{
    return result([Car new], nil);
}

@end
