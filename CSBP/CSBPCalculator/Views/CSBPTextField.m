//
//  CSBPTextField.m
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 29/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CSBPTextField.h"

@implementation CSBPTextField
@synthesize horizontalPadding, verticalPadding;
- (CGRect)textRectForBounds:(CGRect)bounds {
    horizontalPadding =15;
    verticalPadding = 10;
    return CGRectMake(bounds.origin.x + horizontalPadding, bounds.origin.y + verticalPadding, bounds.size.width - horizontalPadding*2, bounds.size.height - verticalPadding*2);
}
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

@end
