//
//  WelcomeViewController.m
//  Clock
//
//  Created by Suncry on 13-7-2.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import "WelcomeViewController.h"
#import "DayViewController.h"
#import "SetYearViewController.h"


@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    repeatTimes = 0.0f;
    
    if (DEVICE_IS_IPHONE5)
    {
        UIImageView *backgroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"首页背景.png"]];
        backgroundImageView.frame = CGRectMake(0, 0, 320, 568);
        [self.view addSubview:backgroundImageView];
    }
    else
    {
        
    }
    
    [self createScrollView];
    
    //在控制视图上加上手势
    _controlView = [[UIView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    _controlView.backgroundColor = [UIColor clearColor];
    //手势
    _recognizerRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [_recognizerRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [_controlView addGestureRecognizer:_recognizerRight];

    _recognizerLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [_recognizerLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [_controlView addGestureRecognizer:_recognizerLeft];

    [self.view addSubview:_controlView];
    
    
    //开始按钮
    _startBtn = [[UIButton alloc]initWithFrame:CGRectMake(65, DEVICE_HEIGHT*462/568, 200, 40)];
    [_startBtn setTitle:@"开启专属你的时光闹钟" forState:UIControlStateNormal];
    [_startBtn.titleLabel setTextColor:[UIColor colorWithRed:(CGFloat)45/255
                                           green:(CGFloat)171/255
                                            blue:(CGFloat)229/255
                                           alpha:1]];

    _startBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [_startBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _startBtn.backgroundColor = [UIColor clearColor];
    [_startBtn addTarget:self action:@selector(startClock) forControlEvents:UIControlEventTouchUpInside];
    _startBtn.hidden = YES;
    [_controlView addSubview:_startBtn];
    
    [self createDots];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)createScrollView
{
    _headerScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, 320, DEVICE_HEIGHT)];
    _headerScrollView.pagingEnabled = YES;
    _headerScrollView.contentSize = CGSizeMake(320*5, 50);
    _headerScrollView.showsHorizontalScrollIndicator = NO;
    _headerScrollView.showsVerticalScrollIndicator = NO;
    _headerScrollView.scrollsToTop = NO;
    _headerScrollView.delegate = self;
    [self.view addSubview:_headerScrollView];
    
    _minScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, 320, DEVICE_HEIGHT)];
    _minScrollView.pagingEnabled = YES;
    _minScrollView.contentSize = CGSizeMake(320*5, 50);
    _minScrollView.showsHorizontalScrollIndicator = NO;
    _minScrollView.showsVerticalScrollIndicator = NO;
    _minScrollView.scrollsToTop = NO;
    _minScrollView.delegate = self;
    _minScrollView.contentOffset = CGPointMake(320*4, 0);
    [self.view addSubview:_minScrollView];
    
    _FooterScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, 320, DEVICE_HEIGHT)];
    _FooterScrollView.pagingEnabled = YES;
    _FooterScrollView.contentSize = CGSizeMake(320*5, 50);
    _FooterScrollView.showsHorizontalScrollIndicator = NO;
    _FooterScrollView.showsVerticalScrollIndicator = NO;
    _FooterScrollView.scrollsToTop = NO;
    _FooterScrollView.delegate = self;
    [self.view addSubview:_FooterScrollView];

    UIColor *blueColor = [UIColor colorWithRed:(CGFloat)45/255
                                         green:(CGFloat)171/255
                                          blue:(CGFloat)229/255
                                         alpha:1];
    UIColor *grayColor = [UIColor colorWithRed:(CGFloat)121/255
                                         green:(CGFloat)121/255
                                          blue:(CGFloat)121/255
                                         alpha:1];
    
    
    //第一排 滚动文字    
//    UILabel *lable1_1 = [[UILabel alloc]initWithFrame:CGRectMake(0+42,234 - (DEVICE_HEIGHT/2 - 150), 270, 50)];
    UILabel *lable1_1 = [[UILabel alloc]initWithFrame:CGRectMake(0+42,DEVICE_HEIGHT*234/568, 270, 50)];
    lable1_1.text = @"每一天";
    [lable1_1 setTextColor:blueColor];
    lable1_1.font = [UIFont systemFontOfSize:32.0f];
    lable1_1.backgroundColor = [UIColor clearColor];
    [_headerScrollView addSubview:lable1_1];
        
    UILabel *lable1_2 = [[UILabel alloc]initWithFrame:CGRectMake(320+42, DEVICE_HEIGHT*219/568, 270, 50)];
    lable1_2.text = @"春去秋来";
    [lable1_2 setTextColor:grayColor];
    lable1_2.font = [UIFont systemFontOfSize:32.0f];
    lable1_2.backgroundColor = [UIColor clearColor];
    [_headerScrollView addSubview:lable1_2];
    
    UILabel *lable1_3 = [[UILabel alloc]initWithFrame:CGRectMake(320*2+124, DEVICE_HEIGHT*235/568, 270, 50)];
    lable1_3.text = @"也许";
    [lable1_3 setTextColor:blueColor];
    lable1_3.font = [UIFont systemFontOfSize:32.0f];
    lable1_3.backgroundColor = [UIColor clearColor];
    [_headerScrollView addSubview:lable1_3];
    
    UILabel *lable1_4 = [[UILabel alloc]initWithFrame:CGRectMake(320*3+91, DEVICE_HEIGHT*198/568, 270, 50)];
    lable1_4.text = @"时光闹钟";
    [lable1_4 setTextColor:blueColor];
    lable1_4.font = [UIFont systemFontOfSize:32.0f];
    lable1_4.backgroundColor = [UIColor clearColor];
    [_headerScrollView addSubview:lable1_4];
    
    
    //第二排 滚动文字
    UILabel *lable2_1 = [[UILabel alloc]initWithFrame:CGRectMake(0+91, DEVICE_HEIGHT*250/568, 270, 50)];
    lable2_1.text = @"以时间的名义";
    [lable2_1 setTextColor:grayColor];
    lable2_1.font = [UIFont systemFontOfSize:21.0f];
    lable2_1.backgroundColor = [UIColor clearColor];
    [_minScrollView addSubview:lable2_1];
    
    UILabel *lable2_2 = [[UILabel alloc]initWithFrame:CGRectMake(320+50, DEVICE_HEIGHT*252/568, 270, 50)];
    lable2_2.text = @"以岁月的名义";
    [lable2_2 setTextColor:grayColor];
    lable2_2.font = [UIFont systemFontOfSize:21.0f];
    lable2_2.backgroundColor = [UIColor clearColor];
    [_minScrollView addSubview:lable2_2];
    
    UILabel *lable2_3 = [[UILabel alloc]initWithFrame:CGRectMake(320*2+84, DEVICE_HEIGHT*287/568, 270, 50)];
    lable2_3.text = @"只有时间的消逝";
    [lable2_3 setTextColor:grayColor];
    lable2_3.font = [UIFont systemFontOfSize:20.0f];
    lable2_3.backgroundColor = [UIColor clearColor];
    [_minScrollView addSubview:lable2_3];
    
    UILabel *lable2_4 = [[UILabel alloc]initWithFrame:CGRectMake(320*3+161, DEVICE_HEIGHT*270/568, 270, 50)];
    lable2_4.text = @"花开花落";
    [lable2_4 setTextColor:blueColor];
    lable2_4.font = [UIFont systemFontOfSize:24.0f];
    lable2_4.backgroundColor = [UIColor clearColor];
    [_minScrollView addSubview:lable2_4];
    
    UILabel *lable2_5 = [[UILabel alloc]initWithFrame:CGRectMake(320*4+42, DEVICE_HEIGHT*295/568, 270, 50)];
    lable2_5.text = @"荏苒的时光从我们身边流过";
    [lable2_5 setTextColor:grayColor];
    lable2_5.font = [UIFont systemFontOfSize:18.0];
    lable2_5.backgroundColor = [UIColor clearColor];
    [_minScrollView addSubview:lable2_5];

    //第三排 滚动文字
    UILabel *lable3_1 = [[UILabel alloc]initWithFrame:CGRectMake(320+100, DEVICE_HEIGHT*314/568, 270, 50)];
    lable3_1.text = @"转瞬即逝";
    [lable3_1 setTextColor:grayColor];
    lable3_1.font = [UIFont systemFontOfSize:28.0f];
    lable3_1.backgroundColor = [UIColor clearColor];
    [_FooterScrollView addSubview:lable3_1];
    
    UILabel *lable3_2 = [[UILabel alloc]initWithFrame:CGRectMake(320*2+50, DEVICE_HEIGHT*323/568, 270, 50)];
    lable3_2.text = @"才能使我们注意到时间";
    [lable3_2 setTextColor:grayColor];
    lable3_2.font = [UIFont systemFontOfSize:20.0f];
    lable3_2.backgroundColor = [UIColor clearColor];
    [_FooterScrollView addSubview:lable3_2];
    
    UILabel *lable3_3 = [[UILabel alloc]initWithFrame:CGRectMake(320*3+160, DEVICE_HEIGHT*295/568, 270, 50)];
    lable3_3.text = @"来记录时间";
    [lable3_3 setTextColor:grayColor];
    lable3_3.font = [UIFont systemFontOfSize:21.0f];
    lable3_3.backgroundColor = [UIColor clearColor];
    [_FooterScrollView addSubview:lable3_3];
    
    UILabel *lable4_4 = [[UILabel alloc]initWithFrame:CGRectMake(320*4+42, DEVICE_HEIGHT*294/568, 270, 50)];
    lable4_4.text = @"记录你积极向上的每一天";
    [lable4_4 setTextColor:grayColor];
    lable4_4.font = [UIFont systemFontOfSize:21.0f];
    lable4_4.backgroundColor = [UIColor clearColor];
    [_FooterScrollView addSubview:lable4_4];

    
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft)
    {
        if (_FooterScrollView.contentOffset.x < 320*4)
        {
            [_controlView removeGestureRecognizer:_recognizerRight];
            [_controlView removeGestureRecognizer:_recognizerLeft];
            //执行程序
            _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:0.001
                                                            target:self
                                                          selector:@selector(moveImageRight)
                                                          userInfo:nil repeats:YES];
        }

    }
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight)
    {
        if (_FooterScrollView.contentOffset.x > 0)
        {
            [_controlView removeGestureRecognizer:_recognizerRight];
            [_controlView removeGestureRecognizer:_recognizerLeft];
            //执行程序
            _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:0.001
                                         target:self
                                       selector:@selector(moveImageLeft)
                                       userInfo:nil repeats:YES];
        }
    }
}
//scrollView 代理
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    //用 offset 判断 屏幕下方显示小点的位置
}
- (void)moveImageRight
{
    if (repeatTimes < 320)
    {
        CGPoint pointHeader= _headerScrollView.contentOffset;
        CGPoint pointMid = _minScrollView.contentOffset;
        CGPoint pointFooter = _FooterScrollView.contentOffset;
        
        if (pointHeader.x < 320*3)
        {
            _headerScrollView.contentOffset = CGPointMake(pointHeader.x+1,pointHeader.y);

        }
        _minScrollView.contentOffset = CGPointMake(pointMid.x-1,pointMid.y);
        _FooterScrollView.contentOffset = CGPointMake(pointFooter.x+1,pointFooter.y);
        repeatTimes = repeatTimes + 1;

    }
    else
    {
        repeatTimes = 0;
        [_scrollTimer invalidate];
        //手势
        [_controlView addGestureRecognizer:_recognizerLeft];
        [_controlView addGestureRecognizer:_recognizerRight];
        [self createDots];

    }

    if (_FooterScrollView.contentOffset.x > 320*3)
    {
        _startBtn.hidden = NO;

    }
}
- (void)moveImageLeft
{
    if (repeatTimes < 320)
    {
        CGPoint pointHeader= _headerScrollView.contentOffset;
        CGPoint pointMid = _minScrollView.contentOffset;
        CGPoint pointFooter = _FooterScrollView.contentOffset;
        if (pointFooter.x < 320*3)
        {
            _headerScrollView.contentOffset = CGPointMake(pointHeader.x-1,pointHeader.y);
            
        }
        _minScrollView.contentOffset = CGPointMake(pointMid.x+1,pointMid.y);
        _FooterScrollView.contentOffset = CGPointMake(pointFooter.x-1,pointFooter.y);
        repeatTimes = repeatTimes + 1;
    }
    else
    {
        repeatTimes = 0;
        [_scrollTimer invalidate];
        //手势
        [_controlView addGestureRecognizer:_recognizerLeft];
        [_controlView addGestureRecognizer:_recognizerRight];
        [self createDots];

    }
    if (_headerScrollView.contentOffset.x < 320*4)
    {
        _startBtn.hidden = YES;
        
    }

}

- (void)startClock
{
//    DayViewController *dayViewController = [[DayViewController alloc]init];
    SetYearViewController *setYearViewController = [[SetYearViewController alloc]init];
    [self presentViewController:setYearViewController animated:YES completion:nil];
}

- (void)createDots
{
    for (int i = 0; i < 5; i++)
    {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(80+16*i+20*i, DEVICE_HEIGHT - 50, 16, 16)];
        if ((int)_FooterScrollView.contentOffset.x/320 == i)
        {
            [btn setImage:[UIImage imageNamed:@"首页点01.png"] forState:UIControlStateNormal];

        }
        else
        {
            [btn setImage:[UIImage imageNamed:@"首页点02.png"] forState:UIControlStateNormal];
        }
        [self.view addSubview:btn];
    }
}
@end