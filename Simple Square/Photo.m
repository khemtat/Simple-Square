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
static NSString* const kGroups = @"groups";
static NSString* const kItems = @"items";


@implementation Photo

-(id)initPhotoWithDictionary:(NSDictionary *) dict{
    self = [super init];
    if (self) {
//        _groups = dict[kGroups];
//        _groupItems = self.groups[0];
//        _items = self.groupItems[kItems];
//        _itemOfItems = self.items[0];
//        _prefix = self.itemOfItems[kPrefix];
//        _suffix = self.itemOfItems[kSuffix];
//        _image = [[self.prefix stringByAppendingString:@"original"] stringByAppendingString:self.suffix];
        
        //NSLog(@"Bug from Photo %@", dict);
        //_groups = dict[kGroups];
        //_items = self.groups[0];
        //NSLog(@"Item Bug %@", self.items);
        //_prefix = [self.items[kPrefix]];
        //NSLog(@"Image From Photo %@", self.image);
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