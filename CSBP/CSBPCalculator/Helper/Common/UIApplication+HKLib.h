//
//  UIApplication+HKLib.h
//  Warcod
//
//  Created by Hendrik Kusuma on 9/27/11.
//  Copyright 2011 Warcod. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HKApplication.h"

@interface UIApplication(HKLib)
+ (id<HKApplication>)applicationController;
@end
