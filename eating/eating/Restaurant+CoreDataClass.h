//
//  Restaurant+CoreDataClass.h
//  eating
//
//  Created by Yencheng on 2016/10/5.
//  Copyright © 2016年 joiiup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RestaurantVO.h"

NS_ASSUME_NONNULL_BEGIN

@interface Restaurant : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+ (void)addRestaurantObject:(RestaurantVO *)new_restaurant;
+ (void)removeRestaurantObject:(NSString *)restaurant_name;
+ (NSArray *)readRestaurantsObject;
+ (BOOL)restaurantsObjectIsFavorite:(NSString *)restaurant_name isFavorite:(NSNumber *)isFavorite;
+ (NSArray *)getIsFavoriteData;

@end

NS_ASSUME_NONNULL_END

#import "Restaurant+CoreDataProperties.h"
