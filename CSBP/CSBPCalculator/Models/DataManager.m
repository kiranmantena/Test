//
//  DataManager.m
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 25/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager
@synthesize managedObjectContext;

#pragma mark -
#pragma mark Init / Dealloc
- (id)initWithManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext {
	if (self == [super init]) {
		self.managedObjectContext = aManagedObjectContext;
	}
	return self;
}

- (void)dealloc {
	self.managedObjectContext = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark Notification
- (void)postNotification:(NSNotification *)notification {
	[[NSNotificationCenter defaultCenter] postNotification:notification];
}

#pragma mark -
#pragma mark Generic Save
- (BOOL)save {
	NSError *error = nil;
	[self.managedObjectContext save:&error];
	if (error == nil) {
		return YES;
	} else {
		[self postNotification:[NSNotification notificationWithName:DMNotificationError object:error]];
		return NO;
	}
}

#pragma mark -
#pragma mark Generic Insert 
- (id)insertNewObject:(NSString *)entity {
	return [NSEntityDescription insertNewObjectForEntityForName:entity inManagedObjectContext:self.managedObjectContext];
}
#pragma mark-
#pragma mark Generic Delete
-(void)removeAllObject:(NSString *)entity{
    NSArray *deletedEntity  = [self fetchObjects:entity]; 
    
    if ([deletedEntity hasObject]) {
        for (NSManagedObject *toBeDeleted in deletedEntity) {
            [self.managedObjectContext deleteObject:toBeDeleted];
            [self save];
        }
    }
    
}
#pragma mark -
#pragma mark Generic Fetch
- (void)revertChanges:(NSManagedObject *)managedObject {
	[self.managedObjectContext refreshObject:managedObject mergeChanges:NO];
}

- (NSArray *)fetchObjects:(NSString *)entity {
	return [self fetchObjects:entity predicate:nil sortDescriptors:nil];
}

- (NSArray *)fetchObjects:(NSString *)entity predicate:(NSPredicate *)predicate {
	return [self fetchObjects:entity predicate:predicate sortDescriptors:nil];
}


- (NSArray *)fetchObjects:(NSString *)entity predicate:(NSPredicate *)predicate sortDescriptor:(NSSortDescriptor *)sortDescriptor {
	return [self fetchObjects:entity predicate:predicate sortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
}

- (NSArray *)fetchObjects:(NSString *)entity sortDescriptor:(NSSortDescriptor *)sortDescriptor {
	return [self fetchObjects:entity sortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
}

- (NSArray *)fetchObjects:(NSString *)entity sortDescriptors:(NSArray *)sortDescriptors {
	return [self fetchObjects:entity predicate:nil sortDescriptors:sortDescriptors];
}

- (NSArray *)fetchObjects:(NSString *)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors {
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[NSEntityDescription entityForName:entity inManagedObjectContext:self.managedObjectContext]];
	
	if (predicate != nil) {
		[fetchRequest setPredicate:predicate];
	}
	
	if (sortDescriptors != nil) {
		[fetchRequest setSortDescriptors:sortDescriptors];
	}
	
	NSError *error = nil;
	NSArray *objects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
	[fetchRequest release];
	
	if (error != nil) {
		[self postNotification:[NSNotification notificationWithName:DMNotificationError object:error]];
		return [NSArray array];
	} else {
        NSLog(@"Objects %@",objects);
		return objects;
	}
}

- (id)fetchObject:(NSString *)entity predicate:(NSPredicate *)predicate {
	return [self fetchObject:entity predicate:predicate sortDescriptors:nil];
}

- (id)fetchObject:(NSString *)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors {
	NSArray *records = [self fetchObjects:entity predicate:predicate sortDescriptors:sortDescriptors];
	
	if ([records hasObject]) {
		return [records firstObject];
	} else {
		return nil;
	}
}
#pragma mark -
#pragma News
-(NSArray *)getAllNews{
    return [self fetchObjects:@"News"];
}
#pragma mark -
#pragma mark Crop & Nutrient
-(NSArray *)getAllNutrient{
    return [self fetchObjects:@"Nutrient"];
}
-(NSArray *)getAllCrops{
    return [self fetchObjects:@"Crop"];
}
-(Crop *)getCropByName:(NSString *)cropType{
    return [self fetchObject:@"Crop" predicate:[NSPredicate predicateWithFormat:@"cropType==[c] %@", cropType]];
}
#pragma mark -
#pragma mark NutrientCalculator
-(NSArray *)getAllNutrientProduct{
    return [self fetchObjects:@"NutrientCalculatorProduct"];
}
-(NSArray *)getAllBandingNProduct{
    return [self fetchObjects:@"NutrientCalculatorProduct" predicate:[NSPredicate predicateWithFormat:@"isBandingN == 1"]];
}
-(NSArray *)getAllKProduct{
    return [self fetchObjects:@"NutrientCalculatorProduct" predicate:[NSPredicate predicateWithFormat:@"isKProduct == 1"]];
}
-(NSArray *)getAllNutrientCalculator{
     return [self fetchObjects:@"NutrientCalculatorProduct" predicate:[NSPredicate predicateWithFormat:@"isNutrientCalculator == 1"]];
}
-(NSArray *)getAllTargetNP{
    return [self fetchObjects:@"NutrientCalculatorProduct" predicate:[NSPredicate predicateWithFormat:@"isTargetNP == 1"]];
}
-(NSArray *)getAllNKCompound{
    return [self fetchObjects:@"NutrientCalculatorProduct" predicate:[NSPredicate predicateWithFormat:@"isNKCompound == 1"]];
}
#pragma mark -
#pragma mark Shire
-(NSArray *)getAllShire{
    return [self fetchObjects:@"Shire"];
}
-(Shire *)getShireByID:(NSString *)shireID{
    return [self fetchObject:@"Shire" predicate:[NSPredicate predicateWithFormat:@"shireID==[c] %@",shireID]];
}
#pragma mark -
#pragma mark dbVersion
-(DbVersion *)getDbVersion{
    return [[self fetchObjects:@"DbVersion"] lastObject];
}
@end
