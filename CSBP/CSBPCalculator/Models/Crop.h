//
//  Crop.h
//  CSBPCalculator
//
//  Created by HK on 22/8/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Nutrient;

@interface Crop : NSManagedObject

@property (nonatomic, retain) NSString * cropType;
@property (nonatomic, retain) NSSet *nutrients;
@end

@interface Crop (CoreDataGeneratedAccessors)

- (void)addNutrientsObject:(Nutrient *)value;
- (void)removeNutrientsObject:(Nutrient *)value;
- (void)addNutrients:(NSSet *)values;
- (void)removeNutrients:(NSSet *)values;

@end
