//
//  AppDelegate.h
//  eating
//
//  Created by Yencheng on 2016/10/5.
//  Copyright © 2016年 joiiup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//after iOS 10
@property (readonly, strong) NSPersistentContainer *persistentContainer;

//before iOS 10
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
- (NSURL *)applicationDocumentsDirectory;

//general
- (void)saveContext;
+ (AppDelegate*)appDelegate;

@end

