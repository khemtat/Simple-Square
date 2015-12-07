//
//  GlobalStorage.m
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/6/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import "GlobalStorage.h"

@implementation GlobalStorage

+ (GlobalStorage *) sharedInstance {
    static GlobalStorage *globalInstance;
    if (globalInstance == nil) {
        globalInstance = [[super alloc] init];
    }
    return globalInstance;
}

@end
