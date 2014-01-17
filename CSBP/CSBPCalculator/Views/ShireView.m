//
//  ShireView.m
//  CSBPCalculator
//
//  Created by HK on 8/8/12.
//
//

#import "ShireView.h"
#import "DataManager.h"
#import "MenuSelectionCell.h"

@implementation ShireView
@synthesize newsParentViewController;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        allShireArray = [Application.dataManager getAllShire];
        [allShireArray retain];
        
        self=[ [ [ NSBundle mainBundle ] loadNibNamed:@"ShireSelection" owner:self options:nil] lastObject];
        shireSelection.dataSource = self;
        shireSelection.delegate = self;
    }
    return self;
}
#pragma mark - UITableView Datasource & Delegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [allShireArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Shire *shire = [allShireArray objectAtIndex:indexPath.row];
    
    UITableViewCell *cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
    cell.textLabel.backgroundColor=[UIColor clearColor];
    cell.textLabel.text = shire.shireName;
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    nutrientCalc.delegate= self;
    
    Shire *shire = [allShireArray objectAtIndex:indexPath.row];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString *shireID = shire.shireID;
    
    [prefs setObject:shireID forKey:@"shireID"];
    
    [self.newsParentViewController dismissShireSelectionView];
        
}

@end
