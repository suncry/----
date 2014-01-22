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
#import "MobClick.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //延长 启动画面的时间   防止一闪而过
//    [NSThread sleepForTimeInterval:1.0];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //设置 友盟 K
    [UMSocialData setAppKey:@"51e4f4ca56240b2cde105d5c"];
    
    [MobClick startWithAppkey:@"51e4f4ca56240b2cde105d5c"];

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
    
    //广告设置
    // 设置适合的背景图片
    // Set background image
    NSString *defaultImgName = @"Default";
    CGFloat offset = 0.0f;
    CGSize adSize;
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        adSize = DOMOB_AD_SIZE_768x576;
        defaultImgName = @"Default-Portrait";
        offset = 374.0f;
    } else {
        adSize = DOMOB_AD_SIZE_320x400;
        if ([UIScreen mainScreen].bounds.size.height > 480.0f) {
            defaultImgName = @"Default-568h";
            offset = 233.0f;
        } else {
            offset = 168.0f;
        }
    }
    
    BOOL isCacheSplash = YES;
    // 选择测试缓存开屏还是实时开屏，NO为实时开屏。
    // Choose NO or YES for RealTimeSplashView or SplashView
    // 初始化开屏广告控制器，此处使用的是测试ID，请登陆多盟官网（www.domob.cn）获取新的ID
    // Get your ID from Domob website
    NSString* testPubID = @"56OJzI84uNJBRyZr7o";
    NSString* testSplashPlacementID = @"16TLmgPlApEQcNUfkZ4Zjups";
    UIColor* bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:defaultImgName]];
    if (isCacheSplash) {
        _splashAd = [[DMSplashAdController alloc] initWithPublisherId:testPubID
                                                          placementId:testSplashPlacementID
                                                                 size:adSize
                                                               offset:offset
                                                               window:self.window
                                                           background:bgColor
                                                            animation:YES];
        _splashAd.delegate = self;
        if (_splashAd.isReady)
        {
            [_splashAd present];
        }
//        [_splashAd release];
    } else {
        DMRTSplashAdController* rtsplashAd = nil;
        rtsplashAd = [[DMRTSplashAdController alloc] initWithPublisherId:testPubID
                                                             placementId:testSplashPlacementID
                                                                    size:adSize
                                                                  offset:233.5f
                                                                  window:self.window
                                                              background:bgColor
                                                               animation:YES];
        
        
        rtsplashAd.delegate = self;
        [rtsplashAd present];
//        [rtsplashAd release];
    }

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
    NSLog(@"进入 后台 设置了闹钟");

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
    //这里设置 本地推送
    PushNotification *pushNotification = [[PushNotification alloc]init];
    [pushNotification setClock];
    NSLog(@"从通知中启动！！！");
//    application.applicationIconBadgeNumber -= 1;
    RingViewController *ringViewController = [[RingViewController alloc]init];
    self.window.rootViewController = ringViewController;
    [self.window makeKeyAndVisible];

}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}
#pragma mark -
#pragma makr Domob Splash Ad Delegate
//成功加开屏广告后调用
//This method will be used after load splash advertisement successfully
- (void)dmSplashAdSuccessToLoadAd:(DMSplashAdController *)dmSplashAd
{
    NSLog(@"[Domob Splash] success to load ad.");
}

// 当开屏广告加载失败后，回调该方法
// This method will be used after load splash advertisement faild
- (void)dmSplashAdFailToLoadAd:(DMSplashAdController *)dmSplashAd withError:(NSError *)err
{
    NSLog(@"[Domob Splash] fail to load ad.");
}

// 当插屏广告要被呈现出来前，回调该方法
// This method will be used before the splashView will show
- (void)dmSplashAdWillPresentScreen:(DMSplashAdController *)dmSplashAd
{
    NSLog(@"[Domob Splash] will appear on screen.");
}

// 当插屏广告被关闭后，回调该方法
// This method will be used after the splashView dismiss
- (void)dmSplashAdDidDismissScreen:(DMSplashAdController *)dmSplashAd
{
    NSLog(@"[Domob Splash] did disappear on screen.");
}

@end
