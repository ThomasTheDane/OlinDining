//
//  MasterViewController.m
//  OlinDining
//
//  Created by Thomas Nattestad on 1/25/14.
//  Copyright (c) 2014 Thomas Nattestad. All rights reserved.
//

#import "MasterViewController.h"
#import "DayViewController.h"
#import "Week.h"
#import "Day.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"

@interface MasterViewController () {
    
}
@end

@implementation MasterViewController

- (void)awakeFromNib{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    id tracker = [[GAI sharedInstance] defaultTracker];
    
//    [tracker set:kGAIScreenName value:@"Week View"];
//    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    NSLog(@"masterview loaded");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dayLoaded) name:@"initWithJsonWeekFinished" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emptyError) name:@"initWithJsonWeekEmptyError" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkError) name:@"initWithJsonWeekNetworkError" object:nil];
    self.week = [[Week alloc] init];

    UIBarButtonItem *reloadButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadData:)];
    self.navigationItem.rightBarButtonItem = reloadButton;

    self.activitySpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.activitySpinner setCenter:CGPointMake(320 / 2.0, 25)];
    [self.view addSubview:self.activitySpinner];
    [self.activitySpinner startAnimating];
    [self.activitySpinner setHidesWhenStopped:YES];
    
    //    [self dayLoaded];
	// Do any additional setup after loading the view, typically from a nib.
    //    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //    self.navigationItem.rightBarButtonItem = addButton;
    //    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)reloadData:(id)sender{
    [self.activitySpinner startAnimating];
    self.week = [[Week alloc] init];
    if(self.errorView){
        [self.errorView removeFromSuperview];
    }
    self.isLoaded = FALSE;
}

- (void)dayLoaded{
    [self.activitySpinner stopAnimating];
    [self.tableView reloadData];
    self.isLoaded = TRUE;
}

-(void)emptyError{
    self.errorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    UITextView *errorMessage = [[UITextView alloc] initWithFrame:CGRectMake(0, 140, 320, 80)];
    [errorMessage setText:@"Seems the menu is out of date, you should go complain to the dining hall about that"];
    [errorMessage setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20]];
    [errorMessage setEditable:NO];
    [self.errorView addSubview:errorMessage];
    [super.view addSubview:self.errorView];
    [self.activitySpinner stopAnimating];
}

-(void)networkError{
    self.errorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    UITextView *errorMessage = [[UITextView alloc] initWithFrame:CGRectMake(0, 140, 320, 80)];
    [errorMessage setText:@"Seems there was a connectivity error, you should probably go blame Ezra Varady"];
    [errorMessage setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20]];
    [errorMessage setEditable:NO];
    [self.errorView addSubview:errorMessage];
    [super.view addSubview:self.errorView];
    [self.activitySpinner stopAnimating];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.week.days.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSLog(@"Loading cell");
    cell.textLabel.text = [self.week.days[indexPath.row] name];
    //    NSLog(@"loading cell with name: %@", [day name]);
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.week.days removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
//}

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"did select a day");
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        Day *object = self.week.days[indexPath.row];
        self.dayViewController.day = object;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"did prepare for segue");
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    Day *object = self.week.days[indexPath.row];
    [[segue destinationViewController] setDayItem:object];
}

@end
