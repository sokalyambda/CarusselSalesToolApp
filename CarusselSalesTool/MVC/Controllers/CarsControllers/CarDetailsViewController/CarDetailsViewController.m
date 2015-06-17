//
//  CarDetailsViewController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 26.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CarDetailsViewController.h"

#import "FullscreenPreviewCarViewController.h"

#import "CSTCar.h"
#import <AssetsLibrary/AssetsLibrary.h>

#import "CarImageCell.h"
#import "UIView+MakeFromXib.h"
#import "CSTAttributedLabel.h"
#import "DropDownTable.h"

#import "CSTBaseDropDownDataSource.h"

@interface CarDetailsViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) DropDownTable *dropDownTable;

@property (weak, nonatomic) IBOutlet UIImageView *prospectsNewListTappedView;
@property (weak, nonatomic) IBOutlet UIImageView *prospectsFavouritesListTappedView;
@property (weak, nonatomic) IBOutlet UIImageView *prospectsCanceledListTappedView;
@property (weak, nonatomic) IBOutlet UIView *headerHolder;

@property (weak, nonatomic) IBOutlet UIScrollView *carDetailsScrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *carImagesCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *carOriginalImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loaderActivityIndicator;

//TODO: outlets
@property (weak, nonatomic) IBOutlet CSTAttributedLabel *carDescriptionLabel;
@property (weak, nonatomic) IBOutlet CSTAttributedLabel *carExtraLabel;

@property (weak, nonatomic) IBOutlet UILabel *carYearLabel;
@property (weak, nonatomic) IBOutlet UILabel *carFuelTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *carTransmissionLabel;
@property (weak, nonatomic) IBOutlet UILabel *carPowerLabel;
@property (weak, nonatomic) IBOutlet UILabel *carTitleLabel;

@end

@implementation CarDetailsViewController

#pragma mark - Accessors

- (void)setCurrentCar:(CSTCar *)currentCar
{
    _currentCar = currentCar;
    [self updateCarInformation];
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initDropDownTableView];
    [self registerCell];
    
    [[CSTDataManager sharedInstance] getCarsCount:^(NSInteger count, NSError *error) {
        //
    }];
}

#pragma mark - Metods

- (void)showImagePickerViewWithType:(UIImagePickerControllerSourceType)type
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.modalPresentationStyle = UIModalPresentationCurrentContext;
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = type;
    [self.parentViewController presentViewController:picker animated:YES completion:NULL];
}

#pragma mark - Actions

- (IBAction)newClick:(UITapGestureRecognizer *)sender
{
    [self showDropDownForSenderView:sender.view];
}

- (IBAction)favouritesClick:(UITapGestureRecognizer *)sender
{
    [self showDropDownForSenderView:sender.view];
}

- (IBAction)canceledClick:(UITapGestureRecognizer *)sender
{
    [self showDropDownForSenderView:sender.view];
}

- (void)showDropDownForSenderView:(UIView *)senderView
{
     CSTBaseDropDownDataSource *dataSource = [self getCurrentDataSourceForDropDownTableFromTappedView:senderView];
    [self.dropDownTable dropDownTableBecomeActiveInView:self.view fromAnchorView:self.headerHolder withDataSource:dataSource withCompletion:^(DropDownTable *dropDownTable, BOOL isExpanded, BOOL isApply) {
        
    }];
}

- (IBAction)fullPhotoClick:(id)sender
{
    self.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
    FullscreenPreviewCarViewController *presentController = [[FullscreenPreviewCarViewController alloc] initWithCar:self.currentCar];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f) {
        presentController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    [self.navigationController presentViewController:presentController animated:YES completion:nil];
}

- (IBAction)galleryClick:(id)sender
{
    [self showImagePickerViewWithType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (IBAction)showCameraClick:(id)sender
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        ShowAlert(NSLocalizedString(@"Camera is not available", nil));
        return;
    } else {
        [self showImagePickerViewWithType:UIImagePickerControllerSourceTypeCamera];
    }
}

- (void)updateCarInformation
{
    [self collectionView:self.carImagesCollectionView didSelectItemAtIndexPath:0];
    
    self.carTitleLabel.text         = self.currentCar.title;
    self.carFuelTypeLabel.text      = self.currentCar.fuel.title;
    //self.carYearLabel.text = self.currentCar.licenseDateYear;
    self.carTransmissionLabel.text  = self.currentCar.transsmision.title;
    self.carPowerLabel.text         = [NSString stringWithFormat:@"%likW/%lihp", (long)self.currentCar.powerKw, (long)self.currentCar.powerHp];
    
    
    [self.carDescriptionLabel setText:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"Description:", nil), self.currentCar.descriptions] withAttributedWordsCount:1 withColor:UIColorFromRGB(0x33CC66)];
    
    [self.carExtraLabel setText:[NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"Extra:", nil), self.currentCar.extra] withAttributedWordsCount:1 withColor:UIColorFromRGB(0x33CC66)];
    
    [self.carImagesCollectionView reloadData];
}

- (IBAction)galleryRightClick:(id)sender
{

}

- (IBAction)galleryLeftClick:(id)sender
{

}

- (void)initDropDownTableView
{
    self.dropDownTable = [DropDownTable makeFromXib];
}

- (CSTBaseDropDownDataSource *)getCurrentDataSourceForDropDownTableFromTappedView:(UIView *)tappedView
{
    CSTBaseDropDownDataSource *currentDataSource = nil;
    
    if ([tappedView isEqual:self.prospectsNewListTappedView]) {
        currentDataSource = [[CSTBaseDropDownDataSource alloc] initWithDataSourceType:CSTDropDownDataSourceTypeNew];
    } else if ([tappedView isEqual:self.prospectsFavouritesListTappedView]) {
        currentDataSource = [[CSTBaseDropDownDataSource alloc] initWithDataSourceType:CSTDropDownDataSourceTypeFavourites];
    } else if ([tappedView isEqual:self.prospectsCanceledListTappedView]) {
        currentDataSource = [[CSTBaseDropDownDataSource alloc] initWithDataSourceType:CSTDropDownDataSourceTypeCanceled];
    }
    
    return currentDataSource;
}

- (void)registerCell
{
    NSString *nibName = NSStringFromClass([CarImageCell class]);
    UINib *cellNib = [UINib nibWithNibName:nibName bundle:nil];
    [self.carImagesCollectionView registerNib:cellNib forCellWithReuseIdentifier:nibName];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.currentCar.images count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CSTImageCar *currentImage = self.currentCar.images[indexPath.row];
    NSURL *currentImageURL = [NSURL URLWithString:currentImage.thumbnailUrl];
    
    CarImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CarImageCell class]) forIndexPath:indexPath];
    
    [cell.loaderCellActivityIndicator startAnimating];
    [cell.carImage sd_setImageWithURL:currentImageURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [cell.loaderCellActivityIndicator stopAnimating];
    }];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CSTImageCar *currentImage = self.currentCar.images[indexPath.row];
    NSURL *currentImageURL = [NSURL URLWithString:currentImage.origUrl];
    
    WEAK_SELF;
    [self.loaderActivityIndicator startAnimating];
    [self.carOriginalImageView sd_setImageWithURL:currentImageURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [weakSelf.loaderActivityIndicator stopAnimating];
    }];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeZero;
    NSInteger height = collectionView.bounds.size.height - ((UICollectionViewFlowLayout *)collectionViewLayout).minimumInteritemSpacing;
    NSInteger width = collectionView.bounds.size.width;
    if (collectionView == self.carImagesCollectionView) {
        width = height;
    }
    size = CGSizeMake(width, height);
    return size;
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    NSURL *imagePath = [info objectForKey:UIImagePickerControllerReferenceURL];
    if (!imagePath) {
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library writeImageToSavedPhotosAlbum:chosenImage.CGImage
                                     metadata:[info objectForKey:UIImagePickerControllerMediaMetadata]
                              completionBlock:^(NSURL *assetURL, NSError *error) {
                                  NSLog(@"assetURL %@", assetURL);
                              }];
    }
    
    WEAK_SELF;
    [[CSTDataManager sharedInstance] postImage:chosenImage withID:self.currentCar.ID result:^(BOOL success, CSTImageCar *image) {
        //TO DO
    }];
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
