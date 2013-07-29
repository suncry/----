//
//  WelcomeViewController.h
//  Clock
//
//  Created by Suncry on 13-7-2.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomeViewController : UIViewController<UIScrollViewDelegate>
{
    UIScrollView *_headerScrollView;
    UIScrollView *_minScrollView;
    UIScrollView *_FooterScrollView;
    
    float repeatTimes;//用于控制 图片的滚动是否
    NSTimer *_scrollTimer;
    
    UIView *_controlView;
    UISwipeGestureRecognizer *_recognizerRight;
    UISwipeGestureRecognizer *_recognizerLeft;

    UIButton *_startBtn;
    UIButton *_lineBtn;
}
@end
