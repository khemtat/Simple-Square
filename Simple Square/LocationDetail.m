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
static const NSString* kcrossStreet = @"crossStreet";
static const NSString* kcity = @"city";
static const NSString* kstate = @"state";
static const NSString* kcountry = @"country";

@implementation LocationDetail

- (id)initLocationDetailWithDictionary:(NSDictionary *) dict{
    self = [super init];
    if(self){
        //NSLog(@"from Location Bug is %@" ,dict);
        self.distance = [dict[kdistance] integerValue];
        _crossStreet = dict[kcrossStreet];
        _city = dict[kcity];
        _state = dict[kstate];
        _country = dict[kcountry];
    };
    return self;
}

@end
