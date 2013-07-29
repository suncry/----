//
//  DayViewController.h
//  Clock
//
//  Created by Suncry on 13-6-24.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDrawView.h"
#import "YearDrawView.h"



@interface DayViewController : UIViewController<UIScrollViewDelegate>
{
    //整个页面是一个scrollView
    UIScrollView *_scrollView;

    //上部分 用来显示格子
    MyDrawView *_drawView;
    YearDrawView *_yearDrawView;
//    //下面用来显示颜色的选择
//    UIView *_colorSetView;
    
    //第一次进入时的提示画面
    UIImageView *_imageView;
    
    //365天和90年切换的提示lable
    UILabel *_alertLable;
    
    //控制渐变
    NSTimer *_timerUp;
    NSTimer *_timerDown;


}
@property (nonatomic,retain)UIScrollView *scrollView;
@end
