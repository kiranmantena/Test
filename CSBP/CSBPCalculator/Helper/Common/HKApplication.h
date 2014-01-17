//
//  HKApplication.h
//  Warcod
//
//  Created by Hendrik Kusuma on 9/26/11.
//  Copyright 2011 Warcod. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#define Application [UIApplication applicationController]

//@class Facebook;
//@class SA_OAuthTwitterEngine;

#define APNotificationMainMenuDidSync               @"APNotificationMainMenuDidSync"

#define APNotificationMainMenuImageChanged          @"APNotificationMainMenuImageChanged"
#define APNotificationComingSoonImageChanged       @"APNotificationComingSoonImageChanged"
#define APNotificationOptionsImageChanged          @"APNotificationOptionsImageChanged"

#define APNotificationNowPlayingImageDownload       @"APNotificationNowPlayingImageDownload"
#define APNotificationComingSoonImageDownload       @"APNotificationComingSoonImageDownload"
#define APNotificationOptionsImageDownload          @"APNotificationOptionsImageDownload"

#define APNotificationNowPlayingImageChanged        @"APNotificationNowPlayingImageChanged"
#define APNotificationComingSoonImageChanged        @"APNotificationComingSoonImageChanged"
#define APNotificationSettingImageChanged           @"APNotificationSettingImageChanged"


#define APNotificationLocationUpdateFail			@"APNotificationLocationUpdateFail"
#define APNotificationUserLoggedIn					@"APNotificationUserLoggedIn"
#define APNotificationUserLoggedOut					@"APNotificationUserLoggedOut"

#define APNotificationMovieCoverImageDownload @"APNotificationMovieCoverImageDownload"
#define APNotificationMovieCoverSmallImageDownload @"APNotificationMovieCoverSmallImageDownload"
#define APNotificationMovieCoverBigImageDownload @"APNotificationMovieCoverBigImageDownload"

#define APNotificationMovieCoverImageChanged        @"APNotificationMovieCoverImageChanged"
#define APNotificationMovieCoverSmallImageChanged        @"APNotificationMovieCoverSmallImageChanged"
#define APNotificationMovieCoverBigImageChanged           @"APNotificationMovieCoverBigImageChanged"

#define CMNotificationDataDownloaded                @"CMNotificationDataDownloaded"
#define TLNotificationDataDownloaded                @"TLNotificationDataDownloaded"
#define TMNotificationDataDownloaded    @"TMNotificationDataDownloaded"

@class DataManager;
@class SyncMaster;

@protocol HKApplication 

- (DataManager *)dataManager;
- (SyncMaster *)syncMaster;
//- (Facebook *)facebook;
//- (SA_OAuthTwitterEngine *) twitter;
// Application busy indicator
- (void)showBusy;
- (void)showBusyWithMessage:(NSString*)message;
- (void)showBusyWithMessage:(NSString *)message disableUserInteraction:(BOOL)disableUserInteraction;
- (void)hideBusy;
@end
