//
//  Photo.h
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/6/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>

@interface Photo : JSONModel

@property (readonly, nonatomic) NSString* prefix;
@property (readonly, nonatomic) NSString* suffix;
@property (readonly, nonatomic) NSDictionary* groupItems;
@property (readonly, nonatomic) NSString* image;
@property (readonly, nonatomic) NSArray* groups;
@property (readonly, nonatomic) NSArray* items;
@property (readonly, nonatomic) NSDictionary* itemOfItems;


-(id)initPhotoWithDictionary:(NSDictionary *) dict;

@end


