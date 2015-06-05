//
//  CSTCheckBoxButton.m
//  CarusselSalesTool
//
//  Created by Eugenity on 05.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTCheckBoxButton.h"

@interface CSTCheckBoxButton ()

@property (strong, nonatomic) UIImage*	notSelectedImage;
@property (strong, nonatomic) UIImage*	selectedImage;

@property (strong, nonatomic) NSString *notSelectedImageName;
@property (strong, nonatomic) NSString *selectedImageName;

@end

@implementation CSTCheckBoxButton

#pragma mark - Init

#warning set correctly selected/unselected images names instead of temporary!

-(void)awakeFromNib
{
    [self setSelectedImageName:@"checked_checkbox"];
    [self setNotSelectedImageName:@"unchecked_checkbox"];
}

#pragma mark - Accessors

- (void)setSelectedImageName:(NSString *)newValue
{
    _selectedImageName = [newValue copy];
    self.selectedImage = [UIImage imageNamed:_selectedImageName];
}

- (void)setNotSelectedImageName:(NSString *)newValue
{
    _notSelectedImageName = [newValue copy];
    self.notSelectedImage = [UIImage imageNamed: _notSelectedImageName];
}

- (void)setSelected:(BOOL)isSelected
{
    if (isSelected != self.isSelected) {
        [super setSelected:isSelected];
        if (isSelected){
            [self setImage:_selectedImage forState: UIControlStateNormal];
        } else {
            [self setImage:_notSelectedImage forState: UIControlStateNormal];
        }
    }
}

- (void)setNotSelectedImage:(UIImage*)newImage
{
    _notSelectedImage = newImage;
    if (!self.isSelected) {
        [self setImage:_notSelectedImage forState: UIControlStateNormal];
    }
}

- (void)setSelectedImage:(UIImage*)newImage
{
    _selectedImage = newImage;
    if (self.isSelected) {
        [self setImage:_selectedImage forState: UIControlStateNormal];
    }
}

#pragma mark - UIControl methods

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super endTrackingWithTouch:touch withEvent:event];
    if (CGRectContainsPoint(self.bounds, [touch locationInView:self])) {
        self.selected = !self.selected;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

@end
