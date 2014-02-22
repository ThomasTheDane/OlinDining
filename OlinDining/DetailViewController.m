//
//  DetailViewController.m
//  OlinDining
//
//  Created by Thomas Nattestad on 1/25/14.
//  Copyright (c) 2014 Thomas Nattestad. All rights reserved.
//

#import "DetailViewController.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;

- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

-(void)setFoodItem:(id)newDetailItem{
    if(self.food != newDetailItem){
        self.food = newDetailItem;
    }
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker set:kGAIScreenName value:@"Detail View"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}
- (void)configureView{
    // Update the user interface for the detail item.
    if (self.food) {
        self.contentScrollView.contentSize = CGSizeMake(320, 850);
        /*
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
         */
        NSDictionary *nutrition = [self.food nutrition];
        self.foodNameLabel.text = [self.food name];

        self.foodDescriptionLabel.text = [nutrition objectForKey:@"description"];
        self.foodServSize.text = [nutrition objectForKey:@"serv_size"];
        self.foodCalories.text = [nutrition objectForKey:@"calories"];
        self.foodFatCalories.text = [nutrition objectForKey:@"fat_calories"];
        self.foodFat.text = [nutrition objectForKey:@"fat"];
        self.foodPercentFatDv.text = [[nutrition objectForKey:@"percent_fat_dv"] stringByAppendingString:@"%"];
        self.foodSatfat.text = [nutrition objectForKey:@"satfat"];
        self.foodPercentSatfat.text = [[nutrition objectForKey:@"percent_satfat"] stringByAppendingString:@"%"];
        self.foodTransFat.text = [nutrition objectForKey:@"trans_fat"];
        self.foodCholesterol.text = [nutrition objectForKey:@"cholesterol"];
        self.foodPercentCholesterol.text = [[nutrition objectForKey:@"percent_cholesterol"] stringByAppendingString:@"%"];
        self.foodSodium.text = [nutrition objectForKey:@"sodium"];
        self.foodPercentSodium.text = [[nutrition objectForKey:@"percent_sodium"] stringByAppendingString:@"%"];
        self.foodCarbo.text = [nutrition objectForKey:@"carbo"];
        self.foodPercentCarbo.text = [[nutrition objectForKey:@"percent_carbo"] stringByAppendingString:@"%"];
        self.foodDfib.text = [nutrition objectForKey:@"dfib"];
        self.foodPercentDfib.text = [[nutrition objectForKey:@"percent_dfib"] stringByAppendingString:@"%"];
        self.foodSugars.text = [nutrition objectForKey:@"sugars"];
        self.foodProtein.text = [nutrition objectForKey:@"protein"];
        self.foodA.text = [nutrition objectForKey:@"a"];
        self.foodCp.text = [nutrition objectForKey:@"cp"];
        self.foodUp.text = [nutrition objectForKey:@"up"];
        self.foodIp.text = [nutrition objectForKey:@"ip"];
        self.foodAllergen.text = [nutrition objectForKey:@"allergen"];
        self.foodPercentVitADv.text = @"";
        self.foodPercentVitCDv.text = @"";
        self.foodPercentCalciumDv.text = @"";
        self.foodPercentIronDv.text = @"";
    }
}

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Split view
//
//- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController{
//    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
//    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
//    self.masterPopoverController = popoverController;
//}
//
//- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem{
//    // Called when the view is shown again in the split view, invalidating the button and popover controller.
//    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
//    self.masterPopoverController = nil;
//}

@end
