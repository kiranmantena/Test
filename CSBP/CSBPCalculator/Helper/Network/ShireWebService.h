//
//  ShireWebService.h
//  CSBPCalculator
//
//  Created by HK on 8/8/12.
//
//

#import "WebService.h"
@protocol ShireWebServiceDelegate;
@interface ShireWebService : WebService{
    id<ShireWebServiceDelegate> delegate;
}

@property(assign)id<ShireWebServiceDelegate> delegate;

-(void) getAllShireInfomation;

@end

@protocol ShireWebServiceDelegate <NSObject>

@optional


@end
