//
//  VenueViewController.m
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/9/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import "VenueViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface VenueViewController ()
@property (strong, nonatomic) IBOutlet UILabel *placeLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UIButton *directionButton;
@property (strong, nonatomic) IBOutlet UIButton *addFavoriteButton;
@end

@implementation VenueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setupViewApperance];
}

- (void) setupView {
    self.title = self.place.title;
    self.placeLabel.text = self.place.title;
    self.addressLabel.text = self.place.subtitle;
    float distance = self.place.placeDetail.distance/1000.0;
    self.distanceLabel.text = [NSString stringWithFormat:@"%.2f Km.",distance];
}

- (void) setupViewApperance {
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.directionButton.layer.cornerRadius = 5;
    self.addFavoriteButton.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)directionButtonTapped:(id)sender {
        NSURL *URL = [NSURL URLWithString:
                      [NSString stringWithFormat:@"http://maps.apple.com/?daddr=%f,%f",
                       self.place.coordinate.latitude,
                       self.place.coordinate.longitude
                       ]];
        [[UIApplication sharedApplication] openURL:URL];
}
@end
