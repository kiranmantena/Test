//
//  HKImageDownloader.m
//  MovPlex
//
//  Created by Hendrik Kusuma on 10/27/11.
//  Copyright (c) 2011 Warcod. All rights reserved.
//

#import "HKImageDownloader.h"


@implementation HKImageDownloader

@synthesize downloadedData;

- (void)postNotification:(NSString *)notificationName {
	[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:notificationName object:self]];
}
-(void)downloadImage:(NSString *)imageUrl
    withNotification: (NSString *)notificationName{
    
    [self downloadImage:imageUrl withNotification:notificationName andDictionary:nil];

}

-(void)downloadImage:(NSString *)imageUrl 
    withNotification: (NSString *)notificationName
      andDictionary : (NSDictionary *) dictionary{
    
    if (imageUrl == nil) {
        return;
    }
//    NSLog(@"IMAGE Address: %@", imageUrl);
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:imageUrl]];
    
    //temp not used
    //    [request setUserInfo:[NSDictionary dictionaryWithObject:imageUrl forKey:@"imageURL"]];
    [request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:notificationName, @"notification", 
                          dictionary,@"dictionaryObject", 
                          nil ]];
    
    request.delegate = self;
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    
    //temp not used
    //	NSString *URL = [request.userInfo objectForKey:@"URL"];
    NSString *notification = [request.userInfo objectForKey:@"notification"];
    self.downloadedData = [request responseData];
    
    NSDictionary *objectAndNotification = [NSDictionary dictionaryWithObjectsAndKeys:
                                           [request.userInfo objectForKey:@"dictionaryObject"],@"dictionaryObject",
                                           self.downloadedData, @"data",
                                           nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:notification object:objectAndNotification];
}
-(void)dealloc{
    
    [downloadedData release];
    [super dealloc];

}
@end
