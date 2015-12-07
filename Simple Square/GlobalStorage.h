//
//  GlobalStorage.h
//  Simple Square
//
//  Created by Khemtat Lengpaiboon on 12/6/2558 BE.
//  Copyright © 2558 404 App not found. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalStorage : NSObject
@property (strong,nonatomic) NSArray* globalArray;
+ (GlobalStorage *) sharedInstance;
@end
