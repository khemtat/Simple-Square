//
//  Categories.m
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/6/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import "Categories.h"

static const NSString* kCategoryName = @"name";
static const NSString* kIcon = @"icon";
static const NSString* kCategories = @"categories";

@implementation Categories


-(id)initCategoriesWithArray:(NSArray *) array{
    self = [super init];
    if (self) {
        _categories = array[0];
        _name = self.categories[kCategoryName];
        _icon = [[Icon alloc] initIconWithDictionary:self.categories[kIcon]];
    }
    return  self;
}
@end
