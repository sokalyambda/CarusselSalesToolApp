//
//  CSTTaskCell.m
//  CarusselSalesTool
//
//  Created by Eugenity on 05.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTTaskCell.h"
#import "CSTBorderedTextField.h"

@interface CSTTaskCell ()

@property (weak, nonatomic) IBOutlet CSTBorderedTextField *taskTextField;
@property (weak, nonatomic) IBOutlet CSTBorderedTextField *dateTextField;
@property (weak, nonatomic) IBOutlet CSTBorderedTextField *timeTextField;

@end

@implementation CSTTaskCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
