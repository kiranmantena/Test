//
//  HKStyle.m
//  Kleepon
//
//  Created by Hendrik Kusuma on 13/2/12.
//  Copyright (c) 2012 PT Kleepon Indonesia. All rights reserved.
//

#import "HKStyle.h"

@implementation HKStyle

+(NSDateFormatter *)wsDateFormat{
    NSDateFormatter *wsFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [wsFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return wsFormatter;
}
+(NSDateFormatter *)wsParamDateFormat{
    NSDateFormatter *wsFormatter = [[[NSDateFormatter alloc] init] autorelease];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [wsFormatter setLocale:usLocale];
    [usLocale release];
    [wsFormatter setDateFormat:@"MMM dd, yyyy HH:mm:ss"];
//    Feb 12, 2012 10:03:10 AM
    return wsFormatter;
}
+(CGRect)dynamicLabelHeight:(UILabel *)targetedLabel:(CGFloat)targetedWidth{
    
    
    CGSize maximumLabelSize = CGSizeMake(targetedWidth,9999);
    
    CGSize expectedLabelSize = [targetedLabel.text sizeWithFont:targetedLabel.font 
                                                    constrainedToSize:maximumLabelSize 
                                                        lineBreakMode:targetedLabel.lineBreakMode]; 
    
    //adjust the label the the new height.
    CGRect newLabelSize = targetedLabel.frame;
    newLabelSize.size.height = expectedLabelSize.height;
    return newLabelSize;

}
+(UILabel *)movieSeparatorTitleLabel:(CGFloat)positionY{
    UILabel *returnedLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, positionY, 320, 20)];
    [returnedLbl setBackgroundColor:[UIColor clearColor]];
    [returnedLbl setFont:[UIFont fontWithName:@"Helvetica" size:14]];
    returnedLbl.textColor = [UIColor whiteColor];
    
    return [returnedLbl autorelease];
}
+(UILabel *)movieSeparatorContentLabel:(CGFloat)positionY{
    UILabel *returnedLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, positionY, 320, 20)];
    [returnedLbl setBackgroundColor:[UIColor clearColor]];
    [returnedLbl setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    returnedLbl.textColor = [UIColor grayColor];
    
    return [returnedLbl autorelease];
}
@end
