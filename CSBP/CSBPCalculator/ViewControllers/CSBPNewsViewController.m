//
//  CSBPNewsViewController.m
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CSBPNewsViewController.h"
#import "CSBPNewsCell.h"
#import "NewsDetailView.h"
#import "NewsService.h"

@interface CSBPNewsViewController ()

@end

@implementation CSBPNewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    
    if (shireID!=nil) {
//        CGRect currentContentViewPosition = self.contentView.frame;
        [newsDetail removeFromSuperview];
        self.contentView = CSBPNewsTableView;
//        self.contentView.frame =  currentContentViewPosition;

        [contentWithBackgroundView addSubview:self.contentView];
        
        backToShire.hidden = NO;
    }
    termConditionIsActive = NO;
    termAndConditionView.hidden = YES;
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    shireID=[prefs objectForKey:@"shireID"];

    if (shireID==nil) {
        allShireArray = [Application.dataManager getAllShire];
        [allShireArray retain];
        backToShire.hidden = YES;
    }
    else{
        csbpNewsArray = [Application.dataManager getAllNews];
        [csbpNewsArray retain];
        
        backToShire.hidden = NO;
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
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


#pragma mark -
#pragma mark UITableView DataSource & Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio{
    if (shireID!=nil)
        return [csbpNewsArray count];
    else
        return [allShireArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (shireID!=nil){
        CSBPNewsCell *cell = [[CSBPNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CSBPNewsCell" andNewsObject:[csbpNewsArray objectAtIndex:indexPath.row]];
        cell.parentViewController = self;
        return cell;
    }
    else{
        Shire *shire = [allShireArray objectAtIndex:indexPath.row];
        
        UITableViewCell *cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        cell.textLabel.textColor = [UIColor whiteColor];
        
        cell.textLabel.text = shire.shireName;
        return cell;
    }
    
}
-(void)backToNews{
//    CGRect currentContentViewPosition = self.contentView.frame;
    [newsDetail removeFromSuperview];
//    [newsDetail release];newsDetail = nil;
    
    [Flurry logEvent:@"Back to News Selection" ];
//    CSBPNewsTableView.frame = CGRectMake(38, 52, 723, 595);
    self.contentView = CSBPNewsTableView;
  
    self.contentView.frame =  CGRectMake(50, 70, 723, 595);
//    [self.contentView performSelectorOnMainThread:@selector(setNeedsDisplay) withObject:nil waitUntilDone:YES];
    [contentWithBackgroundView addSubview:self.contentView];
    
   
}
-(void)newsDidSelected:(News *)news{
    newsDetail = [[NewsDetailView alloc] initWithFrame: CSBPNewsTableView.frame andNewsObject:news];
        
    [Flurry logEvent:[NSString stringWithFormat:@"Select News with Title: %@ ",news.title] ];
    newsDetail.tag=80;
    [newsDetail.backButton addTarget:self action:@selector(backToNews) forControlEvents:UIControlEventTouchUpInside];
    newsDetail.frame = CGRectMake(20, 20, 789, 667);
//    self.contentView = newsDetail;
    [CSBPNewsTableView removeFromSuperview];
    
    [contentWithBackgroundView  addSubview: newsDetail];
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (shireID==nil){
        
        if (csbpNewsArray.count >0) {
            [csbpNewsArray release];csbpNewsArray=nil;
        }
        Shire *shire = [allShireArray objectAtIndex:indexPath.row];
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        shireID = shire.shireID;
        
        NewsService *newsWS = [[NewsService alloc] init];
        [newsWS getAllNews:shireID];
        
        [prefs setObject:shireID forKey:@"shireID"];
        [Flurry logEvent:[NSString stringWithFormat:@"Select %@ as Shire News",shire.shireName] ];
        
        [Application showBusy];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:@"getIpadNewsDone" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(failDownload) name:@"getIpadNewsFail" object:nil];
    
    }
}
-(void)reloadTableView{
    if (csbpNewsArray.count == 0) {
        backToShire.hidden = NO;
        csbpNewsArray = [Application.dataManager getAllNews];
        [csbpNewsArray retain];

    }
    [CSBPNewsTableView reloadData];
    [Application hideBusy];
}
-(void)failDownload{
    [Application hideBusy];
    [Flurry logEvent:@"News fail to download" ];
    UIAlertView *failDownloadNews = [[UIAlertView alloc] initWithTitle:@"Fail" message:@"News not downloaded\nPlease try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [failDownloadNews show];
    [failDownloadNews release];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (shireID == nil) {
        return 40;
    }
    else{
        return 183;
    }
}
#pragma mark - Back Shire Selection
-(IBAction)selectShireDidSelected:(id)sender{
    shireID = nil;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    
    [prefs setObject:shireID forKey:@"shireID"];
    [Flurry logEvent:@"Back to Selecting Shire"];
    [CSBPNewsTableView reloadData];
    
    backToShire.hidden = YES;
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
