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

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UILabel *foodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodServSize;
@property (weak, nonatomic) IBOutlet UILabel *foodCalories;
@property (weak, nonatomic) IBOutlet UILabel *foodFatCalories;
@property (weak, nonatomic) IBOutlet UILabel *foodFat;
@property (weak, nonatomic) IBOutlet UILabel *foodPercentFatDv;
@property (weak, nonatomic) IBOutlet UILabel *foodSatfat;
@property (weak, nonatomic) IBOutlet UILabel *foodPercentSatfat;
@property (weak, nonatomic) IBOutlet UILabel *foodTransFat;
@property (weak, nonatomic) IBOutlet UILabel *foodCholesterol;
@property (weak, nonatomic) IBOutlet UILabel *foodPercentCholesterol;
@property (weak, nonatomic) IBOutlet UILabel *foodSodium;
@property (weak, nonatomic) IBOutlet UILabel *foodPercentSodium;
@property (weak, nonatomic) IBOutlet UILabel *foodCarbo;
@property (weak, nonatomic) IBOutlet UILabel *foodPercentCarbo;
@property (weak, nonatomic) IBOutlet UILabel *foodDfib;
@property (weak, nonatomic) IBOutlet UILabel *foodPercentDfib;
@property (weak, nonatomic) IBOutlet UILabel *foodSugars;
@property (weak, nonatomic) IBOutlet UILabel *foodProtein;
@property (weak, nonatomic) IBOutlet UILabel *foodA;
@property (weak, nonatomic) IBOutlet UILabel *foodCp;
@property (weak, nonatomic) IBOutlet UILabel *foodUp;
@property (weak, nonatomic) IBOutlet UILabel *foodIp;
@property (weak, nonatomic) IBOutlet UILabel *foodAllergen;
@property (weak, nonatomic) IBOutlet UILabel *foodPercentVitADv;
@property (weak, nonatomic) IBOutlet UILabel *foodPercentVitCDv;
@property (weak, nonatomic) IBOutlet UILabel *foodPercentCalciumDv;
@property (weak, nonatomic) IBOutlet UILabel *foodPercentIronDv;

@end
