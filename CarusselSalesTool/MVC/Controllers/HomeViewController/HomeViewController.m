//
//  HomeViewController.m
//  CarusselSalesTool
//
//  Created by Eugenity on 26.05.15.
//  Copyright (c) 2015 ThinkMobiles. All rights reserved.
//

typedef enum : NSUInteger {
    SelectedScreenCars,
    SelectedScreenProspects,
    SelectedScreenNewProspect,
    SelectedScreenTasks
} SelectedScreen;

static NSString *const kMainTabBarSegue = @"mainTabBarSegue";

#import "HomeViewController.h"
#import "MainCarsViewController.h"
#import "DemonstrationViewController.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *selectScreenControl;

@end

@implementation HomeViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Actions

- (IBAction)selectScreenClick:(UISegmentedControl *)segmentedControl
{
    switch (segmentedControl.selectedSegmentIndex) {
        case SelectedScreenCars: {
            //cars selected
            [self performSegueWithIdentifier:kMainTabBarSegue sender:self];
            break;
        }
        case SelectedScreenProspects: {
            //prospects list selected
            
            break;
        }
        case SelectedScreenNewProspect: {
            //new prospect selected
            
            break;
        }
        case SelectedScreenTasks: {
            //tasks selected
            
            break;
        }
            
        default:
            break;
    }
    [segmentedControl setSelectedSegmentIndex:-1];
}

- (IBAction)demonstrationClick:(UISwitch *)sender
{
    //TODO: demonstration appears
    DemonstrationViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([DemonstrationViewController class])];
    [self.navigationController pushViewController:controller animated:YES];
    [sender setOn:NO];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kMainTabBarSegue]) {
//        MainCarsViewController *controller = (MainCarsViewController *)segue.destinationViewController;
    }
}

@end
