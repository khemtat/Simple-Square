//
//  Photo.m
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/6/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import "Photo.h"

static NSString* const kPrefix = @"prefix";
static NSString* const kSuffix = @"suffix";
static NSString* const kImage = @"image";
static NSString* const kPhoto = @"photo";
static NSString* const kGroups = @"groups";
static NSString* const kItems = @"items";
static NSString* const kUser = @"user";

@implementation Photo

-(id)initWithPhoto:(NSDictionary *) dict{
    self = [super init];
    if (self) {
        //NSLog(@"Bug from Photo %@", dict);
        //_groups = dict[kGroups];
        //_items = self.groups[0];
       // NSLog(@"%@", self.items);
        //_prefix = [self.items[kPrefix]];
       //NSLog(@"%@", self.prefix);
    }
    return  self;
}

@end

@interface PhotoGroups : JSONModel

@property (readonly, nonatomic) NSString* groups;

@end

@implementation PhotoGroups

-(id)initWithPhotoGroup:(NSDictionary *) dict{
    self = [super init];
    if (self) {
        _groups = dict[kGroups];
    }
    return self;
}

@end

@interface PhotoItems : JSONModel

@property (readonly, nonatomic) NSString* items;

@end

@implementation PhotoItems

-(id)initWithPhotoItems:(NSDictionary *) dict{
    self = [super init];
    if (self) {
        _items = dict[kItems];
    }
    return self;}

@end