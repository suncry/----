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

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //隐藏状态栏
    [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
//    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"])
    if (YES)

    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        WelcomeViewController *welcomeViewController = [[WelcomeViewController alloc]init];
        self.window.rootViewController = welcomeViewController;
    }
    else
    {
        DayViewController *dayViewController = [[DayViewController alloc]init];
        self.window.rootViewController = dayViewController;
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
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//推送完 执行的事件
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    //notification是发送通知时传入的字典信息
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"标题"
//                                                    message:notification.alertBody
//                                                   delegate:nil
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil];
//    [alert show];

    RingViewController *ringViewController = [[RingViewController alloc]init];
    self.window.rootViewController = ringViewController;
    
    
}
@end
