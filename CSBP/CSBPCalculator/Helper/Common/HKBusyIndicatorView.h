//
//  HKBusyIndicatorView.h
//  MovPlex
//
//  Created by Hendrik Kusuma on 11/7/11.
//  Copyright (c) 2011 Warcod. All rights reserved.
//
#define BusyIndicatorViewTag 9001
#define BusyIndicatorViewWidth 200
#define BusyIndicatorViewHeight 128
#define BusyIndicatorViewAnimationDuration 0.2f
#define BusyIndicatorViewContentMargin 18

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface HKBusyIndicatorView : UIView{
	UIView *rectView;
	UIActivityIndicatorView *spinner;
	UILabel* label;
}

- (id)initWithApplicationFrame;
- (void)showWithMessage:(NSString*)message;
- (void)hide;


@end
