//
//  HKBusyIndicatorView.m
//  MovPlex
//
//  Created by Hendrik Kusuma on 11/7/11.
//  Copyright (c) 2011 Warcod. All rights reserved.
//

#import "HKBusyIndicatorView.h"

@interface HKBusyIndicatorView (PrivateMethods)
- (void)setupSubviews;
@end

@implementation HKBusyIndicatorView

- (id)initWithApplicationFrame {
	return [self initWithFrame:[[UIScreen mainScreen] applicationFrame]];
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.opaque = NO;
		self.backgroundColor = [UIColor clearColor];
		self.tag = BusyIndicatorViewTag;
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

- (void)setupSubviews {
	// Rect View
	rectView = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width - BusyIndicatorViewWidth) / 2, 
														(self.frame.size.height - BusyIndicatorViewHeight) / 2, 
														BusyIndicatorViewWidth, 
														BusyIndicatorViewHeight)];
	
	rectView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];	
	rectView.opaque = NO;
	rectView.layer.cornerRadius = 8;
	rectView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
	
	// Working Spinner
	spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[spinner setHidesWhenStopped:YES];
	[spinner sizeToFit];
	
	spinner.frame = CGRectMake((rectView.frame.size.width - spinner.frame.size.width) / 2, 
							   (rectView.frame.size.height - spinner.frame.size.height - BusyIndicatorViewContentMargin), 
							   spinner.frame.size.width, 
							   spinner.frame.size.height);
	spinner.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    
	spinner.hidden = NO;
	
	// Text label
	label = [[UILabel alloc] initWithFrame:CGRectMake(BusyIndicatorViewContentMargin, BusyIndicatorViewContentMargin, rectView.frame.size.width - BusyIndicatorViewContentMargin * 2, 28)];
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
    
    float targetRotation = -90.0;
    UIInterfaceOrientation  orientation = [UIDevice currentDevice].orientation;
    
    if (orientation == UIDeviceOrientationLandscapeLeft ) {
        targetRotation = 90.0;
    }
    
	
    rectView.transform = CGAffineTransformMakeRotation(targetRotation / 180.0 * M_PI);
    
    
	[self addSubview:rectView];
	[rectView release];
}

- (void)showWithMessage:(NSString*)message {
	label.text = message;
	[spinner startAnimating];
	
	self.hidden = NO;
	self.alpha = 0;
	[UIView beginAnimations:@"BusyIndicatorShow" context:nil];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:BusyIndicatorViewAnimationDuration];
	self.alpha = 1.0f;
	[UIView commitAnimations];
}

- (void)hide {
	[UIView beginAnimations:@"BusyIndicatorHide" context:nil];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:BusyIndicatorViewAnimationDuration];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	
	self.alpha = 0.0f;
	
	[UIView commitAnimations];
}

- (void) animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	if ([animationID isEqualToString:@"BusyIndicatorHide"] && [finished boolValue] == YES) {
		self.hidden = YES;
	}
}


- (void)dealloc {
    [super dealloc];
}

@end
