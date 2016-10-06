//
//  ListAllVC.m
//  eating
//
//  Created by Yencheng on 2016/10/6.
//  Copyright © 2016年 joiiup. All rights reserved.
//

#import "ListAllRestaurantVC.h"
#import "RestaurantVO.h"
#import "Restaurant+CoreDataClass.h"
#import "RestaurantTableViewCell.h"

@interface ListAllRestaurantVC () <RestaurantButtonCellDelegate>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *array;

@end

@implementation ListAllRestaurantVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self tableViewSetting];
 
    [self getDataFromDB];
}

- (void)viewWillAppear:(BOOL)animated {
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(addRestaurant)];
    
    UIBarButtonItem *setRangeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                               target:self
                                                                               action:@selector(priceRange)];
    
    
    self.parentViewController.navigationItem.rightBarButtonItems = @[addButton, setRangeButton];
    
    self.parentViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                                               target:self
                                                                                                               action:@selector(dice)];
    
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50);
}

- (void)viewWillDisappear:(BOOL)animated {
    self.parentViewController.navigationItem.rightBarButtonItem = nil;
    self.parentViewController.navigationItem.leftBarButtonItem = nil;
}

#pragma mark - UI Setting

- (void)tableViewSetting {
    NSLog(@"tableViewSetting");
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = YES;
    self.tableView.scrollEnabled= YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:self.tableView];
}

#pragma mark - action

- (void)addRestaurant {
    UIAlertController * alertC=   [UIAlertController
                                   alertControllerWithTitle:@"新增餐廳"
                                   message:@"請輸入資料"
                                   preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                                   //Do Some action here
                                                   UITextField *name = alertC.textFields.firstObject;
                                                   UITextField *price = alertC.textFields.lastObject;
                                                   
                                                   [self saveRestaurantName:name.text price:price.text];
                                               }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [alertC dismissViewControllerAnimated:YES completion:nil];
                                                   }];
    
    [alertC addAction:ok];
    [alertC addAction:cancel];
    
    [alertC addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"餐廳名稱";
    }];
    [alertC addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"價格";
    }];
    
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void)priceRange {
    
    UIAlertController * alertC=   [UIAlertController
                                   alertControllerWithTitle:@"價格限制"
                                   message:@"請輸入資料"
                                   preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                                   //Do Some action here
                                                   UITextField *price = alertC.textFields.firstObject;
                                                   [self priceRange:price.text.integerValue];
                                               }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [self getDataFromDB];
                                                       [alertC dismissViewControllerAnimated:YES completion:nil];
                                                   }];
    
    [alertC addAction:ok];
    [alertC addAction:cancel];

    [alertC addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"價格";
    }];
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void)priceRange:(NSInteger)priceRange {
    self.array = [[NSMutableArray alloc] init];
    NSArray *tArray = [Restaurant getPriceRangeData:priceRange];
    
    for (int i =0 ; i < [tArray count]; i++) {
        Restaurant *saved_restaurant =  [tArray objectAtIndex:i];
        RestaurantVO *restaurant = [[RestaurantVO alloc] init];
        restaurant.name = saved_restaurant.name;
        restaurant.price = [NSNumber numberWithInteger:saved_restaurant.price];
        restaurant.isFavorite = [NSNumber numberWithBool:saved_restaurant.isFavorite];
        restaurant.category = saved_restaurant.category;
        [self.array insertObject:restaurant atIndex:i];
    }
    
    //reload data
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
}

- (void)dice {
    RestaurantVO *restaurant = [[RestaurantVO alloc] init];
    
    //NSArray *tempArray = [Restaurant getIsFavoriteData];
    //NSUInteger count = [tempArray count];
    //if(count>0) {
    //    int r = arc4random_uniform((int)count);
    //    restaurant = [tempArray objectAtIndex:r];
    //} else {
        int r = arc4random_uniform((int)[self.array count]);
        restaurant = [self.array objectAtIndex:r];
    //}
    
    
    UIAlertController * alertC=   [UIAlertController
                                   alertControllerWithTitle:restaurant.name
                                   message:@""
                                   preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                                   //Do Some action here
                                               }];
    
    
    [alertC addAction:ok];
    [self presentViewController:alertC animated:YES completion:nil];
}

#pragma mark - data saving and loading

- (void)saveRestaurantName:(NSString *)name price:(NSString *)price{
    
    RestaurantVO *restaurant = [[RestaurantVO alloc] init];
    restaurant.name = name;
    restaurant.price = [NSNumber numberWithInteger:[price integerValue]];
    restaurant.isFavorite = @NO;
    restaurant.category = nil;
    [Restaurant addRestaurantObject:restaurant];
    
    [self.array insertObject:restaurant atIndex:[self.array count]];
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    
    //[self getDataFromDB];
}

- (void)getDataFromDB {
    
    self.array = [[NSMutableArray alloc] init];
    NSArray *tArray = [Restaurant readRestaurantsObject];
    
    for (int i =0 ; i < [tArray count]; i++) {
        Restaurant *saved_restaurant =  [tArray objectAtIndex:i];
        RestaurantVO *restaurant = [[RestaurantVO alloc] init];
        restaurant.name = saved_restaurant.name;
        restaurant.price = [NSNumber numberWithInteger:saved_restaurant.price];
        restaurant.isFavorite = [NSNumber numberWithBool:saved_restaurant.isFavorite];
        restaurant.category = saved_restaurant.category;
        [self.array insertObject:restaurant atIndex:i];
    }

    //reload data
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
}

#pragma mark - UITableViewDataSource methods

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.array count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RestaurantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[RestaurantTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.delegate = self;
    }
    
    RestaurantVO *restaurant = [self.array objectAtIndex:indexPath.row];
    cell.name = restaurant.name;
    cell.price = restaurant.price;
    cell.category = restaurant.category;
    cell.cellIndex = indexPath.row;
    cell.isFavorite = restaurant.isFavorite.boolValue;
    cell.accessoryType=UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

#pragma mark - UITableViewDelegate methods;

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    //cell.backgroundColor = [UIColor whiteColor];
    //self.tableView.separatorColor = [UIColor lightGrayColor];
    
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    view.backgroundColor = [UIColor redColor];
    return view;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //選擇時，進入下一頁
    //[self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        RestaurantVO *restaurant = [self.array objectAtIndex:indexPath.row];
        BOOL delete = [Restaurant removeRestaurantObject:restaurant.name];
        
        if(delete==true) {
            //reload data
            [self.array removeObjectAtIndex:indexPath.row];
            [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
        } else {
            //show error message
        }
    }
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = [indexPath row];
    NSUInteger count = [self.array count];
    
    if (row < count) {
        return UITableViewCellEditingStyleDelete;
    } else {
        return UITableViewCellEditingStyleNone;
    }
}

#pragma mark - delegate

- (void)didClickFavoriteOnCellAtIndex:(NSInteger)cellIndex withResponse:(BOOL)response {
    RestaurantVO *restaurant = [self.array objectAtIndex:cellIndex];
    restaurant.isFavorite = [NSNumber numberWithBool:response];
    [self.array replaceObjectAtIndex:cellIndex withObject:restaurant];
}

- (void)didClickFavoriteOnCellAtIndex:(NSInteger)cellIndex {
    
    RestaurantVO *restaurant = [self.array objectAtIndex:cellIndex];
    bool inverse = !(restaurant.isFavorite.boolValue);
    if([Restaurant restaurantsObjectIsFavorite:restaurant.name isFavorite:[NSNumber numberWithBool:inverse]]) {
        restaurant.isFavorite = [NSNumber numberWithBool:inverse];
        [self.array replaceObjectAtIndex:cellIndex withObject:restaurant];
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    } else {
        //show something error
    }
}

#pragma mark - memory

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
