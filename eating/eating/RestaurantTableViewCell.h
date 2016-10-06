//
//  RestaurantTableViewCell.h
//  eating
//
//  Created by Yencheng on 2016/10/6.
//  Copyright © 2016年 joiiup. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RestaurantButtonCellDelegate <NSObject>
- (void)didClickFavoriteOnCellAtIndex:(NSInteger)cellIndex withResponse:(BOOL)response;
- (void)didClickFavoriteOnCellAtIndex:(NSInteger)cellIndex;
@end

@interface RestaurantTableViewCell : UITableViewCell

@property (weak, nonatomic) id<RestaurantButtonCellDelegate> delegate;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic) BOOL isFavorite;
@property (assign, nonatomic) NSInteger cellIndex;

@end
