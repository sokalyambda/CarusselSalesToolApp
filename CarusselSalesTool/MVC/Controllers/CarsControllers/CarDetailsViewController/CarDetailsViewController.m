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
    [self.carDescriptionLabel setText:@"Description: In literary theory, a text is any object that can be read, whether this object is a work of literature, a street sign, an arrangement of buildings on a city block, or styles of clothing. It is a coherent set of signs that transmits some kind of informative message.[1] This set of symbols is considered in terms of the informative message's content, rather than in terms of its physical form or the medium in which it is represented.Within the field of literary criticism, text also refers to the original information content of a particular piece of writing; that is, the text of a work is that primal symbolic arrangement of letters as originally composed, apart from later alterations, deterioration, commentary, translations, paratext, etc. Therefore, when literary criticism is concerned with the determination of a text, it is concerned with the distinguishing of the original information content from whatever has been added to or subtracted from that content as it appears in a given textual document (that is, a physical representation of text)." withAttributedWordsCount:1 withColor:[UIColor greenColor]];

    [self.carExtraLabel setText:@"Extra: paratext, etc. Therefore, when literary criticism is concerned with the determination of a text, it is concerned with the distinguishing of the original information content from whatever has been added to or subtracted from that content as it appears in a given textual document (that is, a physical representation of text).s, paratext, etc. Therefore, when literary criticism is concerned with the determination of a text, it is concerned with the distinguishing of the original information content from whatever has been added to or subtracted from that content as it appears in a given textual document (that is, a physical representation of text).s, paratext, etc. Therefore, when literary criticism is concerned with the determination of a text, it is concerned with the distinguishing of the original information content from whatever has been added to or subtracted from that content as it appears in a given textual document (that is, a physical representation" withAttributedWordsCount:1 withColor:[UIColor greenColor]];
    
    [self.carImagesCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CarImageCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([CarImageCell class])];
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
    //TODO: update views
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
    
    [cell.carImage sd_setImageWithURL:currentImageURL];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CSTImageCar *currentImage = self.currentCar.images[indexPath.row];
    NSURL *currentImageURL = [NSURL URLWithString:currentImage.origUrl];
    [self.carOriginalImageView sd_setImageWithURL:currentImageURL];
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
