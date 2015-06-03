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

@interface CSTDataManager : NSObject

+ (CSTDataManager *)sharedInstance;

- (void)signInWithUserName:(NSString *)userName password:(NSString *)password withResult:(SuccessBlock)result;

@end
