//
//  DropDownTable.h
//  CarusselSalesTool
//
//  Created by Eugenity on 27.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DropDownTable;

typedef void(^DropDownCompletionHandler)(DropDownTable *tableView, BOOL isExpanded);

@interface DropDownTable : UITableView

- (void)dropDownTableBecomeActiveFromAnchorView:(UIView *)anchorView withCompletion:(DropDownCompletionHandler)completion;

@end
