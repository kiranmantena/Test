//
//  HKImageDownloader.h
//  MovPlex
//
//  Created by Hendrik Kusuma on 10/27/11.
//  Copyright (c) 2011 Warcod. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface HKImageDownloader : NSObject{
    NSData *downloadedData;
    
}
- (void)postNotification:(NSString *)notificationName;

- (void)downloadImage:(NSString *)imageUrl
     withNotification:(NSString *)notificationName;

- (void)downloadImage:(NSString *)imageUrl 
    withNotification: (NSString *)notificationName
      andDictionary : (NSDictionary *) dictionary;

@property(nonatomic,retain) NSData *downloadedData;

@end
