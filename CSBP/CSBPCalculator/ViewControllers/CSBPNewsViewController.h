//
//  CSBPNewsViewController.h
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentDetailViewController.h"
#import "NewsDetailView.h"

@interface CSBPNewsViewController : ContentDetailViewController<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *CSBPNewsTableView;
    IBOutlet UIView *contentWithBackgroundView;
    
    IBOutlet UIButton *backToShire;
    
    NSArray *csbpNewsArray;
    
    NSArray *allShireArray;
    NSString *shireID;
    NewsDetailView *newsDetail;
    
    IBOutlet UIView *termAndConditionView;
    BOOL termConditionIsActive;
}
-(void)newsDidSelected:(News *)news;
@end
