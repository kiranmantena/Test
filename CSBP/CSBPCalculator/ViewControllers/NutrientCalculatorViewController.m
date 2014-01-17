//
//  NutrientCalculatorViewController.m
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NutrientCalculatorViewController.h"

@interface NutrientCalculatorViewController ()
-(void)doNutrientCalculation:(NSDictionary *)doCalculationDictionary;
@end

@implementation NutrientCalculatorViewController
@synthesize product1,product2,product3,product4;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        if (title ==nil) {
//            title = [[UILabel alloc] init];
//        }
        
    }
    return self;
}
-(id)init{
    
        self = [super init];
    
    
//    self.view.backgroundColor = [UIColor greenColor];]
    
    return self;
}
-(void)clearAllField{
    

    
    [productTF1 setText:nil];
    [productTF1 setBackground:[UIImage imageNamed:@"DD_Select_Fertiliser_Product.png"]];
    
    [productTF2 setText:nil];
    [productTF2 setBackground:[UIImage imageNamed:@"DD_Select_Fertiliser_Product.png"]];
    
    [productTF3 setText:nil];
    [productTF3 setBackground:[UIImage imageNamed:@"DD_Select_Fertiliser_Product.png"]];
    
    [productTF4 setText:nil];
    [productTF4 setBackground:[UIImage imageNamed:@"DD_Select_Fertiliser_Product.png"]];
    
    [productMultiplierTF1 setText:nil];
    [productMultiplierTF1 setBackground:[UIImage imageNamed:@"TF_Enter_Rate_Applied.png"]];
    
    [productMultiplierTF2 setText:nil];
    [productMultiplierTF2 setBackground:[UIImage imageNamed:@"TF_Enter_Rate_Applied.png"]];
    
    [productMultiplierTF3 setText:nil];
    [productMultiplierTF3 setBackground:[UIImage imageNamed:@"TF_Enter_Rate_Applied.png"]];
    
    [productMultiplierTF4 setText:nil];
    [productMultiplierTF4 setBackground:[UIImage imageNamed:@"TF_Enter_Rate_Applied.png"]];
    
    productResultLbl1.text =@"Fertiliser Product";
    productResultLbl2.text =@"Fertiliser Product";
    productResultLbl3.text =@"Fertiliser Product";
    productResultLbl4.text =@"Fertiliser Product";
    
    productResultLbl1.hidden = YES;
    productResultLbl2.hidden = YES;
    productResultLbl3.hidden = YES;
    productResultLbl4.hidden = YES;

    for (UILabel *productContentLabel in allLabel) {
        productContentLabel.text =@"0";
        productContentLabel.hidden = YES;
    }
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    
//    NSLog(@"Available fonts: %@", [UIFont familyNames]);
//    [self clearAllField];
    termConditionIsActive = NO;
    termAndConditionView.hidden = YES;
    
    
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad
{
    allProduct = [Application.dataManager getAllNutrientCalculator];
    [allProduct retain];
    
    allLabel = [NSArray arrayWithObjects:
                productPContent1,productPContent2,productPContent3,productPContent4,productPContentTotal,
                productNContent1,productNContent2,productNContent3,productNContent4,productNContentTotal,
                productKContent1,productKContent2,productKContent3,productKContent4,productKContentTotal,
                productSContent1,productSContent2,productSContent3,productSContent4,productSContentTotal,
                productCaContent1,productCaContent2,productCaContent3,productCaContent4,productCaContentTotal,
                productCuContent1,productCuContent2,productCuContent3,productCuContent4,productCuContentTotal,
                productZnContent1,productZnContent2,productZnContent3,productZnContent4,productZnContentTotal,
                productMoContent1,productMoContent2,productMoContent3,productMoContent4,productMoContentTotal,
                productMnContent1,productMnContent2,productMnContent3,productMnContent4,productMnContentTotal,nil];
    [allLabel retain];
    
    //solution for not calling resetview
    productResultLbl1.hidden = YES;
    productResultLbl2.hidden = YES;
    productResultLbl3.hidden = YES;
    productResultLbl4.hidden = YES;
    
    for (UILabel *productContentLabel in allLabel) {
        productContentLabel.text =@"0";
        productContentLabel.hidden = YES;
    }

    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(void)viewWillDisappear:(BOOL)animated{
     
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

-(IBAction)productDidSelected:(id)sender{
    UIButton *arrowButton = (UIButton *)sender;
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
        
    switch (arrowButton.tag) {
        case 0:
            showInView = productTF1;
            break;
        case 1:
            showInView = productTF2;
            break;
        case 2:
            showInView = productTF3;
            break;
        case 3:
            showInView = productTF4;
            break;
        default:
            break;
    }
    selectedTag = arrowButton.tag;
    
    [productSelection presentPopoverFromRect:showInView.frame inView:self.contentView  permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    

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
    switch (textField.tag) {
        case 4:
            
            productNContent1.text  = [NSString stringWithFormat:@"%.1f",([textField.text floatValue]*[product1.compositionN floatValue])/100];
            productNContent1.hidden = NO;
            productPContent1.text  = [NSString stringWithFormat:@"%.1f",([textField.text floatValue]*[product1.compositionP floatValue])/100];
             productPContent1.hidden = NO;
            productKContent1.text  = [NSString stringWithFormat:@"%.1f",([textField.text floatValue]*[product1.compositionK floatValue])/100];
             productKContent1.hidden = NO;
            productSContent1.text  = [NSString stringWithFormat:@"%.1f",([textField.text floatValue]*[product1.compositionS floatValue])/100];
             productSContent1.hidden = NO;
            productCaContent1.text  = [NSString stringWithFormat:@"%.1f",([textField.text floatValue]*[product1.compositionCa floatValue])/100];
             productCaContent1.hidden = NO;
            productCuContent1.text  = [NSString stringWithFormat:@"%.2f",([textField.text floatValue]*[product1.compositionCu floatValue])/100];
             productCuContent1.hidden = NO;
            productZnContent1.text  = [NSString stringWithFormat:@"%.2f",([textField.text floatValue]*[product1.compositionZn floatValue])/100];
             productZnContent1.hidden = NO;
            productMoContent1.text  = [NSString stringWithFormat:@"%.3f",([textField.text floatValue]*[product1.compositionMo floatValue])/100];
             productMoContent1.hidden = NO;
            productMnContent1.text  = [NSString stringWithFormat:@"%.2f",([textField.text floatValue]*[product1.compositionMn floatValue])/100];
            productMnContent1.hidden = NO;
            productResultLbl1.hidden = NO;
            if ([textField.text isEqualToString:@""] || [self.product1.product isEqualToString:@"Select Fertiliser Product"] || self.product1.product ==nil) {
                productNContent1.hidden = YES;
                productPContent1.hidden = YES;
                productKContent1.hidden = YES;
                productSContent1.hidden = YES;
                productCaContent1.hidden = YES;
                productCuContent1.hidden = YES;
                productZnContent1.hidden = YES;
                productMoContent1.hidden = YES;
                productMnContent1.hidden = YES;
                if ([self.product1.product isEqualToString:@"Select Fertiliser Product"] || self.product1.product ==nil) {
                     productResultLbl1.hidden = YES;
                }
                break;
            }
            break;
        case 5:
           
            productNContent2.text  = [NSString stringWithFormat:@"%.1f",([textField.text floatValue]*[product2.compositionN floatValue])/100];
            productNContent2.hidden = NO;
            productPContent2.text  = [NSString stringWithFormat:@"%.1f",([textField.text floatValue]*[product2.compositionP floatValue])/100];
            productPContent2.hidden = NO;
            productKContent2.text  = [NSString stringWithFormat:@"%.1f",([textField.text floatValue]*[product2.compositionK floatValue])/100];
            productKContent2.hidden = NO;
            productSContent2.text  = [NSString stringWithFormat:@"%.1f",([textField.text floatValue]*[product2.compositionS floatValue])/100];
            productSContent2.hidden = NO;
            productCaContent2.text  = [NSString stringWithFormat:@"%.1f",([textField.text floatValue]*[product2.compositionCa floatValue])/100];
            productCaContent2.hidden = NO;
            productCuContent2.text  = [NSString stringWithFormat:@"%.2f",([textField.text floatValue]*[product2.compositionCu floatValue])/100];
            productCuContent2.hidden = NO;
            productZnContent2.text  = [NSString stringWithFormat:@"%.2f",([textField.text floatValue]*[product2.compositionZn floatValue])/100];
            productZnContent2.hidden = NO;
            productMoContent2.text  = [NSString stringWithFormat:@"%.3f",([textField.text floatValue]*[product2.compositionMo floatValue])/100];
            productMoContent2.hidden = NO;
            productMnContent2.text  = [NSString stringWithFormat:@"%.2f",([textField.text floatValue]*[product2.compositionMn floatValue])/100];
            productMnContent2.hidden = NO;
            productResultLbl2.hidden = NO;
            if ([textField.text isEqualToString:@""] || [self.product2.product isEqualToString:@"Select Fertiliser Product"] || self.product2.product ==nil) {
                productNContent2.hidden = YES;
                productPContent2.hidden = YES;
                productKContent2.hidden = YES;
                productSContent2.hidden = YES;
                productCaContent2.hidden = YES;
                productCuContent2.hidden = YES;
                productZnContent2.hidden = YES;
                productMoContent2.hidden = YES;
                productMnContent2.hidden = YES;
                if ([self.product2.product isEqualToString:@"Select Fertiliser Product"] || self.product2.product ==nil) {
                    productResultLbl2.hidden = YES;
                }
                break;
            }
            break;
        case 6:
            productNContent3.text  = [NSString stringWithFormat:@"%.1f",([textField.text floatValue]*[product3.compositionN floatValue])/100];
            productNContent3.hidden = NO;
            productPContent3.text  = [NSString stringWithFormat:@"%.1f",([textField.text floatValue]*[product3.compositionP floatValue])/100];
            productPContent3.hidden = NO;
            productKContent3.text  = [NSString stringWithFormat:@"%.1f",([textField.text floatValue]*[product3.compositionK floatValue])/100];
            productKContent3.hidden = NO;
            productSContent3.text  = [NSString stringWithFormat:@"%.1f",([textField.text floatValue]*[product3.compositionS floatValue])/100];
            productSContent3.hidden = NO;
            productCaContent3.text  = [NSString stringWithFormat:@"%.1f",([textField.text floatValue]*[product3.compositionCa floatValue])/100];
            productCaContent3.hidden = NO;
            productCuContent3.text  = [NSString stringWithFormat:@"%.2f",([textField.text floatValue]*[product3.compositionCu floatValue])/100];
            productCuContent3.hidden = NO;
            productZnContent3.text  = [NSString stringWithFormat:@"%.2f",([textField.text floatValue]*[product3.compositionZn floatValue])/100];
            productZnContent3.hidden = NO;
            productMoContent3.text  = [NSString stringWithFormat:@"%.3f",([textField.text floatValue]*[product3.compositionMo floatValue])/100];
            productMoContent3.hidden = NO;
            productMnContent3.text  = [NSString stringWithFormat:@"%.2f",([textField.text floatValue]*[product3.compositionMn floatValue])/100];
            productMnContent3.hidden = NO;
            productResultLbl3.hidden = NO;
            if ([textField.text isEqualToString:@""] || [self.product3.product isEqualToString:@"Select Fertiliser Product"] || self.product3.product ==nil) {
                productNContent3.hidden = YES;
                productPContent3.hidden = YES;
                productKContent3.hidden = YES;
                productSContent3.hidden = YES;
                productCaContent3.hidden = YES;
                productCuContent3.hidden = YES;
                productZnContent3.hidden = YES;
                productMoContent3.hidden = YES;
                productMnContent3.hidden = YES;
                if ([self.product3.product isEqualToString:@"Select Fertiliser Product"] || self.product3.product ==nil) {
                    productResultLbl3.hidden = YES;
                }
                break;
            }

            break;
        case 7:
            
            productNContent4.text  = [NSString stringWithFormat:@"%.1f",([textField.text floatValue]*[product4.compositionN floatValue])/100];
            productNContent4.hidden = NO;
            productPContent4.text  = [NSString stringWithFormat:@"%.1f",([textField.text floatValue]*[product4.compositionP floatValue])/100];
            productPContent4.hidden = NO;
            productKContent4.text  = [NSString stringWithFormat:@"%.1f",([textField.text floatValue]*[product4.compositionK floatValue])/100];
            productKContent4.hidden = NO;
            productSContent4.text  = [NSString stringWithFormat:@"%.1f",([textField.text floatValue]*[product4.compositionS floatValue])/100];
            productSContent4.hidden = NO;
            productCaContent4.text  = [NSString stringWithFormat:@"%.1f",([textField.text floatValue]*[product4.compositionCa floatValue])/100];
            productCaContent4.hidden = NO;
            productCuContent4.text  = [NSString stringWithFormat:@"%.2f",([textField.text floatValue]*[product4.compositionCu floatValue])/100];
            productCuContent4.hidden = NO;
            productZnContent4.text  = [NSString stringWithFormat:@"%.2f",([textField.text floatValue]*[product4.compositionZn floatValue])/100];
            productZnContent4.hidden = NO;
            productMoContent4.text  = [NSString stringWithFormat:@"%.3f",([textField.text floatValue]*[product4.compositionMo floatValue])/100];
            productMoContent4.hidden = NO;
            productMnContent4.text  = [NSString stringWithFormat:@"%.2f",([textField.text floatValue]*[product4.compositionMn floatValue])/100];
            productMnContent4.hidden = NO;
            productResultLbl4.hidden = NO;
            if ([textField.text isEqualToString:@""] || [self.product4.product isEqualToString:@"Select Fertiliser Product"]|| self.product4.product ==nil) {
                productNContent4.hidden = YES;
                productPContent4.hidden = YES;
                productKContent4.hidden = YES;
                productSContent4.hidden = YES;
                productCaContent4.hidden = YES;
                productCuContent4.hidden = YES;
                productZnContent4.hidden = YES;
                productMoContent4.hidden = YES;
                productMnContent4.hidden = YES;
                if ([self.product4.product isEqualToString:@"Select Fertiliser Product"] || self.product4.product ==nil) {
                    productResultLbl4.hidden = YES;
                }
                break;
            }
            break;
        default:
            

            break;
    }
    if (textField.text.length <=0) {
        [textField setBackground:[UIImage imageNamed:@"TF_Enter_Rate_Applied.png"]];
        
    }
    float nTotal = [productNContent1.text floatValue]+[productNContent2.text floatValue] +[productNContent3.text floatValue] + [productNContent4.text floatValue];
    float pTotal = [productPContent1.text floatValue]+[productPContent2.text floatValue] +[productPContent3.text floatValue] + [productPContent4.text floatValue];
    float kTotal = [productKContent1.text floatValue]+[productKContent2.text floatValue] +[productKContent3.text floatValue] + [productKContent4.text floatValue];
    float sTotal = [productSContent1.text floatValue]+[productSContent2.text floatValue] +[productSContent3.text floatValue] + [productSContent4.text floatValue];
    float caTotal = [productCaContent1.text floatValue]+[productCaContent2.text floatValue] +[productCaContent3.text floatValue] + [productCaContent4.text floatValue];
    float cuTotal = [productCuContent1.text floatValue]+[productCuContent2.text floatValue] +[productCuContent3.text floatValue] + [productCuContent4.text floatValue];
    float znTotal = [productZnContent1.text floatValue]+[productZnContent2.text floatValue] +[productZnContent3.text floatValue] + [productZnContent4.text floatValue];
    float moTotal = [productMoContent1.text floatValue]+[productMoContent2.text floatValue] +[productMoContent3.text floatValue] + [productMoContent4.text floatValue];
    float mnTotal = [productMnContent1.text floatValue]+[productMnContent2.text floatValue] +[productMnContent3.text floatValue] + [productMnContent4.text floatValue];

    if (productNContent1.hidden &&
        productNContent2.hidden &&
        productNContent3.hidden &&
        productNContent4.hidden) {
        productNContentTotal.hidden = YES;
        productPContentTotal.hidden = YES;
        productKContentTotal.hidden = YES;
        productSContentTotal.hidden = YES;
        productCaContentTotal.hidden = YES;
        productCuContentTotal.hidden = YES;
        productZnContentTotal.hidden = YES;
        productMoContentTotal.hidden = YES;
        productMnContentTotal.hidden = YES;
    }
    else{
        productNContentTotal.text  = [NSString stringWithFormat:@"%.1f",nTotal];
        productNContentTotal.hidden = NO;
        productPContentTotal.text  = [NSString stringWithFormat:@"%.1f",pTotal];
        productPContentTotal.hidden = NO;
        productKContentTotal.text  = [NSString stringWithFormat:@"%.1f",kTotal];
        productKContentTotal.hidden = NO;
        productSContentTotal.text  = [NSString stringWithFormat:@"%.1f",sTotal];
        productSContentTotal.hidden = NO;
        productCaContentTotal.text  = [NSString stringWithFormat:@"%.1f",caTotal];
        productCaContentTotal.hidden = NO;
        productCuContentTotal.text  = [NSString stringWithFormat:@"%.2f",cuTotal];
        productCuContentTotal.hidden = NO;
        productZnContentTotal.text  = [NSString stringWithFormat:@"%.2f",znTotal];
        productZnContentTotal.hidden = NO;
        productMoContentTotal.text  = [NSString stringWithFormat:@"%.3f",moTotal];
        productMoContentTotal.hidden = NO;
        productMnContentTotal.text  = [NSString stringWithFormat:@"%.2f",mnTotal];
        productMnContentTotal.hidden = NO;
    }
}
#pragma mark-
#pragma mark UIPickerView Datasource and Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return allProduct.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NutrientCalculatorProduct *nutrientCalculatorProduct = [allProduct objectAtIndex:row];
    return nutrientCalculatorProduct.product;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    UITextField *selectedTF;
    UILabel *changedLbl;
    
    NutrientCalculatorProduct *nutrientCalculatorProduct = [allProduct objectAtIndex:row];
    switch (selectedTag) {
        case 0:
            selectedTF = productTF1;
            changedLbl = productResultLbl1;
            self.product1 = nutrientCalculatorProduct;
            break;
        case 1:
            selectedTF = productTF2;
            changedLbl = productResultLbl2;
            self.product2 = nutrientCalculatorProduct;
            break;
        case 2:
            selectedTF = productTF3;
            changedLbl = productResultLbl3;
            self.product3 = nutrientCalculatorProduct;
            break;
        case 3:
            selectedTF = productTF4;
            changedLbl = productResultLbl4;
            self.product4 = nutrientCalculatorProduct;
            break;
        default:
            break;
    }
    [selectedTF setBackground:[UIImage imageNamed:@"DD_or_TF.png"]];
   
    
    [changedLbl setText:nil];
    changedLbl.hidden = YES;
   
    
    if ([self.product1.product isEqualToString:@"Select Fertiliser Product"] && changedLbl == productResultLbl1) {
        [productTF1 setText:nil];
        [productTF1 setBackground:[UIImage imageNamed:@"DD_Select_Fertiliser_Product.png"]];
        
        productResultLbl1.hidden = YES;
        
    }
    else if([self.product2.product isEqualToString:@"Select Fertiliser Product"] && changedLbl == productResultLbl2){
        [productTF2 setText:nil];
        [productTF2 setBackground:[UIImage imageNamed:@"DD_Select_Fertiliser_Product.png"]];
        productResultLbl2.hidden = YES;
        
    }
    else if([self.product3.product isEqualToString:@"Select Fertiliser Product"] && changedLbl == productResultLbl3){
        [productTF3 setText:nil];
        [productTF3 setBackground:[UIImage imageNamed:@"DD_Select_Fertiliser_Product.png"]];
        productResultLbl3.hidden = YES;
        
    }
    else if([self.product4.product isEqualToString:@"Select Fertiliser Product"] && changedLbl == productResultLbl4){
        [productTF4 setText:nil];
        [productTF4 setBackground:[UIImage imageNamed:@"DD_Select_Fertiliser_Product.png"]];
        productResultLbl4.hidden = YES;
    }
    else{
        selectedTF.text = nutrientCalculatorProduct.product;
        changedLbl.text = nutrientCalculatorProduct.product;
        changedLbl.hidden = NO;
    }
    
    NSDictionary *doCalculationDictionary = [NSDictionary dictionaryWithObjectsAndKeys:selectedTF,@"selectedTF",nutrientCalculatorProduct,@"nutrientCalculatorProduct", nil];
    [self doNutrientCalculation:doCalculationDictionary];
    [productSelection dismissPopoverAnimated:YES];
}
-(void)doNutrientCalculation:(NSDictionary *)doCalculationDictionary{
    UITextField *selectedTF = [doCalculationDictionary objectForKey:@"selectedTF"];
    NutrientCalculatorProduct *nutrientCalculatorProduct = [doCalculationDictionary objectForKey:@"nutrientCalculatorProduct"];
    switch (selectedTF.tag) {
        case 0:
            selectedTF = productMultiplierTF1;
            productNContent1.text  = [NSString stringWithFormat:@"%.1f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionN floatValue])/100];
            productNContent1.hidden = NO;
            productPContent1.text  = [NSString stringWithFormat:@"%.1f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionP floatValue])/100];
            productPContent1.hidden = NO;
            productKContent1.text  = [NSString stringWithFormat:@"%.1f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionK floatValue])/100];
            productKContent1.hidden = NO;
            productSContent1.text  = [NSString stringWithFormat:@"%.1f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionS floatValue])/100];
            productSContent1.hidden = NO;
            productCaContent1.text  = [NSString stringWithFormat:@"%.1f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionCa floatValue])/100];
            productCaContent1.hidden = NO;
            productCuContent1.text  = [NSString stringWithFormat:@"%.2f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionCu floatValue])/100];
            productCuContent1.hidden = NO;
            productZnContent1.text  = [NSString stringWithFormat:@"%.2f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionZn floatValue])/100];
            productZnContent1.hidden = NO;
            productMoContent1.text  = [NSString stringWithFormat:@"%.3f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionMo floatValue])/100];
            productMoContent1.hidden = NO;
            productMnContent1.text  = [NSString stringWithFormat:@"%.2f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionMn floatValue])/100];
            productMnContent1.hidden = NO;
            productResultLbl1.hidden = NO;
            if ([nutrientCalculatorProduct.product isEqualToString:@"Select Fertiliser Product"] || [selectedTF.text isEqualToString:@""]) {
                productNContent1.hidden = YES;
                productPContent1.hidden = YES;
                productKContent1.hidden = YES;
                productSContent1.hidden = YES;
                productCaContent1.hidden = YES;
                productCuContent1.hidden = YES;
                productZnContent1.hidden = YES;
                productMoContent1.hidden = YES;
                productMnContent1.hidden = YES;
                if ([nutrientCalculatorProduct.product isEqualToString:@"Select Fertiliser Product"]) {
                    productResultLbl1.hidden = YES;
                }
                
                break;
            }

            [Flurry logEvent:[NSString stringWithFormat:@"Calculate Nutrient of %@ as first product", nutrientCalculatorProduct.product]];
            
            break;
        case 2:
            selectedTF = productMultiplierTF2;
            productNContent2.text  = [NSString stringWithFormat:@"%.1f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionN floatValue])/100];
            productNContent2.hidden = NO;
            productPContent2.text  = [NSString stringWithFormat:@"%.1f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionP floatValue])/100];
            productPContent2.hidden = NO;
            productKContent2.text  = [NSString stringWithFormat:@"%.1f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionK floatValue])/100];
            productKContent2.hidden = NO;
            productSContent2.text  = [NSString stringWithFormat:@"%.1f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionS floatValue])/100];
            productSContent2.hidden = NO;
            productCaContent2.text  = [NSString stringWithFormat:@"%.1f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionCa floatValue])/100];
            productCaContent2.hidden = NO;
            productCuContent2.text  = [NSString stringWithFormat:@"%.2f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionCu floatValue])/100];
            productCuContent2.hidden = NO;
            productZnContent2.text  = [NSString stringWithFormat:@"%.2f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionZn floatValue])/100];
            productZnContent2.hidden = NO;
            productMoContent2.text  = [NSString stringWithFormat:@"%.3f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionMo floatValue])/100];
            productMoContent2.hidden = NO;
            productMnContent2.text  = [NSString stringWithFormat:@"%.2f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionMn floatValue])/100];
            productMnContent2.hidden = NO;
            productResultLbl2.hidden = NO;
            if ([nutrientCalculatorProduct.product isEqualToString:@"Select Fertiliser Product"] || [selectedTF.text isEqualToString:@""]) {
                productNContent2.hidden = YES;
                productPContent2.hidden = YES;
                productKContent2.hidden = YES;
                productSContent2.hidden = YES;
                productCaContent2.hidden = YES;
                productCuContent2.hidden = YES;
                productZnContent2.hidden = YES;
                productMoContent2.hidden = YES;
                productMnContent2.hidden = YES;
                if ([nutrientCalculatorProduct.product isEqualToString:@"Select Fertiliser Product"]) {
                    productResultLbl2.hidden = YES;
                }
                break;
            }

            [Flurry logEvent:[NSString stringWithFormat:@"Calculate Nutrient of %@ as second product", nutrientCalculatorProduct.product]];
            break;
        case 1:
            selectedTF = productMultiplierTF3;
                        productNContent3.text  = [NSString stringWithFormat:@"%.1f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionN floatValue])/100];
            productNContent3.hidden = NO;
            productPContent3.text  = [NSString stringWithFormat:@"%.1f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionP floatValue])/100];
            productPContent3.hidden = NO;
            productKContent3.text  = [NSString stringWithFormat:@"%.1f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionK floatValue])/100];
            productKContent3.hidden = NO;
            productSContent3.text  = [NSString stringWithFormat:@"%.1f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionS floatValue])/100];
            productSContent3.hidden = NO;
            productCaContent3.text  = [NSString stringWithFormat:@"%.1f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionCa floatValue])/100];
            productCaContent3.hidden = NO;
            productCuContent3.text  = [NSString stringWithFormat:@"%.2f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionCu floatValue])/100];
            productCuContent3.hidden = NO;
            productZnContent3.text  = [NSString stringWithFormat:@"%.2f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionZn floatValue])/100];
            productZnContent3.hidden = NO;
            productMoContent3.text  = [NSString stringWithFormat:@"%.3f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionMo floatValue])/100];
            productMoContent3.hidden = NO;
            productMnContent3.text  = [NSString stringWithFormat:@"%.2f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionMn floatValue])/100];
            productMnContent3.hidden = NO;
            productResultLbl3.hidden = NO;
            if ([nutrientCalculatorProduct.product isEqualToString:@"Select Fertiliser Product"] || [selectedTF.text isEqualToString:@""]) {
                productNContent3.hidden = YES;
                productPContent3.hidden = YES;
                productKContent3.hidden = YES;
                productSContent3.hidden = YES;
                productCaContent3.hidden = YES;
                productCuContent3.hidden = YES;
                productZnContent3.hidden = YES;
                productMoContent3.hidden = YES;
                productMnContent3.hidden = YES;
                if ([nutrientCalculatorProduct.product isEqualToString:@"Select Fertiliser Product"]) {
                    productResultLbl3.hidden = YES;
                }
                break;
            }

            [Flurry logEvent:[NSString stringWithFormat:@"Calculate Nutrient of %@ as third product", nutrientCalculatorProduct.product]];
            break;
        case 3:
            selectedTF = productMultiplierTF4;
            
            productNContent4.text  = [NSString stringWithFormat:@"%.1f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionN floatValue])/100];
            productNContent4.hidden = NO;
            productPContent4.text  = [NSString stringWithFormat:@"%.1f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionP floatValue])/100];
            productPContent4.hidden = NO;
            productKContent4.text  = [NSString stringWithFormat:@"%.1f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionK floatValue])/100];
            productKContent4.hidden = NO;
            productSContent4.text  = [NSString stringWithFormat:@"%.1f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionS floatValue])/100];
            productSContent4.hidden = NO;
            productCaContent4.text  = [NSString stringWithFormat:@"%.1f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionCa floatValue])/100];
            productCaContent4.hidden = NO;
            productCuContent4.text  = [NSString stringWithFormat:@"%.2f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionCu floatValue])/100];
            productCuContent4.hidden = NO;
            productZnContent4.text  = [NSString stringWithFormat:@"%.2f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionZn floatValue])/100];
            productZnContent4.hidden = NO;
            productMoContent4.text  = [NSString stringWithFormat:@"%.3f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionMo floatValue])/100];
            productMoContent4.hidden = NO;
            productMnContent4.text  = [NSString stringWithFormat:@"%.2f",([selectedTF.text floatValue]*[nutrientCalculatorProduct.compositionMn floatValue])/100];
            productMnContent4.hidden = NO;
            productResultLbl4.hidden = NO;
            if ([nutrientCalculatorProduct.product isEqualToString:@"Select Fertiliser Product"] || [selectedTF.text isEqualToString:@""]) {
                productNContent4.hidden = YES;
                productPContent4.hidden = YES;
                productKContent4.hidden = YES;
                productSContent4.hidden = YES;
                productCaContent4.hidden = YES;
                productCuContent4.hidden = YES;
                productZnContent4.hidden = YES;
                productMoContent4.hidden = YES;
                productMnContent4.hidden = YES;
                if ([nutrientCalculatorProduct.product isEqualToString:@"Select Fertiliser Product"]) {
                    productResultLbl4.hidden = YES;
                }
                break;
            }
            [Flurry logEvent:[NSString stringWithFormat:@"Calculate Nutrient of %@ as fourth product", nutrientCalculatorProduct.product]];
            break;
        default:
            break;
            
    }
    float nTotal = [productNContent1.text floatValue]+[productNContent2.text floatValue] +[productNContent3.text floatValue] + [productNContent4.text floatValue];
    float pTotal = [productPContent1.text floatValue]+[productPContent2.text floatValue] +[productPContent3.text floatValue] + [productPContent4.text floatValue];
    float kTotal = [productKContent1.text floatValue]+[productKContent2.text floatValue] +[productKContent3.text floatValue] + [productKContent4.text floatValue];
    float sTotal = [productSContent1.text floatValue]+[productSContent2.text floatValue] +[productSContent3.text floatValue] + [productSContent4.text floatValue];
    float caTotal = [productCaContent1.text floatValue]+[productCaContent2.text floatValue] +[productCaContent3.text floatValue] + [productCaContent4.text floatValue];
    float cuTotal = [productCuContent1.text floatValue]+[productCuContent2.text floatValue] +[productCuContent3.text floatValue] + [productCuContent4.text floatValue];
    float znTotal = [productZnContent1.text floatValue]+[productZnContent2.text floatValue] +[productZnContent3.text floatValue] + [productZnContent4.text floatValue];
    float moTotal = [productMoContent1.text floatValue]+[productMoContent2.text floatValue] +[productMoContent3.text floatValue] + [productMoContent4.text floatValue];
    float mnTotal = [productMnContent1.text floatValue]+[productMnContent2.text floatValue] +[productMnContent3.text floatValue] + [productMnContent4.text floatValue];
    
    
    if (productNContent1.hidden &&
        productNContent2.hidden &&
        productNContent3.hidden &&
        productNContent4.hidden) {
        productNContentTotal.hidden = YES;
        productPContentTotal.hidden = YES;
        productKContentTotal.hidden = YES;
        productSContentTotal.hidden = YES;
        productCaContentTotal.hidden = YES;
        productCuContentTotal.hidden = YES;
        productZnContentTotal.hidden = YES;
        productMoContentTotal.hidden = YES;
        productMnContentTotal.hidden = YES;
    }
    else{
        productNContentTotal.text  = [NSString stringWithFormat:@"%.1f",nTotal];
        productNContentTotal.hidden = NO;
        productPContentTotal.text  = [NSString stringWithFormat:@"%.1f",pTotal];
        productPContentTotal.hidden = NO;
        productKContentTotal.text  = [NSString stringWithFormat:@"%.1f",kTotal];
        productKContentTotal.hidden = NO;
        productSContentTotal.text  = [NSString stringWithFormat:@"%.1f",sTotal];
        productSContentTotal.hidden = NO;
        productCaContentTotal.text  = [NSString stringWithFormat:@"%.1f",caTotal];
        productCaContentTotal.hidden = NO;
        productCuContentTotal.text  = [NSString stringWithFormat:@"%.2f",cuTotal];
        productCuContentTotal.hidden = NO;
        productZnContentTotal.text  = [NSString stringWithFormat:@"%.2f",znTotal];
        productZnContentTotal.hidden = NO;
        productMoContentTotal.text  = [NSString stringWithFormat:@"%.3f",moTotal];
        productMoContentTotal.hidden = NO;
        productMnContentTotal.text  = [NSString stringWithFormat:@"%.2f",mnTotal];
        productMnContentTotal.hidden = NO;
    }

    
    
    
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
