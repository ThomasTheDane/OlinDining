//
//  DetailViewController.h
//  OlinDining
//
//  Created by Thomas Nattestad on 1/25/14.
//  Copyright (c) 2014 Thomas Nattestad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodItem.h"


@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

- (void)setFoodItem:(id)newDetailItem;

@property (strong, nonatomic) FoodItem *food;


@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
