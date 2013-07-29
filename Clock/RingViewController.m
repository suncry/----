//
//  RingViewController.m
//  Clock
//
//  Created by Suncry on 13-6-24.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import "RingViewController.h"
#import "DayViewController.h"

@interface RingViewController ()

@end

@implementation RingViewController

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
    self.view.backgroundColor = [UIColor redColor];
    UIButton *getUpBtn = [[UIButton alloc]initWithFrame:CGRectMake(120, 220, 80, 30)];
    [getUpBtn setTitle:@"起床" forState:UIControlStateNormal];
    [getUpBtn addTarget:self
                 action:@selector(getUpBtnClick)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getUpBtn];
    
    UIButton *sleepBtn = [[UIButton alloc]initWithFrame:CGRectMake(120,280 , 80, 30)];
    [sleepBtn setTitle:@"小睡" forState:UIControlStateNormal];
    [sleepBtn addTarget:self
                 action:@selector(sleepBtnClick)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sleepBtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getUpBtnClick
{
    DayViewController *dayViewController = [[DayViewController alloc]init];
    [self presentViewController:dayViewController animated:YES completion:nil];
}
- (void)sleepBtnClick
{
    DayViewController *dayViewController = [[DayViewController alloc]init];
    [self presentViewController:dayViewController animated:YES completion:nil];
}
@end
