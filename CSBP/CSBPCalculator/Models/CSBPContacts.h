//
//  CSBPContacts.h
//  CSBPCalculator
//
//  Created by HK on 14/8/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Shire;

@interface CSBPContacts : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSData * imageData;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * mobile;
@property (nonatomic, retain) Shire *shire;

@end
