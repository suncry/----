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
#import "SettingViewController.h"
#import "InfoViewController.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "MMDrawerBarButtonItem.h"
#import <QuartzCore/QuartzCore.h>
#import "MyDB.h"

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
//    self.view = [[YearDrawView alloc]init];
    self.view.backgroundColor = [UIColor blackColor];
    
    
    _yearDrawView = [[YearDrawView alloc]initWithFrame:CGRectMake(0, 0, 320, DEVICE_HEIGHT)];
    [self.view addSubview:_yearDrawView];
    
    //添加页面跳转手势
    [self addGesture];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"])
    {
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"我们估计"]];
        _imageView.frame = CGRectMake(0, 0, 320, DEVICE_HEIGHT);
        
        [self.view addSubview:_imageView];
        
        UITapGestureRecognizer *tapRecognizer;
        tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [_imageView addGestureRecognizer:tapRecognizer];
        
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
        UILabel *stringLable = [[UILabel alloc]initWithFrame:CGRectMake(280, 40, 200, 60)];
        NSString *tempString = [[NSString alloc]initWithFormat:@"你已经度过了你人生中的第 %d 年",[yearString intValue] - [mydb year]];
        stringLable.text = tempString;
        
        [_imageView addSubview:stringLable];
        
    }
    
    
//    CATransition *animation = [CATransition animation];
//    //动画时间
//    animation.duration = 0.5f;
//    //先慢后快
//    animation.timingFunction = UIViewAnimationCurveEaseInOut;
//    animation.fillMode = kCAFillModeForwards;
//    //animation.removedOnCompletion = NO;
//    animation.type = kCATransitionFade;
//    //    animation.subtype = kCATransitionFromRight;
//    [self.view.layer addAnimation:animation forKey:@"fade?"];
    
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
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        
        [_imageView removeFromSuperview];
        
    }
    else{
                
        
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationDelegate:self];
        self.view.transform = CGAffineTransformScale([self transformForOrientation],7, 7);
        [UIView commitAnimations];
        
        
        [self performSelector:@selector(present) withObject:self afterDelay:1.0];
    }
}

- (void)tapImage:(id)sender
{
    [sender removeFromSuperview];
}
- (CGAffineTransform)transformForOrientation {
	UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
	if (UIInterfaceOrientationLandscapeLeft == orientation) {
		return CGAffineTransformMakeRotation(M_PI*1.5);
	} else if (UIInterfaceOrientationLandscapeRight == orientation) {
		return CGAffineTransformMakeRotation(M_PI/2);
	} else if (UIInterfaceOrientationPortraitUpsideDown == orientation) {
		return CGAffineTransformMakeRotation(-M_PI);
	} else {
		return CGAffineTransformIdentity;
	}
}

- (void)present
{
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
    [drawerController setMaximumRightDrawerWidth:280];
    [drawerController setMaximumLeftDrawerWidth:280];
    
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    drawerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;

    [self presentViewController:drawerController animated:YES completion:nil];

}
@end
