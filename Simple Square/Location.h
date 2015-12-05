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

@property (assign, nonatomic) float lat;
@property (assign, nonatomic) float lng;
@property (assign, nonatomic) int distance;
@property (strong, nonatomic) NSString* crossStreet;
@property (strong, nonatomic) NSString* city;
@property (strong, nonatomic) NSString* state;
@property (strong, nonatomic) NSString* country;

@end
