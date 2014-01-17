//
//  ShireView.h
//  CSBPCalculator
//
//  Created by HK on 8/8/12.
//
//

#import <UIKit/UIKit.h>
#import "CSBPNewsViewController.h"
@interface ShireView : UIView<UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView *shireSelection;
    NSArray *allShireArray;
    
}
@property(nonatomic,retain)CSBPNewsViewController *newsParentViewController;
@end
