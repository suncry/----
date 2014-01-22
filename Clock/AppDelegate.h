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

@interface AppDelegate : UIResponder <UIApplicationDelegate,DMSplashAdControllerDelegate>
{
    DMSplashAdController *_splashAd;

}
@property (strong, nonatomic) UIWindow *window;

@end
