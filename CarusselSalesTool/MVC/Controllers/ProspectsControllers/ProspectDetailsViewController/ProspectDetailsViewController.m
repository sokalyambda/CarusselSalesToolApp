//
//  ProspectDetailsViewController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 26.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "ProspectDetailsViewController.h"

@interface ProspectDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *prospectDetailsScrollView;

@end

@implementation ProspectDetailsViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self handleKeyboardNotifications];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Keyboard methods

static CGFloat DH = 0;
static CGRect keyboardAbsRect;

- (void)checkForMovement
{
    if (DH == 0.f) {
        return;
    }
    
    CGRect keybRect = [self.prospectDetailsScrollView convertRect:keyboardAbsRect fromView:nil];
    
    CGFloat dh = CGRectGetHeight(self.view.frame) - CGRectGetMinY(keybRect);
    if (dh > 0) {
        CGPoint offset = self.prospectDetailsScrollView.contentOffset;
        offset.y += dh;
        
        [UIView animateWithDuration:0.3f animations:^{
            self.prospectDetailsScrollView.contentOffset = offset;
        }];
    }
}

- (void)keyboardWillShow:(NSNotification*) notification
{
    NSDictionary *userInfo = [notification userInfo];
    keyboardAbsRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect keybRect = [self.prospectDetailsScrollView convertRect:keyboardAbsRect fromView:nil];
    
    CGFloat dh  = CGRectGetHeight(self.prospectDetailsScrollView.frame) + self.prospectDetailsScrollView.contentOffset.y - CGRectGetMinY(keybRect) - DH;
    
    if (dh != 0) {
        CGSize contentSize = self.prospectDetailsScrollView.contentSize;
        contentSize.height += dh;
        self.prospectDetailsScrollView.contentSize = contentSize;
        
        DH += dh;
        
        self.prospectDetailsScrollView.scrollEnabled = YES;
        
        [self checkForMovement];
    }
    
}

- (void)keyboardWillHide:(NSNotification*) notification
{
    if (DH) {
        CGSize contentSize = self.prospectDetailsScrollView.contentSize;
        contentSize.height -= DH;
        DH = 0.f;
        
        [UIView animateWithDuration:0.3f animations:^{
            self.prospectDetailsScrollView.contentSize = contentSize;
            self.prospectDetailsScrollView.contentOffset = CGPointZero;
        }];
    }
    
    self.prospectDetailsScrollView.scrollEnabled = NO;
}

#pragma mark - Actions

- (void)handleKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}


@end
