//
//  ContentSelectionViewController.h
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NutrientCalculatorViewController.h"
#import "CSBPNewsViewController.h"
#import "TargetNPViewController.h"
#import "NKLevelsViewController.h"
#import "NutrientDeficiencyViewController.h"

@interface ContentSelectionViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    IBOutlet UITableView *menuSelection;
    
    IBOutlet UIView *masterView;
    IBOutlet UIView *detailView;
    NutrientCalculatorViewController *nutrientCalcVC;
    CSBPNewsViewController *newsVC;
    TargetNPViewController *targetNPVC;
    NKLevelsViewController *NKLevelsVC;
    NutrientDeficiencyViewController *nutrientDeficiencyVC;
    
}
-(IBAction)backButtonDidSelected:(id)sender;

@property (nonatomic,retain)NSIndexPath *selectedIndexPath;
@end
