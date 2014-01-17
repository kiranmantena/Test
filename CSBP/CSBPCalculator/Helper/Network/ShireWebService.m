//
//  ShireWebService.m
//  CSBPCalculator
//
//  Created by HK on 8/8/12.
//
//

#import "ShireWebService.h"
#import "DataManager.h"

@implementation ShireWebService
@synthesize delegate;

- (void)    getAllShireInfomation{
    [self beginRequestPostAction:@"GetShiresWithContacts" parameters:nil];
}
#pragma mark -
#pragma mark Handler
- (void)didFinishAction:(NSString *)action response:(NSDictionary *)response object:(NSObject *)object {
    if ([action isEqualToString:@"GetShiresWithContacts"]) {
        NSArray *shireArray = [[response objectForKey:@"d"] objectFromJSONString];
        NSArray *shireDBArray = [Application.dataManager getAllShire];
        if ([shireDBArray count] != [shireArray count]) {
            [Application.dataManager removeAllObject:@"Shire"];
            [Application.dataManager removeAllObject:@"CSBPContacts"];
        }
        else{
            return;
        }
        for (NSDictionary *shireDict in shireArray) {
            NSArray *csbpContactArray = [shireDict objectForKey:@"CsbpContacts"];
            Shire *shire = [Application.dataManager insertNewObject:@"Shire"];
            shire.shireID = [shireDict objectForKey:@"ShireID"];
            shire.shireName = [shireDict objectForKey:@"Shire"];
            
            NSMutableSet *csbpContactSet = [NSMutableSet set];
            
            if (csbpContactArray.hasObject) {
                for (NSDictionary *csbpContactDict in csbpContactArray) {
                    CSBPContacts *contact = [Application.dataManager insertNewObject:@"CSBPContacts"];
                    
                    contact.firstName = [csbpContactDict objectForKey:@"FirstName"];
                    contact.lastName = [csbpContactDict objectForKey:@"LastName"];
                    contact.email = [csbpContactDict objectForKey:@"Email"];
                    contact.mobile= [csbpContactDict objectForKey:@"Mobile"];
                    if (![[csbpContactDict objectForKey:@"ImageUrl"] isEqual:[NSNull null]]) {
                        contact.imageURL = [csbpContactDict objectForKey:@"ImageUrl"];
                        [csbpContactSet addObject:contact];

                    }
                contact.shire = shire;
                }
                
            }
            
            
            [Application.dataManager save];
        }
            
    }
    
}
@end
