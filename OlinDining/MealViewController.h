//
//  MealViewController.h
//  OlinDining
//
//  Created by Thomas Nattestad on 2/16/14.
//  Copyright (c) 2014 Thomas Nattestad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meal.h"

@interface MealViewController : UITableViewController

- (void)setMealItem:(id)newDetailItem;

@property (strong, nonatomic) Meal *meal;

@end
