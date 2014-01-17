//
//  HKActivityIndicator.h
//  Warcod
//
//  Created by HK on 9/19/11.
//  Copyright 2011 Warcod. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define ActivityIndicatorViewTag 9001
#define ActivityIndicatorViewWidth 200
#define ActivityIndicatorViewHeight 128
#define ActivityIndicatorViewAnimationDuration 0.2f
#define ActivityIndicatorViewContentMargin 18

@interface HKActivityIndicatorView : UIView {
    UIView *rectView;
	UIActivityIndicatorView *spinner;
	UILabel* label;
}

- (id)initWithApplicationFrame;
- (void)showWithMessage:(NSString*)message;
- (void)hide;

@end
