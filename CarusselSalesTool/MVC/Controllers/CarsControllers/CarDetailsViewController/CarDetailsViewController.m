//
//  CarDetailsViewController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 26.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

#import "CarDetailsViewController.h"

#import "CSTCar.h"
#import <AssetsLibrary/AssetsLibrary.h>

#import "CarImageCell.h"
#import "UIView+MakeFromXib.h"
#import "CSTAttributedLabel.h"

@interface CarDetailsViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *carDetailsScrollView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UICollectionView *carImagesCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *carOriginalImageView;

//TODO: outlets
@property (weak, nonatomic) IBOutlet CSTAttributedLabel *carDescriptionLabel;
@property (weak, nonatomic) IBOutlet CSTAttributedLabel *carExtraLabel;

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
    
    WEAK_SELF;
    [[CSTDataManager sharedInstance] getCarWithID:24498 result:^(CSTCar *car, NSError *error) {
        weakSelf.currentCar = car;
    }];
    
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

- (IBAction)fullPhotoClick:(id)sender
{
    
}

- (IBAction)galleryClick:(id)sender
{
    [self showImagePickerViewWithType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (IBAction)showCameraClick:(id)sender
{
    [self showImagePickerViewWithType:UIImagePickerControllerSourceTypeCamera];
}

- (void)updateCarInformation
{
    [self.carImagesCollectionView reloadData];
    //TODO: update views
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
    [[CSTDataManager sharedInstance] postImage:chosenImage withID:24498 result:^(BOOL success, CSTImageCar *image) {
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
