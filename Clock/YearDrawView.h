//
//  YearDrawView.h
//  CyClock
//
//  Created by Suncry on 13-6-13.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YearDrawView : UIView
{
    //用于 填充 过去了年的颜色
    UIColor *_passedColor1;
    UIColor *_passedColor2;
    UIColor *_passedColor3;
    UIColor *_passedColor4;
    UIColor *_passedColor5;
    //用于 填充 还没过的年的颜色
    UIColor *_notPassedColor1;
    UIColor *_notPassedColor2;
    UIColor *_notPassedColor3;
    UIColor *_notPassedColor4;
    UIColor *_notPassedColor5;
    //用于存储当前时间
    NSString *_year;
    //用户多少岁了
    int _yearNum;
}
-(UIColor *)passedYearFillColor;
-(UIColor *)notPassedYearFillColor;
@end
