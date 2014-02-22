//
//  MealViewController.m
//  OlinDining
//
//  Created by Thomas Nattestad on 2/16/14.
//  Copyright (c) 2014 Thomas Nattestad. All rights reserved.
//

#import "MealViewController.h"
#import "DetailViewController.h"
#import "FoodItem.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"

@interface MealViewController ()

@end

@implementation MealViewController

-(void)setMealItem:(id)newDetailItem{
    if(self.meal != newDetailItem){
        self.meal = newDetailItem;
    }
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker set:kGAIScreenName value:self.meal.name];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"view loaded meal");
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[self.meal foodItems] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSDictionary *dictionary = [[self.meal foodItems] objectAtIndex:section];
    NSArray *keys = [dictionary allKeys];
    NSArray *array = [dictionary objectForKey:[keys objectAtIndex:0]];
    return [array count];
//    tableView.allowsSelection = false;
//    return [[self.meal foodItems] count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *dictionary = [[self.meal foodItems] objectAtIndex:section];
    NSArray *keys = [dictionary allKeys];
    return [keys objectAtIndex:0];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    cell.accessoryType = UITableViewCellAccessoryNone;
    
    // Configure the cell...
    NSDictionary *dictionary = [[self.meal foodItems] objectAtIndex:indexPath.section];
    NSArray *keys = [dictionary allKeys];
    NSArray *array = [dictionary objectForKey:[keys objectAtIndex:0]];
    cell.textLabel.text = [[array objectAtIndex:indexPath.row] name];
//    cell.textLabel.text = @"eat dick ezra";
  return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"did prepare for segue");
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    NSDictionary *dictionary = [[self.meal foodItems] objectAtIndex:indexPath.section];
    NSArray *keys = [dictionary allKeys];
    NSArray *array = [dictionary objectForKey:[keys objectAtIndex:0]];
    FoodItem *object = array[indexPath.row];
    [[segue destinationViewController] setFoodItem:object];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
