//
//  CSTBaseDropDownDataSource.h
//  CarusselSalesTool
//
//  Created by Eugenity on 07.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

typedef enum : NSUInteger {
    DropDownDataSourceTypeMakeCar,
    DropDownDataSourceTypeFuelType,
    DropDownDataSourceTypeBodyType,
    DropDownDataSourceTypeCarColor,
    DropDownDataSourceTypeYearFrom
} DropDownDataSourceType;

#import <Foundation/Foundation.h>

@interface CSTBaseDropDownDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *dropDownTableView;

- (instancetype)initWithDataSourceType:(DropDownDataSourceType)dataSourceType;

@end
