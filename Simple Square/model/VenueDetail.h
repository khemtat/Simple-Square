//
//  VenueDetail.h
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/10/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VenueDetail : NSObject
@property (assign, nonatomic) long distance;
@property (readonly, nonatomic) NSString* address;
-(id)initWithDictionary:(NSDictionary *) dict;
@end
