//
//  Restaurant+CoreDataProperties.m
//  eating
//
//  Created by Yencheng on 2016/10/5.
//  Copyright © 2016年 joiiup. All rights reserved.
//

#import "Restaurant+CoreDataProperties.h"

@implementation Restaurant (CoreDataProperties)

+ (NSFetchRequest<Restaurant *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Restaurant"];
}

@dynamic name;
@dynamic price;
@dynamic category;
@dynamic isFavorite;

@end
