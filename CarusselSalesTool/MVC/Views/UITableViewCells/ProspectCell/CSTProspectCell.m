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

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
