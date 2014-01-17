//
//  ContentDetailViewController.h
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 17/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSBPTextField.h"
#import "DataManager.h"
#import "GAITrackedViewController.h"

@protocol ContentDetailViewControllerDelegate; 

@interface ContentDetailViewController : UIViewController{
    

}
@property(nonatomic,retain)IBOutlet UIImageView *menuIcon;
@property(nonatomic,retain)IBOutlet UIImageView *menuText;
@property(nonatomic,retain)IBOutlet UIImageView *background;
@property(nonatomic,retain)IBOutlet UIView *contentView;


@end
