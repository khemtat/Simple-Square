//
//  Photo.h
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/6/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>
#import "User.h"

@interface Photo : JSONModel

@property (strong, nonatomic) NSString* prefix;
@property (strong, nonatomic) NSString* suffix;
@property (strong, nonatomic) User* user;

@end
