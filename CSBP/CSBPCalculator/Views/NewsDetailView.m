//
//  NewsDetailView.m
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 29/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewsDetailView.h"
#import "HKStyle.h"
#import "ASIHTTPRequest.h"

@implementation NewsDetailView
@synthesize newsObject;
@synthesize backButton;

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
    [newsDetailImage setImage:newImage] ;
    
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


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

       if (self) {
        // Initialization code
       NSDictionary *newsDictionary = [NSDictionary dictionaryWithObject:self.newsObject forKey:@"newsObj"];
       self=[ [ [ NSBundle mainBundle ] loadNibNamed:@"NewsDetail" owner:self options:newsDictionary] lastObject];
       self.newsObject = [newsDictionary objectForKey:@"newsObj"];

        NSString *cleanContent = self.newsObject.content;
        NSScanner *theScanner = [NSScanner scannerWithString:cleanContent];
        NSString *strippedText = nil;
//           NSString *imageCaption = nil;
        // find start of IMG tag
        [theScanner scanUpToString:@"<img" intoString:nil];
        if (![theScanner isAtEnd]) {
            NSCharacterSet *charset = [NSCharacterSet characterSetWithCharactersInString:@">"];
            [theScanner scanUpToCharactersFromSet:charset intoString:&strippedText];
            cleanContent = [cleanContent stringByReplacingOccurrencesOfString:
                            [ NSString stringWithFormat:@"%@>", strippedText]
                                                                   withString:@" "];
        }
//           [theScanner scanUpToString:@"<span" intoString:nil];
//           if (![theScanner isAtEnd]) {
//               NSCharacterSet *charset = [NSCharacterSet characterSetWithCharactersInString:@"/>"];
//               [theScanner scanUpToCharactersFromSet:charset intoString:&imageCaption];
//               cleanContent = [cleanContent stringByReplacingOccurrencesOfString:
//                               [ NSString stringWithFormat:@"%@>", imageCaption]
//                                                                      withString:@" "];
//           }
//        NSLog(@"%@",imageCaption);
        
           NSString *cssString = [NSString stringWithFormat:@"<style type=\"text/css\">\
                                  td{border-color:#c6c6c6 !important;}\
                                  table {font-family: arial; font-size: 18px;color:#c6c6c6;}\
                                  span {}\
                                  a{text-decoration:none;color:#c6c6c6;}\
                                  body{font-family: arial; font-size: 18px;}\
                                  </style>"];
           NSString *htmlString = [NSString stringWithFormat:@"<html>%@<body><div style=\"color:#c6c6c6;\"><img src=\"%@\" style =\"float:right;width:263px;border:5px solid black;\"/>\%@</div></body></html>",cssString,self.newsObject.imageURL, cleanContent];
        
        [newsDetailContent loadHTMLString: htmlString baseURL:[NSURL URLWithString:nil]];
            newsDetailContent.scrollView.bounces = NO;
         [self addSubview:newsDetailContent];
               
        
        [newsContentContainer setContentSize:CGSizeMake(newsContentContainer.frame.size.width, newsContent.frame.size.height)];
        
        
        
        newsTitle.text = self.newsObject.title;

    }
    return self;
}
-(id)initWithFrame:(CGRect)frame andNewsObject:(News *)news{
    self.newsObject = news;
    
    return [self initWithFrame:frame];
}
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    return YES;
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    newsDetailContent.opaque = YES;
    NSLog(@"DONE");
}
@end
