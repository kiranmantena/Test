//
//  MenuSelectionCell.m
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuSelectionCell.h"

@implementation MenuSelectionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 188, 2)];
        UIImageView *separatorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TableBorder.png"]];
        [separatorView addSubview:separatorImageView];
        [self addSubview:separatorView];
        
        self.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
   
    // Configure the view for the selected state
}

-(void)setSelectionStyle:(UITableViewCellSelectionStyle)selectionStyle{
    [super setSelectionStyle:selectionStyle];
    CGFloat height =50;
    if (self.frame.size.height >50) {
        height = 94;
    }
    UIView *overlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 189, height)];
    UIImageView *overlayImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 189, height)];
    [overlayImage setImage:[UIImage imageNamed:@"TableCellOverlay.png"]];
    [overlayView addSubview:overlayImage];
    [overlayImage release];
    self.selectedBackgroundView = overlayView;
    [overlayView release];
}
@end
