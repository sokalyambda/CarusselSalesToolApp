//
//  CSTBaseDropDownDataSource.h
//  CarusselSalesTool
//
//  Created by Eugenity on 07.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

typedef enum : NSUInteger {
    CSTDropDownDataSourceTypeMakeCar,
    CSTDropDownDataSourceTypeFuelType,
    CSTDropDownDataSourceTypeBodyType,
    CSTDropDownDataSourceTypeCarColor,
    CSTDropDownDataSourceTypeYearFrom
} CSTDropDownDataSourceType;

#import <Foundation/Foundation.h>

@interface CSTBaseDropDownDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *dropDownTableView;

- (instancetype)initWithDataSourceType:(CSTDropDownDataSourceType)dataSourceType;

@end
