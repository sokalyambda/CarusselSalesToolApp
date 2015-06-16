//
//  CSTProspectCell.m
//  CarusselSalesTool
//
//  Created by Eugenity on 04.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTProspectCell.h"

@interface CSTProspectCell ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *townTextField;
@property (weak, nonatomic) IBOutlet UITextField *yearTextField;
@property (weak, nonatomic) IBOutlet UITextField *carsMatchesTextField;

@end

@implementation CSTProspectCell

#pragma mark - Actions

- (void)configureCellWithProspect:(CSTProspect *)prospect
{
    self.nameTextField.text = prospect.fullName;
    self.townTextField.text = prospect.town;
    self.yearTextField.text = [NSString stringWithFormat:@"%@", prospect.born];
    self.carsMatchesTextField.text = [NSString stringWithFormat:@"%i", prospect.carMatches];
}
@end
