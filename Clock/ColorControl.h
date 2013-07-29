//
//  ColorControl.h
//  Clock
//
//  Created by Suncry on 13-7-10.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorControl : NSObject
{
    //用于 填充 过去了的日子的颜色
    UIColor *_passedColor1;
    UIColor *_passedColor2;
    UIColor *_passedColor3;
    UIColor *_passedColor4;
    UIColor *_passedColor5;
    //用于 填充 还没过的日子的颜色
    UIColor *_notPassedColor1;
    UIColor *_notPassedColor2;
    UIColor *_notPassedColor3;
    UIColor *_notPassedColor4;
    UIColor *_notPassedColor5;
}

- (UIColor *)passedDayFillColor:(int)color;
- (UIColor *)notPassedDayFillColor:(int)color;
@end
