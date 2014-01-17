//
//  NewsService.h
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 25/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebService.h"
#import "DataManager.h"

@protocol NewsServiceDelegate;
@interface NewsService : WebService{
    id<NewsServiceDelegate> delegate;
}

@property(assign)id<NewsServiceDelegate> delegate;

- (void)getAllNews:(NSString *)shireID;

@end

@protocol NewsServiceDelegate <NSObject>

@optional

@end
