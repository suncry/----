//
//  MyDrawView.h
//  CyClock
//
//  Created by Suncry on 13-6-7.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyDrawView : UIView
{
    //今天是今年的第几天
    int _todayNum;
    
    //用于获取时间
    NSString *_year;
    NSString *_month;
    NSString *_day;
    NSString *_hour;
    NSString *_minute;
    NSString *_seconds;
    //用于显示时间
//    UIImageView *_backGroundImageView;//显示背景
    UIImageView *_hourOneImageView;//显示小时第一位
    UIImageView *_hourTwoImageView;//显示小时第二位
    UIImageView *_minuteOneImageView;//显示分钟第一位
    UIImageView *_minuteTwoImageView;//显示分钟第二位
//    UIImageView *_maohaoImageView;//显示冒号
    //用于计算秒数 来改变时间
    int seconds;
    int hour1;
    int hour2;
    int minute1;
    int minute2;
    //用于时钟的运行
    NSTimer *_timer;
}
-(int)todayNumOfYear:(NSString *)year
               Month:(NSString *)month
                 Day:(NSString *)day;
//-(UIColor *)passedDayFillColor;
//-(UIColor *)notPassedDayFillColor;

-(void)show;

@end
