//
//  Places.h
//  Simple Square
//
//  Created by STUDENT on 12/3/15.
//  Copyright © 2015 404 App not found. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Places : NSObject
- (void)loadData:(id)sender;
- (NSArray *)getPlaceList;
- (id)initWithDefaultData;
+(id)defaultData;
@end
