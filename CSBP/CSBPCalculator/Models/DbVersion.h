//
//  DbVersion.h
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 10/22/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DbVersion : NSManagedObject

@property (nonatomic, retain) NSNumber * dbVersion;

@end
