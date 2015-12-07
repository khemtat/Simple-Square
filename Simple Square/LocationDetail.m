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
static const NSString* kcrossStreet = @"crossStreet";

@implementation LocationDetail

- (id)initLocationDetailWithDictionary:(NSDictionary *) dict{
    self = [super init];
    if(self){
        //NSLog(@"from Location Bug is %@" ,dict);
        self.distance = [dict[kdistance] integerValue];
        _address = dict[kaddress];
        if (![dict[kcrossStreet] isEqual:nil]) {
            _crossStreet = dict[kcrossStreet];
        }
    };
    return self;
}

@end
