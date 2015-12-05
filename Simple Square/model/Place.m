//
//  Place.m
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/3/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import "Place.h"
#import <AFNetworking.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

static const NSString *kTitle = @"name";
static const NSString *kLocation = @"location";
static const NSString *kLatitude = @"lat";
static const NSString *kLongitude = @"lng";


@implementation Place

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate andTitle:(NSString* )name {
    self = [super init];
    if (self) {
        self.title = name;
        _coordinate = coordinate;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.title = dict[kTitle];
        _coordinate = [self getLatitudeAndLongitude:dict[kLocation]];
    }
    return self;
}

- (CLLocationCoordinate2D)getLatitudeAndLongitude:(NSDictionary *)dict {
    double lat = dict[kLatitude] != nil;
    double lng = dict[kLongitude] != nil;
    return CLLocationCoordinate2DMake(lat,lng);
}

@end
