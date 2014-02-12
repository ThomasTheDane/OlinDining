//
//  Day.h
//  OlinDining
//
//  Created by Thomas Nattestad on 1/28/14.
//  Copyright (c) 2014 Thomas Nattestad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Meal.h"

@interface Day : NSObject

@property (strong, nonatomic) NSArray *meals;
@property (strong, nonatomic) NSString *name;
@end
