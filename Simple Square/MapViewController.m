//
//  ViewController.m
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/2/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import "MapViewController.h"
#import "AFNetworking.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Place.h"
#import "Places.h"

@interface MapViewController ()
<MKMapViewDelegate, CLLocationManagerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation MapViewController {
    Places *places;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}

#pragma mark - Setup View Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareForSetup];
    [self locationManagerSetup];
    [self setupMapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)prepareForSetup {
    places = [Places defaultData];
    NSArray *temp = [[NSArray alloc] initWithArray:places.getPlaceList];
    NSLog(@"💢 places class counting placeList: %ld",temp.count);
}

#pragma mark - Location Manager

- (void)checkingLocationServicePermission {
    if([CLLocationManager locationServicesEnabled]){
        if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"App Permission Denied"
                                                            message:@"To re-enable, please go to Settings and turn on Location Service for this app."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:@"Settings", nil];
            [alertView show];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"🆘 buttonIndex: %ld",buttonIndex);
    if(buttonIndex == 1) {
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
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    Place *place = [[Place alloc] initWithCoordinate:coordinate andTitle:@"Home"];
    [self.mapView addAnnotation:place];
    [locationManager stopUpdatingLocation];
    locationManager = nil;
    NSLog(@"🔰 Current latitude: %f and longitude: %f",latitude,longitude);
}

#pragma mark - Map View configure

- (void)setupMapView {
    self.mapView.delegate = self;
    [self.mapView addAnnotations:places.getPlaceList];
    NSLog(@"Ⓜ️ Add annotations successfully!!");
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    MKPinAnnotationView *view = (MKPinAnnotationView* )[self.mapView
                                                        dequeueReusableAnnotationViewWithIdentifier:@"pin"];
    if (view == nil) {
        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
        view.canShowCallout = YES;
        view.animatesDrop = NO;
        view.calloutOffset = CGPointMake(-5, 5);
        view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    } else {
        view.annotation = annotation;
    }
    return view;
}
@end
