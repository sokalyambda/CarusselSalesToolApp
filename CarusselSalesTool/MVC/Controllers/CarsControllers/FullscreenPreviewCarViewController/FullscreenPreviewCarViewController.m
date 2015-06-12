//
//  FullscreenPreviewCarViewController.m
//  CarusselSalesTool
//
//  Created by AnatoliyDalekorey on 11.06.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "FullscreenPreviewCarViewController.h"

#import "CarImageCell.h"

typedef NS_ENUM(NSInteger, SelectedItem) {
    SelectedItemPrev,
    SelectedItemNext
};

@interface FullscreenPreviewCarViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) CSTCar *car;

@property (weak, nonatomic) IBOutlet UILabel *carNameLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *carThumbnailsCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *carOriginImageCollectionView;

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
}

#pragma mark - Metods

- (void)selectCellWithIndex:(NSInteger)index forCollectionView:(UICollectionView *)collectionView
{
    NSIndexPath *selectIndex = [NSIndexPath indexPathForRow:index inSection:0];
    [collectionView selectItemAtIndexPath:selectIndex animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    [self collectionView:collectionView didSelectItemAtIndexPath:selectIndex];
}

- (void)registerCell
{
    NSString *nibName = NSStringFromClass([CarImageCell class]);
    UINib *cellNib = [UINib nibWithNibName:nibName bundle:nil];
    [self.carThumbnailsCollectionView registerNib:cellNib forCellWithReuseIdentifier:nibName];
    [self.carOriginImageCollectionView registerNib:cellNib forCellWithReuseIdentifier:nibName];
}

- (void)prevNextImage:(SelectedItem)item
{
    NSArray *selectedItems = [self.carOriginImageCollectionView indexPathsForVisibleItems];
    NSIndexPath *indexPath = selectedItems[0];
    NSInteger index = indexPath.row;
    if (index > 0 && item == SelectedItemPrev) {
        index--;
    } else if (index < self.car.images.count - 1 && item == SelectedItemNext) {
        index++;
    }
    [self selectCellWithIndex:index forCollectionView:self.carOriginImageCollectionView];
    [self selectCellWithIndex:index forCollectionView:self.carThumbnailsCollectionView];
}

#pragma mark - Action

- (IBAction)prevImage:(id)sender
{
    [self prevNextImage:SelectedItemPrev];
}

- (IBAction)nextImage:(id)sender
{
    [self prevNextImage:SelectedItemNext];
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
    NSURL *thumbnailUrl = [NSURL URLWithString:image.thumbnailUrl];
    NSURL *originImagelUrl = [NSURL URLWithString:image.origUrl];
    
    CarImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CarImageCell class]) forIndexPath:indexPath];
    [cell.carImage sd_setImageWithURL:(collectionView == self.carThumbnailsCollectionView ? thumbnailUrl : originImagelUrl)];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.carThumbnailsCollectionView) {
        [self selectCellWithIndex:indexPath.row forCollectionView: self.carOriginImageCollectionView];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeZero;
    NSInteger height = collectionView.bounds.size.height - 10;
    NSInteger width = collectionView.bounds.size.width;
    if (collectionView == self.carThumbnailsCollectionView) {
        width = height;
    }
    size = CGSizeMake(width, height);
    return size;
}

@end
