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
    int weekDayNow=[comp weekday];//今天星期几
//    NSLog(@"[mydb isON:weekDay] == %@",[mydb isON:weekDayNow]);
    for (int i = 0; i < 7 ; i++)
    {
        if ([[mydb isON:i+1] isEqualToString:@"YES"])
        {
            NSLog(@"星期 %d 闹钟是打开的！",i);
        }
    }
//    NSLog(@"[[NSUserDefaults standardUserDefaults] boolForKey:@\"sleep\"] == %d",[[NSUserDefaults standardUserDefaults] boolForKey:@"sleep"]);
    NSLog(@"点击了小睡吗？ == %d",[[NSUserDefaults standardUserDefaults] boolForKey:@"sleep"]);

    //如果现在的时候 已经比小睡提醒的时间晚了   就不设置小睡闹钟了
    NSDate *nowDate = [NSDate date];
    if ([[nowDate earlierDate:[[NSUserDefaults standardUserDefaults]valueForKey:@"sleepNotificationTime"]] isEqualToDate:nowDate])
    {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"sleep"] && [[mydb isON:weekDayNow] isEqualToString:@"YES"])
        {
        //如果现在的时候 已经比小睡提醒的时间晚了   就不设置小睡闹钟了

        NSLog(@"weekDayNow == %d 设置了 小睡闹钟",weekDayNow - 1);
        UILocalNotification *sleepNotification = [[UILocalNotification alloc] init];
        if (sleepNotification)
            {
            //时区
            sleepNotification.timeZone=[NSTimeZone defaultTimeZone];
            //推送时间---根据用户设置
            sleepNotification.fireDate= [[NSUserDefaults standardUserDefaults]valueForKey:@"sleepNotificationTime"];
            NSLog(@"-->sleepNotificationTime == %@",(NSDate *)[[NSUserDefaults standardUserDefaults]valueForKey:@"sleepNotificationTime"]);
            //推送内容
            sleepNotification.alertBody = NSLocalizedString(@"ringText", @"");
            //应用右上角红色图标数字
            //            newNotification.applicationIconBadgeNumber = 0;
            [sleepNotification setSoundName:@"闹钟铃声.mp3"];
            //设置按钮
            sleepNotification.alertAction = @"关闭";
            //设置重复
            sleepNotification.repeatInterval = 0;
            [[UIApplication sharedApplication] scheduleLocalNotification:sleepNotification];
//            //如果现在的时间 比设定的闹钟时间晚 那么重复的闹钟铃声时间就设置为下周的对应时间
//            NSDate *nowDate = [NSDate date];
            UILocalNotification *sleepNotification1 = [[UILocalNotification alloc] init];
            UILocalNotification *sleepNotification2 = [[UILocalNotification alloc] init];
            UILocalNotification *sleepNotification3 = [[UILocalNotification alloc] init];
            UILocalNotification *sleepNotification4 = [[UILocalNotification alloc] init];
            UILocalNotification *sleepNotification5 = [[UILocalNotification alloc] init];
            UILocalNotification *sleepNotification6 = [[UILocalNotification alloc] init];
            UILocalNotification *sleepNotification7 = [[UILocalNotification alloc] init];
            UILocalNotification *sleepNotification8 = [[UILocalNotification alloc] init];
            UILocalNotification *sleepNotification9 = [[UILocalNotification alloc] init];

            sleepNotification1.fireDate= [[[NSUserDefaults standardUserDefaults]valueForKey:@"sleepNotificationTime"] dateByAddingTimeInterval:30];
            sleepNotification2.fireDate= [[[NSUserDefaults standardUserDefaults]valueForKey:@"sleepNotificationTime"] dateByAddingTimeInterval:30*2];
            sleepNotification3.fireDate= [[[NSUserDefaults standardUserDefaults]valueForKey:@"sleepNotificationTime"] dateByAddingTimeInterval:30*3];
            sleepNotification4.fireDate= [[[NSUserDefaults standardUserDefaults]valueForKey:@"sleepNotificationTime"] dateByAddingTimeInterval:30*4];
            sleepNotification5.fireDate= [[[NSUserDefaults standardUserDefaults]valueForKey:@"sleepNotificationTime"] dateByAddingTimeInterval:30*5];
            sleepNotification6.fireDate= [[[NSUserDefaults standardUserDefaults]valueForKey:@"sleepNotificationTime"] dateByAddingTimeInterval:30*6];
            sleepNotification7.fireDate= [[[NSUserDefaults standardUserDefaults]valueForKey:@"sleepNotificationTime"] dateByAddingTimeInterval:30*7];
            sleepNotification8.fireDate= [[[NSUserDefaults standardUserDefaults]valueForKey:@"sleepNotificationTime"] dateByAddingTimeInterval:30*8];
            sleepNotification9.fireDate= [[[NSUserDefaults standardUserDefaults]valueForKey:@"sleepNotificationTime"] dateByAddingTimeInterval:30*9];

            //推送内容
            sleepNotification1.alertBody = NSLocalizedString(@"ringText", @"");
            sleepNotification2.alertBody = NSLocalizedString(@"ringText", @"");
            sleepNotification3.alertBody = NSLocalizedString(@"ringText", @"");
            sleepNotification4.alertBody = NSLocalizedString(@"ringText", @"");
            sleepNotification5.alertBody = NSLocalizedString(@"ringText", @"");
            sleepNotification6.alertBody = NSLocalizedString(@"ringText", @"");
            sleepNotification7.alertBody = NSLocalizedString(@"ringText", @"");
            sleepNotification8.alertBody = NSLocalizedString(@"ringText", @"");
            sleepNotification9.alertBody = NSLocalizedString(@"ringText", @"");

            
            //应用右上角红色图标数字
            //            newNotification.applicationIconBadgeNumber = 0;
            [sleepNotification1 setSoundName:@"闹钟铃声.mp3"];
            [sleepNotification2 setSoundName:@"闹钟铃声.mp3"];
            [sleepNotification3 setSoundName:@"闹钟铃声.mp3"];
            [sleepNotification4 setSoundName:@"闹钟铃声.mp3"];
            [sleepNotification5 setSoundName:@"闹钟铃声.mp3"];
            [sleepNotification6 setSoundName:@"闹钟铃声.mp3"];
            [sleepNotification7 setSoundName:@"闹钟铃声.mp3"];
            [sleepNotification8 setSoundName:@"闹钟铃声.mp3"];
            [sleepNotification9 setSoundName:@"闹钟铃声.mp3"];


            
            //设置按钮
            sleepNotification1.alertAction = @"关闭";
            sleepNotification2.alertAction = @"关闭";
            sleepNotification3.alertAction = @"关闭";
            sleepNotification4.alertAction = @"关闭";
            sleepNotification5.alertAction = @"关闭";
            sleepNotification6.alertAction = @"关闭";
            sleepNotification7.alertAction = @"关闭";
            sleepNotification8.alertAction = @"关闭";
            sleepNotification9.alertAction = @"关闭";

            //设置重复
            sleepNotification1.repeatInterval = 0;
            sleepNotification2.repeatInterval = 0;
            sleepNotification3.repeatInterval = 0;
            sleepNotification4.repeatInterval = 0;
            sleepNotification5.repeatInterval = 0;
            sleepNotification6.repeatInterval = 0;
            sleepNotification7.repeatInterval = 0;
            sleepNotification8.repeatInterval = 0;
            sleepNotification9.repeatInterval = 0;

            //设置userinfo 方便在之后需要撤销的时候使用
//            NSDictionary *info = [NSDictionary dictionaryWithObject:@"重复的闹铃"forKey:@"repeatRing"];
//            sleepNotification1.userInfo = info;
//            sleepNotification2.userInfo = info;
            
            [[UIApplication sharedApplication] scheduleLocalNotification:sleepNotification1];
            [[UIApplication sharedApplication] scheduleLocalNotification:sleepNotification2];
            [[UIApplication sharedApplication] scheduleLocalNotification:sleepNotification3];
            [[UIApplication sharedApplication] scheduleLocalNotification:sleepNotification4];
            [[UIApplication sharedApplication] scheduleLocalNotification:sleepNotification5];
            [[UIApplication sharedApplication] scheduleLocalNotification:sleepNotification6];
            [[UIApplication sharedApplication] scheduleLocalNotification:sleepNotification7];
            [[UIApplication sharedApplication] scheduleLocalNotification:sleepNotification8];
            [[UIApplication sharedApplication] scheduleLocalNotification:sleepNotification9];

            NSLog(@"-->sleepNotification == %@",sleepNotification);
            NSLog(@"-->sleepNotification1 == %@",sleepNotification1);
            NSLog(@"-->sleepNotification2 == %@",sleepNotification2);
            NSLog(@"-->sleepNotification9 == %@",sleepNotification9);

            }
        }
    }
    else
    {
        NSLog(@"现在的时候已经比小睡提醒的时间晚了,就不设置小睡闹钟了");
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
        UILocalNotification *newNotification1 = [[UILocalNotification alloc] init];
        UILocalNotification *newNotification2 = [[UILocalNotification alloc] init];
        UILocalNotification *newNotification3 = [[UILocalNotification alloc] init];
        UILocalNotification *newNotification4 = [[UILocalNotification alloc] init];
        UILocalNotification *newNotification5 = [[UILocalNotification alloc] init];
        UILocalNotification *newNotification6 = [[UILocalNotification alloc] init];
        UILocalNotification *newNotification7 = [[UILocalNotification alloc] init];
        UILocalNotification *newNotification8 = [[UILocalNotification alloc] init];
        UILocalNotification *newNotification9 = [[UILocalNotification alloc] init];

        if (newNotification)
        {
            //时区
            newNotification.timeZone=[NSTimeZone defaultTimeZone];
            //推送时间---根据用户设置
            newNotification.fireDate= [self fireDate:i+1];
            //获取现在的时间
            NSDate *nowDate = [NSDate date];
//            NSLog(@"[NSDate date] == %@",nowDate);
//            
//            NSLog(@"laterDate == %@",[nowDate laterDate:[self fireDate:i+1]]);
            
            //如果现在的时间 比设定的闹钟时间晚 那么重复的闹钟铃声时间就设置为下周的对应时间
            if ([[nowDate laterDate:[self fireDate:i+1]] isEqualToDate:nowDate])
            {
                newNotification1.fireDate= [[self fireDate:i+1] dateByAddingTimeInterval:7*24*60*60+30];
                newNotification2.fireDate= [[self fireDate:i+1] dateByAddingTimeInterval:7*24*60*60+30*2];
                newNotification3.fireDate= [[self fireDate:i+1] dateByAddingTimeInterval:7*24*60*60+30*3];
                newNotification4.fireDate= [[self fireDate:i+1] dateByAddingTimeInterval:7*24*60*60+30*4];
                newNotification5.fireDate= [[self fireDate:i+1] dateByAddingTimeInterval:7*24*60*60+30*5];
                newNotification6.fireDate= [[self fireDate:i+1] dateByAddingTimeInterval:7*24*60*60+30*6];
                newNotification7.fireDate= [[self fireDate:i+1] dateByAddingTimeInterval:7*24*60*60+30*7];
                newNotification8.fireDate= [[self fireDate:i+1] dateByAddingTimeInterval:7*24*60*60+30*8];
                newNotification9.fireDate= [[self fireDate:i+1] dateByAddingTimeInterval:7*24*60*60+30*9];

            }
            else
            {
                newNotification1.fireDate= [[self fireDate:i+1] dateByAddingTimeInterval:30];
                newNotification2.fireDate= [[self fireDate:i+1] dateByAddingTimeInterval:30*2];
                newNotification3.fireDate= [[self fireDate:i+1] dateByAddingTimeInterval:30*3];
                newNotification4.fireDate= [[self fireDate:i+1] dateByAddingTimeInterval:30*4];
                newNotification5.fireDate= [[self fireDate:i+1] dateByAddingTimeInterval:30*5];
                newNotification6.fireDate= [[self fireDate:i+1] dateByAddingTimeInterval:30*6];
                newNotification7.fireDate= [[self fireDate:i+1] dateByAddingTimeInterval:30*7];
                newNotification8.fireDate= [[self fireDate:i+1] dateByAddingTimeInterval:30*8];
                newNotification9.fireDate= [[self fireDate:i+1] dateByAddingTimeInterval:30*9];

            }
            
            //推送内容
            newNotification.alertBody = NSLocalizedString(@"ringText", @"");
            newNotification1.alertBody = NSLocalizedString(@"ringText", @"");
            newNotification2.alertBody = NSLocalizedString(@"ringText", @"");
            newNotification3.alertBody = NSLocalizedString(@"ringText", @"");
            newNotification4.alertBody = NSLocalizedString(@"ringText", @"");
            newNotification5.alertBody = NSLocalizedString(@"ringText", @"");
            newNotification6.alertBody = NSLocalizedString(@"ringText", @"");
            newNotification7.alertBody = NSLocalizedString(@"ringText", @"");
            newNotification8.alertBody = NSLocalizedString(@"ringText", @"");
            newNotification9.alertBody = NSLocalizedString(@"ringText", @"");


            //应用右上角红色图标数字
//            newNotification.applicationIconBadgeNumber = 0;
            [newNotification setSoundName:@"闹钟铃声.mp3"];
            [newNotification1 setSoundName:@"闹钟铃声.mp3"];
            [newNotification2 setSoundName:@"闹钟铃声.mp3"];
            [newNotification3 setSoundName:@"闹钟铃声.mp3"];
            [newNotification4 setSoundName:@"闹钟铃声.mp3"];
            [newNotification5 setSoundName:@"闹钟铃声.mp3"];
            [newNotification6 setSoundName:@"闹钟铃声.mp3"];
            [newNotification7 setSoundName:@"闹钟铃声.mp3"];
            [newNotification8 setSoundName:@"闹钟铃声.mp3"];
            [newNotification9 setSoundName:@"闹钟铃声.mp3"];


            //设置按钮
            newNotification.alertAction = @"关闭";
            newNotification1.alertAction = @"关闭";
            newNotification2.alertAction = @"关闭";
            newNotification3.alertAction = @"关闭";
            newNotification4.alertAction = @"关闭";
            newNotification5.alertAction = @"关闭";
            newNotification6.alertAction = @"关闭";
            newNotification7.alertAction = @"关闭";
            newNotification8.alertAction = @"关闭";
            newNotification9.alertAction = @"关闭";

            //设置重复
            newNotification.repeatInterval = NSWeekCalendarUnit;
            newNotification1.repeatInterval = NSWeekCalendarUnit;
            newNotification2.repeatInterval = NSWeekCalendarUnit;
            newNotification3.repeatInterval = NSWeekCalendarUnit;
            newNotification4.repeatInterval = NSWeekCalendarUnit;
            newNotification5.repeatInterval = NSWeekCalendarUnit;
            newNotification6.repeatInterval = NSWeekCalendarUnit;
            newNotification7.repeatInterval = NSWeekCalendarUnit;
            newNotification8.repeatInterval = NSWeekCalendarUnit;
            newNotification9.repeatInterval = NSWeekCalendarUnit;

            //设置userinfo 方便在之后需要撤销的时候使用
//            NSDictionary *info = [NSDictionary dictionaryWithObject:@"重复的闹铃"forKey:@"repeatRing"];
//            newNotification1.userInfo = info;
//            newNotification2.userInfo = info;

            [[UIApplication sharedApplication] scheduleLocalNotification:newNotification];
            [[UIApplication sharedApplication] scheduleLocalNotification:newNotification1];
            [[UIApplication sharedApplication] scheduleLocalNotification:newNotification2];
            [[UIApplication sharedApplication] scheduleLocalNotification:newNotification3];
            [[UIApplication sharedApplication] scheduleLocalNotification:newNotification4];
            [[UIApplication sharedApplication] scheduleLocalNotification:newNotification5];
            [[UIApplication sharedApplication] scheduleLocalNotification:newNotification6];
            [[UIApplication sharedApplication] scheduleLocalNotification:newNotification7];
            [[UIApplication sharedApplication] scheduleLocalNotification:newNotification8];
            [[UIApplication sharedApplication] scheduleLocalNotification:newNotification9];



        }
        NSLog(@"-->提醒 ==%@", newNotification);
        NSLog(@"-->提醒1 ==%@", newNotification1);
        NSLog(@"-->提醒2 ==%@", newNotification2);
        NSLog(@"-->提醒9 ==%@", newNotification9);

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
