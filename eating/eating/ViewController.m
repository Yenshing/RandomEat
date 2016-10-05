//
//  ViewController.m
//  eating
//
//  Created by Yencheng on 2016/10/5.
//  Copyright © 2016年 joiiup. All rights reserved.
//

#import "ViewController.h"
#import "Restaurant+CoreDataClass.h"
#import "RestaurantVO.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RestaurantVO *temp = [[RestaurantVO alloc] init];
    temp.name = @"有飯開";
    temp.category = @"飯類";
    temp.price = [NSNumber numberWithInteger:100];
    temp.isFavorite = @NO;
    
    [Restaurant addRestaurantObject:temp];
    
    
    NSArray *array = [Restaurant readRestaurantsObject];
    temp = [array objectAtIndex:0];
    NSLog(@"%@", temp.name);
    
    [Restaurant restaurantsObjectIsFavorite:temp.name isFavorite:@YES];
    NSArray *array2 = [Restaurant getIsFavoriteData];
    temp = [array2 objectAtIndex:0];
    NSLog(@"%@", temp.name);
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
