//
//  RTCategory+CoreDataClass.m
//  eating
//
//  Created by Yencheng on 2016/10/6.
//  Copyright © 2016年 joiiup. All rights reserved.
//

#import "RTCategory+CoreDataClass.h"
#import "Restaurant+CoreDataClass.h"
#import "AppDelegate.h"

@implementation RTCategory
/*
+ (NSManagedObjectContext *)getNSManagedObjectContext {
    id delegate = [[UIApplication sharedApplication] delegate];
    //NSManagedObjectContext *context = [delegate managedObjectContext];
    return [delegate persistentContainer].viewContext;
}*/

+ (NSManagedObjectContext *)getNSManagedObjectContext {
    id delegate = [[UIApplication sharedApplication] delegate];
    return [delegate managedObjectContext];;
}

+ (BOOL)addRTCategoryObject:(RTCategoryVO *)new_category {
    NSManagedObjectContext *context = [self getNSManagedObjectContext];
    
    RTCategory *category = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"RTCategory"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", new_category.name];
    
    NSError *error, *err;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if(!matches || error || ([matches count] > 1)){
        //handle error
        return false;
    } else if ([matches count]) {
        //        update
        //        save
        //        if(![context save:&err]) {
        //            NSLog(@"user update error = %@", err);
        //        } else {
        //            NSLog(@"user update success");
        //        }
        NSLog(@"restaurant exist");
        return false;
    } else {
        category = [NSEntityDescription insertNewObjectForEntityForName:@"RTCategory"
                                                   inManagedObjectContext:context];
        
        //insert
        category.name= new_category.name;
        category.descriptions = new_category.descriptions;
        
        //save
        if(![context save:&err]) {
            NSLog(@"category create error = %@", err);
        } else {
            NSLog(@"category create success");
        }
        return true;
    }
}

+ (RTCategory *)categoryWithName:(NSString *)categoryName inManagedObjectContext:(NSManagedObjectContext *)context {
    
    RTCategory *category;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"RTCategory"];
    if(categoryName.length==0 || categoryName==nil) {
        categoryName = @"無分類";
    }
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", categoryName];
    
    NSError *error, *err;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if(!matches || error || ([matches count] > 1)){
        //handle error
    } else if ([matches count]) {
        category = [matches firstObject];
    } else {
        NSLog(@"need create category first");

        category = [NSEntityDescription insertNewObjectForEntityForName:@"RTCategory"
                                                 inManagedObjectContext:context];
        
        //insert
        category.name = categoryName;
        category.descriptions = @"待填";
        //save
        if(![context save:&err]) {
            NSLog(@"category create error = %@", err);
        } else {
            NSLog(@"category create success");
        }
    }
    return category;
}

+ (NSArray *)listAllCategory {
    
    NSArray *allCategory;
    
    NSManagedObjectContext *context = [self getNSManagedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"RTCategory"];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if(!matches || error) {
        //handle error
    } else if ([matches count]) {
        allCategory = matches;
        return allCategory;
    }
    return nil;
}

@end
