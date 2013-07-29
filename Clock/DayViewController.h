//
//  DayViewController.h
//  Clock
//
//  Created by Suncry on 13-6-24.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDrawView.h"



@interface DayViewController : UIViewController<UIScrollViewDelegate>
{
    //整个页面是一个scrollView
    UIScrollView *_scrollView;
    //上部分 用来显示格子
    MyDrawView *_drawView;
    //下面用来显示颜色的选择
    UIView *_colorSetView;

}
@end
