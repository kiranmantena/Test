//
//  RCSwitchWetDry.m
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 7/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RCSwitchWetDry.h"

@implementation RCSwitchWetDry

- (void)initCommon
{
	[super initCommon];
	wetText = [UILabel new];
	wetText.text = NSLocalizedString(@"Wet", @"Switch localized string");
	wetText.textColor = [UIColor whiteColor];
	wetText.font = [UIFont boldSystemFontOfSize:17];
	wetText.shadowColor = [UIColor colorWithWhite:0.175 alpha:1.0];
	
	dryText = [UILabel new];
	dryText.text = NSLocalizedString(@"Dry", @"Switch localized string");
	dryText.textColor = [UIColor grayColor];
	dryText.font = [UIFont boldSystemFontOfSize:17];	
}

- (void)dealloc
{
	[wetText release];
	[dryText release];
	[super dealloc];
}

- (void)drawUnderlayersInRect:(CGRect)aRect withOffset:(float)offset inTrackWidth:(float)trackWidth
{
	{
		CGRect textRect = [self bounds];
		textRect.origin.x += 14.0 + (offset - trackWidth);
		[wetText drawTextInRect:textRect];	
	}
	
	{
		CGRect textRect = [self bounds];
		textRect.origin.x += (offset + trackWidth) - 14.0;
		[dryText drawTextInRect:textRect];
	}	
}


@end
