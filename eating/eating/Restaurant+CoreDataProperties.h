//
//  Restaurant+CoreDataProperties.h
//  eating
//
//  Created by Yencheng on 2016/10/6.
//  Copyright © 2016年 joiiup. All rights reserved.
//

#import "Restaurant+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Restaurant (CoreDataProperties)

+ (NSFetchRequest<Restaurant *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *category;
@property (nonatomic) BOOL isFavorite;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int64_t price;
@property (nullable, nonatomic, retain) RTCategory *whichCategory;

@end

NS_ASSUME_NONNULL_END
