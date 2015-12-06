//
//  Venue.h
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/6/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "Location.h"
#import "Categories.h"
#import "Photo.h"

@interface Venue : JSONModel

@property (readonly, nonatomic) NSString* id;
@property (readonly, nonatomic) NSString* name;
@property (readonly, nonatomic) Location* location;
@property (readonly, nonatomic) Categories* categories;
@property (readonly, nonatomic) Photo* photos;

-(id)initVenueWithDictionary:(NSDictionary *) dict;

@end