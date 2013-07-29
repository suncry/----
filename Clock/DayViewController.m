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
    
    //添加 页面切换 提示
    _alertLable = [[UILabel alloc]initWithFrame:CGRectMake(140, DEVICE_HEIGHT/2, 50, 50)];
    _alertLable.backgroundColor = [UIColor clearColor];
    _alertLable.text = @"365天";
    _alertLable.alpha = 0.0f;
    [self.view addSubview:_alertLable];
    
    
    
    
    //默认进入365天界面
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        
        self.scrollView.contentOffset = CGPointMake(0.0f, 0.0f);
        
        
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"我们估计"]];
        _imageView.frame = CGRectMake(0, 0, 320, DEVICE_HEIGHT);
        
        [self.view addSubview:_imageView];
        
//        UITapGestureRecognizer *tapRecognizer;
//        tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
//        [self.view addGestureRecognizer:tapRecognizer];

        //添加 闪现的Lable
        //获取当月的天数
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        //    [formatter setDateFormat:@"YYYY-MM-dd-hh:mm:ss"];
        //month
        [formatter setDateFormat:@"YYYY"];
        NSString *yearString = [formatter stringFromDate:[NSDate date]];
        [yearString intValue];
        MyDB *mydb = [[MyDB alloc]init];
        [mydb year];
        UILabel *stringLable = [[UILabel alloc]initWithFrame:CGRectMake(40, DEVICE_HEIGHT - 80, 280, 60)];
        stringLable.backgroundColor = [UIColor clearColor];
        NSString *tempString = [[NSString alloc]initWithFormat:@"你已经度过了你人生中的第 %d 年",[yearString intValue] - [mydb year]];
        stringLable.text = tempString;
        
        [_imageView addSubview:stringLable];
        
        //////////////////////////////////////////////////////////////////////
        [UIView animateWithDuration:2.0 delay:0 options:0 animations:^(){
            stringLable.alpha = 0.0;
            [stringLable exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
            stringLable.alpha = 1.0;
        } completion:^(BOOL finished)
         {
             [self tap];
             
         }];
        
        //////////////////////////////////////////////////////////////////////


    }
    else
    {
        self.scrollView.contentOffset = CGPointMake(0.0f, DEVICE_HEIGHT);

    }
    
    
    //添加页面跳转手势
//    [self addGesture];
    
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
    
//    _scrollView.contentOffset = CGPointMake(0, 320);
    
}

- (void)addGesture
{
//    UISwipeGestureRecognizer *recognizer;
    UITapGestureRecognizer *tapRecognizer;
    
//    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
//    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
//    [_scrollView addGestureRecognizer:recognizer];
//    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
//    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
//    [_scrollView addGestureRecognizer:recognizer];
//
//    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
//    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
//    [[self view] addGestureRecognizer:recognizer];
    
    tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [[self view] addGestureRecognizer:tapRecognizer];


}

//-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
//{
//
//    if(recognizer.direction==UISwipeGestureRecognizerDirectionUp)
//    {
//        
//        //执行程序
////        InfoViewController *infoViewController = [[InfoViewController alloc]init];
////        [self presentViewController:infoViewController animated:YES completion:nil];
//        YearViewController *yearViewController = [[YearViewController alloc]init];
//        [self presentViewController:yearViewController animated:YES completion:nil];
//
//        NSLog(@"UISwipeGestureRecognizerDirectionUp");
//
//    }
//    if(recognizer.direction==UISwipeGestureRecognizerDirectionDown)
//    {
//        
//        //执行程序
//        //        InfoViewController *infoViewController = [[InfoViewController alloc]init];
//        //        [self presentViewController:infoViewController animated:YES completion:nil];
//        YearViewController *yearViewController = [[YearViewController alloc]init];
//        [self presentViewController:yearViewController animated:YES completion:nil];
//        
//        NSLog(@"UISwipeGestureRecognizerDirectionDown");
//        
//    }
//    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight)
//    {
//        //执行程序
////        SettingViewController *settingViewController = [[SettingViewController alloc]init];
////        [self presentViewController:settingViewController animated:YES completion:nil];
//
//
//    }
//  
//}
- (void)tap
{

    //////////////////////////////////////////////////////////////////////
    [UIView animateWithDuration:3.0 delay:0 options:0 animations:^(){
        _imageView.alpha = 1.0;
        [_imageView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        _imageView.alpha = 0.0;
    } completion:^(BOOL finished)
     {
         [_imageView removeFromSuperview];

     }];
    
    //////////////////////////////////////////////////////////////////////
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y == 0.0f)
    {
        _alertLable.text = @"90年";
        [UIView animateWithDuration:1.0 delay:0 options:0 animations:^(){
            _alertLable.alpha = 1.0;
            [_alertLable exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
            _alertLable.alpha = 0.0;
        } completion:^(BOOL finished)
        {
            
        }];

    }
    if (scrollView.contentOffset.y == DEVICE_HEIGHT)
    {
        _alertLable.text = @"365天";
        [UIView animateWithDuration:1.0 delay:0 options:0 animations:^(){
            _alertLable.alpha = 1.0;
            [_alertLable exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
            _alertLable.alpha = 0.0;
        } completion:^(BOOL finished)
         {
             
         }];
    }
}

@end
