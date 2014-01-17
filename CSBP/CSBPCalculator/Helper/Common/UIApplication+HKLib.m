//
//  UIApplication+HKLib.m
//  Warcod
//
//  Created by Hendrik Kusuma on 9/27/11.
//  Copyright 2011 Warcod. All rights reserved.
//

#import "UIApplication+HKLib.h"

@implementation UIApplication(HKLib)

+ (id<HKApplication>)applicationController {
	return (id<HKApplication>)[[UIApplication sharedApplication] delegate];
}

@end
