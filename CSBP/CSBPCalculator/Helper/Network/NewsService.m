//
//  NewsService.m
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 25/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewsService.h"
#import "DataManager.h"

@implementation NewsService
@synthesize delegate;

- (void)    getAllNews:(NSString *)shireID{
    [self beginRequestPostAction:@"GetIpadNews" parameters:[NSDictionary dictionaryWithObject:shireID forKey:@"ShireId"]];
}
#pragma mark -
#pragma mark Handler
- (void)didFinishAction:(NSString *)action response:(NSDictionary *)response object:(NSObject *)object {
    if ([action isEqualToString:@"GetIpadNews"]) {
        NSArray *newsArray = [[response objectForKey:@"d"] objectFromJSONString];
        NSDictionary *shireInformation = [(NSString *)object objectFromJSONString];
        Shire *shire = [Application.dataManager getShireByID:[shireInformation objectForKey:@"ShireId"]];
        
//        NSLog(@"RESPONSE:%@",response);
        if ([Application.dataManager getAllNews].count>0) {
            [Application.dataManager removeAllObject:@"News"];
        }
        for (NSDictionary *newsDict in newsArray) {
            News *news = [Application.dataManager insertNewObject:@"News"];
            news.title = [newsDict objectForKey:@"Title"];
            NSString *dateOnly = [[newsDict objectForKey:@"PublicationDate"] stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
            dateOnly = [dateOnly stringByReplacingOccurrencesOfString:@")/" withString:@""];
            NSUInteger exactDate = [dateOnly longLongValue]/1000;
            news.publicationDate = [NSDate dateWithTimeIntervalSince1970:exactDate];
            news.summary = [newsDict objectForKey:@"Summary"];
            news.content = [newsDict objectForKey:@"Content"];
            NSString *url = nil;
            NSString *htmlString = news.content;
            NSScanner *theScanner = [NSScanner scannerWithString:htmlString];
            // find start of IMG tag
            [theScanner scanUpToString:@"<img" intoString:nil];
            if (![theScanner isAtEnd]) {
                [theScanner scanUpToString:@"src" intoString:nil];
                NSCharacterSet *charset = [NSCharacterSet characterSetWithCharactersInString:@"\"'"];
                [theScanner scanUpToCharactersFromSet:charset intoString:nil];
                [theScanner scanCharactersFromSet:charset intoString:nil];
                [theScanner scanUpToCharactersFromSet:charset intoString:&url];
                // "url" now contains the URL of the img
                news.imageURL = url;
            }
            
            news.shire = shire;
            [Application.dataManager save];
            NSDateFormatter *wsFormatter = [[[NSDateFormatter alloc] init] autorelease];
            [wsFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]]; //GMT 0
            [wsFormatter setDateFormat:@"yyyy-MM-dd kk:mm:ss"];
//            NSLog(@"%@",[wsFormatter stringFromDate:news.publicationDate]);

        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getIpadNewsDone" object:nil];
    }    
}
-(void)didFailAction:(NSString *)action error:(NSError *)error object:(NSObject *)object{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getIpadNewsFail" object:nil];
}

@end
