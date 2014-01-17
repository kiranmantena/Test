//
//  News.h
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Shire;

@interface News : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSData * imageData;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSDate * publicationDate;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) Shire *shire;

@end
