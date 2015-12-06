//
//  Venue.m
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/6/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import "Venue.h"
#import "Location.h"
#import "Photo.h"
#import "Categories.h"

static const NSString* kID = @"id";
static const NSString* kVenueName = @"name";
static const NSString* kLocation = @"location";
static const NSString* kCategories = @"categoriess";
static const NSString* kPhoto = @"photos";

@implementation Venue

-(id)initVenueWithDictionary:(NSDictionary *) dict{
    self = [super init];
    if (self) {
        _id = dict[kID];
        _name = dict[kVenueName];
        _location = [[Location alloc] initWithLocation:dict[kLocation]];
        _categories = [[Categories alloc] initWithCategories:dict[kCategories]];
        _photos = [[Photo alloc] initWithPhoto:dict[kPhoto]];
    }
    return self;
}
@end