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
#import "HMSegmentedControl.h"
#import "ListAllRestaurantVC.h"
#import "ListAllCategoryVC.h"

@interface ViewController ()

@property (nonatomic, strong) UIViewController *currentViewController;
@property (nonatomic, strong) UIView *subPageView;

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;

@property (nonatomic, strong) ListAllRestaurantVC *vc1;
@property (nonatomic, strong) ListAllCategoryVC *vc2;
@property (nonatomic, strong) UIViewController *vc3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"所有列表";
    self.viewIdCurrent = -1;
    self.viewIdSelect = segmentView1;
    [self functionTabSetting];
    /*
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
    */
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)functionTabSetting {
    
    self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"所有列表", @"分類列表"]];
    [self.segmentedControl setFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        NSLog(@"Selected index %ld (via block)", (long)index);
        [weakSelf changeChildVC:(segmentViewID)index];
    }];
    self.segmentedControl.selectionIndicatorHeight = 5.0f;
    self.segmentedControl.backgroundColor = [UIColor lightGrayColor];
    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.segmentedControl.selectionIndicatorColor = [UIColor whiteColor];//[UIColor colorWithRed:0.5 green:0.8 blue:1 alpha:1];
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleArrow;
    self.segmentedControl.selectedSegmentIndex = HMSegmentedControlNoSegment;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.shouldAnimateUserSelection = NO;
    self.segmentedControl.tag = 2;
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.view addSubview:self.segmentedControl];
    
    self.subPageView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 64)];
    self.subPageView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.subPageView];
    
    [self changeChildVC:self.viewIdSelect];
}

- (void)changeChildVC:(segmentViewID)index {
    
    if (self.viewIdCurrent == index) {
        return;
    }
    self.viewIdCurrent = index;
    self.viewIdSelect = index;
    
    if (self.currentViewController != nil) {
        [self.currentViewController.view removeFromSuperview];
        [self.currentViewController removeFromParentViewController];
    }
    
    UIViewController *vc = [self viewControllerForSegmentIndex:index];
    [self addChildViewController:vc];
    [self.subPageView addSubview:vc.view];
    self.currentViewController = vc;
    [vc didMoveToParentViewController:self];
}

- (UIViewController *)viewControllerForSegmentIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
            if (self.vc1 == nil) {
                self.vc1 = [[ListAllRestaurantVC alloc] init];
                self.vc1.view.frame = self.subPageView.bounds;
            }
            return self.vc1;
        }
        case 1:
        {
            if (self.vc2 == nil) {
                self.vc2 = [[ListAllCategoryVC alloc] init];
                self.vc2.view.frame = self.subPageView.bounds;
                self.vc2.view.backgroundColor = [UIColor redColor];
            }
            return self.vc2;
        }
    }
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
