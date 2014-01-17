//
//  NKLevelsViewController.h
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 7/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentDetailViewController.h"
#import "RCSwitchOnOff.h"
#import "RCSwitchWetDry.h"

@interface NKLevelsViewController : ContentDetailViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    NSArray *allProduct;
    NSArray *KProductArray;
    NSArray *NBandingArray;
    NSArray *seedTypeArray;

    IBOutlet CSBPTextField *compoundProduct;
    IBOutlet CSBPTextField *bandingProduct;
    IBOutlet CSBPTextField *kProduct;
    IBOutlet CSBPTextField *seedType;
    
    IBOutlet CSBPTextField *compoundRate;
    IBOutlet CSBPTextField *bandingRate;
    IBOutlet CSBPTextField *kRate;
    
    IBOutlet UISlider *rowSpacing;
    IBOutlet UISlider *splitAway;
    IBOutlet UISlider *bandingDepth;
    
    int stepValue;
    int lastStep;
    
    IBOutlet UILabel *splitAwayLbl;
    IBOutlet UILabel *rowSpacingLbl;
    IBOutlet UILabel *bandingDepthTitle;
    
    IBOutlet UILabel *splitAwayTitle;
    
    IBOutlet UIImageView *nLevelBG;
    IBOutlet UIImageView *kLevelBG;
    
    IBOutlet UILabel *nLevelValue;
    IBOutlet UILabel *kLevelValue;
    
    IBOutlet UILabel *nLevelStatus;
    IBOutlet UILabel *kLevelStatus;
    
    UIPopoverController *productSelection;
    UIPopoverController *nBandingProductSelection;
    UIPopoverController *kProductSelection;
    UIPopoverController *seedProductSelection;
    
    NSInteger selectedTag;
    
    NutrientCalculatorProduct *compoundProductObject;
    NutrientCalculatorProduct *nBandingObject;
    NutrientCalculatorProduct *kProductObject;
    
    IBOutlet RCSwitchWetDry *seedBedStatus;
    IBOutlet RCSwitchOnOff *bandingDepthOnOff;
    IBOutlet RCSwitchOnOff *fertilizerSplitOnOff;
    IBOutlet RCSwitchOnOff *kWithSeedOnOff;
    IBOutlet RCSwitchOnOff *kBandedBelowOnOff;
    
    IBOutlet UILabel *depthLabel;
    
    IBOutlet UIView *termAndConditionView;
    BOOL termConditionIsActive;
    
    
    BOOL seedBedIsWet;
    BOOL fertilizerIsSplit;
    BOOL bandedNitrogenIsBelow;
    BOOL isKWithSeed;
    BOOL isKBandedBelow;
    
    BOOL isFirstOpen;
    
    //A1-A3
    NSNumber *compoundN;
    NSNumber *bandingN;
    NSNumber *nLevels;
    //A4-A6
    NSNumber *compoundK;
    NSNumber *bandingK;
    NSNumber *kLevels;
    //A12-A17
    NSNumber *numberOfRow;
    NSNumber *compoundNPerRow;
    NSNumber *bandingNPerRow;
    NSNumber *compoundKPerRow;
    NSNumber *bandingKPerRow;
    NSNumber *kgKPerRow;
    //A19-A24
    NSNumber *splitSeedCalc;
    NSNumber *splitPercentage;
    NSNumber *bandedCalcForN;
    NSNumber *depthCalcForN;
    NSNumber *seedCalcForN;
    NSNumber *finalNValue;
    //A25-A30
    NSNumber *finalKValue;
}

@end
