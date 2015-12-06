//
//  Location.m
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/6/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import "Location.h"
#import <Foundation/Foundation.h>

static const NSString* kdistance = @"distance";
static const NSString* kcrossStreet = @"crossStreet";
static const NSString* kcity = @"city";
static const NSString* kstate = @"state";
static const NSString* kcountry = @"country";

@implementation Location

- (id)initWithLocation:(NSDictionary *)location{
    self = [super init];
    if(self){
        //NSLog(@"from Location lat is %@" ,location[klat]);
        //NSLog(@"from Location lng is %@" ,location[klng]);
        self.distance = [location[kdistance] integerValue];
        _crossStreet = location[kcrossStreet];
        _city = location[kcity];
        _state = location[kstate];
        _country = location[kcountry];
    }
    
    return self;
}

@end
