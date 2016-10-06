//
//  RTCategory+CoreDataClass.h
//  eating
//
//  Created by Yencheng on 2016/10/6.
//  Copyright © 2016年 joiiup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RTCategoryVO.h"

@class Restaurant;

NS_ASSUME_NONNULL_BEGIN

@interface RTCategory : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+ (BOOL)addRTCategoryObject:(RTCategoryVO *)new_category;
+ (BOOL)removeRTCategoryObject:(NSString *)category_name;
+ (NSArray *)listAllCategory;
+ (RTCategory *)categoryWithName:(NSString *)categoryName inManagedObjectContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "RTCategory+CoreDataProperties.h"
