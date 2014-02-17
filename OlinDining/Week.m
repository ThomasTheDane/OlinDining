//
//  Week.m
//  OlinDining
//
//  Created by Thomas Nattestad on 1/28/14.
//  Copyright (c) 2014 Thomas Nattestad. All rights reserved.//

#import "Week.h"
#import "AFJSONRequestOperation.h"
#import "Day.h"
#import "Meal.h"
#import "FoodItem.h"

@implementation Week

-(id)init{
    self = [super init];
    if(self){
        self = [self initWithJSON];
    }
    return self;
}

-(id)initWithJSON{
    self = [super init];
    if(self){
        NSURL *url = [[NSURL alloc] initWithString:@"http://www.olinapps.com/api/dining/olin"];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            NSLog(@"Loaded and shit");
            
            NSMutableArray *tempDays = [[NSMutableArray alloc] init];
            for(NSDictionary *day in JSON){
                Day *aDay = [[Day alloc] init];
                aDay.name = day[@"dayname"];
                
                NSMutableArray *tempMeals = [[NSMutableArray alloc] init];

                Meal *breakfast = [[Meal alloc] init];
                breakfast.name = @"Breakfast";
                NSMutableArray *tempBreakfastFoods = [[NSMutableArray alloc] init];
                for(NSString *aKey in [day[@"breakfast"] allKeys]){
                    NSArray *subMeal = day[@"breakfast"][aKey];
                    //move through subMeal
                    for(NSDictionary *aFood in subMeal){
                        FoodItem *food = [[FoodItem alloc] init];
                        food.name = aFood[@"name"];
                        [tempBreakfastFoods addObject:food];
                    }
                }
                breakfast.foodItems = [[NSArray alloc] initWithArray:tempBreakfastFoods];
                [tempMeals addObject:breakfast];
                
                Meal *lunch = [[Meal alloc] init];
                lunch.name = @"Lunch";
                NSMutableArray *tempLunchFoods = [[NSMutableArray alloc] init];
                for(NSString *aKey in [day[@"lunch"] allKeys]){
                    NSArray *subMeal = day[@"lunch"][aKey];
                    //move through subMeal
                    for(NSDictionary *aFood in subMeal){
                        FoodItem *food = [[FoodItem alloc] init];
                        food.name = aFood[@"name"];
                        [tempBreakfastFoods addObject:food];
                    }
                }
                lunch.foodItems = [[NSArray alloc] initWithArray:tempLunchFoods];
                [tempMeals addObject:lunch];
                
                Meal *dinner = [[Meal alloc] init];
                dinner.name = @"Dinner";
                NSMutableArray *tempDinnerFoods = [[NSMutableArray alloc] init];
                for(NSString *aKey in [day[@"dinner"] allKeys]){
                    NSArray *subMeal = day[@"dinner"][aKey];
                    //move through subMeal
                    for(NSDictionary *aFood in subMeal){
                        FoodItem *food = [[FoodItem alloc] init];
                        food.name = aFood[@"name"];
                        [tempBreakfastFoods addObject:food];
                    }
                }
                dinner.foodItems = [[NSArray alloc] initWithArray:tempDinnerFoods];
                [tempMeals addObject:dinner];
                
                aDay.meals = [[NSArray alloc] initWithArray:tempMeals];
                [tempDays addObject:aDay];
            }
            self.days = [[NSArray alloc] initWithArray:tempDays];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"initWithJsonWeekFinished" object:nil];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"NSError: %@",[error localizedDescription]);
        }];
        [operation start];
    }
    return self;
}

@end