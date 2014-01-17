//
//  CSBPNewsCell.h
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 29/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "CSBPNewsViewController.h"

@interface CSBPNewsCell : UITableViewCell{
    IBOutlet UILabel *newsTitle;
    IBOutlet UILabel *newsSnippet;
    IBOutlet UIImageView *newsImage;
    IBOutlet UIButton *readMoreBtn;
    IBOutlet UIActivityIndicatorView *imageIndicator;
    
    NSOperationQueue *queue;
}
@property(nonatomic,retain)News *newsObject;
@property(nonatomic,retain)CSBPNewsViewController *parentViewController;


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andNewsObject:(News*)news;
@end
