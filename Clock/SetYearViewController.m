//
//  SetYearViewController.m
//  Clock
//
//  Created by Suncry on 13-7-3.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import "SetYearViewController.h"
#import "DayViewController.h"
#import "MyDB.h"
#import "SettingViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "InfoViewController.h"
#import "MMDrawerController.h"


@interface SetYearViewController ()

@end

@implementation SetYearViewController

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
    
    //初始化
    //获取当前年
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //用于设定 年的初始值
    [formatter setDateFormat:@"YYYY"];
    year = [[formatter stringFromDate:[NSDate date]]intValue] - 25;
    month = 6;
    day =15;
    
    //获取当前年
    NSString *yearSring = [[NSString alloc]init];
    yearSring = [formatter stringFromDate:[NSDate date]];
    yearNow = [yearSring intValue];


    //创建 确认 按钮
//    UIButton *okBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT-50, 320, 50)];
//    [okBtn setTitle:@"确  认" forState:UIControlStateNormal];
//    okBtn.titleLabel.font = [UIFont systemFontOfSize:26.0f];
//    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    okBtn.backgroundColor =[UIColor colorWithRed:(CGFloat)45/255
//                                           green:(CGFloat)171/255
//                                            blue:(CGFloat)229/255
//                                           alpha:1];
//    [okBtn addTarget:self action:@selector(okBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:okBtn];
    
    
    yearPickerView.backgroundColor = [UIColor clearColor];
    monthPickerView.backgroundColor = [UIColor clearColor];
    dayPickerView.backgroundColor = [UIColor clearColor];
    

    yearPickerView.dataSource = self;
    yearPickerView.delegate = self;
    yearPickerView.shouldBeTransparent = YES;
    yearPickerView.horizontalScrolling = NO;
    yearPickerView.debugEnabled = NO;
    [yearPickerView selectIndex:[NSIndexPath indexPathForRow:10 inSection:0]];


    monthPickerView.dataSource = self;
    monthPickerView.delegate = self;
    monthPickerView.shouldBeTransparent = YES;
    monthPickerView.horizontalScrolling = NO;
    
    monthPickerView.debugEnabled = NO;
    [monthPickerView selectIndex:[NSIndexPath indexPathForRow:6 inSection:0]];

    dayPickerView.dataSource = self;
    dayPickerView.delegate = self;
    dayPickerView.shouldBeTransparent = YES;
    dayPickerView.horizontalScrolling = NO;
    dayPickerView.debugEnabled = NO;
    [dayPickerView selectIndex:[NSIndexPath indexPathForRow:15 inSection:0]];
    
    
    [self performSelector:@selector(selectSet) withObject:self afterDelay:0];

    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"])
    {
        if (DEVICE_IS_IPHONE5)
        {
            UIImageView *tempImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"出生年月设置过渡.jpg"]];
            tempImageView.frame = CGRectMake(0, 0, 320, DEVICE_HEIGHT);
            [self.view addSubview:tempImageView];
            //////////////////////////////////////////////////////////////////////
            [UIView animateWithDuration:1.0 delay:0 options:0 animations:^(){
                tempImageView.alpha = 1.0;
                [tempImageView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
                tempImageView.alpha = 0.0;
            } completion:^(BOOL finished)
             {
             }];
            
            //////////////////////////////////////////////////////////////////////

        }
        else
        {
            UIImageView *tempImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"出生年月设置过渡960.jpg"]];
            tempImageView.frame = CGRectMake(0, 0, 320, DEVICE_HEIGHT);
            [self.view addSubview:tempImageView];
            //////////////////////////////////////////////////////////////////////
            [UIView animateWithDuration:1.0 delay:0 options:0 animations:^(){
                tempImageView.alpha = 1.0;
                [tempImageView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
                tempImageView.alpha = 0.0;
            } completion:^(BOOL finished)
             {
             }];
            
            //////////////////////////////////////////////////////////////////////

        }
    }
//    else
//    {
//        
//    }

    //如果是第一次启动  隐藏  取消按钮
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"])
    {
        
        _cancelBtn.hidden = YES;
        _cancelBtn2.hidden = YES;

    }
    else
    {
        _cancelBtn.hidden = NO;
        _cancelBtn2.hidden = NO;

    }


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma IZValueSelector dataSource
- (NSInteger)numberOfRowsInSelector:(IZValueSelectorView *)valueSelector {
    if (valueSelector == yearPickerView)
    {
        return 90;
    }
    if (valueSelector == monthPickerView)
    {
        return 12;
    }
    if (valueSelector == dayPickerView)
    {
        return 31;
    }
    return 10;
}



//ONLY ONE OF THESE WILL GET CALLED (DEPENDING ON the horizontalScrolling property Value)
- (CGFloat)rowHeightInSelector:(IZValueSelectorView *)valueSelector {

    return 202/5.0;
}

- (CGFloat)rowWidthInSelector:(IZValueSelectorView *)valueSelector {
    return 92.0;
}


- (UIView *)selector:(IZValueSelectorView *)valueSelector viewForRowAtIndex:(NSInteger)index {
    UIColor *blueColor = [UIColor colorWithRed:(CGFloat)45/255
                                         green:(CGFloat)171/255
                                          blue:(CGFloat)229/255
                                         alpha:1];
    UILabel * label = nil;

    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, yearPickerView.frame.size.width, 202/5.0)];
    //年
    if (valueSelector == yearPickerView)
    {
        label.text = [NSString stringWithFormat:@"%d年",yearNow - 90 + index + 1 ];
        [label setTextColor:blueColor];
        label.font = [UIFont boldSystemFontOfSize:21.0f];
        label.textAlignment =  NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
    }
    //月
    else if (valueSelector == monthPickerView)
    {
        label.text = [NSString stringWithFormat:@"%d月",index + 1];
        [label setTextColor:blueColor];
        label.font = [UIFont boldSystemFontOfSize:21.0f];
        label.textAlignment =  NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
    }
    else if (valueSelector == dayPickerView)
    {
        label.text = [NSString stringWithFormat:@"%d日",index + 1];
        [label setTextColor:blueColor];
        label.font = [UIFont boldSystemFontOfSize:21.0f];
        label.textAlignment =  NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
    }
    
    return label;
}

- (CGRect)rectForSelectionInSelector:(IZValueSelectorView *)valueSelector {

    // 选中框的 rect
    return CGRectMake(0.0,yearPickerView.frame.size.height/2 - 202/5.0/2, 92.0, 202/5.0);
}

#pragma IZValueSelector delegate
- (void)selector:(IZValueSelectorView *)valueSelector didSelectRowAtIndex:(NSInteger)index {
    NSLog(@"Selected index %d",index);
    //获取 pickerView 选择的时间 存入全局变量
    if (valueSelector == yearPickerView)
    {
        year = [[[NSString alloc]initWithFormat:@"%d",yearNow - 90 + index +1]intValue];
        NSLog(@"存入的year == %d",year);
    }
    if (valueSelector == monthPickerView)
    {
        month = [[[NSString alloc]initWithFormat:@"%d",index + 1]intValue];
        NSLog(@"存入的month == %d",month);
    }
    if (valueSelector == dayPickerView)
    {
        day = [[[NSString alloc]initWithFormat:@"%d",index + 1]intValue];
        NSLog(@"存入day == %d",day);
    }
}
- (void)selectSet
{
    
    //获取当前年
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //用于设定 年的初始值
    [formatter setDateFormat:@"YYYY"];
    MyDB *mydb = [[MyDB alloc]init];
    [yearPickerView selectIndex:[NSIndexPath indexPathForRow:(90 - ([[formatter stringFromDate:[NSDate date]]intValue] - 1980) - 1) inSection:0]];
    [monthPickerView selectIndex:[NSIndexPath indexPathForRow:[mydb month] - 1 inSection:0]];
    [dayPickerView selectIndex:[NSIndexPath indexPathForRow:[mydb day] - 1 inSection:0]];
}
- (IBAction)okBtnClick:(id)sender
{
    //储存年月日
    MyDB *mydb = [[MyDB alloc]init];
    [mydb setYear:year];
    [mydb setMonth:month];
    [mydb setDay:day];
    
    
    //默认进入365天界面
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"])
    {

        DayViewController * center = [[DayViewController alloc] init];
        
        [self presentViewController:center animated:YES completion:nil];

    }
    else
    {
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
        
        
        
            [self presentViewController:drawerController animated:YES completion:nil];

    }


}
- (IBAction)cancelBtnClick:(id)sender
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"])
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
        
        
        [drawerController setMaximumRightDrawerWidth:320];
        [drawerController setMaximumLeftDrawerWidth:320];
        
        [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        
        [self presentViewController:drawerController animated:YES completion:nil];

    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}
@end
