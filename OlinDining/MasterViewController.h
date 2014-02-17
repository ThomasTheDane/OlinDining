//
//  MasterViewController.h
//  OlinDining
//
//  Created by Thomas Nattestad on 1/25/14.
//  Copyright (c) 2014 Thomas Nattestad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Week.h"

@class DayViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DayViewController *dayViewController;
@property (strong, nonatomic) Week *week;

@end
