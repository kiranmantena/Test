//
//  ContentSelectionViewController.m
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ContentSelectionViewController.h"
#import "MenuViewController.h"
#import "ContentDetailViewController.h"
#import "MenuSelectionCell.h"
#import "CommonFunctions.h"

@interface ContentSelectionViewController ()

@end

@implementation ContentSelectionViewController
@synthesize selectedIndexPath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    nutrientCalcVC = [[NutrientCalculatorViewController alloc] initWithNibName:@"NutrientCalculator" bundle:nil];
    targetNPVC = [[TargetNPViewController alloc] initWithNibName:@"TargetNP" bundle:nil];    
    NKLevelsVC = [[NKLevelsViewController alloc] initWithNibName:@"NKLevels" bundle:nil];
    newsVC = [[CSBPNewsViewController alloc] initWithNibName:@"CSBPNews" bundle:nil];
    nutrientDeficiencyVC = [[NutrientDeficiencyViewController alloc] initWithNibName:@"NutrientDeficiency" bundle:nil];
    
    [menuSelection selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
    
    switch (selectedIndexPath.row) {
        case 0:
            [detailView addSubview:nutrientCalcVC.view];
            break;
        case 1:
            [detailView addSubview:targetNPVC.view];
            break;
        case 2:
            [detailView addSubview:NKLevelsVC.view];
            break;
        case 3:
            [detailView addSubview:nutrientDeficiencyVC.view];
            break;
        case 4:
            [detailView addSubview:newsVC.view];
            break;
        default:
            break;
    }
    
   
    
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    
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
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}
#pragma mark - UITableView Datasource & Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row==3) {
//        return 94;
//    }
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MenuSelectionCell *cell =  [[MenuSelectionCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    NSString *cellString;
    switch (indexPath.row) {
        case 0:
            cellString = @"Nutrient Calculator";
            cell.textLabel.textColor = RGBCOLOR(0, 113, 186);
            break;
        case 1:
            cellString = @"Target N and P";
            
            cell.textLabel.textColor = RGBCOLOR(0, 113, 186);
            break;
        case 2:
            cellString = @"N and K Banding";
            
            cell.textLabel.textColor = RGBCOLOR(0, 113, 186);
            break;
        case 3:
            cellString = @"Nutrient Deficiencies";
            cell.textLabel.textColor = RGBCOLOR(124, 166, 12);
            break;
        case 4:
            cellString = @"CSBP News";
            cell.textLabel.textColor = RGBCOLOR(224, 121, 11);
            break;
        default:
            break;
    }
    cell.textLabel.text = cellString;
    return cell;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footerView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 188, 2)];
    UIImageView *footerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TableBorder.png"]];
    [footerView addSubview:footerImageView];
    return [footerView autorelease];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    nutrientCalc.delegate= self;
    if (self.selectedIndexPath.row == indexPath.row) {
        return;
    }
    self.selectedIndexPath = indexPath;
    switch (indexPath.row) {
        case 0:
//            if(nutrientCalcVC==nil){
            for (UIView *childView in detailView.subviews) {
                [childView removeFromSuperview];
                
            }
                [detailView addSubview:nutrientCalcVC.view];
                [Flurry logEvent:@"Open Nutrient Calculator from side menu"];
//            }
            break;
        case 1:
            for (UIView *childView in detailView.subviews) {
                [childView removeFromSuperview];
                
            }
            [detailView addSubview:targetNPVC.view];
            [Flurry logEvent:@"Open Target N and P Calculator from side menu"];
            break;
        case 2:
            for (UIView *childView in detailView.subviews) {
                [childView removeFromSuperview];
                
            }
            [detailView addSubview:NKLevelsVC.view];
            [Flurry logEvent:@"Open N and K Banding Calculator from side menu"];
            break;
        case 3:
            for (UIView *childView in detailView.subviews) {
                [childView removeFromSuperview];
                
            }
//            MenuSelectionCell *cell = (MenuSelectionCell *)[tableView cellForRowAtIndexPath:indexPath];
//            UILabel *wheatLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 10)];
//            [cell setFrame:CGRectMake(cell.frame.origin.x, cell.frame.origin.y+40, cell.frame.size.width, 20)];
//            wheatLabel.font = [UIFont systemFontOfSize:10];
//            wheatLabel.text=@"Wheat";
//            [wheatLabel setBackgroundColor:[UIColor clearColor]];
//            [cell addSubview:wheatLabel];
//            [wheatLabel release];
            [detailView addSubview:nutrientDeficiencyVC.view];
            [Flurry logEvent:@"Open Nutrient Deficiency from side menu"];
            break;
        case 4:
//            if (newsVC ==nil) {
                for (UIView *childView in detailView.subviews) {
                    [childView removeFromSuperview];
                    
                }
            [detailView addSubview:newsVC.view];
            [Flurry logEvent:@"Open CSBP News from side menu"];
//            }
            break;
        default:
            break;
    }

}
#pragma mark - Button
-(IBAction)backButtonDidSelected:(id)sender{
    [Flurry logEvent:@"Back to Main Menu"];
    [self dismissModalViewControllerAnimated:YES];
}
@end
