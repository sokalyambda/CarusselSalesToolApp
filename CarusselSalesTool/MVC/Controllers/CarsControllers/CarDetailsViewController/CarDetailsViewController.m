//
//  CarDetailsViewController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 26.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CarDetailsViewController.h"
#import "Car.h"
#import "CarImageCell.h"
#import "UIView+MakeFromXib.h"

@interface CarDetailsViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

//TODO: outlets

@end

@implementation CarDetailsViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Actions

- (void)updateCarInformation
{
    //TODO: update views
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.currentCar.images count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CarImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CarImageCell class]) forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [CarImageCell makeFromXib];
    }
    
    //TODO: configure cell
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

@end
