//
//  UIScreen+HKLib.m
//  MovPlex
//
//  Created by Hendrik Kusuma on 10/24/11.
//  Copyright (c) 2011 Warcod. All rights reserved.
//

#import "UIScreen+HKLib.h"

@implementation UIScreen(HKLib)
+ (BOOL)highResolution {
	BOOL highResolution = NO;
	if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
		CGFloat scale = [[UIScreen mainScreen] scale];
		if (scale > 1.0) {
			highResolution = YES;
		}
	}
	return highResolution;
}
@end
