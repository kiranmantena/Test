//
//  HKStyle.h
//  Kleepon
//
//  Created by Hendrik Kusuma on 13/2/12.
//  Copyright (c) 2012 PT Kleepon Indonesia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKStyle : NSObject

+(NSDateFormatter *)wsDateFormat;
+(NSDateFormatter *)wsParamDateFormat;
+(CGRect)dynamicLabelHeight:(UILabel *)targetedLabel:(CGFloat)targetedWidth;
+(UILabel *)movieSeparatorTitleLabel:(CGFloat)positionY;
+(UILabel *)movieSeparatorContentLabel:(CGFloat)positionY;
@end
