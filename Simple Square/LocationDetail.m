//
//  Location.m
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/6/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import "LocationDetail.h"
#import <Foundation/Foundation.h>

static const NSString* kdistance = @"distance";
static const NSString* kaddress = @"address";
static NSString* const kformattedAddress = @"formattedAddress";

@implementation LocationDetail

- (id)initLocationDetailWithDictionary:(NSDictionary *) dict{
    self = [super init];
    if(self){
        //NSLog(@"from Location Bug is %@" ,dict);
        self.distance = [dict[kdistance] integerValue];
//        if (![[dict valueForKey:kformattedAddress] isEqual:nil]) {
//            _formattedAddress = dict[kformattedAddress];
//        }
        _address = dict[kaddress];
        
    };
    return self;
}

@end
