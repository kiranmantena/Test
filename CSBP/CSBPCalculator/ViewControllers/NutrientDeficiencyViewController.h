//
//  NutrientDeficiencyViewController.h
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 7/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentDetailViewController.h"
#import "DataManager.h"

@interface NutrientDeficiencyViewController : ContentDetailViewController{
    NSArray *allCrop;
    Crop *selectedCrop;
    
    IBOutlet UILabel *selectedCropLbl;
    
    IBOutlet UILabel *nutrientLbl;
    IBOutlet UIScrollView *nutrientDefContentView;
    IBOutlet UILabel *contentDetail;
    
    IBOutlet UIImageView *containerImage1;
    IBOutlet UIImageView *containerImage2;
    IBOutlet UIImageView *containerImage3;
    IBOutlet UIImageView *image1;
    IBOutlet UIImageView *image2;
    IBOutlet UIImageView *image3;
    
    IBOutlet UIActivityIndicatorView *imageIndicator1;
    IBOutlet UIActivityIndicatorView *imageIndicator2;
    IBOutlet UIActivityIndicatorView *imageIndicator3;
    
    IBOutlet UIButton *currentSelectedButton;
    IBOutlet UIButton *defaultButton;

    IBOutlet UIView *termAndConditionView;
    BOOL termConditionIsActive;
    
    NSOperationQueue *queue;
    
    IBOutlet UIWebView *nutrientDefContentWebView;
}
-(void)dismissCropSelectionView:(Crop *)crop;
@end
