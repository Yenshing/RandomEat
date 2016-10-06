//
//  Restaurant+CoreDataClass.m
//  eating
//
//  Created by Yencheng on 2016/10/5.
//  Copyright © 2016年 joiiup. All rights reserved.
//

#import "Restaurant+CoreDataClass.h"
#import "AppDelegate.h"

@implementation Restaurant

/*
+ (NSPersistentContainer *)getNSPersistentContainer {
    id delegate = [[UIApplication sharedApplication] delegate];
    //NSManagedObjectContext *context = [delegate managedObjectContext];
    return [delegate persistentContainer];
}

+ (NSManagedObjectContext *)getNSManagedObjectContext {
    id delegate = [[UIApplication sharedApplication] delegate];
    //NSManagedObjectContext *context = [delegate managedObjectContext];
    return [delegate persistentContainer].viewContext;
}*/

+ (NSManagedObjectContext *)getNSManagedObjectContext {
    id delegate = [[UIApplication sharedApplication] delegate];
    return [delegate managedObjectContext];;
}

+ (void)addRestaurantObject:(RestaurantVO *)new_restaurant {
    NSManagedObjectContext *context = [self getNSManagedObjectContext];
    
    Restaurant *restaurant = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Restaurant"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", new_restaurant.name];
    
    NSError *error, *err;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if(!matches || error || ([matches count] > 1)){
        //handle error
    } else if ([matches count]) {
        //        update
        //        save
        //        if(![context save:&err]) {
        //            NSLog(@"user update error = %@", err);
        //        } else {
        //            NSLog(@"user update success");
        //        }
        NSLog(@"restaurant exist");
    } else {
        restaurant = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant"
                                                inManagedObjectContext:context];
        
        //insert
        restaurant.name= new_restaurant.name;
        restaurant.price = new_restaurant.price.integerValue;
        restaurant.category = new_restaurant.category;
        restaurant.isFavorite = new_restaurant.isFavorite.boolValue;
        restaurant.whichCategory = [RTCategory categoryWithName:new_restaurant.category inManagedObjectContext:context];
        
        //save
        if(![context save:&err]) {
            NSLog(@"restaurant create error = %@", err);
        } else {
            NSLog(@"restaurant create success");
        }
    }
}

+ (BOOL)removeRestaurantObject:(NSString *)restaurant_name {
    NSManagedObjectContext *context = [self getNSManagedObjectContext];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Restaurant"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", restaurant_name];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if(!matches || error || ([matches count] > 1)){
        //handle error
        NSLog(@"match error = %@", error);
        return false;
    } else if ([matches count]) {
        [context deleteObject:[matches firstObject]];
    } else {
        NSLog(@"match error = empty");
        return false;
    }
    
    if(![context save:&error]) {
        NSLog(@"delete error = %@", error);
    } else {
        NSLog(@"delete success");
        return true;
    }
    return false;
}

+ (NSArray *)readRestaurantsObject {
    NSManagedObjectContext *context = [self getNSManagedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Restaurant"];
    
    NSSortDescriptor *numberSort = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:numberSort, nil];
    [request setSortDescriptors:sortDescriptors];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if(!matches || error ){
        //handle error
        NSLog(@"match error = %@", error);
    } else if ([matches count]) {
        NSLog(@"match count= %lu", (unsigned long)[matches count]);
        return matches;
    } else {
        NSLog(@"match error = empty");
    }
    return nil;
}

+ (BOOL)restaurantsObjectIsFavorite:(NSString *)restaurant_name isFavorite:(NSNumber *)isFavorite{
    NSManagedObjectContext *context = [self getNSManagedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Restaurant"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@",restaurant_name];
    
    Restaurant *restaurant = nil;
    NSError *error, *err;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if(!matches || error || ([matches count] > 1)){
        //handle error
        return false;
    } else if ([matches count]) {
        restaurant = [matches firstObject];
        //update
        restaurant.isFavorite = isFavorite.boolValue;
        
        //save
        if(![context save:&err]) {
            NSLog(@"isFavorite update error = %@", err);
            return false;
        } else {
            NSLog(@"isFavorite update success");
            return true;
        }
    } else {
        return false;
    }
    return false;
}

+ (NSArray *)getIsFavoriteData {
    NSManagedObjectContext *context = [self getNSManagedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Restaurant"];
    request.predicate = [NSPredicate predicateWithFormat:@"isFavorite = %@",[NSNumber numberWithBool:YES]];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if(!matches || error ){
        //handle error
        NSLog(@"match error = %@", error);
    } else if ([matches count]) {
        NSLog(@"match count= %lu", (unsigned long)[matches count]);
        return matches;
    } else {
        NSLog(@"match error = empty");
    }
    return nil;

}

+ (NSArray *)getPriceRangeData:(NSInteger)priceRange {
    NSManagedObjectContext *context = [self getNSManagedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Restaurant"];
    request.predicate = [NSPredicate predicateWithFormat:@"price <= %@",[NSNumber numberWithInteger:priceRange]];

    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if(!matches || error ){
        //handle error
        NSLog(@"match error = %@", error);
    } else if ([matches count]) {
        NSLog(@"match count= %lu", (unsigned long)[matches count]);
        return matches;
    } else {
        NSLog(@"match error = empty");
    }
    return nil;
}

@end
