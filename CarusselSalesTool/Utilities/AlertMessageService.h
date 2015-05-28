//
//  AlertMessageService.h
//  Pseudo
//
//  Created by Eugenity on 20.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertMessageService : NSObject

void ShowTitleErrorAlert(NSString *title, NSError *error);
void ShowErrorAlert(NSError *error);

void ShowTitleAlert(NSString *title, NSString *message);
void ShowAlert(NSString *message);

@end
