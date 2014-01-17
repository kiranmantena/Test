//
//  WebService.m
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 25/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebService.h"

@implementation WebService
#pragma Error Handling
- (NSError *)errorWithMessage:(NSString *)message{
    return [NSError errorWithDomain:@"CSBPWS" code:WebServiceErrorCode userInfo:[NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey]];
}

#pragma -
#pragma POST action
- (void)beginRequestPostAction:(NSString *)action parameters:(NSDictionary *)parameters{
    [self beginRequestPostAction:action parameters:parameters object:nil];
    
}
- (void)beginRequestPostAction:(NSString *)action parameters:(NSDictionary *)parameters object:(NSObject *)object{
    NSURL *requestURL;
    requestURL = [NSURL URLWithString:[NSString stringWithFormat: CSBPWebServiceURL, action]];
    
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:requestURL];
    
    NSMutableDictionary *headerDictionary = [NSMutableDictionary dictionary];
    [headerDictionary setObject:@"application/json, text/javascript, */*" forKey:@"Accept"];
	
	[headerDictionary setObject:@"application/json; charset=utf-8" forKey:@"Content-Type"];
	[request setRequestHeaders:headerDictionary];
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
	
	[userInfo setObject:action forKey:@"Action"];
    
    [request setDelegate:self];
    
	if (parameters != nil) {
        //to be implemented later
        NSData *paramData = [parameters JSONData];
        [request setPostBody:[NSMutableData dataWithData:paramData]];
        [userInfo setObject:[[[NSString alloc] initWithData:paramData encoding:NSUTF8StringEncoding]autorelease ] forKey:@"Object"];
//        NSArray *parametersArray = [parameters allKeys];
//        for (NSString *parameterKey in parametersArray) {
//            [request setPostValue:[parameters objectForKey:parameterKey] forKey:parameterKey];
//        }
	}
	[request setUserInfo:userInfo];
	[request startAsynchronous];	
}
//- (void)beginRequestPostAction:(NSString *)action user:(User *)user parameters:(NSDictionary *)parameters;
//- (void)beginRequestPostAction:(NSString *)action user:(User *)user parameters:(NSDictionary *)parameters object:(NSObject *)object;
#pragma GET action
- (void)beginRequestGetAction:(NSString *)action{
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate

- (void)requestFinished:(ASIHTTPRequest *)request {
	NSString *action = [[request userInfo] objectForKey:@"Action"];
	NSObject *object = [[request userInfo] objectForKey:@"Object"];
	
    NSDictionary *response =  [[request responseString] objectFromJSONString];
	
    if ([response isKindOfClass:[NSDictionary class]] && [response hasObject]) {
        [self didFinishAction:action response:response object:object];
	} else {
		[self didFailAction:action error:[self errorWithMessage:@"Invalid API Request"] object:object];
	}
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	NSString *action = [[request userInfo] objectForKey:@"Action"];
	NSObject *object = [[request userInfo] objectForKey:@"Object"];
	NSError *error = [request error];
	[self didFailAction:action error:error object:object];
}

- (void)beginRequestGetAction:(NSString *)action parameters:(NSDictionary *)parameters{
}
//- (void)beginRequestGetAction:(NSString *)action user:(User *)user parameters:(NSDictionary *)parameters;

- (void)didFinishAction:(NSString *)action response:(NSDictionary *)response object:(NSObject *)object{
    
}

- (void)didFailAction:(NSString *)action error:(NSError *)error object:(NSObject *)object{
    
}
@end
