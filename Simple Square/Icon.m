//
//  Icon.m
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/6/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import "Icon.h"

static const NSString* kIconPrefix = @"prefix";
static const NSString* kIconSuffix = @"suffix";

@implementation Icon

-(id)initWithIcon:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        _prefix = dict[kIconPrefix];
        _suffix = dict[kIconSuffix];
    }
    return  self;
}

@end
