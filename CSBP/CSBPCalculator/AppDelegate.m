//
//  AppDelegate.m
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuViewController.h"

#import "NewsService.h"
#import "NutrientService.h"
#import "ShireWebService.h"
#import "DataManager.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"

/******* Setting tracking ID  *******/
static NSString *const kTrackingId = @"UA-31346950-2";
static NSString *const kAllowTracking = @"allowTracking";

@implementation AppDelegate

@synthesize window = _window;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

#pragma mark - initial database
-(void)insertInitialData{
    NSString *nutrientCalculatorFilePath = [[NSBundle mainBundle] pathForResource:@"NutrientCalculator" ofType:@"json"];  
    NSArray *nutrientProduct = [[NSData dataWithContentsOfFile:nutrientCalculatorFilePath] objectFromJSONData];
    
    for (NSDictionary *nutrientDetail in nutrientProduct) {
        NutrientCalculatorProduct *nutrientProduct = [Application.dataManager insertNewObject:@"NutrientCalculatorProduct"];
        nutrientProduct.id = [NSNumber numberWithInt:[[nutrientDetail objectForKey:@"ID"]intValue]];
        nutrientProduct.product = [nutrientDetail objectForKey:@"Product"];
        nutrientProduct.rate = [NSNumber numberWithInt:[[nutrientDetail objectForKey:@"Rate"]intValue]];
        nutrientProduct.compositionB = [NSNumber numberWithFloat:[[nutrientDetail objectForKey:@"B"]floatValue]];
        nutrientProduct.compositionCa = [NSNumber numberWithFloat:[[nutrientDetail objectForKey:@"Ca"]floatValue]];
        nutrientProduct.compositionCo = [NSNumber numberWithFloat:[[nutrientDetail objectForKey:@"Co"]floatValue]];
        nutrientProduct.compositionCu = [NSNumber numberWithFloat:[[nutrientDetail objectForKey:@"Cu"]floatValue]];
        nutrientProduct.compositionK = [NSNumber numberWithFloat:[[nutrientDetail objectForKey:@"K"]floatValue]];
        nutrientProduct.compositionMg = [NSNumber numberWithFloat:[[nutrientDetail objectForKey:@"Mg"]floatValue]];
        nutrientProduct.compositionMn = [NSNumber numberWithFloat:[[nutrientDetail objectForKey:@"Mn"]floatValue]];
        nutrientProduct.compositionMo = [NSNumber numberWithFloat:[[nutrientDetail objectForKey:@"Mo"]floatValue]];
        nutrientProduct.compositionN = [NSNumber numberWithFloat:[[nutrientDetail objectForKey:@"N"]floatValue]];
        nutrientProduct.compositionP = [NSNumber numberWithFloat:[[nutrientDetail objectForKey:@"P"]floatValue]];
        nutrientProduct.compositionS = [NSNumber numberWithFloat:[[nutrientDetail objectForKey:@"S"]floatValue]];
        nutrientProduct.compositionZn = [NSNumber numberWithFloat:[[nutrientDetail objectForKey:@"Zn"]floatValue]];
        nutrientProduct.isBandingN = [NSNumber numberWithInt:[[nutrientDetail objectForKey:@"isBandingN"]intValue]];
        nutrientProduct.isKProduct = [NSNumber numberWithInt:[[nutrientDetail objectForKey:@"isKProduct"]intValue]];
        nutrientProduct.isNutrientCalculator = [NSNumber numberWithInt:[[nutrientDetail objectForKey:@"isNutrientCalculator"]intValue]];
        nutrientProduct.isTargetNP = [NSNumber numberWithInt:[[nutrientDetail objectForKey:@"isTargetNP"]intValue]];
        nutrientProduct.isNKCompound = [NSNumber numberWithInt:[[nutrientDetail objectForKey:@"isNKCompound"]intValue]];
        
        
        [Application.dataManager save];
    }
    if ([Application.dataManager getDbVersion]==nil) {
        DbVersion *firstDB = [Application.dataManager insertNewObject:@"DbVersion"];
        firstDB.dbVersion = [NSNumber numberWithInt:1];
        [Application.dataManager save];
    }
    else if([Application.dataManager getDbVersion].dbVersion.intValue != CurrentDBVersion){
        DbVersion *updatedDB = [Application.dataManager getDbVersion];
        updatedDB.dbVersion = [NSNumber numberWithInt:CurrentDBVersion];
        [Application.dataManager save];
    }
        
}
#pragma mark - generated classes

- (void)dealloc
{
    [_window release];
    [__managedObjectContext release];
    [__managedObjectModel release];
    [__persistentStoreCoordinator release];
    [super dealloc];
}
- (void)cleanNutrientCalculatorProduct{
//    NSArray *allNutrientProduct = [Application.dataManager getAllNutrientProduct];
//    for (NutrientCalculatorProduct *nutrientProduct in allNutrientProduct) {
    [Application.dataManager removeAllObject:@"NutrientCalculatorProduct"];
//    }
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"Launching Options Changes %@",launchOptions);
    NSString* flurry_ID = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Flurry API KEY"];
    [Flurry startSession:flurry_ID];
	[Flurry setUserID:[[UIDevice currentDevice] name]];
    [Flurry logPageView];
    [Flurry logEvent:@"CSBP In Field Running" timed:YES];

    //import initial data
    if (![[Application.dataManager getAllNutrientProduct] hasObject]) {
        [Flurry endTimedEvent:@"CSBP In Field First Install" withParameters:nil];
          [self insertInitialData];
    }
    else if([Application.dataManager getDbVersion].dbVersion.intValue != CurrentDBVersion){
        [Flurry endTimedEvent:@"CSBP In Field Update Database" withParameters:nil];
        [self cleanNutrientCalculatorProduct];
        [self insertInitialData];

    }
    self.tracker = [[GAI sharedInstance] trackerWithTrackingId:kTrackingId];
    [self.tracker set:@"tracking" value:kTrackingId];
    NSDictionary *appDefaults = @{kAllowTracking: @(YES)};
    [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
    // User must be able to opt out of tracking
    [GAI sharedInstance].optOut =
    ![[NSUserDefaults standardUserDefaults] boolForKey:kAllowTracking];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"App Launch", kGAIHitType, @"Launch Screen", kGAIScreenName, nil];
    [self.tracker send:params];
    // Initialize Google Analytics with a 120-second dispatch interval. There is a
    // tradeoff between battery usage and timely dispatch.
    [GAI sharedInstance].dispatchInterval = 20;
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [[GAI sharedInstance] dispatch];
    [self.tracker set:kGAIUseSecure value:[@NO stringValue]];
    
    //end of import
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // saving an NSString
    [prefs setObject:nil forKey:@"shireID"];
    
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    MenuViewController *menuViewController = [[MenuViewController alloc]initWithNibName:@"Menu" bundle:nil];
    
    [self.window setRootViewController:menuViewController];
    //temp
  
    NutrientService *testNutrient = [[NutrientService alloc] init];
    [testNutrient getAllNutrientInfomation];
    ShireWebService *shireWS = [[ShireWebService alloc] init];
    [shireWS getAllShireInfomation];
    
    
    
    //end of temp
    [menuViewController release];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [Flurry endTimedEvent:@"CSBP In Field Running" withParameters:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [Flurry endTimedEvent:@"CSBP In Field Running" withParameters:nil];
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CSBPCalculator" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CSBPCalculator.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
#pragma mark -
#pragma mark HKApplication
- (DataManager *)dataManager {
	if (dataManager == nil) {
        dataManager = [[DataManager alloc] initWithManagedObjectContext:self.managedObjectContext];
	}
	return dataManager;
}
#pragma mark -
#pragma mark BusyIndicatorView 
#pragma mark Busy Indicator

-(void) showBusy { 
	[self showBusyWithMessage:@"Downloading Data..."]; 
}

-(void) showBusyWithMessage:(NSString*)message {
	[self showBusyWithMessage:message disableUserInteraction:YES];
}

- (void)showBusyWithMessage:(NSString *)message disableUserInteraction:(BOOL)disableUserInteraction {
	if (busyIndicatorView == nil)
	{
		busyIndicatorView = [[HKBusyIndicatorView alloc] initWithApplicationFrame];
		[self.window addSubview:busyIndicatorView];
		[busyIndicatorView release];
	}
	busyIndicatorView.userInteractionEnabled = disableUserInteraction;
    [busyIndicatorView showWithMessage:message];	
}

-(void) hideBusy {
    [busyIndicatorView hide];
}
@end
