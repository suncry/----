//
//  startViewController.m
//  CyClock
//
//  Created by kratos on 13-6-7.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import "startViewController.h"

@interface startViewController ()

@end

@implementation startViewController

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
	// Do any additional setup after loading the view.
    //第一次启动程序 firstLaunch bool值为0
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        [NSTimer scheduledTimerWithTimeInterval:0.00001
                                         target:self
                                       selector:@selector(toInfoView)
                                       userInfo:nil
                                        repeats:NO];
        
        NSLog(@"%d\n",[[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]);
    }
    
    ///////
    UITapGestureRecognizer *_tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                    action:@selector(tapGesture)];
    [self.view addGestureRecognizer:_tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)toInfoView
{
     [self performSegueWithIdentifier:@"toInfoViewNOAnimates" sender:self];
}
- (void)tapGesture
{
    [_yearTextField resignFirstResponder];
    [_mouthTextField resignFirstResponder];
    [_dayTextField resignFirstResponder];
    
}
@end
