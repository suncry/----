//
//  YearViewController.m
//  Clock
//
//  Created by Suncry on 13-6-24.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import "YearViewController.h"
#import "YearDrawView.h"
#import "DayViewController.h"

@interface YearViewController ()

@end

@implementation YearViewController

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
    self.view = [[YearDrawView alloc]init];
    _yearDrawView = [[YearDrawView alloc]initWithFrame:CGRectMake(0, 0, 320, DEVICE_HEIGHT)];
    [self.view addSubview:_yearDrawView];
    
    //添加页面跳转手势
    [self addGesture];
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addGesture
{
    UITapGestureRecognizer *tapRecognizer;
    tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [[self view] addGestureRecognizer:tapRecognizer];
    
}
- (void)tap
{
    DayViewController *dayViewController = [[DayViewController alloc]init];
    
    
    
    //    UIView *Animations; //动画:
//    [UIView beginAnimations:@"animationID" context:nil];
//    [UIView setAnimationDuration:2.0f];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationRepeatAutoreverses:NO];
//    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp
//                           forView:self.view
//                             cache:YES];//oglFlip, fromLeft
//    
//    [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
//    [UIView commitAnimations];

    
    
    [self presentViewController:dayViewController animated:YES completion:nil];
}
@end
