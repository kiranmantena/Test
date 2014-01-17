//
//  TargetNP.h
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TargetNP : NSManagedObject

@property (nonatomic, retain) NSNumber * idTargetNP;
@property (nonatomic, retain) NSString * product;
@property (nonatomic, retain) NSNumber * rate;
@property (nonatomic, retain) NSNumber * compositionN;
@property (nonatomic, retain) NSNumber * compositionK;
@property (nonatomic, retain) NSNumber * compositionP;
@property (nonatomic, retain) NSNumber * compositionS;
@property (nonatomic, retain) NSNumber * ureaRate;
@property (nonatomic, retain) NSNumber * flexiNRate;
@property (nonatomic, retain) NSNumber * mopRate;
@property (nonatomic, retain) NSNumber * graNSRate;

@end
