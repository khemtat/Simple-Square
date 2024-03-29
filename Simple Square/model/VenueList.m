//
//  VenueList.m
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/3/15.
//  Copyright © 2015 404 App not found. All rights reserved.
//

#import "VenueList.h"
#import "venue.h"
#import <Foundation/Foundation.h>
#import <AFNetworking.h>

const static NSString *clientID = @"KTNUKEWM0BIWR3LFJ1DM150OFZ4ZBP0WYCFFJC2EOVH0QNL2";
const static NSString *clientSecret = @"X00LW15CHQKBSLNJGGQ4XFHQ24CK0VMZW5TZ5EQYEMDFVG4M";
const static NSString *APIRequestVersion = @"20151203";
const static NSString *section = @"food";

@implementation VenueList {
    NSArray* venueList;
}

+ (id)defaultDataWithCurrentLocation:(CLLocation *)location {
    return [[[self class] alloc] initWithDefaultData:location];
}

- (id)initWithDefaultData:(CLLocation *)location {
    self = [super init];
    if (self) {
        self.currentLocation = location;
        [self sendRequestVenueListData:self];
    }
    return self;
}

- (void)sendRequestVenueListData:(id)sender {
        // My API (GET https://api.foursquare.com/v2/venues/explore)
    
        // Create manager
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
        // Create request
        NSString *llParameter = [NSString stringWithFormat:@"%f,%f", self.currentLocation.coordinate.latitude, self.currentLocation.coordinate.longitude];
        NSDictionary* URLParameters = @{
                                        @"client_id":clientID,
                                        @"client_secret":clientSecret,
                                        @"v":APIRequestVersion,
                                        @"section":section,
                                        @"ll":llParameter,
                                        @"venuePhotos":@"1",
                                        @"sortByDistance":@"1",
                                        };
    
        NSMutableURLRequest* request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:@"https://api.foursquare.com/v2/venues/explore" parameters:URLParameters error:NULL];
        
            // Fetch Request
            AFHTTPRequestOperation *operation = [manager
                                                 HTTPRequestOperationWithRequest:request
                                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                     NSLog(@"✅ HTTP Response Status Code: %ld", [operation.response statusCode]);
                                                     [self parsedToJson:responseObject];
                                                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                     NSLog(@"⁉️ HTTP Request failed: %@", error);
                                                 }];
            [manager.operationQueue addOperation:operation];
            NSLog(@"✅ Send request VenueList data successfully!!");
}

- (void)parsedToJson:(id) responseObject {
    NSDictionary* dictionary = [[NSDictionary alloc] initWithDictionary:responseObject];
    NSArray* tempArray = [[NSArray alloc] initWithObjects:dictionary[@"response"], nil];
    dictionary = [[NSDictionary alloc] initWithDictionary:tempArray[0]];
    tempArray = [[NSArray alloc] initWithObjects:dictionary[@"groups"], nil];
    NSArray* json = [[NSArray alloc] initWithArray:tempArray[0]];
    NSDictionary* itemDictionary = [[NSDictionary alloc] initWithDictionary:json[0]];
    NSArray* jsonItem = [[NSArray alloc] initWithObjects:itemDictionary[@"items"], nil];
    NSArray* venues = [[NSArray alloc] initWithArray:jsonItem[0]];
    venues != nil ? NSLog(@"✅ Parsed json successfully "):NSLog(@"⁉️ Error can't parsed json");
    [self parsedJsonToArray:venues];
}

- (void)parsedJsonToArray:(NSArray *) venues {
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:venues.count];
    NSLog(@"✅ json.count = %ld", venues.count);
    for (NSDictionary *dict in venues) {
        [tempArray addObject:[[Venue alloc] initWithDictionary:dict]];
    }
    venueList = [[NSArray alloc] initWithArray:tempArray];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"foursquareDataLoadedNotification"
                                                        object:nil];
    NSLog(@"✅ Parsed json to VenueList array successfully!!");
}


- (Venue *) venueAtIndex:(NSUInteger)index {
    return [venueList objectAtIndex:index];
}

- (NSUInteger) count {
    return venueList.count;
}

- (NSArray *) getVenueList {
    return venueList;
}
@end