//
//  Venue.h
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/6/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>


@interface PlaceDetail : NSObject

@property (assign, nonatomic) long distance;
@property (readonly, nonatomic) NSString* address;

-(id)initDetailWithDictionary:(NSDictionary *) dict;

@end