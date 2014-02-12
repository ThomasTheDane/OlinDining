//
//  Week.m
//  OlinDining
//
//  Created by Thomas Nattestad on 1/28/14.
//  Copyright (c) 2014 Thomas Nattestad. All rights reserved.
//

#import "Week.h"
#import "AFJSONRequestOperation.h"
#import "Day.h"

@implementation Week

-(id)init{
    self = [super init];
//    if(self){
//        self = [self initWithJSON];
//    }
    return self;
}

-(id)initWithJSON{
    self = [super init];
    if(self){
        NSURL *url = [[NSURL alloc] initWithString:@"http://operation-models.codeschool.com/feedImages.json"];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            NSLog(@"Loaded and shit");
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"initFoodItemFinishedLoading" object:nil];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            NSLog(@"NSError: %@",[error localizedDescription]);
        }];
        [operation start];
    }
    return self;
}

@end