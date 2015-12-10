//
//  VenueDetail.m
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/10/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import "VenueDetail.h"

static const NSString* kLocation = @"location";
static const NSString* kVenue = @"venue";
static const NSString* kdistance = @"distance";
static const NSString* kaddress = @"address";

@interface VenueDetail()
@property (readwrite) NSString* address;
@end

@implementation VenueDetail
-(id)initWithDictionary:(NSDictionary *) dict{
    self = [super init];
    if (self) {
        NSDictionary* venue = dict[kVenue];
        NSDictionary* location = venue[kLocation];
        self.distance = [location[kdistance] integerValue];
        self.address = location[kaddress];
    }
    return self;
}
@end
