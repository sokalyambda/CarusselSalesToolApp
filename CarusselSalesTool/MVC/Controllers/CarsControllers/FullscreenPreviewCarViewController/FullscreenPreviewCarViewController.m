//
//  FullscreenPreviewCarViewController.m
//  CarusselSalesTool
//
//  Created by AnatoliyDalekorey on 11.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "FullscreenPreviewCarViewController.h"

#import "CarImageCell.h"

@interface FullscreenPreviewCarViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) CSTCar *car;

@property (weak, nonatomic) IBOutlet UILabel *carNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *fullScreenImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *carImagesCollectionView;

@end

@implementation FullscreenPreviewCarViewController

#pragma mark - Life Cycle

- (instancetype)initWithCar:(CSTCar *)car
{
    self = [super init];
    if (self) {
        _car = car;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerCell];
    
    self.carNameLabel.text = self.car.title;
    [self selectCellWithIndex:0];
}

#pragma mark - Metods

- (void)selectCellWithIndex:(NSInteger)index
{
    NSIndexPath *selectIndex = [NSIndexPath indexPathForRow:index inSection:0];
    [self.carImagesCollectionView selectItemAtIndexPath:selectIndex animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
}

- (void)setFullScreenImageWithIndex:(NSInteger)index
{
    CSTImageCar *image = _car.images[index];
    NSURL *imageUrl = [NSURL URLWithString:image.origUrl];
    [self.fullScreenImageView sd_setImageWithURL:imageUrl completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //TO DO
    }];
}

- (void)registerCell
{
    NSString *nibName = NSStringFromClass([CarImageCell class]);
    UINib *cellNib = [UINib nibWithNibName:nibName bundle:nil];
    [self.carImagesCollectionView registerNib:cellNib forCellWithReuseIdentifier:nibName];
}

#pragma mark - Action

- (IBAction)prevImage:(id)sender
{
    NSArray *selectedItems = [self.carImagesCollectionView indexPathsForSelectedItems];
    NSIndexPath *indexPath = selectedItems[0];
    if (indexPath.row > 0) {
        [self selectCellWithIndex:indexPath.row - 1];
    }
}

- (IBAction)nextImage:(id)sender
{
    NSArray *selectedItems = [self.carImagesCollectionView indexPathsForSelectedItems];
    NSIndexPath *indexPath = selectedItems[0];
    if (indexPath.row < self.car.images.count - 1) {
        [self selectCellWithIndex:indexPath.row + 1];
    }
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.car.images count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CSTImageCar *image = self.car.images[indexPath.row];
    NSURL *imageUrl = [NSURL URLWithString:image.thumbnailUrl];
    
    CarImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CarImageCell class]) forIndexPath:indexPath];
    [cell.carImage sd_setImageWithURL:imageUrl];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self setFullScreenImageWithIndex:indexPath.row];
}


@end
