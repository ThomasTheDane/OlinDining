//
//  Week.h
//  OlinDining
//
//  Created by Thomas Nattestad on 1/28/14.
//  Copyright (c) 2014 Thomas Nattestad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Day.h"

@interface Week : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *days;


@end
