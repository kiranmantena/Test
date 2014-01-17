//
//  NutrientService.h
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 7/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebService.h"

@protocol NutrientServiceDelegate;
@interface NutrientService : WebService{
    id<NutrientServiceDelegate> delegate;
}

@property(assign)id<NutrientServiceDelegate> delegate;

-(void) getAllNutrientInfomation;

@end

@protocol NutrientServiceDelegate <NSObject>

@optional


@end
