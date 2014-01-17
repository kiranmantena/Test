//
//  CommonFunctions.h
//  CSBPCalculator
//
//  Created by Hendrik Kusuma on 25/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define FLOATCOLOR(r,g,b) {r/255.0, g/255.0, b/255.0,1 }
#define FLOATACOLOR(r,g,b,a) {r/255.0, g/255.0, b/255.0,a }

#define CSBPWebServiceURL            @"http://www.csbp-fertilisers.com.au/modules/csbpwebservices.asmx/%@"

#define CurrentDBVersion                2

#define WebServiceErrorCode             9999