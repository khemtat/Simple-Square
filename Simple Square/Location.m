//
//  Location.m
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/6/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import "Location.h"
#import <Foundation/Foundation.h>

static const NSString* klat = @"lat";
static const NSString* klng = @"lng";
static const NSString* kdistance = @"distance";
static const NSString* kcrossStreet = @"crossStreet";
static const NSString* kcity = @"city";
static const NSString* kstate = @"state";
static const NSString* kcountry = @"country";

@implementation Location

-(id)initWithLocation:(NSDictionary *)location{
    self = [super init];
    if(self){
        self.lat = location[klat];
        self.lng = location[klng];
        self.distance = location[kdistance];
        self.crossStreet = location[kcrossStreet];
        self.city = location[kcity];
        self.state = location[kstate];
        self.country = location[kcountry];
    }
    
    return self;
}

@end
