//
//  TargetNPViewController.m
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 7/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TargetNPViewController.h"

@interface TargetNPViewController (PrivateMethods)
-(void)doCalculation;

@end

@implementation TargetNPViewController
@synthesize product1,product2,product3,product4;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)clearAllField{
    [productTF1 setText:nil];
    [productTF1 setBackground:[UIImage imageNamed:@"DD_Select_Fertiliser.png"]];
    
    [productTF2 setText:nil];
    [productTF2 setBackground:[UIImage imageNamed:@"DD_Select_Fertiliser.png"]];
    
    [productTF3 setText:nil];
    [productTF3 setBackground:[UIImage imageNamed:@"DD_Select_Fertiliser.png"]];
    
    [productTF4 setText:nil];
    [productTF4 setBackground:[UIImage imageNamed:@"DD_Select_Fertiliser.png"]];
    
    [requiredNTF setText:nil];
    [requiredNTF setBackground:[UIImage imageNamed:@"TF_RequiredLevelofN.png"]];
    
    [requiredPTF setText:nil];
    [requiredPTF setBackground:[UIImage imageNamed:@"TF_RequiredLevelofP.png"]];
    
    [requiredKTF setText:nil];
    [requiredKTF setBackground:[UIImage imageNamed:@"TF_RequiredLevelofK.png"]];
    
    [requiredSTF setText:nil];
    [requiredSTF setBackground:[UIImage imageNamed:@"TF_RequiredLevelofS.png"]];
    
    
    for (UILabel *productContentLabel in allLabel) {
        productContentLabel.text =@"0";
    }
    

}
-(void)viewWillAppear:(BOOL)animated{
    
//    [self clearAllField];
    termConditionIsActive = NO;
    termAndConditionView.hidden = YES;
    
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    allTargetNPProduct = [Application.dataManager getAllTargetNP];
    [allTargetNPProduct retain];
    
    allLabel = [NSArray arrayWithObjects:
                productN1,productN2,productN3,productN4,
                productK1,productK2,productK3,productK4,
                productP1,productP2,productP3,productP4,
                productS1,productS2,productS3,productS4,
                rateToBeApplied1,rateToBeApplied2,rateToBeApplied3,rateToBeApplied4,
                urea1,urea2,urea3,urea4,
                flexiN1,flexiN2,flexiN3,flexiN4,
                kMOP1,kMOP2,kMOP3,kMOP4,
                sGRaNS1,sGRaNS2,sGRaNS3,sGRaNS4,nil];
    [allLabel retain];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}
#pragma mark-
#pragma mark UITextField
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag >=4) {
        return NO;
    }
    
    [textField setBackground:[UIImage imageNamed:@"DD_or_TF.png"]];
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == requiredNTF.tag  && textField.text.length <=0) {
        [requiredNTF setBackground:[UIImage imageNamed:@"TF_RequiredLevelofN.png"]];
    }
    if (textField.tag == requiredPTF.tag  && textField.text.length <=0) {
        [requiredPTF setBackground:[UIImage imageNamed:@"TF_RequiredLevelofP.png"]];
    }
    if (textField.tag == requiredKTF.tag  && textField.text.length <=0) {
        [requiredKTF setBackground:[UIImage imageNamed:@"TF_RequiredLevelofK.png"]];
    }
    if (textField.tag == requiredSTF.tag && textField.text.length <=0) {
        [requiredSTF setBackground:[UIImage imageNamed:@"TF_RequiredLevelofS.png"]];
    }
    [self doCalculation];
    

   
    
}



#pragma mark -
#pragma mark drop down
-(IBAction)dropDownDidSelected:(id)sender{
    UIButton *selectedDropDown  = (UIButton *)sender;
    
    UIViewController* popoverContent = [[UIViewController alloc]
                                        init];
    UIView* popoverView = [[UIView alloc]
                           initWithFrame:CGRectMake(0, 0, 300, 400)];

    UIPickerView *productSelectionPicker = [[UIPickerView alloc] initWithFrame:popoverView.frame];
    productSelectionPicker.delegate = self;
    productSelectionPicker.dataSource = self;
    productSelectionPicker.showsSelectionIndicator = YES;
    [popoverView addSubview:productSelectionPicker];

    popoverContent.view = popoverView;

    //resize the popover view shown
    //in the current view to the view's size
    popoverContent.contentSizeForViewInPopover =
    CGSizeMake(300, 200);
    
    if (productSelection ==nil) {
        //create a popover controller
        productSelection = [[UIPopoverController alloc]
                            initWithContentViewController:popoverContent];
    }
    UIView *showInView;

    switch (selectedDropDown.tag) {
        case 4:
            showInView = productTF1;
            break;
        case 5:
            showInView = productTF2;
            break;
        case 6:
            showInView = productTF3;
            break;
        case 7:
            showInView = productTF4;
            break;
        default:
            break;
    }
    selectedTag = selectedDropDown.tag;

    [productSelection presentPopoverFromRect:showInView.frame inView:self.contentView  permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];


    //release the popover content
    [popoverView release];
    [popoverContent release];
    

}
#pragma mark-
#pragma mark UIPickerView Datasource and Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return allTargetNPProduct.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NutrientCalculatorProduct *targetNPProduct = [allTargetNPProduct objectAtIndex:row];
    return targetNPProduct.product;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    UITextField *selectedTF;
//    UILabel *changedLbl;
    UILabel *selectedNLbl;
    UILabel *selectedKLbl;
    UILabel *selectedPLbl;
    UILabel *selectedSLbl;
    
    UILabel *selectedRateLbl;
    UILabel *selectedUreaLbl;
    UILabel *selectedFlexiNLbl;
    UILabel *selectedKMOPLbl;
    UILabel *selectedGRaNSLbl;
    
       
    NutrientCalculatorProduct *targetNPProduct = [allTargetNPProduct objectAtIndex:row];
    
    
  
    switch (selectedTag) {
        case 4:
            selectedTF = productTF1;
            selectedNLbl = productN1;
            selectedPLbl = productP1;
            selectedKLbl = productK1;
            selectedSLbl = productS1;

            selectedRateLbl = rateToBeApplied1;
            selectedUreaLbl = urea1;
            selectedFlexiNLbl = flexiN1;
            selectedKMOPLbl = kMOP1;
            selectedGRaNSLbl = sGRaNS1;
            
            self.product1 = targetNPProduct;
            
            if (targetNP1 !=nil) {
                [targetNP1 release];targetNP1=nil;
            }
            targetNP1 = targetNPProduct;
            [targetNP1 retain];
            
            
            
            break;
        case 5:
            selectedTF = productTF2;
            selectedNLbl = productN2;
            selectedPLbl = productP2;
            selectedKLbl = productK2;
            selectedSLbl = productS2;
            
            
            selectedRateLbl = rateToBeApplied2;
            selectedUreaLbl = urea2;
            selectedFlexiNLbl = flexiN2;
            selectedKMOPLbl = kMOP2;
            selectedGRaNSLbl = sGRaNS2;
            
            self.product2 = targetNPProduct;
            
            if (targetNP2 !=nil) {
                [targetNP2 release];targetNP2=nil;
            }
            targetNP2 = targetNPProduct;
            [targetNP2 retain];
            
            
            break;
        case 6:
            selectedTF = productTF3;
            selectedNLbl = productN3;
            selectedPLbl = productP3;
            selectedKLbl = productK3;
            selectedSLbl = productS3;
            
            selectedRateLbl = rateToBeApplied3;
            selectedUreaLbl = urea3;
            selectedFlexiNLbl = flexiN3;
            selectedKMOPLbl = kMOP3;
            selectedGRaNSLbl = sGRaNS3;
            
            self.product3 = targetNPProduct;
            
            if (targetNP3 !=nil) {
                [targetNP3 release];targetNP3=nil;
            }
            targetNP3 = targetNPProduct;
            [targetNP3 retain];
            
            
            break;
        case 7:
            selectedTF = productTF4;
            selectedNLbl = productN4;
            selectedPLbl = productP4;
            selectedKLbl = productK4;
            selectedSLbl = productS4;
            
            selectedRateLbl = rateToBeApplied4;
            selectedUreaLbl = urea4;
            selectedFlexiNLbl = flexiN4;
            selectedKMOPLbl = kMOP4;
            selectedGRaNSLbl = sGRaNS4;
            
            self.product4 = targetNPProduct;
            
            if (targetNP4 !=nil) {
                [targetNP4 release];targetNP4=nil;
            }
            targetNP4 = targetNPProduct;
            [targetNP4 retain];
            
            break;
        default:
            break;
    }
  
//    NSLog(@"%@",targetNPProduct.product);
    [selectedTF setBackground:[UIImage imageNamed:@"DD_or_TF.png"]];
        
    [productSelection dismissPopoverAnimated:YES];
    
    
    selectedTF.text = targetNPProduct.product;
    
       
//    (Q2 divide Rate of P for product Q5 (refer to worksheet 2)) X 100
    
//    [self doCalculation];
    float rate = ([requiredPTF.text floatValue]/[targetNPProduct.compositionP floatValue])*100;
    if([targetNPProduct.product isEqual:@"Grazeburst"]||
       [targetNPProduct.product isEqual:@"Hayburst"]||
       [targetNPProduct.product isEqual:@"Springburst"]){
        rate = ([requiredNTF.text floatValue]/[targetNPProduct.compositionN floatValue])*100;
    
    }
    //A10 = Q1 – (A1 X Rate of N for product Q5 (re                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       fer to worksheet 2) divide 100) – A5 X 0.191
    
    //A5 = 0 If (A1 X Rate of S for Product Q5 (refer to worksheet 2) divide 100) > Q4, otherwise Q4 – (A1 X Rate of S for Product Q5 (refer to worksheet 2) divide 100) divided 0.218
    float graNS = 0;
    if ((rate * [targetNPProduct.compositionS floatValue]/100)<= [requiredSTF.text floatValue]) {
        graNS = ([requiredSTF.text floatValue]  - (rate * [targetNPProduct.compositionS floatValue]/100))/0.218;
    }
    
    float additionalN = ([requiredNTF.text floatValue] - (rate *[targetNPProduct.compositionN floatValue]/100)) - (graNS *0.191);
    
    float additionalUrea = 0;
    float additionalFlexiN = 0;
    if (additionalN>0) {
        additionalUrea = additionalN/0.46;
        additionalFlexiN = additionalN/0.42;
    }
    float mopRate =0;
    //A1 X Rate of K for product Q5 (refer to worksheet 2) divide 100
    float mopRateCondition = (rate * [targetNPProduct.compositionK floatValue]) /100;
   
    if (mopRateCondition < [requiredKTF.text floatValue]) {
        //Q3 – (A1X Rate of K for product Q5 (refer to worksheet 2) divide 100) divided 0.495
        mopRate = ([requiredKTF.text floatValue] -mopRateCondition)/0.495;
    }
    if (mopRate <=0) {
        mopRate = 0;
    }
    if (graNS <=0) {
        graNS = 0;
    }
    
    float totalN = rate*[targetNPProduct.compositionN floatValue]/100 +(additionalUrea *0.46)+(graNS*0.191);
    float totalP = rate*[targetNPProduct.compositionP floatValue]/100 +(graNS*0.015);
    float totalK = rate*[targetNPProduct.compositionK floatValue]/100 +(mopRate *0.495);
    float totalS = rate*[targetNPProduct.compositionS floatValue]/100 +(graNS*0.218);
    
    if ([selectedTF.text isEqualToString:@"Select Fertiliser Product"]) {
        
        [selectedTF setText:nil];
        [selectedTF setBackground:[UIImage imageNamed:@"DD_Select_Fertiliser.png"]];
        
        totalN = 0;
        totalP = 0;
        totalK = 0;
        totalS = 0;
        
        additionalUrea = 0;
        additionalFlexiN =0;
        mopRate = 0;
        graNS = 0;
        
        rate = 0;
    }
    
    selectedNLbl.text = [NSString stringWithFormat:@"%.1f", totalN];
    selectedPLbl.text = [NSString stringWithFormat:@"%.1f", totalP];
    selectedKLbl.text = [NSString stringWithFormat:@"%.1f", totalK];
    selectedSLbl.text = [NSString stringWithFormat:@"%.1f", totalS];
    
    selectedUreaLbl.text = [NSString stringWithFormat:@"%.0f",additionalUrea];
    selectedFlexiNLbl.text = [NSString stringWithFormat:@"%.0f",additionalFlexiN];
    selectedKMOPLbl.text = [NSString stringWithFormat:@"%.0f",mopRate];
    selectedGRaNSLbl.text = [NSString stringWithFormat:@"%.0f",graNS];
    
    selectedRateLbl.text = [NSString stringWithFormat:@"%.0f",rate];

}
-(void)doCalculation{
    NutrientCalculatorProduct *targetNPProduct;
    
    UILabel *selectedNLbl;
    UILabel *selectedKLbl;
    UILabel *selectedPLbl;
    UILabel *selectedSLbl;
    
    UILabel *selectedRateLbl;
    UILabel *selectedUreaLbl;
    UILabel *selectedFlexiNLbl;
    UILabel *selectedKMOPLbl;
    UILabel *selectedGRaNSLbl;
    
    
    for (UILabel *changingLbl in allLabel) {
        NSMutableDictionary *singleData;
            switch (changingLbl.tag) {
                case 0:
                    selectedNLbl = productN1;
                    selectedPLbl = productP1;
                    selectedKLbl = productK1;
                    selectedSLbl = productS1;
                    
                    selectedRateLbl = rateToBeApplied1;
                    selectedUreaLbl = urea1;
                    selectedFlexiNLbl = flexiN1;
                    selectedKMOPLbl = kMOP1;
                    selectedGRaNSLbl = sGRaNS1;
                    if (targetNP1==nil) {
                        return;
                    }
                    targetNPProduct = targetNP1;
                    singleData = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  selectedNLbl,@"selectedNLbl", 
                                  selectedPLbl,@"selectedPLbl",
                                  selectedKLbl,@"selectedKLbl",
                                  selectedSLbl,@"selectedSLbl",
                                  selectedRateLbl,@"selectedRateLbl",
                                  selectedUreaLbl,@"selectedUreaLbl",
                                  selectedFlexiNLbl,@"selectedFlexiNLbl",
                                  selectedKMOPLbl,@"selectedKMOPLbl",
                                  selectedGRaNSLbl,@"selectedGRaNSLbl",
                                  targetNPProduct,@"targetNPProduct",
                                  nil];
                    [self calculateSingleNP:singleData];
                    [Flurry logEvent:[NSString stringWithFormat:@"Calculate Target N and P for %@ as first product", targetNPProduct.product]];
                    break;
                case 1:
                    selectedNLbl = productN2;
                    selectedPLbl = productP2;
                    selectedKLbl = productK2;
                    selectedSLbl = productS2;
                    
                    selectedRateLbl = rateToBeApplied2;
                    selectedUreaLbl = urea2;
                    selectedFlexiNLbl = flexiN2;
                    selectedKMOPLbl = kMOP2;
                    selectedGRaNSLbl = sGRaNS2;
                    if (targetNP2==nil) {
                        return;
                    }
                    targetNPProduct = targetNP2;
                    singleData = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  selectedNLbl,@"selectedNLbl", 
                                  selectedPLbl,@"selectedPLbl",
                                  selectedKLbl,@"selectedKLbl",
                                  selectedSLbl,@"selectedSLbl",
                                  selectedRateLbl,@"selectedRateLbl",
                                  selectedUreaLbl,@"selectedUreaLbl",
                                  selectedFlexiNLbl,@"selectedFlexiNLbl",
                                  selectedKMOPLbl,@"selectedKMOPLbl",
                                  selectedGRaNSLbl,@"selectedGRaNSLbl",
                                  targetNPProduct,@"targetNPProduct",
                                  nil];
                    [self calculateSingleNP:singleData];
                    [Flurry logEvent:[NSString stringWithFormat:@"Calculate Target N and P for %@ as second product", targetNPProduct.product]];

                    break;
                case 2:
                    selectedNLbl = productN3;
                    selectedPLbl = productP3;
                    selectedKLbl = productK3;
                    selectedSLbl = productS3;
                    
                    selectedRateLbl = rateToBeApplied3;
                    selectedUreaLbl = urea3;
                    selectedFlexiNLbl = flexiN3;
                    selectedKMOPLbl = kMOP3;
                    selectedGRaNSLbl = sGRaNS3;
                    if (targetNP3==nil) {
                        return;
                    }
                    targetNPProduct = targetNP3;
                    singleData = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  selectedNLbl,@"selectedNLbl", 
                                  selectedPLbl,@"selectedPLbl",
                                  selectedKLbl,@"selectedKLbl",
                                  selectedSLbl,@"selectedSLbl",
                                  selectedRateLbl,@"selectedRateLbl",
                                  selectedUreaLbl,@"selectedUreaLbl",
                                  selectedFlexiNLbl,@"selectedFlexiNLbl",
                                  selectedKMOPLbl,@"selectedKMOPLbl",
                                  selectedGRaNSLbl,@"selectedGRaNSLbl",
                                  targetNPProduct,@"targetNPProduct",
                                  nil];
                    [self calculateSingleNP:singleData];
                    [Flurry logEvent:[NSString stringWithFormat:@"Calculate Target N and P for %@ as third product", targetNPProduct.product]];

                    break;
                case 3:
                    selectedNLbl = productN4;
                    selectedPLbl = productP4;
                    selectedKLbl = productK4;
                    selectedSLbl = productS4;
                    
                    selectedRateLbl = rateToBeApplied4;
                    selectedUreaLbl = urea4;
                    selectedFlexiNLbl = flexiN4;
                    selectedKMOPLbl = kMOP4;
                    selectedGRaNSLbl = sGRaNS4;
                    if (targetNP4==nil) {
                        return;
                    }
                    targetNPProduct = targetNP4;
                    singleData = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  selectedNLbl,@"selectedNLbl", 
                                  selectedPLbl,@"selectedPLbl",
                                  selectedKLbl,@"selectedKLbl",
                                  selectedSLbl,@"selectedSLbl",
                                  selectedRateLbl,@"selectedRateLbl",
                                  selectedUreaLbl,@"selectedUreaLbl",
                                  selectedFlexiNLbl,@"selectedFlexiNLbl",
                                  selectedKMOPLbl,@"selectedKMOPLbl",
                                  selectedGRaNSLbl,@"selectedGRaNSLbl",
                                  targetNPProduct,@"targetNPProduct",
                                  nil];
                    [self calculateSingleNP:singleData];
                    [Flurry logEvent:[NSString stringWithFormat:@"Calculate Target N and P for %@ as fourth product", targetNPProduct.product]];

                    break;
                default:
                    break;
            }
        
        
        

    }
}
    
-(void)calculateSingleNP:(NSDictionary *)singleData{
    NutrientCalculatorProduct *targetNPProduct;
    
    UILabel *selectedNLbl;
    UILabel *selectedKLbl;
    UILabel *selectedPLbl;
    UILabel *selectedSLbl;
    
    UILabel *selectedRateLbl;
    UILabel *selectedUreaLbl;
    UILabel *selectedFlexiNLbl;
    UILabel *selectedKMOPLbl;
    UILabel *selectedGRaNSLbl;
    
    selectedNLbl = [singleData objectForKey:@"selectedNLbl"];
    selectedPLbl =  [singleData objectForKey:@"selectedPLbl"];
    selectedKLbl =  [singleData objectForKey:@"selectedKLbl"];
    selectedSLbl =  [singleData objectForKey:@"selectedSLbl"];
    
    selectedRateLbl =  [singleData objectForKey:@"selectedRateLbl"];
    selectedUreaLbl =  [singleData objectForKey:@"selectedUreaLbl"];
    selectedFlexiNLbl =  [singleData objectForKey:@"selectedFlexiNLbl"];
    selectedKMOPLbl =  [singleData objectForKey:@"selectedKMOPLbl"];
    selectedGRaNSLbl =  [singleData objectForKey:@"selectedGRaNSLbl"];
    
    targetNPProduct =  [singleData objectForKey:@"targetNPProduct"];
    
    float rate = ([requiredPTF.text floatValue]/[targetNPProduct.compositionP floatValue])*100;
    selectedRateLbl.text = [NSString stringWithFormat:@"%.0f",rate];
    //A10 = Q1 – (A1 X Rate of N for product Q5 (re                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       fer to worksheet 2) divide 100) – A5 X 0.191
    
    //A5 = 0 If (A1 X Rate of S for Product Q5 (refer to worksheet 2) divide 100) > Q4, otherwise Q4 – (A1 X Rate of S for Product Q5 (refer to worksheet 2) divide 100) divided 0.218
    float graNS = 0;
    if ((rate * [targetNPProduct.compositionS floatValue]/100)<= [requiredSTF.text floatValue]) {
        graNS = ([requiredSTF.text floatValue]  - (rate * [targetNPProduct.compositionS floatValue]/100))/0.218;
    }
    
    float additionalN = ([requiredNTF.text floatValue] - (rate *[targetNPProduct.compositionN floatValue]/100)) - (graNS *0.191);
    
    float additionalUrea = 0;
    float additionalFlexiN = 0;
    if (additionalN>0) {
        additionalUrea = additionalN/0.46;
        additionalFlexiN = additionalN/0.42;
    }
    float mopRate =0;
    //A1 X Rate of K for product Q5 (refer to worksheet 2) divide 100
    float mopRateCondition = (rate * [targetNPProduct.compositionK floatValue]) /100;
    
    if (mopRateCondition < [requiredKTF.text floatValue]) {
        //Q3 – (A1X Rate of K for product Q5 (refer to worksheet 2) divide 100) divided 0.495
        mopRate = ([requiredKTF.text floatValue] -mopRateCondition)/0.495;
    }
    if (mopRate <=0) {
        mopRate = 0;
    }
    if (graNS <=0) {
        graNS = 0;
    }
    
    float totalN = rate*[targetNPProduct.compositionN floatValue]/100 +(additionalUrea *0.46)+(graNS*0.191);
    float totalP = rate*[targetNPProduct.compositionP floatValue]/100 +(graNS*0.015);
    float totalK = rate*[targetNPProduct.compositionK floatValue]/100 +(mopRate *0.495);
    float totalS = rate*[targetNPProduct.compositionS floatValue]/100 +(graNS*0.218);
    
    
    
    selectedNLbl.text = [NSString stringWithFormat:@"%.1f", totalN];
    selectedPLbl.text = [NSString stringWithFormat:@"%.1f", totalP];
    selectedKLbl.text = [NSString stringWithFormat:@"%.1f", totalK];
    selectedSLbl.text = [NSString stringWithFormat:@"%.1f", totalS];
    
    selectedUreaLbl.text = [NSString stringWithFormat:@"%.0f",additionalUrea];
    selectedFlexiNLbl.text = [NSString stringWithFormat:@"%.0f",additionalFlexiN];
    selectedKMOPLbl.text = [NSString stringWithFormat:@"%.0f",mopRate];
    selectedGRaNSLbl.text = [NSString stringWithFormat:@"%.0f",graNS];
}
    
    
    

#pragma mark - terms and Condition
-(IBAction)termsAndConditionDidSelected:(id)sender{
    termAndConditionView.hidden = NO;
    termConditionIsActive = YES;
    [Flurry logEvent:@"Open Terms and Conditions"];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    
    if (termConditionIsActive) {
        termAndConditionView.hidden = YES;
        [Flurry logEvent:@"Close Terms and Conditions"];
    }
    [super touchesBegan:touches withEvent:event];
}
@end
