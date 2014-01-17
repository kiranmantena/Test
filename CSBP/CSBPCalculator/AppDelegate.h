//
//  AppDelegate.h
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKBusyIndicatorView.h"
#import "HKApplication.h"
#import "GAI.h"
#import "GAITracker.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,HKApplication>{
    @private
    HKBusyIndicatorView *busyIndicatorView;
    DataManager *dataManager;
    
}

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic, strong) id<GAITracker> tracker;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


// Application busy indicator
- (void)showBusy;
- (void)showBusyWithMessage:(NSString*)message;
- (void)showBusyWithMessage:(NSString *)message disableUserInteraction:(BOOL)disableUserInteraction;
- (void)hideBusy;
@end
