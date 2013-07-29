//
//  AppDelegate.m
//  Clock
//
//  Created by Suncry on 13-6-24.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import "AppDelegate.h"
#import "DayViewController.h"
#import "YearViewController.h"
#import "PushNotification.h"
#import "RingViewController.h"
#import "WelcomeViewController.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "MMDrawerBarButtonItem.h"
#import "SettingViewController.h"
#import "InfoViewController.h"
#import "UMSocial.h"
#import "WXApi.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //延长 启动画面的时间   防止一闪而过
    [NSThread sleepForTimeInterval:2.0];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //设置 友盟 K
    [UMSocialData setAppKey:@"51e4f4ca56240b2cde105d5c"];
    //设置 微信 K
    [WXApi registerApp:@"wx86caf90079225ab8"];
    //隐藏状态栏
    [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"])
//    if (YES)

    {
        WelcomeViewController *welcomeViewController = [[WelcomeViewController alloc]init];
        self.window.rootViewController = welcomeViewController;
    }
    else
    {
//        DayViewController *dayViewController = [[DayViewController alloc]init];
//        self.window.rootViewController = dayViewController;
        SettingViewController * leftDrawer = [[SettingViewController alloc] init];
        leftDrawer.view.backgroundColor = [UIColor blackColor];
        DayViewController * center = [[DayViewController alloc] init];
        center.view.backgroundColor = [UIColor yellowColor];
        InfoViewController * rightDrawer = [[InfoViewController alloc] init];
        rightDrawer.view.backgroundColor = [UIColor greenColor];
        
        MMDrawerController * drawerController = [[MMDrawerController alloc]
                                                 initWithCenterViewController:center
                                                 leftDrawerViewController:leftDrawer
                                                 rightDrawerViewController:rightDrawer];
        
        
        [drawerController setMaximumRightDrawerWidth:320];
        [drawerController setMaximumLeftDrawerWidth:320];
        
        [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        
        self.window.rootViewController = drawerController;
        
        
    }
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    //这里设置 本地推送
    PushNotification *pushNotification = [[PushNotification alloc]init];
    [pushNotification setClock];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [UMSocialSnsService  applicationDidBecomeActive];

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//推送完 执行的事件
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{

    application.applicationIconBadgeNumber -= 1;

    RingViewController *ringViewController = [[RingViewController alloc]init];
    
    
    [UIView animateWithDuration:1.0 delay:0 options:0 animations:^(){
        self.window.rootViewController.view.alpha = 1.0;
        [self.window.rootViewController.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        self.window.rootViewController.view.alpha = 0.3;
    } completion:^(BOOL finished)
     {
         self.window.rootViewController = ringViewController;

     }];
    
    //////////////////////////////////////////////////////////////////////
    
    
}



- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}
@end
