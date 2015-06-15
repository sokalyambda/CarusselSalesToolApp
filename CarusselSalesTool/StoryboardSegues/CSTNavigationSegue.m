//
//  CSTNavigationSegue.m
//  CarusselSalesTool
//
//  Created by Eugenity on 02.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CSTNavigationSegue.h"
#import "CSTBaseOffersController.h"

@implementation CSTNavigationSegue

- (void)perform
{
    CSTBaseOffersController *tabBarController = (CSTBaseOffersController *) self.sourceViewController;
    UIViewController *destinationController = (UIViewController *) self.destinationViewController;
    
    for (UIView *view in tabBarController.placeholderView.subviews) {
        [view removeFromSuperview];
    }
    
    // Add view to placeholder view
    tabBarController.currentViewController = destinationController;
    [tabBarController.placeholderView addSubview:destinationController.view];
    
    // Set autoresizing
    [tabBarController.placeholderView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    UIView *childview = destinationController.view;
    [childview setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // fill horizontal
    [tabBarController.placeholderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[childview]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(childview)]];
    
    // fill vertical
    [tabBarController.placeholderView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[childview]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(childview)]];
    
    [tabBarController.placeholderView layoutIfNeeded];
    
    // notify did move
    [tabBarController addChildViewController:destinationController];
    [destinationController didMoveToParentViewController:tabBarController];
}

@end
