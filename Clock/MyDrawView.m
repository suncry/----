//
//  MyDrawView.m
//  CyClock
//
//  Created by Suncry on 13-6-7.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import "MyDrawView.h"

@implementation MyDrawView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //先求出已经过了多少天
    //获取当月的天数
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //    [formatter setDateFormat:@"YYYY-MM-dd-hh:mm:ss"];
    //month
    [formatter setDateFormat:@"YYYY"];
    _year = [formatter stringFromDate:[NSDate date]];
    //month
    [formatter setDateFormat:@"MM"];
    _month = [formatter stringFromDate:[NSDate date]];
    //day
    [formatter setDateFormat:@"dd"];
    _day = [formatter stringFromDate:[NSDate date]];
    
    _todayNum = [self todayNumOfYear:_year Month:_month Day:_day]; //得到 今天是今年的第几天
    
    ////////////////////////////////////////////////////////////////////
    
    CGContextRef ref=UIGraphicsGetCurrentContext();//拿到当前被准备好的画板。在这个画板上画就是在当前视图上画
    
    
    CGContextBeginPath(ref);//这里提到一个很重要的概念叫路径（path），其实就是告诉画板环境，我们要开始画了，你记下。
    CGContextSetLineWidth(ref, 2.0);//制定了线的宽度
    
    CGContextMoveToPoint(ref,0, 0);//画线需要我解释吗？不用了吧？就是两点确定一条直线了。
    
    CGFloat _myColor[4]={0.0, 0.0, 0.0,1.0};//设置颜色
    
   //过去了的日子的颜色设定
    _passedColor1 = [UIColor colorWithRed:(CGFloat) 253/255.0
                                    green:(CGFloat) 124/255.0
                                     blue:(CGFloat) 128/255.0
                                    alpha:(CGFloat) 1.0];
    
    _passedColor2 = [UIColor colorWithRed:(CGFloat) 255/255.0
                                    green:(CGFloat) 101/255.0
                                     blue:(CGFloat) 115/255.0
                                    alpha:(CGFloat) 1.0];
    
    _passedColor3 = [UIColor colorWithRed:(CGFloat) 155/255.0
                                    green:(CGFloat) 27/255.0
                                     blue:(CGFloat) 50/255.0
                                    alpha:(CGFloat) 1.0];
    
    _passedColor4 = [UIColor colorWithRed:(CGFloat) 254/255.0
                                    green:(CGFloat) 68/255.0
                                     blue:(CGFloat) 81/255.0
                                    alpha:(CGFloat) 1.0];
    
    _passedColor5 = [UIColor colorWithRed:(CGFloat) 248/255.0
                                    green:(CGFloat) 41/255.0
                                     blue:(CGFloat) 57/255.0
                                    alpha:(CGFloat) 1.0];
    
    //还没过的日子的填充颜色
    _notPassedColor1 = [UIColor colorWithRed:(CGFloat) 254/255.0
                                    green:(CGFloat) 203/255.0
                                     blue:(CGFloat) 204/255.0
                                    alpha:(CGFloat) 1.0];
    
    _notPassedColor2 = [UIColor colorWithRed:(CGFloat) 255/255.0
                                    green:(CGFloat) 193/255.0
                                     blue:(CGFloat) 199/255.0
                                    alpha:(CGFloat) 1.0];
    
    _notPassedColor3 = [UIColor colorWithRed:(CGFloat) 255/255.0
                                    green:(CGFloat) 180/255.0
                                     blue:(CGFloat) 185/255.0
                                    alpha:(CGFloat) 1.0];
    
    _notPassedColor4 = [UIColor colorWithRed:(CGFloat) 252/255.0
                                    green:(CGFloat) 169/255.0
                                     blue:(CGFloat) 176/255.0
                                    alpha:(CGFloat) 1.0];
    
    _notPassedColor5 = [UIColor colorWithRed:(CGFloat) 215/255.0
                                    green:(CGFloat) 164/255.0
                                     blue:(CGFloat) 173/255.0
                                    alpha:(CGFloat) 1.0];
    
#pragma mark 随机填充
    CGContextSetStrokeColor(ref, _myColor);//设置了一下当前那个画笔的颜色。画笔啊！你记着我前面说的windows画图板吗？
    int sum = 0;
    for (int j = 0; j<26; j++)
    {
        for (int i = 0; i<14; i++)
        {
            if (sum < _todayNum)
            {
                CGContextSetFillColorWithColor(ref,[self passedDayFillColor].CGColor);
            }
            else
            {
                CGContextSetFillColorWithColor(ref,[self notPassedDayFillColor].CGColor);

            }
            if (DEVICE_IS_IPHONE5) {
                //iphone5 的格子
                CGContextFillRect(ref, CGRectMake(22*i+i, 21*j+j, 22, 21));
            }
            else
            {
                CGContextFillRect(ref, CGRectMake(22*i+i, 17.5*j+j, 22, 17.5));
                //iPhone4 的格子
            }
            sum ++;
        }
    }
    [self show];
}
-(int)todayNumOfYear:(NSString *)year
                     Month:(NSString *)month
                       Day:(NSString *)day

{
    {
        int sum = 0,leap,yearInt,monthInt,dayInt;
//        printf("\nplease input year,month,day\n");
//        scanf("%d,%d,%d",&year,&month,&day);
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
        return sum;
    }
}
-(UIColor *)passedDayFillColor
{
    int x = arc4random() % 100;
    if (x < 20)
    {
        return  _passedColor1;
    }
    else if (20 <= x && x < 40) {
        return  _passedColor2;
    }
    else if (40 <= x && x < 60) {
        return  _passedColor3;
    }
    else if (60 <= x && x < 80) {
        return  _passedColor4;
    }
    else if (80 <= x && x < 100) {
        return  _passedColor5;
    }
    return  _passedColor1;

}
-(UIColor *)notPassedDayFillColor
{
    int x = arc4random() % 100;
    if (x < 20)
    {
        return  _notPassedColor1;
    }
    else if (20 <= x && x < 40) {
        return  _notPassedColor2;
    }
    else if (40 <= x && x < 60) {
        return  _notPassedColor3;
    }
    else if (60 <= x && x < 80) {
        return  _notPassedColor4;
    }
    else if (80 <= x && x < 100) {
        return  _notPassedColor5;
    }
    return  _notPassedColor1;
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
    //day
    [formatter setDateFormat:@"dd"];
    _day = [formatter stringFromDate:[NSDate date]];
    //hour
    [formatter setDateFormat:@"HH"];
    _hour = [formatter stringFromDate:[NSDate date]];
    //minute
    [formatter setDateFormat:@"mm"];
    _minute = [formatter stringFromDate:[NSDate date]];
    //seconds
    [formatter setDateFormat:@"ss"];
    _seconds = [formatter stringFromDate:[NSDate date]];
    
    
//    [formatter setDateFormat:@"EEEE MMMM d"]; // 显示 星期的格式
    
    
    
#pragma mark 显示时间
    if (DEVICE_IS_IPHONE5)
    {
        //iphone5
        //小时第一位
        _hourOneImageView = [[UIImageView alloc]init];
        hour1 = [_hour intValue]/10;
        NSString *hourOneString = [[NSString alloc]initWithFormat:@"%d.png",hour1];
        [_hourOneImageView setImage:[UIImage imageNamed:hourOneString]];
        _hourOneImageView.frame = CGRectMake(69, 110, 68, 109);
        [self addSubview:_hourOneImageView];
        //小时第二位
        _hourTwoImageView = [[UIImageView alloc]init];
        hour2 = [_hour intValue]%10;
        NSString *hourTwoString = [[NSString alloc]initWithFormat:@"%d.png",hour2];
        [_hourTwoImageView setImage:[UIImage imageNamed:hourTwoString]];
        _hourTwoImageView.frame = CGRectMake(184, 110, 68, 109);
        [self addSubview:_hourTwoImageView];
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
        _minuteOneImageView.frame = CGRectMake(69, 352, 68, 109);
        [self addSubview:_minuteOneImageView];
        //分钟第二位
        _minuteTwoImageView = [[UIImageView alloc]init];
        minute2 = [_minute intValue]%10;
        NSString *minuteTwoString = [[NSString alloc]initWithFormat:@"%d.png",minute2];
        [_minuteTwoImageView setImage:[UIImage imageNamed:minuteTwoString]];
        _minuteTwoImageView.frame = CGRectMake(184, 352, 68, 109);
        [self addSubview:_minuteTwoImageView];
    }
    else
    {
        //iPhone4
        //小时第一位
        _hourOneImageView = [[UIImageView alloc]init];
        hour1 = [_hour intValue]/10;
        NSString *hourOneString = [[NSString alloc]initWithFormat:@"%d.png",hour1];
        [_hourOneImageView setImage:[UIImage imageNamed:hourOneString]];
        _hourOneImageView.frame = CGRectMake(69, 92.5, 68, 91.5);
        [self addSubview:_hourOneImageView];
        //小时第二位
        _hourTwoImageView = [[UIImageView alloc]init];
        hour2 = [_hour intValue]%10;
        NSString *hourTwoString = [[NSString alloc]initWithFormat:@"%d.png",hour2];
        [_hourTwoImageView setImage:[UIImage imageNamed:hourTwoString]];
        _hourTwoImageView.frame = CGRectMake(184, 92.5, 68, 91.5);
        [self addSubview:_hourTwoImageView];
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
        _minuteOneImageView.frame = CGRectMake(69, 296, 68, 91.5);
        [self addSubview:_minuteOneImageView];
        //分钟第二位
        _minuteTwoImageView = [[UIImageView alloc]init];
        minute2 = [_minute intValue]%10;
        NSString *minuteTwoString = [[NSString alloc]initWithFormat:@"%d.png",minute2];
        [_minuteTwoImageView setImage:[UIImage imageNamed:minuteTwoString]];
        _minuteTwoImageView.frame = CGRectMake(184, 296, 68, 91.5);
        [self addSubview:_minuteTwoImageView];
    }
    
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
    [self addSubview:_minuteTwoImageView];
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
    [self addSubview:_minuteOneImageView];
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
    [self addSubview:_minuteOneImageView];
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
    [self addSubview:_hourOneImageView];
}

@end
