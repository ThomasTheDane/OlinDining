//
//  MealViewController.h
//  OlinDining
//
//  Created by Thomas Nattestad on 2/16/14.
//  Copyright (c) 2014 Thomas Nattestad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meal.h"

@class DetailViewController;

@interface MealViewController : UITableViewController

- (void)setMealItem:(id)newDetailItem;

@property (strong, nonatomic) Meal *meal;
@property (strong, nonatomic) DetailViewController *detailViewController;

@end
