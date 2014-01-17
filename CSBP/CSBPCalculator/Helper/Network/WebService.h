//
//  WebService.h
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 25/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "CommonFunctions.h"
#import "JSONKit.h"
#import "DataManager.h"

@interface WebService : NSObject<ASIHTTPRequestDelegate>{
    
}
- (NSError *)errorWithMessage:(NSString *)message;

- (void)beginRequestPostAction:(NSString *)action parameters:(NSDictionary *)parameters;
- (void)beginRequestPostAction:(NSString *)action parameters:(NSDictionary *)parameters object:(NSObject *)object;
//- (void)beginRequestPostAction:(NSString *)action user:(User *)user parameters:(NSDictionary *)parameters;
//- (void)beginRequestPostAction:(NSString *)action user:(User *)user parameters:(NSDictionary *)parameters object:(NSObject *)object;

- (void)beginRequestGetAction:(NSString *)action;
- (void)beginRequestGetAction:(NSString *)action parameters:(NSDictionary *)parameters;
//- (void)beginRequestGetAction:(NSString *)action user:(User *)user parameters:(NSDictionary *)parameters;

- (void)didFinishAction:(NSString *)action response:(NSDictionary *)response object:(NSObject *)object;
- (void)didFailAction:(NSString *)action error:(NSError *)error object:(NSObject *)object;

@end
