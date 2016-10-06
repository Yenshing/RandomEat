//
//  RTCategory+CoreDataProperties.h
//  eating
//
//  Created by Yencheng on 2016/10/6.
//  Copyright © 2016年 joiiup. All rights reserved.
//

#import "RTCategory+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface RTCategory (CoreDataProperties)

+ (NSFetchRequest<RTCategory *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *descriptions;
@property (nullable, nonatomic, retain) NSSet<Restaurant *> *restaurants;

@end

@interface RTCategory (CoreDataGeneratedAccessors)

- (void)addRestaurantsObject:(Restaurant *)value;
- (void)removeRestaurantsObject:(Restaurant *)value;
- (void)addRestaurants:(NSSet<Restaurant *> *)values;
- (void)removeRestaurants:(NSSet<Restaurant *> *)values;

@end

NS_ASSUME_NONNULL_END
