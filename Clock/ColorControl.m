//
//  ColorControl.m
//  Clock
//
//  Created by Suncry on 13-7-10.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import "ColorControl.h"

@implementation ColorControl

- (UIColor *)passedDayFillColor:(int)color
{
    switch (color) {
        case 0: //红色
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
            
            break;
        case 1://橙色
            _passedColor1 = [UIColor colorWithRed:(CGFloat) 251/255.0
                                            green:(CGFloat) 169/255.0
                                             blue:(CGFloat) 23/255.0
                                            alpha:(CGFloat) 1.0];
            
            _passedColor2 = [UIColor colorWithRed:(CGFloat) 241/255.0
                                            green:(CGFloat) 143/255.0
                                             blue:(CGFloat) 17/255.0
                                            alpha:(CGFloat) 1.0];
            
            _passedColor3 = [UIColor colorWithRed:(CGFloat) 236/255.0
                                            green:(CGFloat) 123/255.0
                                             blue:(CGFloat) 40/255.0
                                            alpha:(CGFloat) 1.0];
            
            _passedColor4 = [UIColor colorWithRed:(CGFloat) 252/255.0
                                            green:(CGFloat) 105/255.0
                                             blue:(CGFloat) 25/255.0
                                            alpha:(CGFloat) 1.0];
            
            _passedColor5 = [UIColor colorWithRed:(CGFloat) 191/255.0
                                            green:(CGFloat) 72/255.0
                                             blue:(CGFloat) 6/255.0
                                            alpha:(CGFloat) 1.0];
            
            break;
        case 2://黄色
            _passedColor1 = [UIColor colorWithRed:(CGFloat) 254/255.0
                                            green:(CGFloat) 248/255.0
                                             blue:(CGFloat) 66/255.0
                                            alpha:(CGFloat) 1.0];
            
            _passedColor2 = [UIColor colorWithRed:(CGFloat) 253/255.0
                                            green:(CGFloat) 224/255.0
                                             blue:(CGFloat) 32/255.0
                                            alpha:(CGFloat) 1.0];
            
            _passedColor3 = [UIColor colorWithRed:(CGFloat) 253/255.0
                                            green:(CGFloat) 202/255.0
                                             blue:(CGFloat) 0/255.0
                                            alpha:(CGFloat) 1.0];
            
            _passedColor4 = [UIColor colorWithRed:(CGFloat) 254/255.0
                                            green:(CGFloat) 179/255.0
                                             blue:(CGFloat) 0/255.0
                                            alpha:(CGFloat) 1.0];
            
            _passedColor5 = [UIColor colorWithRed:(CGFloat) 253/255.0
                                            green:(CGFloat) 154/255.0
                                             blue:(CGFloat) 0/255.0
                                            alpha:(CGFloat) 1.0];
            
            break;
        case 4://蓝色
            _passedColor1 = [UIColor colorWithRed:(CGFloat) 107/255.0
                                            green:(CGFloat) 175/255.0
                                             blue:(CGFloat) 214/255.0
                                            alpha:(CGFloat) 1.0];
            
            _passedColor2 = [UIColor colorWithRed:(CGFloat) 66/255.0
                                            green:(CGFloat) 146/255.0
                                             blue:(CGFloat) 197/255.0
                                            alpha:(CGFloat) 1.0];
            
            _passedColor3 = [UIColor colorWithRed:(CGFloat) 33/255.0
                                            green:(CGFloat) 114/255.0
                                             blue:(CGFloat) 180/255.0
                                            alpha:(CGFloat) 1.0];
            
            _passedColor4 = [UIColor colorWithRed:(CGFloat) 8/255.0
                                            green:(CGFloat) 82/255.0
                                             blue:(CGFloat) 157/255.0
                                            alpha:(CGFloat) 1.0];
            
            _passedColor5 = [UIColor colorWithRed:(CGFloat) 8/255.0
                                            green:(CGFloat) 48/255.0
                                             blue:(CGFloat) 107/255.0
                                            alpha:(CGFloat) 1.0];
            
            break;
        case 3://绿色
            _passedColor1 = [UIColor colorWithRed:(CGFloat) 217/255.0
                                            green:(CGFloat) 240/255.0
                                             blue:(CGFloat) 162/255.0
                                            alpha:(CGFloat) 1.0];
            
            _passedColor2 = [UIColor colorWithRed:(CGFloat) 173/255.0
                                            green:(CGFloat) 222/255.0
                                             blue:(CGFloat) 143/255.0
                                            alpha:(CGFloat) 1.0];
            
            _passedColor3 = [UIColor colorWithRed:(CGFloat) 120/255.0
                                            green:(CGFloat) 198/255.0
                                             blue:(CGFloat) 122/255.0
                                            alpha:(CGFloat) 1.0];
            
            _passedColor4 = [UIColor colorWithRed:(CGFloat) 48/255.0
                                            green:(CGFloat) 163/255.0
                                             blue:(CGFloat) 85/255.0
                                            alpha:(CGFloat) 1.0];
            
            _passedColor5 = [UIColor colorWithRed:(CGFloat) 0/255.0
                                            green:(CGFloat) 104/255.0
                                             blue:(CGFloat) 55/255.0
                                            alpha:(CGFloat) 1.0];
            
            break;
        default:
            break;
    }
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
- (UIColor *)notPassedDayFillColor:(int)color
{
    
    switch (color) {
        case 0: //红色
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
            
            break;
        case 1://橙色
            //还没过的日子的填充颜色
            _notPassedColor1 = [UIColor colorWithRed:(CGFloat) 253/255.0
                                               green:(CGFloat) 221/255.0
                                                blue:(CGFloat) 162/255.0
                                               alpha:(CGFloat) 1.0];
            
            _notPassedColor2 = [UIColor colorWithRed:(CGFloat) 249/255.0
                                               green:(CGFloat) 210/255.0
                                                blue:(CGFloat) 160/255.0
                                               alpha:(CGFloat) 1.0];
            
            _notPassedColor3 = [UIColor colorWithRed:(CGFloat) 247/255.0
                                               green:(CGFloat) 202/255.0
                                                blue:(CGFloat) 169/255.0
                                               alpha:(CGFloat) 1.0];
            
            _notPassedColor4 = [UIColor colorWithRed:(CGFloat) 254/255.0
                                               green:(CGFloat) 195/255.0
                                                blue:(CGFloat) 163/255.0
                                               alpha:(CGFloat) 1.0];
            
            _notPassedColor5 = [UIColor colorWithRed:(CGFloat) 229/255.0
                                               green:(CGFloat) 182/255.0
                                                blue:(CGFloat) 155/255.0
                                               alpha:(CGFloat) 1.0];
            
            break;
        case 2://黄色
            //还没过的日子的填充颜色
            _notPassedColor1 = [UIColor colorWithRed:(CGFloat) 255/255.0
                                               green:(CGFloat) 252/255.0
                                                blue:(CGFloat) 179/255.0
                                               alpha:(CGFloat) 1.0];
            
            _notPassedColor2 = [UIColor colorWithRed:(CGFloat) 254/255.0
                                               green:(CGFloat) 243/255.0
                                                blue:(CGFloat) 166/255.0
                                               alpha:(CGFloat) 1.0];
            
            _notPassedColor3 = [UIColor colorWithRed:(CGFloat) 254/255.0
                                               green:(CGFloat) 234/255.0
                                                blue:(CGFloat) 153/255.0
                                               alpha:(CGFloat) 1.0];
            
            _notPassedColor4 = [UIColor colorWithRed:(CGFloat) 255/255.0
                                               green:(CGFloat) 225/255.0
                                                blue:(CGFloat) 153/255.0
                                               alpha:(CGFloat) 1.0];
            
            _notPassedColor5 = [UIColor colorWithRed:(CGFloat) 254/255.0
                                               green:(CGFloat) 215/255.0
                                                blue:(CGFloat) 153/255.0
                                               alpha:(CGFloat) 1.0];
            
            break;
        case 4://蓝色
            //还没过的日子的填充颜色
            _notPassedColor1 = [UIColor colorWithRed:(CGFloat) 196/255.0
                                               green:(CGFloat) 223/255.0
                                                blue:(CGFloat) 239/255.0
                                               alpha:(CGFloat) 1.0];
            
            _notPassedColor2 = [UIColor colorWithRed:(CGFloat) 179/255.0
                                               green:(CGFloat) 211/255.0
                                                blue:(CGFloat) 232/255.0
                                               alpha:(CGFloat) 1.0];
            
            _notPassedColor3 = [UIColor colorWithRed:(CGFloat) 166/255.0
                                               green:(CGFloat) 199/255.0
                                                blue:(CGFloat) 225/255.0
                                               alpha:(CGFloat) 1.0];
            
            _notPassedColor4 = [UIColor colorWithRed:(CGFloat) 156/255.0
                                               green:(CGFloat) 186/255.0
                                                blue:(CGFloat) 216/255.0
                                               alpha:(CGFloat) 1.0];
            
            _notPassedColor5 = [UIColor colorWithRed:(CGFloat) 156/255.0
                                               green:(CGFloat) 172/255.0
                                                blue:(CGFloat) 196/255.0
                                               alpha:(CGFloat) 1.0];
            
            break;
        case 3://绿色
            //还没过的日子的填充颜色
            _notPassedColor1 = [UIColor colorWithRed:(CGFloat) 240/255.0
                                               green:(CGFloat) 249/255.0
                                                blue:(CGFloat) 218/255.0
                                               alpha:(CGFloat) 1.0];
            
            _notPassedColor2 = [UIColor colorWithRed:(CGFloat) 222/255.0
                                               green:(CGFloat) 242/255.0
                                                blue:(CGFloat) 210/255.0
                                               alpha:(CGFloat) 1.0];
            
            _notPassedColor3 = [UIColor colorWithRed:(CGFloat) 201/255.0
                                               green:(CGFloat) 232/255.0
                                                blue:(CGFloat) 202/255.0
                                               alpha:(CGFloat) 1.0];
            
            _notPassedColor4 = [UIColor colorWithRed:(CGFloat) 172/255.0
                                               green:(CGFloat) 218/255.0
                                                blue:(CGFloat) 187/255.0
                                               alpha:(CGFloat) 1.0];
            
            _notPassedColor5 = [UIColor colorWithRed:(CGFloat) 153/255.0
                                               green:(CGFloat) 195/255.0
                                                blue:(CGFloat) 175/255.0
                                               alpha:(CGFloat) 1.0];
            
            break;
        default:
            break;
    }

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
