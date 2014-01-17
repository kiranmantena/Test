//
//  Nutrient.h
//  CSBPCalculator
//
//  Created by HK on 22/8/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Crop;

@interface Nutrient : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSData * imageData_1;
@property (nonatomic, retain) NSData * imageData_2;
@property (nonatomic, retain) NSData * imageData_3;
@property (nonatomic, retain) NSString * imageURL_1;
@property (nonatomic, retain) NSString * imageURL_2;
@property (nonatomic, retain) NSString * imageURL_3;
@property (nonatomic, retain) NSString * nutrientName;
@property (nonatomic, retain) Crop *crops;

@end
