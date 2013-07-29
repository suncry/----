//
//  CyClockViewController.m
//  CyClock
//
//  Created by kratos on 13-6-6.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import "CyClockViewController.h"
#import "yearViewController.h"
#import "MyDrawView.h"
#import "TimePicker.h"

@interface CyClockViewController ()

@end

@implementation CyClockViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSUserDefaults standardUserDefaults] setValue:@"YES"
                                             forKey:@"notfirstToMainView"];
    
    //放大手势 进入到 yearView 页面
    UIPinchGestureRecognizer *_bigPinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self
                                                                                   action:@selector(toYearView)];
    [self.view addGestureRecognizer:_bigPinch];
    
    
//    _backGroundImageView = [[UIImageView alloc]init];
//    [_backGroundImageView setImage:[UIImage imageNamed:@"background.png"]];
//    _backGroundImageView.frame = CGRectMake(0, 0, 320, 550);
//    [self.view addSubview:_backGroundImageView];
    
    //显示时钟
    [self show];
    
//    NSLog(@"[UIDevice currentDevice].systemVersion == %@",[UIDevice currentDevice].);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
//    self presentedViewController
}
-(void)toYearView
{
    [self performSegueWithIdentifier:@"toYearView" sender:self];
}
-(void)show
{
#pragma mark 获取当前时间
    //获取当月的天数
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //    [formatter setDateFormat:@"YYYY-MM-dd-hh:mm:ss"];
    //month
    [formatter setDateFormat:@"MM"];
    _month = [formatter stringFromDate:[NSDate date]];
    NSLog(@"月：%@\n",_month);
    //day
    [formatter setDateFormat:@"dd"];
    _day = [formatter stringFromDate:[NSDate date]];
    NSLog(@"天：%@\n",_day);
    //hour
    [formatter setDateFormat:@"HH"];
    _hour = [formatter stringFromDate:[NSDate date]];
    NSLog(@"时：%@\n",_hour);
    //minute
    [formatter setDateFormat:@"mm"];
    _minute = [formatter stringFromDate:[NSDate date]];
    NSLog(@"分：%@\n",_minute);
    //seconds
    [formatter setDateFormat:@"ss"];
    _seconds = [formatter stringFromDate:[NSDate date]];
    NSLog(@"秒：%@\n",_seconds);
    
    
    [formatter setDateFormat:@"EEEE MMMM d"]; // 显示 星期的格式
    NSString *_test = [[NSString alloc]init];
    _test = [formatter stringFromDate:[NSDate date]];
    NSLog(@"秒：%@\n",_test);
    
    
    
#pragma mark 显示时间
    //小时第一位
    _hourOneImageView = [[UIImageView alloc]init];
    hour1 = [_hour intValue]/10;
    NSString *hourOneString = [[NSString alloc]initWithFormat:@"%d.png",hour1];
    [_hourOneImageView setImage:[UIImage imageNamed:hourOneString]];
    _hourOneImageView.frame = CGRectMake(69, 111, 68, 109);
    [self.view addSubview:_hourOneImageView];
    //小时第二位
    _hourTwoImageView = [[UIImageView alloc]init];
    hour2 = [_hour intValue]%10;
    NSString *hourTwoString = [[NSString alloc]initWithFormat:@"%d.png",hour2];
    [_hourTwoImageView setImage:[UIImage imageNamed:hourTwoString]];
    _hourTwoImageView.frame = CGRectMake(184, 111, 68, 109);
    [self.view addSubview:_hourTwoImageView];
    //冒号
//    _maohaoImageView = [[UIImageView alloc]init];
//    [_maohaoImageView setImage:[UIImage imageNamed:@"冒号"]];
//    _maohaoImageView.frame = CGRectMake(150, 208, 20, 64);
//    [self.view addSubview:_maohaoImageView];
    //分钟第一位
    _minuteOneImageView = [[UIImageView alloc]init];
    minute1 = [_minute intValue]/10;
    NSString *minuteOneString = [[NSString alloc]initWithFormat:@"%d.png",minute1];
    [_minuteOneImageView setImage:[UIImage imageNamed:minuteOneString]];
    _minuteOneImageView.frame = CGRectMake(69, 353, 68, 109);
    [self.view addSubview:_minuteOneImageView];
    //分钟第二位
    _minuteTwoImageView = [[UIImageView alloc]init];
    minute2 = [_minute intValue]%10;
    NSString *minuteTwoString = [[NSString alloc]initWithFormat:@"%d.png",minute2];
    [_minuteTwoImageView setImage:[UIImage imageNamed:minuteTwoString]];
    _minuteTwoImageView.frame = CGRectMake(184, 353, 68, 109);
    [self.view addSubview:_minuteTwoImageView];
#pragma mark 运行时钟
    seconds = [_seconds intValue];
    
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(secondsChange)
                                   userInfo:nil
                                    repeats:YES];
    //changeMinute1为改变分钟第一位 changeMinute2为改变分钟第二位  其他类似 1代表第一位 2代表第二位
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(minute2Change) name:@"changeMinute2"
                                              object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(minute1Change) name:@"changeMinute1"
                                              object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(hour2Change) name:@"changeHour2"
                                              object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(hour1Change) name:@"changeHour1"
                                              object:nil];
    
}
-(void)secondsChange
{
    if (seconds < 60)
    {
        seconds ++;
    }
    else
    {
        seconds = 0;
        //分钟数加1
        [[NSNotificationCenter defaultCenter]postNotificationName:@"changeMinute2"
                                                           object:self];
    }
}
-(void)minute2Change
{
    if (minute2 < 9)
    {
        minute2 ++;
    }
    else
    {
        minute2 = 0;
        //分钟加10
        [[NSNotificationCenter defaultCenter]postNotificationName:@"changeMinute1"
                                                           object:self];
    }
    NSString *minuteTwoString = [[NSString alloc]initWithFormat:@"%d.png",minute2];
    [_minuteTwoImageView setImage:[UIImage imageNamed:minuteTwoString]];
    [self.view addSubview:_minuteTwoImageView];
}
-(void)minute1Change
{
    if (minute1 < 5)
    {
        minute1 ++;
    }
    else
    {
        minute1 = 0;
        //小时加1
        [[NSNotificationCenter defaultCenter]postNotificationName:@"changeHour2"
                                                           object:self];
    }
    NSString *minuteOneString = [[NSString alloc]initWithFormat:@"%d.png",minute1];
    [_minuteOneImageView setImage:[UIImage imageNamed:minuteOneString]];
    [self.view addSubview:_minuteOneImageView];
}
-(void)hour2Change
{
    if (hour1 == 0 || hour1 == 1 )
    {
        if (hour2 < 9) {
            hour2 ++;
        }
        else
        {
            hour2 = 0;
            //小时加10
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeHour1"
                                                               object:self];
        }
    }
    else
    {
        if (hour2 < 4) {
            hour2 ++;
        }
        else
        {
            hour2 = 0;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeHour1"
                                                               object:self];
        }
    }
    NSString *minuteOneString = [[NSString alloc]initWithFormat:@"%d.png",minute1];
    [_minuteOneImageView setImage:[UIImage imageNamed:minuteOneString]];
    [self.view addSubview:_minuteOneImageView];
}
-(void)hour1Change
{
    if(hour1 < 2)
    {
        hour1 ++;
    }
    else
    {
        hour1 = 0;
    }
    NSString *hourOneString = [[NSString alloc]initWithFormat:@"%d.png",hour1];
    [_hourOneImageView setImage:[UIImage imageNamed:hourOneString]];
    [self.view addSubview:_hourOneImageView];
}
@end
