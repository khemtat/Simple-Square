//
//  ViewController.m
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/2/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>
#import "Places.h"
#import "Place.h"
#import <EAIntroView/EAIntroView.h>
#import <MBProgressHUD/MBProgressHUD.h>


@interface MapViewController ()
<MKMapViewDelegate, CLLocationManagerDelegate, UIAlertViewDelegate, EAIntroDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation MapViewController {
    UIView *rootView;
    EAIntroView *_intro;
    Places *places;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}

#pragma mark - Setup View Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setupIntroView];
    [self setupLoadingState];
    [self locationManagerSetup];
}

- (void) setupView {
    self.title = @"Cafe Recommended";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.00 green:0.70 blue:0.99 alpha:1.0];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
}

- (void) setupLoadingState {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Loading";
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setupMapView)
                                                 name:@"foursquareDataLoadedNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(viewDidLoad)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}

#pragma mark - Intro View

- (void) setupIntroView {
    rootView = self.navigationController.view;
    if (![@"1" isEqualToString:[[NSUserDefaults standardUserDefaults]
                                objectForKey:@"firstTimeRunningApp"]]) {
        [self showIntroWithCrossDissolve];
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"firstTimeRunningApp"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

#pragma mark - Location Manager

- (void)checkingLocationServicePermission {
    if([CLLocationManager locationServicesEnabled]){
        if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"App Permission Denied"
                                                            message:@"To re-enable, please go to Settings and turn on Location Service for this app."
                                                           delegate:self
                                                  cancelButtonTitle:@"Settings"
                                                  otherButtonTitles:nil];
            [alertView show];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"🆘 buttonIndex: %ld",buttonIndex);
    if(buttonIndex == 0) {
        NSURL*url=[NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)locationManagerSetup {
    [self checkingLocationServicePermission];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    currentLocation = locations[0];
    double latitude = currentLocation.coordinate.latitude;
    double longitude = currentLocation.coordinate.longitude;
    places = [Places defaultDataWithCurrentLocation:currentLocation];
    [locationManager stopUpdatingLocation];
    locationManager = nil;
    self.mapView.showsUserLocation = YES;
    NSLog(@"🔰 Current latitude: %f and longitude: %f",latitude,longitude);
}

#pragma mark - Map View configure

- (void)setupMapView{
    NSLog(@"⚠️ [places count] from MapViewController: %ld",[places count]);
    [self.mapView addAnnotations:[places getPlaceList]];
    [self mapViewEnclosedAnnotationsIncludeUserLocation];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"Ⓜ️ Add annotations successfully!!");
}

- (void)mapViewEnclosedAnnotationsIncludeUserLocation {
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        if (MKMapRectIsNull(zoomRect)) {
            zoomRect = pointRect;
        } else {
            zoomRect = MKMapRectUnion(zoomRect, pointRect);
        }
    }
    [self.mapView setVisibleMapRect:zoomRect
                        edgePadding:UIEdgeInsetsMake(85, 10, 10, 10)
                           animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if (annotation == mapView.userLocation)
        return nil;
    double distanceInKM = ((double)((Place *)annotation).placeDetail.distance)/1000.0;
    MKAnnotationView *view = (MKAnnotationView* )[self.mapView
                                dequeueReusableAnnotationViewWithIdentifier:@"Place"];
    view = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                    reuseIdentifier:@"Place"];
    [self setupCallout:view andDistance:distanceInKM];
    return view;
}

- (MKAnnotationView *) setupCallout:(MKAnnotationView *)annotation andDistance:(double) distanceInKM {
    annotation.canShowCallout = YES;
    annotation.calloutOffset = CGPointMake(-5, 5);
    annotation.rightCalloutAccessoryView = [self setupRightCalloutAccessoryView];
    annotation.leftCalloutAccessoryView = [self setupLeftCalloutAccessoryView:distanceInKM];
    annotation.image = [UIImage imageNamed:@"pin"];
    return annotation;
}

- (UIButton *) setupRightCalloutAccessoryView {
    return [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
}

- (UIView *) setupLeftCalloutAccessoryView:(double) distanceInKM {
    UILabel *distance = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    distance.textColor = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0];
    distance.text = [NSString stringWithFormat:@"%.2lf\nKM",distanceInKM];
    distance.textAlignment = 1;
    distance.numberOfLines = 2;
    [distance setFont:[UIFont systemFontOfSize:15.0]];
    distance.backgroundColor = [UIColor colorWithRed:0.36 green:0.72 blue:0.36 alpha:1.0];
    return distance;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view
                      calloutAccessoryControlTapped:(UIControl *)control {
    Place *place = (Place *)view.annotation;
    NSURL *URL = [NSURL URLWithString:
                  [NSString stringWithFormat:@"http://maps.apple.com/?daddr=%f,%f",
                   place.coordinate.latitude,
                   place.coordinate.longitude
                   ]];
    [[UIApplication sharedApplication] openURL:URL];
}

#pragma mark - Intro View

- (void)showIntroWithCrossDissolve {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Welcome !!";
    page1.desc = @"Simple Square is a quick way to explore food places, cafe and restaurants\ngo and find some places :)";
    page1.bgImage = [UIImage imageNamed:@"bg1"];
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"restaurant"]];
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:rootView.bounds andPages:@[page1]];
    [intro setDelegate:self];
    [intro showInView:rootView animateDuration:0.3];
}
@end
