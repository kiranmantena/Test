//
//  Shire.h
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CSBPContacts, News;

@interface Shire : NSManagedObject

@property (nonatomic, retain) NSString * shireID;
@property (nonatomic, retain) NSString * shireName;
@property (nonatomic, retain) NSSet *csbpContacts;
@property (nonatomic, retain) NSSet *news;
@end

@interface Shire (CoreDataGeneratedAccessors)

- (void)addCsbpContactsObject:(CSBPContacts *)value;
- (void)removeCsbpContactsObject:(CSBPContacts *)value;
- (void)addCsbpContacts:(NSSet *)values;
- (void)removeCsbpContacts:(NSSet *)values;

- (void)addNewsObject:(News *)value;
- (void)removeNewsObject:(News *)value;
- (void)addNews:(NSSet *)values;
- (void)removeNews:(NSSet *)values;

@end
