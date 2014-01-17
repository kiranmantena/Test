//
//  NutrientCalculatorProduct.h
//  CSBPCalculator
//
//  Created by HK on 14/8/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NutrientCalculatorProduct : NSManagedObject

@property (nonatomic, retain) NSNumber * compositionB;
@property (nonatomic, retain) NSNumber * compositionCa;
@property (nonatomic, retain) NSNumber * compositionCo;
@property (nonatomic, retain) NSNumber * compositionCu;
@property (nonatomic, retain) NSNumber * compositionK;
@property (nonatomic, retain) NSNumber * compositionMg;
@property (nonatomic, retain) NSNumber * compositionMn;
@property (nonatomic, retain) NSNumber * compositionMo;
@property (nonatomic, retain) NSNumber * compositionN;
@property (nonatomic, retain) NSNumber * compositionP;
@property (nonatomic, retain) NSNumber * compositionS;
@property (nonatomic, retain) NSNumber * compositionZn;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * isBandingN;
@property (nonatomic, retain) NSNumber * isKProduct;
@property (nonatomic, retain) NSNumber * isNKCompound;
@property (nonatomic, retain) NSNumber * isNutrientCalculator;
@property (nonatomic, retain) NSNumber * isTargetNP;
@property (nonatomic, retain) NSString * product;
@property (nonatomic, retain) NSNumber * rate;

@end
