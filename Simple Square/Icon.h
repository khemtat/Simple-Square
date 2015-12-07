//
//  Icon.h
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/6/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface Icon : JSONModel

@property (readonly, nonatomic) NSString* prefix;
@property (readonly, nonatomic) NSString* suffix;
@property (readonly, nonatomic) NSString* icon;

-(id)initIconWithDictionary:(NSDictionary *) dict;

@end
