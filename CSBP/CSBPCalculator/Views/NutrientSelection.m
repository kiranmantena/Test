//
//  NutrientSelection.m
//  CSBPCalculator
//
//  Created by HK on 13/8/12.
//
//

#import "NutrientSelection.h"
#import "DataManager.h"

@implementation NutrientSelection
@synthesize nutrientParentViewController;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        self=[ [ [ NSBundle mainBundle ] loadNibNamed:@"NutrientSelection" owner:self options:nil] lastObject];
        nutrientSelection.dataSource = self;
        nutrientSelection.delegate = self;
        
        allCropArray = [Application.dataManager getAllCrops];
        [allCropArray retain];
        
       
    }
    return self;
}
#pragma mark - UITableView Datasource & Delegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [allCropArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Crop *crop = [allCropArray objectAtIndex:indexPath.row];
    
    UITableViewCell *cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    cell.textLabel.text = crop.cropType;
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    nutrientCalc.delegate= self;
    
    Crop *crop = [allCropArray objectAtIndex:indexPath.row];
    
    
    [self.nutrientParentViewController dismissCropSelectionView:crop];
    
}


@end
