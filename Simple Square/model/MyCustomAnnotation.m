//
//  MyCustomAnnotation.m
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/8/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import "MyCustomAnnotation.h"

@implementation MyCustomAnnotation
- (id) initWithLocation:(CLLocationCoordinate2D)coord andTitle:(NSString *)title {
    self = [super init];
    if (self) {
        _coordinate = coord;
        self.title  = title;
    }
    return self;
}
@end
