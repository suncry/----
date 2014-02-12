//
//  AppDelegate.h
//  Clock
//
//  Created by Suncry on 13-6-24.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMSplashAdController.h"
#import "DMRTSplashAdController.h"
#import "DMInterstitialAdController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,DMSplashAdControllerDelegate,DMInterstitialAdControllerDelegate>
{
    DMSplashAdController *_splashAd;
    //插屏广告
    DMInterstitialAdController *_dmInterstitial;

}
@property (strong, nonatomic) UIWindow *window;

@end
