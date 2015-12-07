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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    
    NSString* coordinateString = [NSString stringWithFormat:@"%f,%f",latitude,longitude];
    places = [Places defaultDataWithCurrentLocation:coordinateString];
    NSLog(@"❓ Places instance in MapViewController: %@",places);
    [locationManager stopUpdatingLocation];
    locationManager = nil;
    self.mapView.showsUserLocation = YES;
    NSLog(@"🔰 Current latitude: %f and longitude: %f",latitude,longitude);
}

#pragma mark - Map View configure


- (void)setupMapView {

//    Place *place1 = [[Place alloc] initWithCoordinate:CLLocationCoordinate2DMake(13.845766, 100.840859) andTitle:@"71/271"];
//    Place *place2 = [[Place alloc] initWithCoordinate:CLLocationCoordinate2DMake(13.831599, 100.849828) andTitle:@"ศูนย์ฝึกอบรม"];
//    Place *place3 = [[Place alloc] initWithCoordinate:CLLocationCoordinate2DMake(13.820008, 100.844289) andTitle:@"OtheBankky"];
//    Place *place4 = [[Place alloc] initWithCoordinate:CLLocationCoordinate2DMake(13.834016, 100.865964) andTitle:@"Clevz"];
//    NSArray *list = @[place1,place2,place3,place4];
//    [self.mapView addAnnotations:list];
    
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"⚠️ [places count] from MapViewController: %ld",[places count]);
    });
    [self mapViewEnclosedAnnotationsIncludeUserLocation];
//    NSLog(@"Ⓜ️ Add annotations successfully!!");
}

- (void)mapViewEnclosedAnnotationsIncludeUserLocation {
//    MKMapPoint userCurrentAnnotationPoint = MKMapPointForCoordinate(currentLocation.coordinate);
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        if (MKMapRectIsNull(zoomRect)) {
//            pointRect = MKMapRectMake(userCurrentAnnotationPoint.x, userCurrentAnnotationPoint.y, 0.1, 0.1);
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
