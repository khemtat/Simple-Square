//
//  Place.m
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/3/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import "Place.h"
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

static  NSString const *kTitle = @"name";
static  NSString const *kLocation = @"location";
static  NSString const *kLatitude = @"lat";
static  NSString const *kLongitude = @"lng";
static  NSString const *kPlaceDetail = @"placeDetail";
static  NSString const *kVenue = @"venue";

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
        _venue = dict[kVenue];
        self.title = self.venue[kTitle];
        //NSLog(@"%@", self.title);
        _location = self.venue[kLocation];
        _coordinate = [self getLatitudeAndLongitude:self.location];
        _placeDetail = [[PlaceDetail alloc] initDetailWithDictionary:dict];    };
    return self;
}

- (CLLocationCoordinate2D)getLatitudeAndLongitude:(NSDictionary *)dict {
    double lat = [dict[kLatitude] doubleValue];
    double lng = [dict[kLongitude] doubleValue];
    return CLLocationCoordinate2DMake(lat,lng);
}

@end
