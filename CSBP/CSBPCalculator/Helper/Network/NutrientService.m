//
//  NutrientService.m
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 7/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NutrientService.h"
#import "DataManager.h"

@implementation NutrientService
@synthesize delegate;

- (void)    getAllNutrientInfomation{
    [self beginRequestPostAction:@"GetNutrientDeficiencies" parameters:nil];
}
#pragma mark -
#pragma mark Handler
- (void)didFinishAction:(NSString *)action response:(NSDictionary *)response object:(NSObject *)object {
    if ([action isEqualToString:@"GetNutrientDeficiencies"]) {
        NSArray *nutrientArray = [[response objectForKey:@"d"] objectFromJSONString];
       
        if ([Application.dataManager getAllNutrient].count>0) {
            [Application.dataManager removeAllObject:@"Nutrient"];
            [Application.dataManager removeAllObject:@"Crop"];
        }
        for (NSDictionary *nutrientDict in nutrientArray) {
//             NSLog(@"NUTRIENT DEFICIENCY:%@",nutrientDict);
            
            Crop *crop = [Application.dataManager insertNewObject:@"Crop"];
            crop.cropType = [nutrientDict objectForKey:@"CropType"];
            NSArray *nutrientDetailArr = [nutrientDict objectForKey:@"Nutrients"];
            
            
            if (nutrientDetailArr.hasObject) {
                for (NSDictionary *nutrientDetail in nutrientDetailArr) {
                    Nutrient * nutrient = [Application.dataManager insertNewObject:@"Nutrient"];
                    
                    nutrient.nutrientName = [nutrientDetail objectForKey:@"Nutrient"];
                    nutrient.content = [nutrientDetail objectForKey:@"Content"];
                    if (![[nutrientDetail objectForKey:@"Image1"] isEqual:[NSNull null]]) {
                         nutrient.imageURL_1 = [nutrientDetail objectForKey:@"Image1"];
                    }
                    if (![[nutrientDetail objectForKey:@"Image2"] isEqual:[NSNull null]]) {
                        nutrient.imageURL_2 = [nutrientDetail objectForKey:@"Image2"];

                    }
                    if (![[nutrientDetail objectForKey:@"Image3"] isEqual:[NSNull null]]) {
                        nutrient.imageURL_3 = [nutrientDetail objectForKey:@"Image3"];
                    }
                    nutrient.crops = crop;
                    [Application.dataManager save];

                }
            }
            else{
                [Application.dataManager save];
            }
            
        }
        //        for (NSDictionary *cityDict in cityArray) {
        //            Cities *city = [Application.dataManager getCityById:[cityDict objectForKey:@"ID"]];
        //            if (city == nil) {
        //                city = [Application.dataManager insertNewObject:@"Cities"];
        //            }
        //            city.cityId = [cityDict objectForKey:@"ID"];
        //            city.cityName = [cityDict objectForKey:@"CityName"];
        //            [Application.dataManager save];
        //        }
    }    
}

@end
