//
//  PushNotification.m
//  CyClock
//
//  Created by Suncry on 13-6-15.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import "PushNotification.h"
#import "MyDB.h"


@implementation PushNotification

- (void)setClock
{
    //取消通知：
    //通知完一定要取消，IOS最多允许最近本地通知数量是64个，超过限制的本地通知将被忽略。
    //1：删除应用所有通知
    NSLog(@"/////////////////////////////////////////////////////////////////////////////////////");
    NSLog(@"/////////////////////////////////////////////////////////////////////////////////////");

    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    MyDB *mydb = [[MyDB alloc]init];
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:(NSWeekdayCalendarUnit) fromDate:date];
    int weekDayNow=[comp weekday];
    NSLog(@"[mydb isON:weekDay] == %@",[mydb isON:weekDayNow]);
    for (int i = 0; i < 7 ; i++)
    {
        if ([[mydb isON:i+1] isEqualToString:@"YES"])
        {
            NSLog(@"星期 %d 闹钟是打开的！",i);
        }
    }
    NSLog(@"[[NSUserDefaults standardUserDefaults] boolForKey:@\"sleep\"] == %d",[[NSUserDefaults standardUserDefaults] boolForKey:@"sleep"]);
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"sleep"] && [[mydb isON:weekDayNow] isEqualToString:@"YES"])
    {
        NSLog(@"weekDayNow == %d 设置了 小睡闹钟",weekDayNow - 1);
        UILocalNotification *sleepNotification = [[UILocalNotification alloc] init];
        if (sleepNotification)
        {
            
            //时区
            sleepNotification.timeZone=[NSTimeZone defaultTimeZone];
            //推送时间---根据用户设置
            //            newNotification.fireDate=[[NSDate date] dateByAddingTimeInterval:10];
            sleepNotification.fireDate= [[NSUserDefaults standardUserDefaults]valueForKey:@"sleepNotificationTime"];
            NSLog(@"[[NSUserDefaults standardUserDefaults]valueForKey:@\"sleepNotificationTime\"] == %@",(NSDate *)[[NSUserDefaults standardUserDefaults]valueForKey:@"sleepNotificationTime"]);
            //推送内容
            sleepNotification.alertBody = @"开心迎接新的一天吧！";
            //应用右上角红色图标数字
            //            newNotification.applicationIconBadgeNumber = 0;
            [sleepNotification setSoundName:@"闹钟铃声.mp3"];
            //设置按钮
            sleepNotification.alertAction = @"关闭";
            //设置重复
            sleepNotification.repeatInterval = kCFCalendarUnitDay;
            [[UIApplication sharedApplication] scheduleLocalNotification:sleepNotification];
            
        }
    }

    for (int i = 0; i < 7 ; i++)
    {
        if ([[mydb isON:i+1] isEqualToString:@"NO"])
        {
            NSLog(@"星期 %d 闹钟是关闭的！",i);
            continue; //闹钟关闭那天不设置通知
        }
        //发送通知：
        UILocalNotification *newNotification = [[UILocalNotification alloc] init];
        if (newNotification)
        {
 
            //时区
            newNotification.timeZone=[NSTimeZone defaultTimeZone];
            //推送时间---根据用户设置
//            newNotification.fireDate=[[NSDate date] dateByAddingTimeInterval:10];
            newNotification.fireDate= [self fireDate:i+1];
            //推送内容
            newNotification.alertBody = @"开心迎接新的一天吧！";
            //应用右上角红色图标数字
//            newNotification.applicationIconBadgeNumber = 0;
            [newNotification setSoundName:@"闹钟铃声.mp3"];
            //设置按钮
            newNotification.alertAction = @"关闭";
            //设置重复
            newNotification.repeatInterval = NSWeekCalendarUnit;
            [[UIApplication sharedApplication] scheduleLocalNotification:newNotification];

        }
        NSLog(@"Post new localNotification:%@", newNotification);
    }
    NSLog(@"闹钟设定了！");
}
- (NSDate *)fireDate:(int)day
{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:(NSWeekdayCalendarUnit| NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSYearCalendarUnit |NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    int weekDayNow=[comp weekday];
    int hourNow = [comp hour];
    int minNow = [comp minute];
    int secNow = [comp second];
//    int yearNow = [comp year];
//    int monthNow = [comp month];
//    int dayNow = [comp day];
    //将fireDate 初始化到零点
    //这里不调整时差  因为 在发送通知时 会调整时差
    NSDate *fireDate = [[NSDate date]dateByAddingTimeInterval:-(hourNow*60*60+minNow*60+secNow)];
    //设定 指定day的fireDate
    fireDate=[fireDate dateByAddingTimeInterval:[self timeInterval:day weekday:weekDayNow]];
    return fireDate;
}

- (NSTimeInterval)timeInterval:(int)day weekday:(int)weekDayNow
{
    NSTimeInterval intervalTime = 0;
    
    MyDB *mydb = [[MyDB alloc]init];
    int clockHour;
    int clockMinute;
    clockHour = [mydb hour:day];
    clockMinute = [mydb minute:day];
    intervalTime = (day - weekDayNow) * (24 * 60 * 60) + (clockHour * 60 * 60) + (clockMinute * 60);
    return intervalTime;
    
    
}

@end
