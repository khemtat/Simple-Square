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
    
    MKAnnotationView *view = (MKAnnotationView* )[self.mapView
                                dequeueReusableAnnotationViewWithIdentifier:@"Place"];
    
    if (view == nil) {
        view = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:@"Place"];
        view.canShowCallout = YES;
        view.calloutOffset = CGPointMake(-5, 5);
        view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    } else {
        view.annotation = annotation;
    }
    view.image = [UIImage imageNamed:@"pin"];
    return view;
}
@end
