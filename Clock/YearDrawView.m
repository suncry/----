//
//  YearDrawView.m
//  CyClock
//
//  Created by Suncry on 13-6-13.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import "YearDrawView.h"
#import "MyDB.h"
#import "ColorControl.h"

@implementation YearDrawView

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
    _yearNum = [_year intValue];

    
    ////////////////////////////////////////////////////////////////////
    
    CGContextRef ref=UIGraphicsGetCurrentContext();//拿到当前被准备好的画板。在这个画板上画就是在当前视图上画
    
    
    CGContextBeginPath(ref);//这里提到一个很重要的概念叫路径（path），其实就是告诉画板环境，我们要开始画了，你记下。
    CGContextSetLineWidth(ref, 2.0);//制定了线的宽度
    
    CGContextMoveToPoint(ref,0, 0);//画线需要我解释吗？不用了吧？就是两点确定一条直线了。
    
    CGFloat _myColor[4]={0.0, 0.0, 0.0,1.0};//设置颜色
    

    
#pragma mark 随机填充
    CGContextSetStrokeColor(ref, _myColor);//设置了一下当前那个画笔的颜色。画笔啊！你记着我前面说的windows画图板吗？
    
    //白色背景。。。得到后面白色的间隔线
    CGContextSetFillColorWithColor(ref,[UIColor whiteColor].CGColor);
    CGContextFillRect(ref, CGRectMake(0,0,320,DEVICE_HEIGHT));
    
    int sum = 0;
    MyDB *mydb = [[MyDB alloc]init];
    ColorControl *colorControl = [[ColorControl alloc]init];
    int colorNum = [mydb color];
    for (int j = 0; j<13; j++)
    {
        for (int i = 0; i<7; i++)
        {
            if (sum < _yearNum - [mydb year])//算出岁数
            {
                CGContextSetFillColorWithColor(ref,[colorControl passedDayFillColor:colorNum].CGColor);
            }
            else
            {
                CGContextSetFillColorWithColor(ref,[colorControl notPassedDayFillColor:colorNum].CGColor);
                
            }
            if (DEVICE_IS_IPHONE5) {
                //iphone5 的格子
                CGContextFillRect(ref, CGRectMake(45*i+i, 43*j+j, 45, 43));
            }
            else
            {
                //iPhone4 的格子
                CGContextFillRect(ref, CGRectMake(45*i+i, 36*j+j, 45, 36));
            }
            sum ++;
        }
    }

}
@end
