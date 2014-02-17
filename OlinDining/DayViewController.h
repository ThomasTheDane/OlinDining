//
//  DayViewController.h
//  OlinDining
//
//  Created by Thomas Nattestad on 2/15/14.
//  Copyright (c) 2014 Thomas Nattestad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Day.h"

@class FoodViewController;

@interface DayViewController : UITableViewController

@property (strong, nonatomic) FoodViewController *foodViewController;
@property (strong, nonatomic) Day *day;

@end
