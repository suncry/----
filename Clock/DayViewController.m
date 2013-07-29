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



@interface DayViewController ()

@end

@implementation DayViewController

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
    self.view.backgroundColor = [UIColor blackColor];
    //scrollView
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, DEVICE_HEIGHT)];
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(320, DEVICE_HEIGHT+DEVICE_HEIGHT/3);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.scrollsToTop = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    //绘制格子
    _drawView = [[MyDrawView alloc]initWithFrame:CGRectMake(0, 0, 320, DEVICE_HEIGHT)];
    [_scrollView addSubview:_drawView];
    //选颜色实现
    _colorSetView = [[UIView alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT, 320, DEVICE_HEIGHT+DEVICE_HEIGHT/3)];
    [_scrollView addSubview:_colorSetView];
    
    //5个选择颜色的按钮
    UIButton *colorBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT, 320, DEVICE_HEIGHT+DEVICE_HEIGHT/3/5)];
    colorBtn1.backgroundColor = [UIColor redColor];
    colorBtn1.tag = 1;
    [colorBtn1 addTarget:self
                  action:@selector(colorBtnClick:)
        forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:colorBtn1];
    
    UIButton *colorBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT+DEVICE_HEIGHT/3/5, 320, DEVICE_HEIGHT+DEVICE_HEIGHT/3/5)];
    colorBtn2.backgroundColor = [UIColor whiteColor];
    colorBtn2.tag = 2;
    [colorBtn2 addTarget:self
                  action:@selector(colorBtnClick:)
        forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:colorBtn2];
    
    UIButton *colorBtn3 = [[UIButton alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT+(DEVICE_HEIGHT/3/5)*2, 320, DEVICE_HEIGHT+DEVICE_HEIGHT/3/5)];
    colorBtn3.backgroundColor = [UIColor blackColor];
    colorBtn3.tag = 3;
    [colorBtn3 addTarget:self
                  action:@selector(colorBtnClick:)
        forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:colorBtn3];
    
    UIButton *colorBtn4 = [[UIButton alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT+(DEVICE_HEIGHT/3/5)*3, 320, DEVICE_HEIGHT+DEVICE_HEIGHT/3/5)];
    colorBtn4.backgroundColor = [UIColor greenColor];
    colorBtn4.tag = 4;
    [colorBtn4 addTarget:self
                  action:@selector(colorBtnClick:)
        forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:colorBtn4];
    
    UIButton *colorBtn5 = [[UIButton alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT+(DEVICE_HEIGHT/3/5)*4, 320, DEVICE_HEIGHT+DEVICE_HEIGHT/3/5)];
    colorBtn5.backgroundColor = [UIColor grayColor];
    colorBtn5.tag = 5;
    [colorBtn5 addTarget:self
                  action:@selector(colorBtnClick:)
        forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:colorBtn5];
    
    
    //添加页面跳转手势
    [self addGesture];
    
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
    [mydb setON:@"YES" day:tmpBtn.tag];
    NSLog(@"isON  == %@",[mydb isON:tmpBtn.tag]);

}

- (void)addGesture
{
    UISwipeGestureRecognizer *recognizer;
    UITapGestureRecognizer *tapRecognizer;
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [[self view] addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [[self view] addGestureRecognizer:recognizer];
    
    tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [[self view] addGestureRecognizer:tapRecognizer];

}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{

    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft)
    {
        
        //执行程序
        InfoViewController *infoViewController = [[InfoViewController alloc]init];
        [self presentViewController:infoViewController animated:YES completion:nil];
    }
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight)
    {
        
        //执行程序
        SettingViewController *settingViewController = [[SettingViewController alloc]init];
        [self presentViewController:settingViewController animated:YES completion:nil];

    }
}
- (void)tap
{
//    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
    YearViewController *yearViewController = [[YearViewController alloc]init];
    
    
//    UIView *Animations; //动画:
//    [UIView beginAnimations:@"animationID" context:nil];
//    [UIView setAnimationDuration:0.5f];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationRepeatAutoreverses:NO];
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft
//                           forView:self.view
//                             cache:YES];//oglFlip, fromLeft
//    
//    [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
//    [UIView commitAnimations];

    [self presentViewController:yearViewController animated:YES completion:nil];
}
@end
