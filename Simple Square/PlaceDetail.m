//
//  Venue.m
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/6/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import "PlaceDetail.h"


static const NSString* kLocation = @"location";
static const NSString* kVenue = @"venue";
static const NSString* kdistance = @"distance";
static const NSString* kaddress = @"address";

@implementation PlaceDetail

-(id)initDetailWithDictionary:(NSDictionary *) dict{
    self = [super init];
    if (self) {
        NSDictionary* location = [NSDictionary alloc];
        NSDictionary* venue = [NSDictionary alloc];
        venue = dict[kVenue];
        location = venue[kLocation];
        self.distance = [location[kdistance] integerValue];
        _address = location[kaddress];
        
    }
    return self;
}
@end