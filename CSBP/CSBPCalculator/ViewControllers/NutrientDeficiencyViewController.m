//
//  NutrientDeficiencyViewController.m
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 7/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NutrientDeficiencyViewController.h"
#import "CommonFunctions.h"
#import "HKStyle.h"
#import "ASIHTTPRequest.h"
#import "NutrientSelection.h"

@interface NutrientDeficiencyViewController ()

@end

@implementation NutrientDeficiencyViewController

#pragma mark - image downloader
-(void)requestSuccess:(ASIHTTPRequest *)request{
    
    NSDictionary *requestUserInfo = [request userInfo];
    
    Nutrient *nutrient = (Nutrient *)[requestUserInfo objectForKey:@"nutrientObject"];
    
    if (nutrient ==nil) {
        return;
    }
    if ([[requestUserInfo objectForKey:@"imagePlace"] isEqual:image1]) {
        nutrient.imageData_1 = [NSData dataWithData:[request responseData]];
        
    }
    else if([[requestUserInfo objectForKey:@"imagePlace"] isEqual:image2]){
        nutrient.imageData_2 = [NSData dataWithData:[request responseData]];
    }
    else{
        nutrient.imageData_3 = [NSData dataWithData:[request responseData]];
    }
    [Application.dataManager save];
    
//    NSDictionary *menuDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageWithData: cover.menuImageData],@"menuImage",
//                              nil];
    //bypass Selection
       
    [self performSelectorOnMainThread:@selector(displayNutrientImage:)
                           withObject:requestUserInfo
                        waitUntilDone:YES];
}
-(void)requestFail:(ASIHTTPRequest *)request{
    UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)[[request userInfo] objectForKey:@"indicator"];
    [indicatorView stopAnimating];
    indicatorView.hidden = YES;
    
    UIAlertView *failDownload = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Fail to download Image" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [failDownload show];
    [failDownload release];
}
-(void)displayNutrientImage:(NSDictionary *)userInfoDict{
    
    UIImageView *requestedImage = [userInfoDict objectForKey:@"imagePlace"];
    
   
    Nutrient *nutrient = (Nutrient*)[userInfoDict objectForKey:@"nutrientObject"];
    if ([requestedImage isEqual:image1]) {
        [requestedImage setImage:[UIImage imageWithData:nutrient.imageData_1]];
    }
    else if([requestedImage isEqual:image2]){
        [requestedImage setImage:[UIImage imageWithData:nutrient.imageData_2]];
    }
    else {
        [requestedImage setImage:[UIImage imageWithData:nutrient.imageData_3]];
    }
    
    
    UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)[userInfoDict objectForKey:@"indicator"];
    [indicatorView stopAnimating];
    indicatorView.hidden = YES;

}


#pragma mark - view related
-(void)nutrientHasData:(Nutrient *)nutrient{
    nutrientDefContentView.hidden =NO;
    contentDetail.text = nutrient.content;
    [contentDetail setFrame:[HKStyle dynamicLabelHeight:contentDetail :contentDetail.frame.size.width]];
    [nutrientDefContentView setContentSize:CGSizeMake(nutrientDefContentView.frame.size.width, contentDetail.frame.size.height)];
    NSString *nutrientHTMLContent = [NSString stringWithFormat:@"<div style=\"color:#c6c6c6;font-family:arial; font-size: 18px;\">%@</div>",nutrient.content];
    nutrientDefContentWebView.scrollView.bounces = NO;
    [nutrientDefContentWebView loadHTMLString:nutrientHTMLContent baseURL:nil];
    nutrientDefContentView.hidden = YES;
    image1.image = [UIImage imageNamed:@"DeficiencyImageBG.png"];
    image2.image = [UIImage imageNamed:@"DeficiencyImageBG.png"];
    image3.image = [UIImage imageNamed:@"DeficiencyImageBG.png"];
    if (nutrient.imageURL_1 == nil) {
        containerImage1.hidden = YES;
        image1.hidden = YES;
        imageIndicator1.hidden = YES;
    }
    else {
        containerImage1.hidden = NO;
        image1.hidden = NO;
        if (nutrient.imageData_1 ==nil) {
            if (queue == nil) {
                queue = [NSOperationQueue new];
            }
            imageIndicator1.hidden = NO;
            [imageIndicator1 startAnimating];
            
            NSDictionary *menuDictionary = [NSDictionary dictionaryWithObjectsAndKeys:image1,@"imagePlace",nutrient,@"nutrientObject",imageIndicator1,@"indicator", nil];
            
            
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:
                                       [NSURL URLWithString:nutrient.imageURL_1]];
            [request setUserInfo:menuDictionary];
            
            [request setDidFinishSelector:@selector(requestSuccess:)];
            [request setDidFailSelector:@selector(requestFail:)];
            
            
            request.delegate = self;
            
            [queue addOperation:request];
            
        }
        
        else{
            image1.image = [UIImage imageWithData:nutrient.imageData_1];
        }
    }
    if (nutrient.imageURL_2 == nil) {
        containerImage2.hidden = YES;
        image2.hidden = YES;
        imageIndicator2.hidden = YES;
    }
    else {
        containerImage2.hidden = NO;
        image2.hidden = NO;
        if (nutrient.imageData_2 ==nil) {
            if (queue == nil) {
                queue = [NSOperationQueue new];
            }
            imageIndicator2.hidden = NO;
            [imageIndicator2 startAnimating];
            
            NSDictionary *menuDictionary = [NSDictionary dictionaryWithObjectsAndKeys:image2,@"imagePlace",nutrient,@"nutrientObject",imageIndicator2,@"indicator", nil];
            
            
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:
                                       [NSURL URLWithString:nutrient.imageURL_2]];
            [request setUserInfo:menuDictionary];
            
            [request setDidFinishSelector:@selector(requestSuccess:)];
            [request setDidFailSelector:@selector(requestFail:)];
            
            
            request.delegate = self;
            
            [queue addOperation:request];
            
        }
        else{
            image2.image = [UIImage imageWithData:nutrient.imageData_2];
        }
    }
    if (nutrient.imageURL_3 == nil) {
        containerImage3.hidden = YES;
        image3.hidden = YES;
        imageIndicator3.hidden = YES;
    }
    else {
        containerImage3.hidden = NO;
        image3.hidden = NO;
        if (nutrient.imageData_3 ==nil) {
            if (queue == nil) {
                queue = [NSOperationQueue new];
            }
            imageIndicator3.hidden = NO;
            [imageIndicator3 startAnimating];
            
            NSDictionary *menuDictionary = [NSDictionary dictionaryWithObjectsAndKeys:image3,@"imagePlace",nutrient,@"nutrientObject",imageIndicator3,@"indicator", nil];
            
            
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:
                                       [NSURL URLWithString:nutrient.imageURL_3]];
            [request setUserInfo:menuDictionary];
            
            [request setDidFinishSelector:@selector(requestSuccess:)];
            [request setDidFailSelector:@selector(requestFail:)];
            
            
            request.delegate = self;
            
            [queue addOperation:request];
            
        }
        else{
            image3.image = [UIImage imageWithData:nutrient.imageData_3];
        }
    }

}
#pragma mark - View
-(void)hideLayoutNilNutrient{
        //            NSLog(@" Nitrogen has data");
    nutrientDefContentView.hidden =YES;
    containerImage1.hidden = YES;
    image1.hidden = YES;
    imageIndicator1.hidden = YES;
    containerImage2.hidden = YES;
    image2.hidden = YES;
    imageIndicator2.hidden = YES;
    containerImage3.hidden = YES;
    image3.hidden = YES;
    imageIndicator3.hidden = YES;
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{

    NutrientSelection *nutrientView = [[NutrientSelection alloc] initWithFrame:self.contentView.frame];
    nutrientView.tag = 81;
    nutrientView.nutrientParentViewController = self;
//    [self.contentView addSubview:nutrientView];
//    [nutrientView release];
    termConditionIsActive = NO;
    termAndConditionView.hidden = YES;
    
    selectedCrop = [Application.dataManager getCropByName:@"Wheat"];
    [self viewDidRefresh];

    
    [super viewWillAppear:animated];
}
-(void)viewDidRefresh{
    if (currentSelectedButton.tag !=0) {
        currentSelectedButton.selected = NO;
        
        defaultButton.selected = YES;
        currentSelectedButton = defaultButton;
    }
    
    
    nutrientDefContentView.contentSize = CGSizeMake(723, 721);
    
    for (Nutrient * nutrient in selectedCrop.nutrients) {
        NSPredicate *containPred = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", @"nitrogen"];
        if ([containPred evaluateWithObject:[nutrient.nutrientName lowercaseString]]) {
            //            NSLog(@" Nitrogen has data");
            [self nutrientHasData:nutrient];
            break;
        }
        else {
             [self hideLayoutNilNutrient];
            
        }
        
        
    }
    selectedCropLbl.text = selectedCrop.cropType;
   
    nutrientLbl.text = @"Nitrogen";

}

- (void)viewDidLoad
{
//    allCrop = [Application.dataManager getAllCrops];
//    [allCrop retain];
//    
//    for (Crop *singleCrop in allCrop) {
//        if ([singleCrop.nutrients count]>0) {
//            selectedCrop = singleCrop;
////            NSLog(@"%@",selectedCrop.cropType);
//        }
//    }
    
    
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
-(IBAction)NitrogenDidSelected:(id)sender{
    UIButton *selectedButton = (UIButton *)sender;
    if (![currentSelectedButton isEqual:selectedButton]) {
        currentSelectedButton.selected = NO;
        selectedButton.selected = YES;
        currentSelectedButton = selectedButton;
        [Flurry logEvent:@"Select Nitrogen on Nutrient Deficiencies"];
    }
    for (Nutrient * nutrient in selectedCrop.nutrients) {
        NSPredicate *containPred = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", @"nitrogen"];
        if ([containPred evaluateWithObject:[nutrient.nutrientName lowercaseString]]) {
//            NSLog(@" Nitrogen has data");
            [self nutrientHasData:nutrient];
            break;
        }
        else {
            
            [self hideLayoutNilNutrient];
        }
    }
    nutrientLbl.text = @"Nitrogen";
}

-(IBAction)PhosporusDidSelected:(id)sender{
    UIButton *selectedButton = (UIButton *)sender;
    if (![currentSelectedButton isEqual:selectedButton]) {
        currentSelectedButton.selected = NO;
        selectedButton.selected = YES;
        currentSelectedButton = selectedButton;
        [Flurry logEvent:@"Select Phosphorus on Nutrient Deficiencies"];
    }
    for (Nutrient * nutrient in selectedCrop.nutrients) {
        NSPredicate *containPred = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", @"phosphorus"];
        if ([containPred evaluateWithObject:[nutrient.nutrientName lowercaseString]]) {
//            NSLog(@"Phosporus has data");
            [self nutrientHasData:nutrient];
            break;
        }
        else {
            
            [self hideLayoutNilNutrient];
        }
    }
    nutrientLbl.text = @"Phosphorus";
}

-(IBAction)PotassiumDidSelected:(id)sender{
    UIButton *selectedButton = (UIButton *)sender;
    if (![currentSelectedButton isEqual:selectedButton]) {
        currentSelectedButton.selected = NO;
        selectedButton.selected = YES;
        currentSelectedButton = selectedButton;
        [Flurry logEvent:@"Select Potassium on Nutrient Deficiencies"];
    }
    
    for (Nutrient * nutrient in selectedCrop.nutrients) {
        NSPredicate *containPred = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", @"potassium"];
        if ([containPred evaluateWithObject:[nutrient.nutrientName lowercaseString]]) {
//            NSLog(@"Potassium has data");
            [self nutrientHasData:nutrient];
            break;
        }
        else {
            
            [self hideLayoutNilNutrient];
        }
    }
    nutrientLbl.text = @"Potassium";
}

-(IBAction)SulphurDidSelected:(id)sender{
    UIButton *selectedButton = (UIButton *)sender;
    if (![currentSelectedButton isEqual:selectedButton]) {
        currentSelectedButton.selected = NO;
        selectedButton.selected = YES;
        currentSelectedButton = selectedButton;
        [Flurry logEvent:@"Select Sulphur on Nutrient Deficiencies"];
    }
    for (Nutrient * nutrient in selectedCrop.nutrients) {
        NSPredicate *containPred = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", @"sulphur"];
        if ([containPred evaluateWithObject:[nutrient.nutrientName lowercaseString]]) {
//            NSLog(@"Sulphur has data");
            [self nutrientHasData:nutrient];
            break;
        }
        else {
            
            [self hideLayoutNilNutrient];
        }
    }
    nutrientLbl.text = @"Sulphur";
}

-(IBAction)CopperDidSelected:(id)sender{
    UIButton *selectedButton = (UIButton *)sender;
    if (![currentSelectedButton isEqual:selectedButton]) {
        currentSelectedButton.selected = NO;
        selectedButton.selected = YES;
        currentSelectedButton = selectedButton;
        [Flurry logEvent:@"Select Copper on Nutrient Deficiencies"];
    }
    for (Nutrient * nutrient in selectedCrop.nutrients) {
        NSPredicate *containPred = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", @"copper"];
        if ([containPred evaluateWithObject:[nutrient.nutrientName lowercaseString]]) {
//            NSLog(@"Cooper has data");
            [self nutrientHasData:nutrient];
            break;
        }
        else {
            
            [self hideLayoutNilNutrient];
        }
    }
    nutrientLbl.text = @"Copper";
}

-(IBAction)ZincDidSelected:(id)sender{
    UIButton *selectedButton = (UIButton *)sender;
    if (![currentSelectedButton isEqual:selectedButton]) {
        currentSelectedButton.selected = NO;
        selectedButton.selected = YES;
        currentSelectedButton = selectedButton;
        [Flurry logEvent:@"Select Zinc on Nutrient Deficiencies"];
    }
    for (Nutrient * nutrient in selectedCrop.nutrients) {
        NSPredicate *containPred = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", @"zinc"];
        if ([containPred evaluateWithObject:[nutrient.nutrientName lowercaseString]]) {
//            NSLog(@"Zinc has data");
            [self nutrientHasData:nutrient];
            break;
        }
        else {
            
            [self hideLayoutNilNutrient];
        }
    }
    nutrientLbl.text = @"Zinc";
}

-(IBAction)MolybdenumDidSelected:(id)sender{
    UIButton *selectedButton = (UIButton *)sender;
    if (![currentSelectedButton isEqual:selectedButton]) {
        currentSelectedButton.selected = NO;
        selectedButton.selected = YES;
        currentSelectedButton = selectedButton;
        [Flurry logEvent:@"Select Molybdenum on Nutrient Deficiencies"];
    }    
    for (Nutrient * nutrient in selectedCrop.nutrients) {
        NSPredicate *containPred = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", @"molybdenum"];
        if ([containPred evaluateWithObject:[nutrient.nutrientName lowercaseString]]) {
//            NSLog(@"Molybdenum has data");
            [self nutrientHasData:nutrient];
            break;
        }
        else {
            
            [self hideLayoutNilNutrient];
        }
    }
    nutrientLbl.text = @"Molybdenum";
}

-(IBAction)ManganeseDidSelected:(id)sender{
    UIButton *selectedButton = (UIButton *)sender;
    if (![currentSelectedButton isEqual:selectedButton]) {
        currentSelectedButton.selected = NO;
        selectedButton.selected = YES;
        currentSelectedButton = selectedButton;
        [Flurry logEvent:@"Select Manganese on Nutrient Deficiencies"];
    }
    for (Nutrient * nutrient in selectedCrop.nutrients) {
        NSPredicate *containPred = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", @"manganese"];
        if ([containPred evaluateWithObject:[nutrient.nutrientName lowercaseString]]){
//            NSLog(@"Manganese has data");
            [self nutrientHasData:nutrient];
            break;
        }
        else {
            
            [self hideLayoutNilNutrient];
        }
    }
    nutrientLbl.text = @"Manganese";
}

-(void)dismissCropSelectionView:(Crop *)crop{
    for (UIView *subviews in self.contentView.subviews) {
        if (subviews.tag==81) {
            selectedCrop = crop;
            [subviews removeFromSuperview];
            [self viewDidRefresh];
        }
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
