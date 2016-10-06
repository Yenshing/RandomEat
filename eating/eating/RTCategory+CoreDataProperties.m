//
//  RTCategory+CoreDataProperties.m
//  eating
//
//  Created by Yencheng on 2016/10/6.
//  Copyright © 2016年 joiiup. All rights reserved.
//

#import "RTCategory+CoreDataProperties.h"

@implementation RTCategory (CoreDataProperties)

+ (NSFetchRequest<RTCategory *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"RTCategory"];
}

@dynamic name;
@dynamic descriptions;
@dynamic restaurants;

@end
