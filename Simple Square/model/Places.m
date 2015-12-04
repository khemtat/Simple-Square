//
//  Places.m
//  Simple Square
//
//  Created by STUDENT on 12/3/15.
//  Copyright © 2015 404 App not found. All rights reserved.
//

#import "Places.h"
#import "Place.h"
#import <AFNetworking.h>

@implementation Places {
    NSArray* placeList;
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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        // My API (GET https://api.foursquare.com/v2/venues/search)
        
        // Create manager
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        // Create request
        NSDictionary* URLParameters = @{
                                        @"client_id":@"KTNUKEWM0BIWR3LFJ1DM150OFZ4ZBP0WYCFFJC2EOVH0QNL2",
                                        @"client_secret":@"X00LW15CHQKBSLNJGGQ4XFHQ24CK0VMZW5TZ5EQYEMDFVG4M",
                                        @"v":@"20151203 ",
                                        @"ll":@"13.746220,100.530704",
                                        @"query":@"coffee",
                                        };
        
        NSMutableURLRequest* request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:@"https://api.foursquare.com/v2/venues/search" parameters:URLParameters error:NULL];
        NSLog(@"%@",request);
        // Fetch Request
        AFHTTPRequestOperation *operation = [manager
                HTTPRequestOperationWithRequest:request
                                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                            NSLog(@"HTTP Response Status Code: %ld", [operation.response statusCode]);
                                            [self parseJSON:responseObject];
                                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                            NSLog(@"HTTP Request failed: %@", error);
                                        }];
        [manager.operationQueue addOperation:operation];
        NSLog(@"#sendRequestPlacesData successfully!!");
    });
}

- (void)parseJSON:(id)responseObject {
    NSDictionary* dictionary = [[NSDictionary alloc] initWithDictionary:responseObject];
    NSArray* tempArray = [[NSArray alloc] initWithObjects:dictionary[@"response"], nil];
    
    NSDictionary* tempDict = [[NSDictionary alloc] initWithDictionary:tempArray[0]];
    NSArray* tmp = [[NSArray alloc] initWithObjects:tempDict[@"venues"], nil];
    NSArray* json = [[NSArray alloc] initWithArray:tmp[0]];
    json != nil ? NSLog(@"#parseJSON successfully"):NSLog(@"error can't load json");
    [self parseJSONToPlacesArray:json];
}

- (void) parseJSONToPlacesArray:(NSArray *)json {
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:json.count];
    NSLog(@"json.count = %ld",json.count);
    for (NSDictionary *dict in json) {
        [tempArray addObject:[[Place alloc] initWithDictionary:dict]];
    }
    placeList = [NSArray arrayWithArray:tempArray];
    NSLog(@"#parseJSONToPlacesArray successfully!!");
}

- (NSArray* )getPlaceList {
    return placeList;
}

@end
