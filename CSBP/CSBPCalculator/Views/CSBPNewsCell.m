//
//  CSBPNewsCell.m
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 29/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CSBPNewsCell.h"
#import "ASIHTTPRequest.h"

@implementation CSBPNewsCell
@synthesize newsObject;
@synthesize parentViewController;


#pragma mark - image downloader
-(void)requestSuccess:(ASIHTTPRequest *)request{
    
    [imageIndicator stopAnimating];
    imageIndicator.hidden = YES;
    
    News *news = self.newsObject;
    
    if (news ==nil) {
        return;
    }
    
    news.imageData = [NSData dataWithData:[request responseData]];
        
    [Application.dataManager save];
    
    
    
    NSDictionary *newsDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageWithData: news.imageData],@"newsImage",
                                 nil];
    [self performSelectorOnMainThread:@selector(displayNewsImage:)
                           withObject:newsDict
                        waitUntilDone:YES];
}
-(void)displayNewsImage:(NSDictionary *)userInfoDict{
    UIImage *newImage = [userInfoDict objectForKey:@"newsImage"];
    [newsImage setImage:newImage] ;

}
-(void)requestFail:(ASIHTTPRequest *)request{
//    UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)[[request userInfo] objectForKey:@"indicator"];
//    [indicatorView stopAnimating];
//    indicatorView.hidden = YES;
    [imageIndicator stopAnimating];
    
    imageIndicator.hidden = YES;
    UIAlertView *failDownload = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Fail to download Image" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [failDownload show];
    [failDownload release];
}


-(void)readMoreDidSelected:(id)sender{
//    NSLog(@"Here you go");
    [self.parentViewController newsDidSelected:newsObject];
    for (ASIHTTPRequest *request in queue.operations)
    {
        [request setDelegate: nil];
        [request setDidFinishSelector: nil];
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSDictionary *newsDictionary = [NSDictionary dictionaryWithObject:self.newsObject forKey:@"newsObj"];
        self=[ [ [ NSBundle mainBundle ] loadNibNamed:@"CSBPNewsCell" owner:self options:newsDictionary] lastObject];
        self.newsObject = [newsDictionary objectForKey:@"newsObj"];
        [readMoreBtn addTarget:self action:@selector(readMoreDidSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        newsTitle.text = self.newsObject.title;
        newsSnippet.text = self.newsObject.summary;
        if (self.newsObject.imageData ==nil) {
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:
                                       [NSURL URLWithString:self.newsObject.imageURL]];
            
            
            [request setDidFinishSelector:@selector(requestSuccess:)];
            [request setDidFailSelector:@selector(requestFail:)];
            
            request.delegate = self;
            
            [request startAsynchronous];
            [queue addOperation:request];
            [imageIndicator startAnimating];
        }
        else{
            [imageIndicator stopAnimating];
            
            imageIndicator.hidden = YES;
            [newsImage setImage:[UIImage imageWithData:self.newsObject.imageData]];
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andNewsObject:(News*)news{
    self.newsObject = news;
    
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier];
}
@end
