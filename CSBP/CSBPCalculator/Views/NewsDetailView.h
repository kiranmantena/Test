//
//  NewsDetailView.h
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 29/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

@interface NewsDetailView : UIView<UIWebViewDelegate>{
    IBOutlet UIImageView *newsDetailImage;
    IBOutlet UIWebView *newsDetailContent;
    IBOutlet UILabel *newsTitle;
    IBOutlet UILabel *newsContent;
    
    
    IBOutlet UIScrollView *newsContentContainer;
    IBOutlet UIButton *backButton;
    
    IBOutlet UIActivityIndicatorView *imageIndicator;
    
    NSOperationQueue *queue;
}
-(id)initWithFrame:(CGRect)frame andNewsObject:(News *)news;
@property(nonatomic,retain)News *newsObject;
@property(nonatomic,retain)UIButton *backButton;


@end
