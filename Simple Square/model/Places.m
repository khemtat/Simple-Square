//
//  Places.m
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/3/15.
//  Copyright © 2015 404 App not found. All rights reserved.
//

#import "Places.h"
#import "Place.h"
#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "MapViewController.h"

const static NSString *clientID = @"KTNUKEWM0BIWR3LFJ1DM150OFZ4ZBP0WYCFFJC2EOVH0QNL2";
const static NSString *clientSecret = @"X00LW15CHQKBSLNJGGQ4XFHQ24CK0VMZW5TZ5EQYEMDFVG4M";
const static NSString *APIRequestVersion = @"20151203";
const static NSString *section = @"food";

@implementation Places {
    NSArray* placeList;
    Place* place;
}

+ (id)defaultData {
    return [[[self class] alloc] initWithDefaultData];
}

- (id)initWithDefaultData {
    self = [super init];
    if (self) {
        [self loadData:self];
    }
    return self;
}

- (void)loadData:(id)sender {
    [self sendRequestPlacesData:sender];
}

- (void)sendRequestPlacesData:(id)sender {
        // My API (GET https://api.foursquare.com/v2/venues/explore)
        
        // Create manager
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        // Create request
        NSDictionary* URLParameters = @{
                                        @"client_id":clientID,
                                        @"client_secret":clientSecret,
                                        @"v":APIRequestVersion,
                                        @"section":section,
                                        @"ll":@"13.746220,100.530704",
                                        @"venuePhotos":@"1"
                                        };
        
        NSMutableURLRequest* request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:@"https://api.foursquare.com/v2/venues/explore" parameters:URLParameters error:NULL];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            // Fetch Request
            AFHTTPRequestOperation *operation = [manager
                                                 HTTPRequestOperationWithRequest:request
                                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                     NSLog(@"✅ HTTP Response Status Code: %ld", [operation.response statusCode]);
                                                     [self parseJSON:responseObject];
                                                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                     NSLog(@"⁉️ HTTP Request failed: %@", error);
                                                 }];
            [manager.operationQueue addOperation:operation];
            NSLog(@"✅ Send request places data successfully!!");
        });
}

- (void)parseJSON:(id)responseObject {
    NSDictionary* dictionary = [[NSDictionary alloc] initWithDictionary:responseObject];
    NSArray* tempArray = [[NSArray alloc] initWithObjects:dictionary[@"response"], nil];
    dictionary = [[NSDictionary alloc] initWithDictionary:tempArray[0]];
    tempArray = [[NSArray alloc] initWithObjects:dictionary[@"groups"], nil];
    NSArray* json = [[NSArray alloc] initWithArray:tempArray[0]];
    NSDictionary* itemDictionary = [[NSDictionary alloc] initWithDictionary:json[0]];
    NSArray* jsonItem = [[NSArray alloc] initWithObjects:itemDictionary[@"items"], nil];
    NSArray* venue = [[NSArray alloc] initWithArray:jsonItem[0]];
    venue != nil?NSLog(@"✅ Parsed json successfully "):NSLog(@"⁉️ error can't load json");
    [self parseJSONToPlacesArray:venue];
}

- (void) parseJSONToPlacesArray:(NSArray *)venue{
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:venue.count];
    NSLog(@"✅ json.count = %ld", venue.count);
    for (NSDictionary *dict in venue) {
        [tempArray addObject:[[Place alloc] initWithDictionary:dict]];
    }
    placeList = [[NSArray alloc] initWithArray:tempArray];
    NSLog(@"✅ Parsed;json to places array successfully!!");
}

- (NSArray* )getPlaceList {
    return placeList;
    
}

@end
