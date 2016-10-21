//
//  AppDelegate.h
//  YuyuMall
//
//  Created by rock on 16/9/1.
//  Copyright © 2016年 YuyuMall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (UINavigationController *)rootNavigationController;

- (void)saveContext;

- (NSURL *)applicationDocumentsDirectory;

@end

