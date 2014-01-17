//
//  HKActivityIndicator.m
//  Warcod
//
//  Created by HK on 9/19/11.
//  Copyright 2011 Warcod. All rights reserved.
//

#import "HKActivityIndicatorView.h"

@interface HKActivityIndicatorView (PrivateMethods)
- (void)setupSubviews;
@end

@implementation HKActivityIndicatorView

- (id)initWithApplicationFrame {
	return [self initWithFrame:[[UIScreen mainScreen] applicationFrame]];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
		self.backgroundColor = [UIColor clearColor];
		self.tag = ActivityIndicatorViewTag;
		self.userInteractionEnabled = YES;
		[self setupSubviews];
    }
    return self;
}

- (void)setUserInteractionEnabled:(BOOL)enabled {
	[super setUserInteractionEnabled:enabled];
	if (enabled) {
		self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
	} else {
		self.backgroundColor = [UIColor clearColor];
	}
}

- (void)showWithMessage:(NSString*)message {
	label.text = message;
	[spinner startAnimating];
	
	self.hidden = NO;
	self.alpha = 0;
	[UIView beginAnimations:@"ActivityIndicatorShow" context:nil];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:ActivityIndicatorViewAnimationDuration];
	self.alpha = 1.0f;
	[UIView commitAnimations];
}

- (void)hide {
	[UIView beginAnimations:@"ActivityIndicatorHide" context:nil];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:ActivityIndicatorViewAnimationDuration];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	
	self.alpha = 0.0f;
	
	[UIView commitAnimations];
}

- (void) animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	if ([animationID isEqualToString:@"ActivityIndicatorHide"] && [finished boolValue] == YES) {
		self.hidden = YES;
	}
}

- (void)setupSubviews {
	// Rect View
	rectView = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width - ActivityIndicatorViewWidth) / 2, 
														(self.frame.size.height - ActivityIndicatorViewHeight) / 2, 
														ActivityIndicatorViewWidth, 
														ActivityIndicatorViewHeight)];
	
	rectView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];	
	rectView.opaque = NO;
	rectView.layer.cornerRadius = 8;
	rectView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
	
	// Working Spinner
	spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[spinner setHidesWhenStopped:YES];
	[spinner sizeToFit];
	
	spinner.frame = CGRectMake((rectView.frame.size.width - spinner.frame.size.width) / 2, 
							   (rectView.frame.size.height - spinner.frame.size.height - ActivityIndicatorViewContentMargin), 
							   spinner.frame.size.width, 
							   spinner.frame.size.height);
	spinner.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    
	spinner.hidden = NO;
	
	// Text label
	label = [[UILabel alloc] initWithFrame:CGRectMake(ActivityIndicatorViewContentMargin, ActivityIndicatorViewContentMargin, rectView.frame.size.width - ActivityIndicatorViewContentMargin * 2, 28)];
	label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
	label.lineBreakMode = UILineBreakModeWordWrap;
	
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor whiteColor];
	label.textAlignment = UITextAlignmentCenter;
	label.font = [UIFont boldSystemFontOfSize:16];
	label.adjustsFontSizeToFitWidth = YES;
	label.minimumFontSize = 12;
	
	[rectView addSubview:spinner];
	[rectView addSubview:label];
	
	[spinner release];
	[label release];
	
	[self addSubview:rectView];
	[rectView release];
}


- (void)dealloc
{
    [super dealloc];
}

@end
