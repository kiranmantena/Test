//
//  NutrientSelection.h
//  CSBPCalculator
//
//  Created by HK on 13/8/12.
//
//

#import <UIKit/UIKit.h>
#import "NutrientDeficiencyViewController.h"

@interface NutrientSelection : UIView<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *nutrientSelection;
    NSArray *allCropArray;
    
}
@property(nonatomic,retain)NutrientDeficiencyViewController *nutrientParentViewController;

@end
