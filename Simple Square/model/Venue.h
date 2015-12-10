//
//  Venue.h
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/3/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "VenueDetail.h"

@interface Venue : NSObject <MKAnnotation>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) VenueDetail* VenueDetail;
@property (nonatomic, readonly) NSDictionary* venue;
@property (nonatomic, readonly) NSDictionary* location;

- (id)initWithDictionary:(NSDictionary *)dict;

@end