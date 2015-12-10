//
//  VenueList.h
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/3/15.
//  Copyright © 2015 404 App not found. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "venue.h"

@interface VenueList : NSObject
@property (strong,nonatomic) CLLocation *currentLocation;
@property (readonly) NSUInteger count;

+ (id)defaultDataWithCurrentLocation:(CLLocation *)location;
- (Venue *) venueAtIndex:(NSUInteger)index;
- (NSArray *) getVenueList;

@end
