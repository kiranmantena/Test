//
//  NKLevelsViewController.m
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 7/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NKLevelsViewController.h"
#import "CommonFunctions.h"
@interface NKLevelsViewController ()
-(void)doNKCalculation;
-(void)checkNKLevels;
-(void)resetView;
@end

@implementation NKLevelsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)resetView{
    nLevelBG.image = [UIImage imageNamed:@"Box_Safe.png"];
    nLevelValue.text = @"0";
    nLevelStatus.text = @"Safe";
    
    kLevelBG.image = [UIImage imageNamed:@"Box_Safe.png"];
    kLevelValue.text =@"0";
    kLevelStatus.text =@"Safe";
    
    seedBedIsWet = YES;
    fertilizerIsSplit = YES;
    bandedNitrogenIsBelow = YES;
    isKWithSeed = YES;
    isKBandedBelow = YES;
    
    bandingDepth.enabled = YES;
    [bandingDepth setUserInteractionEnabled:YES];
    bandingDepth.minimumTrackTintColor = nil;
    
    depthLabel.text = [NSString stringWithFormat:@"%.1fcm",bandingDepth.value*0.5];
    depthLabel.textColor = RGBCOLOR(224, 121, 11);
    bandingDepthTitle.textColor = [UIColor whiteColor];
    
    compoundProduct.text = nil;
    [compoundProduct setBackground:[UIImage imageNamed:@"DD_Select_Compoud.png"]];
    bandingProduct.text = nil;
    [bandingProduct setBackground:[UIImage imageNamed:@"DD_SelectN.png"]];
    kProduct.text = nil;
    [kProduct setBackground:[UIImage imageNamed:@"DD_SelectK.png"]];
    seedType.text = nil;
    [seedType setBackground:[UIImage imageNamed:@"DD_Select_TypeofSeed.png"]];
    
    
    compoundRate.text = nil;
    [compoundRate setBackground:[UIImage imageNamed:@"TF_Rate_Applied.png"]];
    bandingRate.text = nil;
    [bandingRate setBackground:[UIImage imageNamed:@"TF_Rate_Applied.png"]];
    kRate.text = nil;
    [kRate setBackground:[UIImage imageNamed:@"TF_Rate_Applied.png"]];
    
    termConditionIsActive = NO;
    termAndConditionView.hidden = YES;
    
    int rawValue = (int)[rowSpacing value];
    float accurateValue = rawValue*0.5;
    //    rowSpacing.value = accurateValue;
    //    NSLog(@"accurateValue:%.1f\n",accurateValue);
    
    float rowSpacingValue = accurateValue *5;
    rowSpacingLbl.text = [NSString stringWithFormat:@"%.1fcm",rowSpacingValue];
    
    //    if (numberOfRow ==nil) {
    //        numberOfRow = [[NSNumber alloc] init];
    //    }
    numberOfRow = [NSNumber numberWithFloat:100/rowSpacingValue];
    [numberOfRow retain];
}
-(void)viewWillAppear:(BOOL)animated{

//    [self resetView];
    

    
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    seedBedIsWet = YES;
    fertilizerIsSplit = YES;
    bandedNitrogenIsBelow = YES;
    isFirstOpen = YES;
    //    isKWithSeed = YES;
    //    isKBandedBelow = YES;
    
    bandingDepth.enabled = YES;
    [bandingDepth setUserInteractionEnabled:YES];
    bandingDepth.minimumTrackTintColor = nil;
    
    
    depthLabel.text = [NSString stringWithFormat:@"%.1fcm",bandingDepth.value*0.5];
    depthLabel.textColor = RGBCOLOR(224, 121, 11);
    bandingDepthTitle.textColor = [UIColor whiteColor];
    allProduct = [Application.dataManager getAllNKCompound];
    [allProduct retain];
    
    NBandingArray = [Application.dataManager getAllBandingNProduct];
    [NBandingArray retain];
    
    KProductArray = [Application.dataManager getAllKProduct];
    [KProductArray retain];
    
    seedTypeArray = [NSArray arrayWithObjects:@"Choose type of seed",@"Canola", @"Wheat", @"Barley", @"Oats", @"Lupins", @"Peas", @"Beans", nil];
    [seedTypeArray retain];
    
    seedType.text = @"Wheat";
    [seedType setBackground:[UIImage imageNamed:@"DD_or_TF.png"]];
    
    [splitAway addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    [rowSpacing addTarget:self action:@selector(rowChanged:) forControlEvents:UIControlEventValueChanged];
    [bandingDepth addTarget:self action:@selector(bandingDepthChanged:) forControlEvents:UIControlEventValueChanged];
    
    nLevelBG.image = [UIImage imageNamed:@"Box_Safe.png"];
    nLevelValue.text = @"0";
    nLevelStatus.text = @"Safe";
    
    kLevelBG.image = [UIImage imageNamed:@"Box_Safe.png"];
    kLevelValue.text =@"0";
    kLevelStatus.text =@"Safe";
    termConditionIsActive = NO;
    termAndConditionView.hidden = YES;
    
    int rawValue = (int)[rowSpacing value];
    float accurateValue = rawValue*0.5;
    //    rowSpacing.value = accurateValue;
    //    NSLog(@"accurateValue:%.1f\n",accurateValue);
    
    float rowSpacingValue = accurateValue *5;
    rowSpacingLbl.text = [NSString stringWithFormat:@"%.1fcm",rowSpacingValue];
    splitPercentage = [NSNumber numberWithFloat:[splitAwayLbl.text floatValue]/100];
    [splitPercentage retain];
    //    if (numberOfRow ==nil) {
    //        numberOfRow = [[NSNumber alloc] init];
    //    }
    isKWithSeed = YES;
    isKBandedBelow = YES;
    numberOfRow = [NSNumber numberWithFloat:100/rowSpacingValue];
    [numberOfRow retain];
    
    if (kProduct.text.length <=0 ) {
        kWithSeedOnOff.enabled = NO;
        kBandedBelowOnOff.enabled = NO;
//        isKWithSeed = NO;
//        isKBandedBelow = NO;
        [kWithSeedOnOff setOn:NO animated:YES];
        [kWithSeedOnOff setUserInteractionEnabled:NO];
        
//        [kBandedBelowOnOff setOn:NO animated:YES];
        [kBandedBelowOnOff setUserInteractionEnabled:NO];
    }
    
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - slider
-(void)sliderChanged:(UISlider *)slider{
    int value = (int)[splitAway value];
    int stepSize = 10;
    value = (value - value % stepSize);
    
    splitAway.value = value;
    splitAwayLbl.text = [NSString stringWithFormat:@"%g %%",splitAway.value];
    splitPercentage = [NSNumber numberWithFloat:[splitAwayLbl.text floatValue]/100];
    [splitPercentage retain];
    [self doNKCalculation];
}
-(void)rowChanged:(UISlider *)slider{
    int rawValue = (int)[rowSpacing value];
    float accurateValue = rawValue*0.5;
//    rowSpacing.value = accurateValue;
//    NSLog(@"accurateValue:%.1f\n",accurateValue);
    
    float rowSpacingValue = accurateValue *5;
    rowSpacingLbl.text = [NSString stringWithFormat:@"%.1fcm",rowSpacingValue];
    
//    if (numberOfRow ==nil) {
//        numberOfRow = [[NSNumber alloc] init];
//    }
    numberOfRow = [NSNumber numberWithFloat:100/rowSpacingValue];
    [numberOfRow retain];
    [self doNKCalculation];
    
}
-(void)bandingDepthChanged:(UISlider *)slider{
//    bandingDepth.value = round(bandingDepth.value);
    int valueRaw = (int)[bandingDepth value];
    float value = valueRaw *0.5;
    if (value<=0.5) {
        value = 0.5;
    }
    [bandingDepth setValue:valueRaw];
    
    depthLabel.text = [NSString stringWithFormat:@"%.1fcm", value];
    depthCalcForN = [NSNumber numberWithFloat:value];
    [depthCalcForN retain];
    [self doNKCalculation];
}
#pragma mark - drop down
-(IBAction)compoundDidSelected:(id)sender{
    UIButton *buttonSender = (UIButton*)sender;
    UIViewController* popoverContent = [[UIViewController alloc]
                                        init];
    UIView* popoverView = [[UIView alloc]
                           initWithFrame:CGRectMake(0, 0, 300, 400)];
    
    UIPickerView *productSelectionPicker = [[UIPickerView alloc] initWithFrame:popoverView.frame];
    productSelectionPicker.delegate = self;
    productSelectionPicker.dataSource = self;
    productSelectionPicker.tag = 0;
    
    productSelectionPicker.showsSelectionIndicator = YES;
    selectedTag = buttonSender.tag;
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
    else {
        if ([productSelection contentViewController]!=nil) {
            [[productSelection contentViewController ] removeFromParentViewController];
            [[productSelection contentViewController] addChildViewController:popoverContent];
        }
    }
    [productSelection presentPopoverFromRect:compoundProduct.frame inView:self.contentView  permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
    
    //release the popover content
    [popoverView release];
    [popoverContent release];
}

-(IBAction)bandingDidSelected:(id)sender{
    UIButton *buttonSender = (UIButton*)sender;
    UIViewController* popoverContent = [[UIViewController alloc]
                                        init];
    UIView* popoverView = [[UIView alloc]
                           initWithFrame:CGRectMake(0, 0, 300, 400)];
    
    UIPickerView *productSelectionPicker = [[UIPickerView alloc] initWithFrame:popoverView.frame];
    productSelectionPicker.delegate = self;
    productSelectionPicker.dataSource = self;
    
    productSelectionPicker.showsSelectionIndicator = YES;
    productSelectionPicker.tag = 1;
    selectedTag = buttonSender.tag;
    [popoverView addSubview:productSelectionPicker];
    
    popoverContent.view = popoverView;
    
    //resize the popover view shown
    //in the current view to the view's size
    popoverContent.contentSizeForViewInPopover =
    CGSizeMake(300, 200);
    
    if (nBandingProductSelection ==nil) {
        //create a popover controller
        nBandingProductSelection = [[UIPopoverController alloc]
                            initWithContentViewController:popoverContent];
    }
    
    [nBandingProductSelection presentPopoverFromRect:bandingProduct.frame inView:self.contentView  permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
    
    //release the popover content
    [popoverView release];
    [popoverContent release];
}

-(IBAction)kDidSelected:(id)sender{
    UIButton *buttonSender = (UIButton*)sender;
    UIViewController* popoverContent = [[UIViewController alloc]
                                        init];
    UIView* popoverView = [[UIView alloc]
                           initWithFrame:CGRectMake(0, 0, 300, 400)];
    
    UIPickerView *productSelectionPicker = [[UIPickerView alloc] initWithFrame:popoverView.frame];
    productSelectionPicker.delegate = self;
    productSelectionPicker.dataSource = self;
    productSelectionPicker.tag = 2;
    
    productSelectionPicker.showsSelectionIndicator = YES;
    selectedTag = buttonSender.tag;
    [popoverView addSubview:productSelectionPicker];
    
    popoverContent.view = popoverView;
    
    //resize the popover view shown
    //in the current view to the view's size
    popoverContent.contentSizeForViewInPopover =
    CGSizeMake(300, 200);
    
   
    if (kProductSelection ==nil) {
        //create a popover controller
        kProductSelection = [[UIPopoverController alloc]
                            initWithContentViewController:popoverContent];
    }
    
    [kProductSelection presentPopoverFromRect:kProduct.frame inView:self.contentView  permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
    
    //release the popover content
    [popoverView release];
    [popoverContent release];
}

-(IBAction)typeOfSeedDidSelected:(id)sender{
    UIButton *buttonSender = (UIButton*)sender;
    UIViewController* popoverContent = [[UIViewController alloc]
                                        init];
    UIView* popoverView = [[UIView alloc]
                           initWithFrame:CGRectMake(0, 0, 300, 400)];
    
    UIPickerView *productSelectionPicker = [[UIPickerView alloc] initWithFrame:popoverView.frame];
    productSelectionPicker.delegate = self;
    productSelectionPicker.dataSource = self;
    productSelectionPicker.tag = 3;
    if (isFirstOpen) {
        isFirstOpen = !isFirstOpen;
        [productSelectionPicker selectRow:2 inComponent:0 animated:NO];
    }
    productSelectionPicker.showsSelectionIndicator = YES;
    selectedTag = buttonSender.tag;
    [popoverView addSubview:productSelectionPicker];
    
    popoverContent.view = popoverView;
    
    //resize the popover view shown
    //in the current view to the view's size
    popoverContent.contentSizeForViewInPopover =
    CGSizeMake(300, 200);
    
    
    if (seedProductSelection ==nil) {
        //create a popover controller
        seedProductSelection = [[UIPopoverController alloc]
                            initWithContentViewController:popoverContent];
    }
    
    [seedProductSelection presentPopoverFromRect:seedType.frame inView:self.contentView  permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    
    
    //release the popover content
    [popoverView release];
    [popoverContent release];
}
#pragma mark -
#pragma mark UITextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag <4) {
        return NO;
    }
    [textField setBackground:[UIImage imageNamed:@"DD_or_TF.png"]];
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    
    if (textField.text.length <=0) {
        
        switch (textField.tag) {
            case 4:
                compoundRate.text = nil;
                [compoundRate setBackground:[UIImage imageNamed:@"TF_Rate_Applied.png"]];
                break;
            case 5:
                bandingRate.text = nil;
                [bandingRate setBackground:[UIImage imageNamed:@"TF_Rate_Applied.png"]];
                break;
            case 6:
                kRate.text = nil;
                [kRate setBackground:[UIImage imageNamed:@"TF_Rate_Applied.png"]];
                break;
            default:
                break;
        }
        
        
        
        
    }
    
    [self doNKCalculation];
    
}
#pragma mark - Calculation
-(void)doNKCalculation{
    
    
    //N Calculation
    float compoundPerHectare = [compoundProductObject.compositionN floatValue] * ([compoundRate.text floatValue]/100);
    float A1 = compoundPerHectare;
    
    float bandedNPerHectare = [nBandingObject.compositionN floatValue] * ([bandingRate.text floatValue]/100);
    float A2 = bandedNPerHectare;
    
    float A3 = A1+A2;
    nLevelValue.text = [NSString stringWithFormat:@"%.2f",A3];
    
    float A4 = [compoundProductObject.compositionK floatValue]* ([compoundRate.text floatValue]/100);

    float A5 = [kProductObject.compositionK floatValue] * ([kRate.text floatValue]/100);
    
    float A5a;
    
    
    if ([nBandingObject.product hasPrefix:@"Flexi-NK"]||
        [nBandingObject.product hasPrefix:@"NK"]||
        [nBandingObject.product hasPrefix:@"NKS"]) {
        A5a = [nBandingObject.compositionK floatValue] * ([bandingRate.text floatValue]/100);
    }
    else{
        A5a=0;
    }
    
    float A6 = A4+A5+A5a;
    
    float A12 = [numberOfRow floatValue];
    
    float A13 = A1/A12;
    float A14 = A2/A12;
    float A15 = A4/A12;
    float A16 = A5/A12;
    float A17 = A6/A12;
    
    float bandingNPerRowValue = bandedNPerHectare/[numberOfRow floatValue];
    bandingNPerRow= [NSNumber numberWithFloat:bandingNPerRowValue];
    

    
    if(compoundN ==nil)
        compoundN = [[NSNumber alloc] init];
    compoundN = [NSNumber numberWithFloat:compoundPerHectare];
    if (compoundNPerRow == nil) {
        compoundNPerRow = [[NSNumber alloc] init];
    }
    
    float compoundNPerRowValue =compoundPerHectare/[numberOfRow floatValue];
    float A18;
    
    float A25;
    if (seedBedIsWet) {
        A18 = A13 - (0.25*A13);
        A25 = A15 - (0.15*A15);
    }
    else {
        A18 = A13;
        A25 = A15;
    }
    
    float A19 = A18;
    float A20 = [splitPercentage floatValue];
    
    float A26 = A25;
    if (fertilizerIsSplit) {
        A19 = A18 - (A20* A18);
        compoundNPerRowValue *= compoundNPerRowValue - ([splitPercentage floatValue]*compoundNPerRowValue);
        A26 = A25 -(A20*A25);
    }
    float A21;
    float A22;
    
    
    
    if (bandedNitrogenIsBelow) {
        A21 = A19;
       
        if (A14<=0) {
            A22 = A21;
        }
        else if(A14>0){
            if ([depthCalcForN floatValue]<2.5) {
                A22 = (A21 +5) +A21;
            }
            else{
                A22 = A21;
            }
        }
    }
    else {
        A21 = A14+A19;
        A22 = A21;
    }
    
    if (!bandedNitrogenIsBelow) {
//        NSLog(@"%lf",compoundNPerRowValue);
        compoundNPerRowValue += bandingNPerRowValue;
//        NSLog(@"%lf",compoundNPerRowValue);
    }
    else {
        if (bandingNPerRowValue>0) {
            if ([depthCalcForN floatValue]<2.5) {
                compoundNPerRowValue = (compoundNPerRowValue+5)+compoundNPerRowValue;
            }
        }
    }
    float A23 = A22;
    if ([seedType.text isEqualToString:@"Canola"]) {
        A23 = A22 +(0.15*A22);
        compoundNPerRowValue += 0.15*compoundNPerRowValue;
    }
    
//    finalNValue = [NSNumber numberWithFloat:compoundNPerRowValue];
    finalNValue = [NSNumber numberWithFloat:A23];
    [finalNValue retain];
    
    
    //K calculation
    
    
    float compoundKPerHectare = [compoundProductObject.compositionK floatValue] * [compoundRate.text floatValue]/100;
    if (compoundK == nil) {
        compoundK = [[NSNumber alloc] init];
    }
    kLevelValue.text = [NSString stringWithFormat:@"%.2f",A6];
    compoundK = [NSNumber numberWithFloat:compoundKPerHectare];
    
    float suppliesKPerHectare = [kProductObject.compositionK floatValue] * [kRate.text floatValue]/100;
   
    if (bandingK ==nil) {
        bandingK = [[NSNumber alloc] init];
    }
    bandingK = [NSNumber numberWithFloat:suppliesKPerHectare];
    
    float KLevelSupplied =compoundKPerHectare + suppliesKPerHectare;
    if (kLevels ==nil) {
        kLevels = [[NSNumber alloc] init];
    }
    kLevels = [NSNumber numberWithFloat:KLevelSupplied];
    
    if (compoundKPerRow ==nil) {
        compoundKPerRow = [[NSNumber alloc] init];
    }
    float compoundKPerRowVal = compoundKPerHectare/[numberOfRow floatValue];
//    NSLog(@"%lf numberofrow:%lf",compoundKPerRowVal,[numberOfRow floatValue]);
    compoundKPerRowVal = compoundKPerHectare/compoundKPerRowVal;
    
    compoundKPerRow =[NSNumber numberWithFloat:compoundKPerRowVal];
    
    if (bandingKPerRow == nil) {
        bandingKPerRow = [[NSNumber alloc] init];
    }
    float bandingKPerRowVal = suppliesKPerHectare/[numberOfRow floatValue];
    
    bandingKPerRow = [NSNumber numberWithFloat:bandingKPerRowVal];
    
    if (kgKPerRow == nil) {
        kgKPerRow = [[NSNumber alloc] init];
    }
    float kgKPerRowVal = KLevelSupplied/[numberOfRow floatValue];
    kgKPerRow = [NSNumber numberWithFloat:kgKPerRowVal];
    
    if (seedBedIsWet) {
        compoundKPerRowVal = compoundKPerRowVal -(0.15*compoundKPerRowVal);
    }
    if (fertilizerIsSplit) {
        compoundKPerRowVal = compoundKPerRowVal - [splitPercentage floatValue]*compoundKPerRowVal;
    }
    float A27= A26;
    if (isKWithSeed) {
        compoundKPerRowVal = bandingKPerRowVal + compoundKPerRowVal;
        A27 = A16+A26;
    }
    float A28;
    if (!isKBandedBelow) {
        compoundKPerRowVal = kgKPerRowVal +5 +compoundKPerRowVal;
        A28 = (A17 +5 )+A27;
    }
    else {
        compoundKPerRowVal = bandingKPerRowVal + compoundKPerRowVal;
        A28 = A16+A27;
    }
    float A29 = A28;
    if ([seedType.text isEqualToString:@"Canola"]) {
        compoundKPerRowVal += 0.15*compoundNPerRowValue;
        A29 = A28 +(0.15*A28);
    }
    
//    finalKValue = [[NSNumber alloc] initWithFloat:compoundKPerRowVal];
    finalKValue = [[NSNumber alloc] initWithFloat:A29];
    
//    NSLog(@"A1:%lf\nA2:%lf\nA3:%lf\nA4:%lf\nA5:%lf\nA5a:%lf\nA6:%lf\nA12:%lf\nA13:%lf\nA14:%lf\nA15:%lf\nA16:%lf\nA17:%lf\nA18:%lf\nA19:%lf\nA20:%lf\nA21:%lf\nA22:%lf\nA23:%lf\nA25:%lf\nA26:%lf\nA27:%lf\nA28:%lf\nA29:%lf\n",A1,A2,A3,A4,A5,A5a,A6,A12,A13,A14,A15,A16,A17,A18,A19,A20,A21,A22,A23,A25,A26,A27,A28,A29);
    
    [self checkNKLevels];
}
-(void)checkNKLevels{
    //check N Levels
    
    if ([finalNValue floatValue] >=4) {
        nLevelBG.image = [UIImage imageNamed:@"Box_Caution.png"];
        nLevelStatus.text =@"Caution Required";
        
    }
    else {
        nLevelBG.image = [UIImage imageNamed:@"Box_Safe.png"];
        nLevelStatus.text =@"Safe";
        
    }
    
    //check K Levels
//    NSLog(@"%lf",[finalKValue floatValue]);
    if ([finalKValue floatValue] >=3.2) {
        kLevelBG.image = [UIImage imageNamed:@"Box_Caution.png"];
        kLevelStatus.text =@"Caution Required";
            }
    else {
        kLevelBG.image = [UIImage imageNamed:@"Box_Safe.png"];
        kLevelStatus.text =@"Safe";
        
    }
    
}
#pragma mark-
#pragma mark UIPickerView Datasource and Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{


    switch (pickerView.tag) {
        case 0:
            return [allProduct count];
            break;
        case 1:
            return [NBandingArray count];
            break;
        case 2:
            return [KProductArray count];
            break;
        case 3:
            return [seedTypeArray count];
            break;
        default:
            break;
    }

    return 1;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    NutrientCalculatorProduct *product;
    NSString *result;
    
    switch (pickerView.tag) {
        case 0:
            product = [allProduct objectAtIndex:row];
            result =  product.product;
            break;
        case 1:
            product = [NBandingArray objectAtIndex:row];
            result = product.product;
            break;
        case 2:
            product = [KProductArray objectAtIndex:row];
            result = product.product;
            break;
        case 3:
            result = [seedTypeArray objectAtIndex:row];
            break;
        default:
            break;
    }
    
       return  result;
//    return @"Test";//nutrientCalculatorProduct.product;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NutrientCalculatorProduct *product;// = [allProduct objectAtIndex:row];
    NSString *selectedSeed;
    switch (selectedTag) {
        case 0:
            product = [allProduct objectAtIndex:row];
            if ([product.product isEqualToString:@"Select Compound Product"]) {
                compoundProduct.text = nil;
                [compoundProduct setBackground:[UIImage imageNamed:@"DD_Select_Compoud.png"]];
                
            }
            else{
                [Flurry logEvent:[NSString stringWithFormat:@"Select %@ as Compound Product",product.product]];
                compoundProduct.text = product.product;
                [compoundProduct setBackground:[UIImage imageNamed:@"DD_or_TF.png"]];
                compoundProductObject = product;
                [compoundProductObject retain];
            }
            break;
        case 1:
            product = [NBandingArray objectAtIndex:row];
            if ([product.product isEqualToString:@"Select Banding N Product"]) {
                bandingProduct.text = nil;
                [bandingProduct setBackground:[UIImage imageNamed:@"DD_SelectN.png"]];
                
            }
            else{
                [Flurry logEvent:[NSString stringWithFormat:@"Select %@ as Banding N Product",product.product]];
                bandingProduct.text = product.product;
                [bandingProduct setBackground:[UIImage imageNamed:@"DD_or_TF.png"]];
                nBandingObject = product;
                [nBandingObject retain];
            }
            break;
        case 2:
            product = [KProductArray objectAtIndex:row];
            if ([product.product isEqualToString:@"Select Banding K Product"]) {
                kProduct.text = nil;
                [kProduct setBackground:[UIImage imageNamed:@"DD_SelectK.png"]];
                
            }
            else{
                [Flurry logEvent:[NSString stringWithFormat:@"Select %@ as Banding K Product",product.product]];
                kProduct.text = product.product;
                [kProduct setBackground:[UIImage imageNamed:@"DD_or_TF.png"]];
                kProductObject = product;
                [kProductObject retain];
            }
            break;
        case 3:
            selectedSeed = [seedTypeArray objectAtIndex:row];
            if ([selectedSeed isEqualToString:@"Choose type of seed"]) {
                seedType.text = nil;
                [seedType setBackground:[UIImage imageNamed:@"DD_Select_TypeofSeed.png"]];

            }
            else{
                [Flurry logEvent:[NSString stringWithFormat:@"Select %@ as Type of Seed",selectedSeed]];
                seedType.text = selectedSeed;
                [seedType setBackground:[UIImage imageNamed:@"DD_or_TF.png"]];
            }
            break;
        default:
            break;
    }
    
    [productSelection dismissPopoverAnimated:YES];
    [kProductSelection dismissPopoverAnimated:YES];
    [nBandingProductSelection dismissPopoverAnimated:YES];
    [seedProductSelection dismissPopoverAnimated:YES];
    
    if (kProduct.text.length <=0 ) {
        kBandedBelowOnOff.enabled = NO;
        kWithSeedOnOff.enabled = NO;
//        isKWithSeed = NO;
//        isKBandedBelow = NO;
        [kWithSeedOnOff setOn:NO animated:YES];
        [kWithSeedOnOff setUserInteractionEnabled:NO];
        
//        [kBandedBelowOnOff setOn:NO animated:YES];
        [kBandedBelowOnOff setUserInteractionEnabled:NO];
    }
    else{
        kBandedBelowOnOff.enabled = YES;
        kWithSeedOnOff.enabled = YES;
        
        [kWithSeedOnOff setUserInteractionEnabled:YES];
        
        [kBandedBelowOnOff setUserInteractionEnabled:YES];
    }
    
    [self doNKCalculation];
    
}
#pragma mark - on off button
-(IBAction)onOffButton:(id)sender{
    bandedNitrogenIsBelow = !bandedNitrogenIsBelow;
    if(bandedNitrogenIsBelow){
        bandingDepth.enabled = YES;
        [bandingDepth setUserInteractionEnabled:YES];
        bandingDepth.minimumTrackTintColor = nil;
        int valueRaw = (int)[bandingDepth value];
        float value = valueRaw *0.5;
        if (value<=0.5) {
            value = 0.5;
        }
        [bandingDepth setValue:valueRaw];
        
        depthLabel.text = [NSString stringWithFormat:@"%.1fcm", value];
        depthLabel.textColor = RGBCOLOR(224, 121, 11);
        bandingDepthTitle.textColor = [UIColor whiteColor];
    }
    else{
        bandingDepth.enabled = NO;
        [bandingDepth setUserInteractionEnabled:NO];
        bandingDepth.minimumTrackTintColor = [UIColor darkGrayColor];
        depthLabel.text = @"N/A";
        depthLabel.textColor = [UIColor darkGrayColor];
        bandingDepthTitle.textColor = [UIColor darkGrayColor];
    }
    [self doNKCalculation];
}
-(IBAction)yesNoButton:(id)sender{
//    NSLog(fertilizerIsSplit ? @"Yes" : @"No");
    fertilizerIsSplit = !fertilizerIsSplit;
//    NSLog(fertilizerIsSplit ? @"Yes" : @"No");
    if(!fertilizerIsSplit ){//&& kProduct.text.length>0){
        splitAway.enabled = NO;
        [splitAway setUserInteractionEnabled:NO];
        splitAway.minimumTrackTintColor = [UIColor darkGrayColor];
        splitAwayLbl.text = @"N/A";
        splitAwayLbl.textColor = [UIColor darkGrayColor];
        splitAwayTitle.textColor = [UIColor darkGrayColor];
        
//        isKWithSeed = YES;
//        [kWithSeedOnOff setOn:YES animated:YES];
//        [kWithSeedOnOff setUserInteractionEnabled:NO];
    }
    else{
        
        splitAway.enabled = YES;
        [splitAway setUserInteractionEnabled:YES];
        splitAway.minimumTrackTintColor = nil;
        splitAwayLbl.text = [NSString stringWithFormat:@"%g %%",splitAway.value];
        splitAwayLbl.textColor = RGBCOLOR(224, 121, 11);
        splitAwayTitle.textColor = [UIColor whiteColor];
        
        [kWithSeedOnOff setUserInteractionEnabled:YES];
        
        
    }
    [self doNKCalculation];
}
-(IBAction)wetDryButton:(id)sender{
    seedBedIsWet = !seedBedIsWet;
    [self doNKCalculation];
}
-(IBAction)kWithSeed:(id)sender{
    isKWithSeed = !isKWithSeed;
    [self doNKCalculation];
}
-(IBAction)kBandedBelow:(id)sender{
    isKBandedBelow = !isKBandedBelow;
    [self doNKCalculation];
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
