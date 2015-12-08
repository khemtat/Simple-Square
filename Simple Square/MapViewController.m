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


@interface MapViewController ()
<MKMapViewDelegate, CLLocationManagerDelegate, UIAlertViewDelegate, EAIntroDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation MapViewController {\
    UIView *rootView;
    EAIntroView *_intro;
    Places *places;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}

#pragma mark - Setup View Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    rootView = self.navigationController.view;
    if (![@"1" isEqualToString:[[NSUserDefaults standardUserDefaults]
                                objectForKey:@"firstTimeRunningApp"]]) {
        [self showIntroWithCrossDissolve];
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"firstTimeRunningApp"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } //else {
        //[self performSegueWithIdentifier:@"showMapViewController" sender:self];
        //NSLog(@"AEIOU");
    //}
    [self locationManagerSetup];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setupMapView)
                                                 name:@"foursquareDataLoadedNotification"
                                               object:nil];
}

#pragma mark - Location Manager

- (void)checkingLocationServicePermission {
    if([CLLocationManager locationServicesEnabled]){
        if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
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
    NSLog(@"❓ Places instance in MapViewController: %@",places);
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
    [self.mapView setVisibleMapRect:zoomRect edgePadding:UIEdgeInsetsMake(85, 10, 10, 10) animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if (annotation == mapView.userLocation)
        return nil;
    Place *place = (Place *)annotation;
    long distanceInM = (place.placeDetail.location.distance);
    double distanceInKM = distanceInM/1000.0;
    MKAnnotationView *view = (MKAnnotationView* )[self.mapView
                                dequeueReusableAnnotationViewWithIdentifier:@"Place"];
    if (view == nil) {
        view = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:@"Place"];
        view.canShowCallout = YES;
        view.calloutOffset = CGPointMake(-5, 5);
        view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        UILabel *distance = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        distance.textColor = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0];
        distance.text = [NSString stringWithFormat:@"%.2lf\nKM",distanceInKM];
        distance.textAlignment = 1;
        distance.numberOfLines = 2;
        [distance setFont:[UIFont systemFontOfSize:15.0]];
        distance.backgroundColor = [UIColor colorWithRed:0.36 green:0.72 blue:0.36 alpha:1.0];
        view.leftCalloutAccessoryView = distance;
        view.image = [UIImage imageNamed:@"pin"];
    } else {
        view.annotation = annotation;
    }
    return view;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view
                      calloutAccessoryControlTapped:(UIControl *)control {
    Place *place = (Place *)view.annotation;
    NSLog(@"inside the stupid method %@",[place placeDetail].venue);
}

#pragma mark - Intro View

- (void)showIntroWithCrossDissolve {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Hello world";
    page1.desc = @"1 na";
    page1.bgImage = [UIImage imageNamed:@"bg1"];
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title1"]];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"This is page 2";
    page2.desc = @"2 na";
    page2.bgImage = [UIImage imageNamed:@"bg2"];
    page2.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title2"]];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"This is page 3";
    page3.desc = @"3 na";
    page3.bgImage = [UIImage imageNamed:@"bg3"];
    page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title3"]];
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.title = @"This is page 4";
    page4.desc = @"4 na";
    page4.bgImage = [UIImage imageNamed:@"bg4"];
    page4.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title4"]];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:rootView.bounds andPages:@[page1,page2,page3,page4]];
    
    [intro setDelegate:self];
    
    [intro showInView:rootView animateDuration:0.3];
}
@end
