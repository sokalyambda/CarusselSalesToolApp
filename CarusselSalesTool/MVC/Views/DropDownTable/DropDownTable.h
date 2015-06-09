//
//  DropDownTable.h
//  CarusselSalesTool
//
//  Created by Eugenity on 27.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DropDownTable, CSTBaseDropDownDataSource;

typedef void(^DropDownCompletionHandler)(DropDownTable *dropDownTable, BOOL isExpanded, BOOL isApply);

@interface DropDownTable : UIView

@property (assign, nonatomic) BOOL isExpanded;

- (void)dropDownTableBecomeActiveInView:(UIView *)presentedView
                         fromAnchorView:(UIView *)anchorView
                         withDataSource:(CSTBaseDropDownDataSource *)dataSource
                         withCompletion:(DropDownCompletionHandler)completion;

@end
