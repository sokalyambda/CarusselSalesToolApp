//
//  CSTModelGroupSectionHeader.h
//  CarusselSalesTool
//
//  Created by Eugenity on 08.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSTModelGroupSectionHeader;

@protocol ExpandableSectionDelegate <NSObject>

- (void)shouldExpandSectionFromHeader:(CSTModelGroupSectionHeader *)headerView;

@end

@interface CSTModelGroupSectionHeader : UIView

@property (weak, nonatomic) IBOutlet UILabel *modelGroupTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;
@property (assign, nonatomic) NSUInteger section;
@property (weak, nonatomic) id<ExpandableSectionDelegate>delegate;

@end
