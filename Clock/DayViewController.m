//
//  DayViewController.m
//  Clock
//
//  Created by Suncry on 13-6-24.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import "DayViewController.h"
#import "MyDB.h"
#import "SettingViewController.h"
#import "InfoViewController.h"
#import "YearViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MMDrawerController.h"


@interface DayViewController ()

@end

@implementation DayViewController
@synthesize scrollView = _scrollView;
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

    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    //scrollView
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, DEVICE_HEIGHT)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(320, DEVICE_HEIGHT*2+62*5);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;

    [self.view addSubview:self.scrollView];
    //绘制365天格子
    _drawView = [[MyDrawView alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT, 320, DEVICE_HEIGHT)];
    [self.scrollView addSubview:_drawView];
    //绘制90年格子
    _yearDrawView = [[YearDrawView alloc]initWithFrame:CGRectMake(0, 0, 320, DEVICE_HEIGHT)];
    [self.scrollView addSubview:_yearDrawView];
    //选颜色实现
    //5个选择颜色的按钮
    UIButton *colorBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT*2, 320, DEVICE_HEIGHT+DEVICE_HEIGHT/3/5)];
    colorBtn1.backgroundColor = [UIColor colorWithRed:(CGFloat)213/255
                                                green:(CGFloat)62/255
                                                 blue:(CGFloat)79/255
                                                alpha:1];
    colorBtn1.tag = 1;
    [colorBtn1 addTarget:self
                  action:@selector(colorBtnClick:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:colorBtn1];
    
    UIButton *colorBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT*2+62, 320, 62)];
    colorBtn2.backgroundColor = [UIColor colorWithRed:(CGFloat)245/255
                                                green:(CGFloat)109/255
                                                 blue:(CGFloat)67/255
                                                alpha:1];
    colorBtn2.tag = 2;
    [colorBtn2 addTarget:self
                  action:@selector(colorBtnClick:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:colorBtn2];
    
    UIButton *colorBtn3 = [[UIButton alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT*2+62*2, 320, 62)];
    colorBtn3.backgroundColor = [UIColor colorWithRed:(CGFloat)253/255
                                                green:(CGFloat)174/255
                                                 blue:(CGFloat)97/255
                                                alpha:1];
    colorBtn3.tag = 3;
    [colorBtn3 addTarget:self
                  action:@selector(colorBtnClick:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:colorBtn3];
    
    UIButton *colorBtn4 = [[UIButton alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT*2+62*3, 320, 62)];
    colorBtn4.backgroundColor = [UIColor colorWithRed:(CGFloat)135/255
                                                green:(CGFloat)224/255
                                                 blue:(CGFloat)87/255
                                                alpha:1];

    
    colorBtn4.tag = 4;
    [colorBtn4 addTarget:self
                  action:@selector(colorBtnClick:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:colorBtn4];
    
    UIButton *colorBtn5 = [[UIButton alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT*2+62*4, 320, 62)];
    colorBtn5.backgroundColor = [UIColor colorWithRed:(CGFloat)36/255
                                                green:(CGFloat)158/255
                                                 blue:(CGFloat)215/255
                                                alpha:1];
    colorBtn5.tag = 5;
    [colorBtn5 addTarget:self
                  action:@selector(colorBtnClick:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:colorBtn5];
    
    UIImageView *shadowImg_1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"更改颜色_阴影"]];
    shadowImg_1.frame = CGRectMake(0, DEVICE_HEIGHT, 320,8);
    [self.scrollView addSubview:shadowImg_1];
    
    UIImageView *shadowImg_2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"更改颜色_阴影"]];
    shadowImg_2.frame = CGRectMake(0, DEVICE_HEIGHT*2, 320,8);
    [self.scrollView addSubview:shadowImg_2];
    
    
    //默认进入365天界面
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"])
    {
        
        
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        
        self.scrollView.contentOffset = CGPointMake(0.0f, 0.0f);
        
        
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"我们估计"]];
        _imageView.frame = CGRectMake(0, 0, 320, DEVICE_HEIGHT);
        
        [self.view addSubview:_imageView];

        
        //添加 第一次 进入90年的Lable
        //获取当月的天数
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        //    [formatter setDateFormat:@"YYYY-MM-dd-hh:mm:ss"];
        //month
        [formatter setDateFormat:@"YYYY"];
        NSString *yearString = [formatter stringFromDate:[NSDate date]];
        [yearString intValue];
        MyDB *mydb = [[MyDB alloc]init];
        [mydb year];
        UILabel *stringLable = [[UILabel alloc]initWithFrame:CGRectMake(25, DEVICE_HEIGHT - 100, 280, 60)];
        stringLable.backgroundColor = [UIColor clearColor];
        stringLable.font = [UIFont boldSystemFontOfSize:18.0f];
        stringLable.textColor = [UIColor whiteColor];
        NSString *tempString = [[NSString alloc]initWithFormat:@"你已经度过了你人生中的第         年"];
        stringLable.text = tempString;
        [_imageView addSubview:stringLable];

        UILabel *numLable = [[UILabel alloc]initWithFrame:CGRectMake(242, DEVICE_HEIGHT - 100, 280, 60)];
        numLable.backgroundColor = [UIColor clearColor];
        numLable.font = [UIFont boldSystemFontOfSize:40.0f];
        numLable.textColor = [UIColor whiteColor];
        NSString *numString = [[NSString alloc]initWithFormat:@"%d",[yearString intValue] - [mydb year]];
        numLable.text = numString;
        
        [_imageView addSubview:numLable];
        

        //把滚动属性设置为NO  防止 在 我们估计页面的时候 出现动画效果
        _scrollView.scrollEnabled = NO;
        
        //////////////////////////////////////////////////////////////////////
        [UIView animateWithDuration:3.0 delay:1 options:0 animations:^(){
            numLable.alpha = 0.0;
            [numLable exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
            numLable.alpha = 1.0;
        } completion:^(BOOL finished)
         {


         }];
        
        //////////////////////////////////////////////////////////////////////

        //////////////////////////////////////////////////////////////////////
        [UIView animateWithDuration:3.0 delay:1 options:0 animations:^(){
            stringLable.alpha = 0.0;
            [stringLable exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
            stringLable.alpha = 1.0;
        } completion:^(BOOL finished)
         {
             //////////////////////////////////////////////////////////////////////
             [UIView animateWithDuration:3.0 delay:0 options:0 animations:^(){
                 numLable.alpha = 1.0;
                 [numLable exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
                 numLable.alpha = 0.0;
             } completion:^(BOOL finished)
              {
              }];
             
             //////////////////////////////////////////////////////////////////////

             //////////////////////////////////////////////////////////////////////
             [UIView animateWithDuration:3.0 delay:0 options:0 animations:^(){
                 stringLable.alpha = 1.0;
                 [stringLable exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
                 stringLable.alpha = 0.0;
             } completion:^(BOOL finished)
              {
                  //////////////////////////////////////////////////////////////////////
                  [UIView animateWithDuration:3.0 delay:0 options:0 animations:^(){
                      _imageView.alpha = 1.0;
                      [_imageView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
                      _imageView.alpha = 0.0;
                  } completion:^(BOOL finished)
                   {
                       [_imageView removeFromSuperview];
//                       [blockLable removeFromSuperview];
                       //跳转
                       SettingViewController * leftDrawer = [[SettingViewController alloc] init];
                       leftDrawer.view.backgroundColor = [UIColor blackColor];
                       DayViewController * center = [[DayViewController alloc] init];
                       center.view.backgroundColor = [UIColor yellowColor];
                       InfoViewController * rightDrawer = [[InfoViewController alloc] init];
                       rightDrawer.view.backgroundColor = [UIColor greenColor];
                       
                       MMDrawerController * drawerController = [[MMDrawerController alloc]
                                                                initWithCenterViewController:center
                                                                leftDrawerViewController:leftDrawer
                                                                rightDrawerViewController:rightDrawer];
                       
                       [drawerController setMaximumRightDrawerWidth:320];
                       [drawerController setMaximumLeftDrawerWidth:320];
                       
                       [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
                       [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
                       
                       
                       
                       [self presentViewController:drawerController animated:NO completion:nil];
                       
                   }];
                  
                  //////////////////////////////////////////////////////////////////////
                  

              }];
             
             //////////////////////////////////////////////////////////////////////

             
         }];
        
        //////////////////////////////////////////////////////////////////////


    }
    else
    {
        self.scrollView.contentOffset = CGPointMake(0.0f, DEVICE_HEIGHT);

    }
    
    
    //添加页面跳转手势
//    [self addGesture];
    
    
    
    _yearAlertImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"90.png"]];
    _yearAlertImageView.frame = CGRectMake(55, (DEVICE_HEIGHT - 50)/2 - 50, 210, 100);
    
    _dayAlertImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"365.png"]];
    _dayAlertImageView.frame = CGRectMake(66, (DEVICE_HEIGHT - 50)/2 - 50, 210, 100);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)colorBtnClick:(id)sender
{
    MyDB * mydb = [[MyDB alloc]init];
    UIButton *tmpBtn = (UIButton *)sender;
    [mydb setColor:tmpBtn.tag - 1];

    [_drawView setNeedsDisplay];
    [_yearDrawView setNeedsDisplay];
}

//- (void)addGesture
//{
//    UITapGestureRecognizer *tapRecognizer;
//
//    tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
//    [[self view] addGestureRecognizer:tapRecognizer];
//
//
//}
//
//- (void)tap
//{
//
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y == 0.0f)
    {

        [self.view addSubview:_alertBackgroundView];
        //用4个嵌套的动画 实现  提示的  渐入渐出
        [UIView animateWithDuration:0.5 delay:0 options:0 animations:^(){
            _alertBackgroundView.alpha = 0.0;
            [_alertBackgroundView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
            _alertBackgroundView.alpha = 1.0;
        } completion:^(BOOL finished)
         {
             [self.view addSubview:_yearAlertImageView];
             [UIView animateWithDuration:1.0 delay:0 options:0 animations:^(){
                 _yearAlertImageView.alpha = 0.0;
                 [_yearAlertImageView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
                 _yearAlertImageView.alpha = 1.0;
             } completion:^(BOOL finished)
              {
                  [self.view addSubview:_yearAlertImageView];
                  [UIView animateWithDuration:1.0 delay:0 options:0 animations:^(){
                      _yearAlertImageView.alpha = 1.0;
                      [_yearAlertImageView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
                      _yearAlertImageView.alpha = 0.0;
                  } completion:^(BOOL finished)
                   {
                       [_yearAlertImageView removeFromSuperview];
                       [self.view addSubview:_alertBackgroundView];
                       [UIView animateWithDuration:0.5 delay:0 options:0 animations:^(){
                           _alertBackgroundView.alpha = 1.0;
                           [_alertBackgroundView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
                           _alertBackgroundView.alpha = 0.0;
                       } completion:^(BOOL finished)
                        {
                            [_alertBackgroundView removeFromSuperview];
                        }];
                   }];
                  

              }];
         }];


    }
    if (scrollView.contentOffset.y == DEVICE_HEIGHT)
    {
        
        [self.view addSubview:_alertBackgroundView];
        //用4个嵌套的动画 实现  提示的  渐入渐出
        [UIView animateWithDuration:0.5 delay:0 options:0 animations:^(){
            _alertBackgroundView.alpha = 0.0;
            [_alertBackgroundView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
            _alertBackgroundView.alpha = 1.0;
        } completion:^(BOOL finished)
         {
             [self.view addSubview:_dayAlertImageView];
             [UIView animateWithDuration:1.0 delay:0 options:0 animations:^(){
                 _dayAlertImageView.alpha = 0.0;
                 [_dayAlertImageView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
                 _dayAlertImageView.alpha = 1.0;
             } completion:^(BOOL finished)
              {
                  [self.view addSubview:_dayAlertImageView];
                  [UIView animateWithDuration:1.0 delay:0 options:0 animations:^(){
                      _dayAlertImageView.alpha = 1.0;
                      [_dayAlertImageView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
                      _dayAlertImageView.alpha = 0.0;
                  } completion:^(BOOL finished)
                   {
                       [_yearAlertImageView removeFromSuperview];
                       [self.view addSubview:_alertBackgroundView];
                       [UIView animateWithDuration:0.5 delay:0 options:0 animations:^(){
                           _alertBackgroundView.alpha = 1.0;
                           [_alertBackgroundView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
                           _alertBackgroundView.alpha = 0.0;
                       } completion:^(BOOL finished)
                        {
                            [_alertBackgroundView removeFromSuperview];
                        }];
                   }];
                  
                  
              }];
         }];

    }
}

@end
