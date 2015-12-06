//
//  Venue.m
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/6/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import "PlaceDetail.h"
#import "LocationDetail.h"
#import "Photo.h"
#import "Categories.h"

static const NSString* kLocationDetail = @"location";
static const NSString* kCategories = @"categories";
static const NSString* kPhoto = @"photos";
static const NSString* kVenue = @"venue";

@implementation PlaceDetail

-(id)initDetailWithDictionary:(NSDictionary *) dict{
    self = [super init];
    if (self) {
        _venue = dict[kVenue];
        //NSLog(@"I'm a Bug %@",self.venue);
        _location = [[LocationDetail alloc] initLocationDetailWithDictionary:self.venue[kLocationDetail]];
        _categories = [[Categories alloc] initWithCategories:self.venue[kCategories]];
        _photos = [[Photo alloc] initWithPhoto:self.venue[kPhoto]];
    }
    return self;
}
@end