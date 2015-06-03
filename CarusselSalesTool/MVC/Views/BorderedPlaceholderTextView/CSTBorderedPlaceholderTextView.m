//
//  CSTBorderedPlaceholderTextView.m
//  CarusselSalesTool
//
//  Created by Eugenity on 03.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTBorderedPlaceholderTextView.h"

@interface CSTBorderedPlaceholderTextView ()

@property (strong, nonatomic) UILabel *placeHolderLabel;

@end

@implementation CSTBorderedPlaceholderTextView

static CGFloat const kPlaceHolderDisappearingTime = .25f;
static NSInteger const kPlaceholderLabelPaddingValue = 8.f;

#pragma mark - Accessors

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self textChanged:nil];
}

#pragma mark - Init & Lifecycle

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    if (!self.placeholder) {
        [self setPlaceholder:@""];
    }
    if (!self.placeholderColor) {
        [self setPlaceholderColor:[UIColor lightGrayColor]];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    [self addBorder];
}

#pragma mark - Actions

- (void)textChanged:(NSNotification *)notification
{
    if (!self.placeholder.length) {
        return;
    }
    
    [UIView animateWithDuration:kPlaceHolderDisappearingTime animations:^{
        if (!self.text.length) {
            self.placeHolderLabel.alpha = 1.f;
        } else {
            self.placeHolderLabel.alpha = 0.f;
        }
    }];
}

- (void)addBorder
{
    self.backgroundColor = [UIColor colorWithWhite:0.9f alpha:0.5f];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5.0;
    self.layer.borderWidth = 1.f;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)drawRect:(CGRect)rect
{
    if (self.placeholder.length) {
        if (!self.placeHolderLabel) {
            self.placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPlaceholderLabelPaddingValue, kPlaceholderLabelPaddingValue, self.bounds.size.width - 2 * kPlaceholderLabelPaddingValue, 0)];
            self.placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            self.placeHolderLabel.numberOfLines = 0;
            self.placeHolderLabel.font = self.font;
            self.placeHolderLabel.backgroundColor = [UIColor clearColor];
            self.placeHolderLabel.textColor = self.placeholderColor;
            self.placeHolderLabel.alpha = 0;
            
            [self addSubview:self.placeHolderLabel];
        }
        
        self.placeHolderLabel.text = self.placeholder;
        [self.placeHolderLabel sizeToFit];
        [self sendSubviewToBack:_placeHolderLabel];
    }
    
    if (!self.text.length && self.placeholder.length) {
        self.placeHolderLabel.alpha = 1.f;
    }
    
    [super drawRect:rect];
}

@end
