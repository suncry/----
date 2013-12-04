//
//  RingViewController.m
//  Clock
//
//  Created by Suncry on 13-6-24.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import "RingViewController.h"
#import "DayViewController.h"
#import "MyDB.h"
#import "SettingViewController.h"
#import "InfoViewController.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "MMDrawerBarButtonItem.h"
#import "PushNotification.h"


@interface RingViewController ()

@end

@implementation RingViewController
@synthesize ring = _ring;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
//    //这里设置 本地推送
//    PushNotification *pushNotification = [[PushNotification alloc]init];
//    [pushNotification setClock];
//    NSLog(@"从通知中启动！！！");
//    //    application.applicationIconBadgeNumber -= 1;

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [UIView animateWithDuration:1.0 delay:0 options:0 animations:^(){
        self.view.alpha = 0.3;
        [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        self.view.alpha = 1.0;
    } completion:^(BOOL finished)
     {
         
     }];
    
    //////////////////////////////////////////////////////////////////////
    //获取当月的天数
        
    [dayNumLable setText:[NSString stringWithFormat:@"%d",[self dayNum]]];
    
//    //背景音乐
    //后台播放 设置
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];

    
    //播放音乐设置
    NSString *musicFilePath = [[NSBundle mainBundle] pathForResource:@"闹钟铃声" ofType:@"mp3"];       //创建音乐文件路径
    NSURL *musicURL = [[NSURL alloc] initFileURLWithPath:musicFilePath];
    
    AVAudioPlayer *thePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    self.ring = thePlayer;
    //创建播放器
//    [thePlayer prepareToPlay];
    [self.ring setVolume:1];   //设置音量大小
    self.ring.numberOfLoops = -1;//设置音乐播放次数  -1为一直循环
    [self.ring play];   //播放
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)getUpBtnClick:(id)sender
{
    [self.ring stop];   //

    //////////////////////////////////////////////////////////////////////
    
    [UIView animateWithDuration:1.0 delay:0 options:0 animations:^(){
        self.view.alpha = 1.0;
        [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        self.view.alpha = 0.0;
    } completion:^(BOOL finished)
     {
         
     }];
    
    //////////////////////////////////////////////////////////////////////
    
    
    
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
    
    //起床之后就把 小睡通知 设为空
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"sleep"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"sleepNotificationTime"];

    
    [self presentViewController:drawerController animated:YES completion:nil];
}
- (IBAction)sleepBtnClick:(id)sender
{
    [self.ring stop];   //

    //////////////////////////////////////////////////////////////////////
    
    [UIView animateWithDuration:1.0 delay:0 options:0 animations:^(){
        self.view.alpha = 1.0;
        [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        self.view.alpha = 0.0;
    } completion:^(BOOL finished)
     {
         
     }];
    
    //////////////////////////////////////////////////////////////////////
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"sleep"];
    [[NSUserDefaults standardUserDefaults] setValue:[NSDate dateWithTimeIntervalSinceNow:5*60] forKey:@"sleepNotificationTime"];

    
    
//    UILocalNotification *sleepNotification = [[UILocalNotification alloc] init];
//    //发送通知：
//    if (sleepNotification)
//    {
//        //时区
//        sleepNotification.timeZone=[NSTimeZone defaultTimeZone];
//        
//        //推送时间---根据用户设置
//        //点击了  小睡之后   5分钟之后再响
////        sleepNotification.fireDate=[NSDate dateWithTimeIntervalSinceNow:5*60];
//        sleepNotification.fireDate=[NSDate dateWithTimeIntervalSinceNow:15];
//
//        //推送内容
//        sleepNotification.alertBody = @"开心迎接新的一天吧！";
//        [sleepNotification setSoundName:@"闹钟铃声.mp3"];
////        //设置按钮
//        sleepNotification.alertAction = @"关闭";
//        //设置重复
//        sleepNotification.repeatInterval = kCFCalendarUnitDay;
//        [[UIApplication sharedApplication] scheduleLocalNotification:sleepNotification];
//        
//           NSLog(@"小睡5分钟");
//        NSLog(@"sleepNotification == %@",sleepNotification);
//        [[NSUserDefaults standardUserDefaults] setValue:[NSDate dateWithTimeIntervalSinceNow:5*60] forKey:@"sleepNotificationTime"];
//
//        NSLog(@"设定的 [[NSUserDefaults standardUserDefaults]valueForKey:@\"sleepNotificationTime\"] == %@",(NSDate *)[[NSUserDefaults standardUserDefaults]valueForKey:@"sleepNotificationTime"]);
//
//    }

    
    
    
    ////////////////////////////////////////////////////////////
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
    
    
    [self presentViewController:drawerController animated:YES completion:nil];
}
-(int)dayNum
{
        int sum = 0,leap,yearInt,monthInt,dayInt;
        //        printf("\nplease input year,month,day\n");
        //        scanf("%d,%d,%d",&year,&month,&day);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //    [formatter setDateFormat:@"YYYY-MM-dd-hh:mm:ss"];
    //month
    [formatter setDateFormat:@"YYYY"];
    NSString *year = [formatter stringFromDate:[NSDate date]];
    //month
    [formatter setDateFormat:@"MM"];
    NSString *month = [formatter stringFromDate:[NSDate date]];
    //day
    [formatter setDateFormat:@"dd"];
    NSString *day = [formatter stringFromDate:[NSDate date]];

        NSString*stringMonth = month;
        monthInt =[stringMonth intValue];
        
        NSString*stringDay = day;
        dayInt =[stringDay intValue];
        
        NSString*stringYear = year;
        yearInt =[stringYear intValue];
        
        switch(monthInt) /*先计算某月以前月份的总天数*/
        {
            case 1:sum=0;break;
            case 2:sum=31;break;
            case 3:sum=59;break;
            case 4:sum=90;break;
            case 5:sum=120;break;
            case 6:sum=151;break;
            case 7:sum=181;break;
            case 8:sum=212;break;
            case 9:sum=243;break;
            case 10:sum=273;break;
            case 11:sum=304;break;
            case 12:sum=334;break;
            default:printf("data error");break;
                
        }
        sum=sum+dayInt; /*再加上某天的天数*/
        if(yearInt%400==0||(yearInt%4==0&&yearInt%100!=0)) /*判断是不是闰年*/
            leap=1;
        else
            leap=0;
        if(leap==1&&monthInt>2) /*如果是闰年且月份大于2,总天数应该加一天*/
            sum++;
        
        MyDB *mydb = [[MyDB alloc]init];
        return sum + (yearInt - [mydb year])*365;
}


@end
