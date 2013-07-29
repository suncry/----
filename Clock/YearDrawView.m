//
//  YearDrawView.m
//  CyClock
//
//  Created by Suncry on 13-6-13.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import "YearDrawView.h"
#import "MyDB.h"

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
    MyDB *mydb = [[MyDB alloc]init];
    for (int j = 0; j<13; j++)
    {
        for (int i = 0; i<7; i++)
        {
            if (sum < _yearNum - [mydb year])//算出岁数
            {
                CGContextSetFillColorWithColor(ref,[self passedYearFillColor].CGColor);
            }
            else
            {
                CGContextSetFillColorWithColor(ref,[self notPassedYearFillColor].CGColor);
                
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
-(UIColor *)passedYearFillColor
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
-(UIColor *)notPassedYearFillColor
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

@end
