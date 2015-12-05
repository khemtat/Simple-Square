//
//  Categories.h
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/6/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>
#import "Icon.h"

@interface Categories : JSONModel

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) Icon* icon;

@end
