//
//  TargetNPViewController.h
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 7/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentDetailViewController.h"
#import "DataManager.h"


@interface TargetNPViewController : ContentDetailViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    IBOutlet CSBPTextField *requiredNTF;
    IBOutlet CSBPTextField *requiredPTF;
    IBOutlet CSBPTextField *requiredKTF;
    IBOutlet CSBPTextField *requiredSTF;
    
    IBOutlet UIButton *checkN;
    IBOutlet UIButton *checkP;
    IBOutlet UIButton *checkK;
    IBOutlet UIButton *checkS;
    
    IBOutlet CSBPTextField *productTF1;
    IBOutlet CSBPTextField *productTF2;
    IBOutlet CSBPTextField *productTF3;
    IBOutlet CSBPTextField *productTF4;
    
    IBOutlet UILabel *productN1;
    IBOutlet UILabel *productN2;
    IBOutlet UILabel *productN3;
    IBOutlet UILabel *productN4;
    
    IBOutlet UILabel *productK1;
    IBOutlet UILabel *productK2;
    IBOutlet UILabel *productK3;
    IBOutlet UILabel *productK4;
    
    IBOutlet UILabel *productP1;
    IBOutlet UILabel *productP2;
    IBOutlet UILabel *productP3;
    IBOutlet UILabel *productP4;
    
    IBOutlet UILabel *productS1;
    IBOutlet UILabel *productS2;
    IBOutlet UILabel *productS3;
    IBOutlet UILabel *productS4;
    
    IBOutlet UILabel *rateToBeApplied1;
    IBOutlet UILabel *rateToBeApplied2;
    IBOutlet UILabel *rateToBeApplied3;
    IBOutlet UILabel *rateToBeApplied4;
    
    IBOutlet UILabel *urea1;
    IBOutlet UILabel *urea2;
    IBOutlet UILabel *urea3;
    IBOutlet UILabel *urea4;
    
    IBOutlet UILabel *flexiN1;
    IBOutlet UILabel *flexiN2;
    IBOutlet UILabel *flexiN3;
    IBOutlet UILabel *flexiN4;
    
    IBOutlet UILabel *kMOP1;
    IBOutlet UILabel *kMOP2;
    IBOutlet UILabel *kMOP3;
    IBOutlet UILabel *kMOP4;
    
    IBOutlet UILabel *sGRaNS1;
    IBOutlet UILabel *sGRaNS2;
    IBOutlet UILabel *sGRaNS3;
    IBOutlet UILabel *sGRaNS4;
    
    IBOutlet UIView *termAndConditionView;
    BOOL termConditionIsActive;
    
    UIPopoverController *productSelection;
    NSArray *allTargetNPProduct;
    NSInteger selectedTag;
    
    NSArray *allLabel;
    ;    
    NutrientCalculatorProduct *targetNP1;
    NutrientCalculatorProduct *targetNP2;
    NutrientCalculatorProduct *targetNP3;
    NutrientCalculatorProduct *targetNP4;
    
    NSArray *allDynamicLabels;
}
@property (nonatomic,retain)NutrientCalculatorProduct *product1;
@property (nonatomic,retain)NutrientCalculatorProduct *product2;
@property (nonatomic,retain)NutrientCalculatorProduct *product3;
@property (nonatomic,retain)NutrientCalculatorProduct *product4;
@end
