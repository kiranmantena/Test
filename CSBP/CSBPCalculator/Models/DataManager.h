//
//  DataManager.h
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 25/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "News.h"
#import "Crop.h"
#import "Nutrient.h"
#import "NutrientCalculatorProduct.h"
#import "Shire.h"
#import "CSBPContacts.h"
#import "DbVersion.h"

#define DMNotificationError						@"DMNotificationError"
#define DMNotificationCategoryChanged			@"DMNotificationCategoryChanged"
#define DMNotificationCategoryRemoved			@"DMNotificationCategoryRemoved"
#define DMNotificationFavouriteChanged			@"DMNotificationFavouriteChanged"
#define DMNotificationVoucherChanged			@"DMNotificationVoucherChanged"
#define DMNotificationLocationServiceChanged	@"DMNotificationLocationServiceChanged"

@interface DataManager : NSObject{
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext;

#pragma mark -
#pragma mark Generic Save
- (BOOL)save;

#pragma mark -
#pragma mark Generic Insert 
- (id)insertNewObject:(NSString *)entity;

#pragma mark-
#pragma mark Generic Delete
-(void)removeAllObject:(NSString *)entity;


#pragma mark -
#pragma mark Generic Fetch
- (void)revertChanges:(NSManagedObject *)managedObject;

- (NSArray *)fetchObjects:(NSString *)entity;
- (NSArray *)fetchObjects:(NSString *)entity predicate:(NSPredicate *)predicate;
- (NSArray *)fetchObjects:(NSString *)entity predicate:(NSPredicate *)predicate sortDescriptor:(NSSortDescriptor *)sortDescriptor;

- (NSArray *)fetchObjects:(NSString *)entity sortDescriptor:(NSSortDescriptor *)sortDescriptor;
- (NSArray *)fetchObjects:(NSString *)entity sortDescriptors:(NSArray *)sortDescriptors;

- (NSArray *)fetchObjects:(NSString *)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors;

- (id)fetchObject:(NSString *)entity predicate:(NSPredicate *)predicate;
- (id)fetchObject:(NSString *)entity predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors;
#pragma mark -
#pragma News
-(NSArray *)getAllNews;
#pragma mark -
#pragma mark Crop & Nutrient
-(NSArray *)getAllNutrient;
-(NSArray *)getAllCrops;
-(Crop *)getCropByName:(NSString *)cropType;
#pragma mark -
#pragma mark NutrientCalculator
-(NSArray *)getAllNutrientProduct;
-(NSArray *)getAllBandingNProduct;
-(NSArray *)getAllKProduct;
-(NSArray *)getAllNutrientCalculator;
-(NSArray *)getAllTargetNP;
-(NSArray *)getAllNKCompound;
#pragma mark -
#pragma mark Shire
-(NSArray *)getAllShire;
-(Shire *)getShireByID:(NSString *)shireID;
#pragma mark -
#pragma mark dbVersion
-(DbVersion *)getDbVersion;
@end
