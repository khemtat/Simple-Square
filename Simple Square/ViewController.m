//
//  ViewController.m
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/2/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Place.h"

@interface ViewController ()<MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation ViewController {
    Place *place;
    CGPoint point;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMapView];
}

- (void)setupMapView {
    self.mapView.delegate = self;
//    place = [[Place alloc] initWithCoordinate:CLLocationCoordinate2DMake(13.825265, 100.865449) andTitle:@"Sweet Home"];
//    [self.mapView addAnnotation:place];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    MKPinAnnotationView *view = (MKPinAnnotationView* )[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"pin"];
    if (view == nil) {
        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
        view.canShowCallout = YES;
        view.animatesDrop = NO;
        view.calloutOffset = [self makePointWithX:-5 andPointY:5];
        view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    } else {
        view.annotation = annotation;
    }
    return view;
}

- (CGPoint)makePointWithX:(float) x andPointY:(float) y{
    point.x = x;
    point.y = y;
    return point;
}
@end
