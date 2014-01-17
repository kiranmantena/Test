//
//  MenuViewController.m
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"
#import "ContentSelectionViewController.h"
@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view..
    self.screenName=@"MenuViewController";
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
-(IBAction)menuDidSelected:(id)sender{
    UIButton *selectedButton = (UIButton *)sender;
    ContentSelectionViewController *contentSelectionController = [[ContentSelectionViewController alloc] initWithNibName:@"ContentSelection" bundle:nil];
    contentSelectionController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    NSInteger selectedIndex=selectedButton.tag;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    NSString *selectedPage;
    switch (selectedIndex) {
        case 0:
            selectedPage = @"Nutrient Calculator";
            break;
        case 1:
            selectedPage = @"Target N&P Calculator";
            break;
        case 2:
            selectedPage = @"NK Levels Calculator";
            break;
        case 3:
            selectedPage = @"Nutrient Deficiencies";
            break;
        case 4:
            selectedPage = @"CSBP News";
            break;
        default:
            break;
    }
    [Flurry logEvent:[NSString stringWithFormat:@"Open %@ page from main menu",selectedPage]];
    contentSelectionController.selectedIndexPath =indexPath;
    [self presentModalViewController:contentSelectionController animated:YES];
    [contentSelectionController release];
//    [nextController release];
}
@end
