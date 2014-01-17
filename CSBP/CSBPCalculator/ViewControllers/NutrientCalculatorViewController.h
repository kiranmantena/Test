//
//  NutrientCalculatorViewController.h
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentDetailViewController.h"
#import "DataManager.h"


@interface NutrientCalculatorViewController : ContentDetailViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    IBOutlet UILabel  *titleLbl;
    IBOutlet UILabel  *fieldNumber1;
    IBOutlet UILabel  *fieldNumber2;
    IBOutlet UILabel  *fieldNumber3;
    IBOutlet UILabel  *fieldNumber4;
    
    IBOutlet UILabel *fertiliserProdcutLbl1;    
    IBOutlet UILabel *fertiliserProdcutLbl2;
    IBOutlet UILabel *fertiliserProdcutLbl3;
    IBOutlet UILabel *fertiliserProdcutLbl4;
    
    IBOutlet CSBPTextField *productTF1;
    IBOutlet CSBPTextField *productTF2;
    IBOutlet CSBPTextField *productTF3;
    IBOutlet CSBPTextField *productTF4;
    
    IBOutlet CSBPTextField *productMultiplierTF1;
    IBOutlet CSBPTextField *productMultiplierTF2;
    IBOutlet CSBPTextField *productMultiplierTF3;
    IBOutlet CSBPTextField *productMultiplierTF4;
    
    IBOutlet UILabel *productResultLbl1;
    IBOutlet UILabel *productResultLbl2;
    IBOutlet UILabel *productResultLbl3;
    IBOutlet UILabel *productResultLbl4;
    
    IBOutlet UILabel *productNContent1;
    IBOutlet UILabel *productNContent2;
    IBOutlet UILabel *productNContent3;
    IBOutlet UILabel *productNContent4;
    IBOutlet UILabel *productNContentTotal;
    
    IBOutlet UILabel *productPContent1;
    IBOutlet UILabel *productPContent2;
    IBOutlet UILabel *productPContent3;
    IBOutlet UILabel *productPContent4;
    IBOutlet UILabel *productPContentTotal;
    
    IBOutlet UILabel *productKContent1;
    IBOutlet UILabel *productKContent2;
    IBOutlet UILabel *productKContent3;
    IBOutlet UILabel *productKContent4;
    IBOutlet UILabel *productKContentTotal;
    
    IBOutlet UILabel *productSContent1;
    IBOutlet UILabel *productSContent2;
    IBOutlet UILabel *productSContent3;
    IBOutlet UILabel *productSContent4;
    IBOutlet UILabel *productSContentTotal;
    
    IBOutlet UILabel *productCaContent1;
    IBOutlet UILabel *productCaContent2;
    IBOutlet UILabel *productCaContent3;
    IBOutlet UILabel *productCaContent4;
    IBOutlet UILabel *productCaContentTotal;
    
    IBOutlet UILabel *productCuContent1;
    IBOutlet UILabel *productCuContent2;
    IBOutlet UILabel *productCuContent3;
    IBOutlet UILabel *productCuContent4;
    IBOutlet UILabel *productCuContentTotal;
    
    IBOutlet UILabel *productZnContent1;
    IBOutlet UILabel *productZnContent2;
    IBOutlet UILabel *productZnContent3;
    IBOutlet UILabel *productZnContent4;
    IBOutlet UILabel *productZnContentTotal;
    
    IBOutlet UILabel *productMoContent1;
    IBOutlet UILabel *productMoContent2;
    IBOutlet UILabel *productMoContent3;
    IBOutlet UILabel *productMoContent4;
    IBOutlet UILabel *productMoContentTotal;
    
    IBOutlet UILabel *productMnContent1;
    IBOutlet UILabel *productMnContent2;
    IBOutlet UILabel *productMnContent3;
    IBOutlet UILabel *productMnContent4;
    IBOutlet UILabel *productMnContentTotal;
    
    IBOutlet UIView *termAndConditionView;
    BOOL termConditionIsActive;

    
    UIPopoverController *productSelection;
    
    NSArray *allProduct;
    NSInteger selectedTag;
    
    NSArray *allLabel;
    
}
@property(nonatomic,retain) NutrientCalculatorProduct *product1;
@property(nonatomic,retain) NutrientCalculatorProduct *product2;
@property(nonatomic,retain) NutrientCalculatorProduct *product3;
@property(nonatomic,retain) NutrientCalculatorProduct *product4;
@end
