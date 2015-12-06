//
//  Venue.h
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/6/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "LocationDetail.h"
#import "Categories.h"
#import "Photo.h"

@interface PlaceDetail : JSONModel

@property (readonly, nonatomic) LocationDetail *location;
@property (readonly, nonatomic) Categories *categories;
@property (readonly, nonatomic) Photo *photos;
@property (readonly, nonatomic) NSDictionary* venue;

-(id)initDetailWithDictionary:(NSDictionary *) dict;

@end