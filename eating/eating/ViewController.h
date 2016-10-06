//
//  ViewController.h
//  eating
//
//  Created by Yencheng on 2016/10/5.
//  Copyright © 2016年 joiiup. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    segmentView1 = 0,
    segmentView2 = 1,
    segmentView3 = 2
} segmentViewID;

@interface ViewController : UIViewController

@property (nonatomic) segmentViewID viewIdSelect;
@property (nonatomic) segmentViewID viewIdCurrent;

@end

