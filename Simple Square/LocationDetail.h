//
//  Location.h
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/6/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface Location : JSONModel

@property (assign, nonatomic) long distance;
@property (readonly, nonatomic) NSString* crossStreet;
@property (readonly, nonatomic) NSString* city;
@property (readonly, nonatomic) NSString* state;
@property (readonly, nonatomic) NSString* country;

- (id)initWithLocation:(NSDictionary *)location;

@end
