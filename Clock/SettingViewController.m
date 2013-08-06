//
//  SettingViewController.m
//  Clock
//
//  Created by Suncry on 13-6-24.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import "SettingViewController.h"
#import "DayViewController.h"
#import "MyDB.h"
#import <QuartzCore/QuartzCore.h>
#import "PushNotification.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

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
    dayNum = 0;
    [self initTimeDictionary];
    [self creatLable];
    [self creatTimeBtn];
    [self creatBtn];   
//    [self addGesture];
    _pickerView.frame = CGRectMake(0, DEVICE_HEIGHT, 320, DEVICE_HEIGHT);
    [self.view addSubview:_pickerView];
    _hourPicker.dataSource = self;
    _hourPicker.delegate = self;
    _hourPicker.shouldBeTransparent = YES;
    _hourPicker.horizontalScrolling = NO;
    _hourPicker.debugEnabled = NO;
//    [_hourPicker selectIndex:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    
    _minutePicker.dataSource = self;
    _minutePicker.delegate = self;
    _minutePicker.shouldBeTransparent = YES;
    _minutePicker.horizontalScrolling = NO;
    _minutePicker.debugEnabled = NO;
//    [_minutePicker selectIndex:[NSIndexPath indexPathForRow:3 inSection:0]];
    
//    _pickerView.hidden = YES;

    
    if (!DEVICE_IS_IPHONE5) {
//        _backgroundView.frame = CGRectMake(0, -300, 320, 568);
        NSLog(@"是 4、、、、、");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//添加手势
- (void)addGesture
{
    UISwipeGestureRecognizer *recognizer;

    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [[self view] addGestureRecognizer:recognizer];
  
}
//手势响应
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft)
    {
        //执行程序
        DayViewController *dayViewController = [[DayViewController alloc]init];
        [self presentViewController:dayViewController animated:YES completion:nil];
    }

}
//创建 Lable
- (void)creatLable
{
    if (DEVICE_IS_IPHONE5)//iPhone5
    {
        //(i+1)*(DEVICE_HEIGHT/9)
        for (int i = 0; i < 7; i++)
        {
            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(22, i*22 + i*41 + 84, 150, 22)];
            NSString *string =[[NSString alloc]init];
            switch (i + 1) {
                case 1:
                    string = [[NSString alloc]initWithFormat:@"星 期 一"];
                    break;
                case 2:
                    string = [[NSString alloc]initWithFormat:@"星 期 二"];
                    break;
                case 3:
                    string = [[NSString alloc]initWithFormat:@"星 期 三"];
                    break;
                case 4:
                    string = [[NSString alloc]initWithFormat:@"星 期 四"];
                    break;
                case 5:
                    string = [[NSString alloc]initWithFormat:@"星 期 五"];
                    break;
                case 6:
                    string = [[NSString alloc]initWithFormat:@"星 期 六"];
                    break;
                case 7:
                    string = [[NSString alloc]initWithFormat:@"星 期 天"];
                    break;
                    
                default:
                    break;
            }
            [lable setTextColor:[UIColor grayColor]];
            lable.font = [UIFont systemFontOfSize:19.0f];
            lable.backgroundColor = [UIColor clearColor];
            [lable setText:string];
            [self.view addSubview:lable];
            //        [_backgroundView addSubview:lable];
        }

    }
    else//iPhone4
    {
        for (int i = 0; i < 7; i++)
        {
            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(22, i*22 + i*41 + 38, 150, 22)];
            NSString *string =[[NSString alloc]init];
            switch (i + 1) {
                case 1:
                    string = [[NSString alloc]initWithFormat:@"星 期 一"];
                    break;
                case 2:
                    string = [[NSString alloc]initWithFormat:@"星 期 二"];
                    break;
                case 3:
                    string = [[NSString alloc]initWithFormat:@"星 期 三"];
                    break;
                case 4:
                    string = [[NSString alloc]initWithFormat:@"星 期 四"];
                    break;
                case 5:
                    string = [[NSString alloc]initWithFormat:@"星 期 五"];
                    break;
                case 6:
                    string = [[NSString alloc]initWithFormat:@"星 期 六"];
                    break;
                case 7:
                    string = [[NSString alloc]initWithFormat:@"星 期 天"];
                    break;
                    
                default:
                    break;
            }
            [lable setTextColor:[UIColor grayColor]];
            lable.font = [UIFont systemFontOfSize:19.0f];
            lable.backgroundColor = [UIColor clearColor];
            [lable setText:string];
            [self.view addSubview:lable];
            //        [_backgroundView addSubview:lable];
        }
    }
   
}


//创建 开关按钮
- (void)creatBtn
{ 
    MyDB * mydb = [[MyDB alloc]init];
    
    if (DEVICE_IS_IPHONE5)//iPhone5
    {
        //Btn 1到6
        for (int i = 0; i < 6; i++)
        {
            UIButton *onBtn = [[UIButton alloc]initWithFrame:CGRectMake(207 - 11, i*22 + i*41 + 84 - 12, 44, 44)];
            //        [onBtn setTitle:@"on" forState:UIControlStateNormal];
            onBtn.tag = i + 2 + 200; //星期天 为第一天 tag 为201
            [onBtn addTarget:self
                      action:@selector(onBtnClick:)
            forControlEvents:UIControlEventTouchUpInside];
            if ([[mydb isON:i + 2] isEqualToString:@"YES"])
            {
                [onBtn setImage:[UIImage imageNamed:@"on高亮"] forState:UIControlStateNormal];
            }
            if ([[mydb isON:i + 2] isEqualToString:@"NO"])
            {
                [onBtn setImage:[UIImage imageNamed:@"on灰"] forState:UIControlStateNormal];
            }
            [self.view addSubview:onBtn];
            
            //取消按钮的 tag 从101 开始
            UIButton *offBtn = [[UIButton alloc]initWithFrame:CGRectMake(253 - 11, i*22 + i*41 + 84 - 12, 44, 44)];
            //        [offBtn setTitle:@"off" forState:UIControlStateNormal];
            offBtn.tag = i + 2+100; //星期天 为第一天 tag 为1
            [offBtn addTarget:self
                       action:@selector(offBtnClick:)
             forControlEvents:UIControlEventTouchUpInside];
            if ([[mydb isON:i + 2] isEqualToString:@"YES"])
            {
                [offBtn setImage:[UIImage imageNamed:@"off灰"] forState:UIControlStateNormal];
            }
            if ([[mydb isON:i + 2] isEqualToString:@"NO"])
            {
                [offBtn setImage:[UIImage imageNamed:@"off高亮"] forState:UIControlStateNormal];
            }
            [self.view addSubview:offBtn];
            
            
        }
        //Btn 7
        UIButton *onBtn_7 = [[UIButton alloc]initWithFrame:CGRectMake(207-11, 6*22 + 6*41 + 84 - 12, 44, 44)];
        //    [onBtn_7 setTitle:@"on" forState:UIControlStateNormal];
        onBtn_7.tag = 201; //星期天 为第一天 tag 为1
        [onBtn_7 addTarget:self
                    action:@selector(onBtnClick:)
          forControlEvents:UIControlEventTouchUpInside];
        if ([[mydb isON:201 - 200] isEqualToString:@"YES"])
        {
            [onBtn_7 setImage:[UIImage imageNamed:@"on高亮"] forState:UIControlStateNormal];
        }
        if ([[mydb isON:201 - 200] isEqualToString:@"NO"])
        {
            [onBtn_7 setImage:[UIImage imageNamed:@"on灰"] forState:UIControlStateNormal];
        }
        [self.view addSubview:onBtn_7];
        
        UIButton *offBtn_7 = [[UIButton alloc]initWithFrame:CGRectMake(253 - 11, 6*22 + 6*41 + 84 - 12, 44, 44)];
        //    [offBtn_7 setTitle:@"off" forState:UIControlStateNormal];
        offBtn_7.tag = 101; //星期天 为第一天 tag 为1
        [offBtn_7 addTarget:self
                     action:@selector(offBtnClick:)
           forControlEvents:UIControlEventTouchUpInside];
        if ([[mydb isON:101 - 100] isEqualToString:@"YES"])
        {
            [offBtn_7 setImage:[UIImage imageNamed:@"off灰"] forState:UIControlStateNormal];
        }
        if ([[mydb isON:101 - 100] isEqualToString:@"NO"])
        {
            [offBtn_7 setImage:[UIImage imageNamed:@"off高亮"] forState:UIControlStateNormal];
        }
        [self.view addSubview:offBtn_7];

    }

    else
    {
        //Btn 1到6
        for (int i = 0; i < 6; i++)
        {
            UIButton *onBtn = [[UIButton alloc]initWithFrame:CGRectMake(207 - 11, i*22 + i*41 + 40 - 12, 44, 44)];
            //        [onBtn setTitle:@"on" forState:UIControlStateNormal];
            onBtn.tag = i + 2 + 200; //星期天 为第一天 tag 为201
            [onBtn addTarget:self
                      action:@selector(onBtnClick:)
            forControlEvents:UIControlEventTouchUpInside];
            if ([[mydb isON:i + 2] isEqualToString:@"YES"])
            {
                [onBtn setImage:[UIImage imageNamed:@"on高亮"] forState:UIControlStateNormal];
            }
            if ([[mydb isON:i + 2] isEqualToString:@"NO"])
            {
                [onBtn setImage:[UIImage imageNamed:@"on灰"] forState:UIControlStateNormal];
            }
            [self.view addSubview:onBtn];
            
            //取消按钮的 tag 从101 开始
            UIButton *offBtn = [[UIButton alloc]initWithFrame:CGRectMake(253 - 11, i*22 + i*41 + 40 - 12, 44, 44)];
            //        [offBtn setTitle:@"off" forState:UIControlStateNormal];
            offBtn.tag = i + 2+100; //星期天 为第一天 tag 为1
            [offBtn addTarget:self
                       action:@selector(offBtnClick:)
             forControlEvents:UIControlEventTouchUpInside];
            if ([[mydb isON:i + 2] isEqualToString:@"YES"])
            {
                [offBtn setImage:[UIImage imageNamed:@"off灰"] forState:UIControlStateNormal];
            }
            if ([[mydb isON:i + 2] isEqualToString:@"NO"])
            {
                [offBtn setImage:[UIImage imageNamed:@"off高亮"] forState:UIControlStateNormal];
            }
            [self.view addSubview:offBtn];
            
            
        }
        //Btn 7
        UIButton *onBtn_7 = [[UIButton alloc]initWithFrame:CGRectMake(207-11, 6*22 + 6*41 + 40 - 12, 44, 44)];
        //    [onBtn_7 setTitle:@"on" forState:UIControlStateNormal];
        onBtn_7.tag = 201; //星期天 为第一天 tag 为1
        [onBtn_7 addTarget:self
                    action:@selector(onBtnClick:)
          forControlEvents:UIControlEventTouchUpInside];
        if ([[mydb isON:201 - 200] isEqualToString:@"YES"])
        {
            [onBtn_7 setImage:[UIImage imageNamed:@"on高亮"] forState:UIControlStateNormal];
        }
        if ([[mydb isON:201 - 200] isEqualToString:@"NO"])
        {
            [onBtn_7 setImage:[UIImage imageNamed:@"on灰"] forState:UIControlStateNormal];
        }
        [self.view addSubview:onBtn_7];
        
        UIButton *offBtn_7 = [[UIButton alloc]initWithFrame:CGRectMake(253 - 11, 6*22 + 6*41 + 40 - 12, 44, 44)];
        //    [offBtn_7 setTitle:@"off" forState:UIControlStateNormal];
        offBtn_7.tag = 101; //星期天 为第一天 tag 为1
        [offBtn_7 addTarget:self
                     action:@selector(offBtnClick:)
           forControlEvents:UIControlEventTouchUpInside];
        if ([[mydb isON:101 - 100] isEqualToString:@"YES"])
        {
            [offBtn_7 setImage:[UIImage imageNamed:@"off灰"] forState:UIControlStateNormal];
        }
        if ([[mydb isON:101 - 100] isEqualToString:@"NO"])
        {
            [offBtn_7 setImage:[UIImage imageNamed:@"off高亮"] forState:UIControlStateNormal];
        }
        [self.view addSubview:offBtn_7];

    }

}
//创建 显示时间的button
- (void)creatTimeBtn
{

    UIColor *blueColor = [UIColor colorWithRed:(CGFloat)45/255
                                         green:(CGFloat)171/255
                                          blue:(CGFloat)229/255
                                         alpha:1];
    MyDB * mydb = [[MyDB alloc]init];
    NSString *timeString = [[NSString alloc]init];

    if (DEVICE_IS_IPHONE5)//iPhone5
    {
        //星期天 第一个
        
        _timeBtn7 = [[UIButton alloc]initWithFrame:CGRectMake(110, 6*22 + 6*41 + 84, 80, 22)];
        if ([[mydb isON:1] isEqualToString:@"YES"])
        {
            timeString = [[NSString alloc]initWithFormat:@"%.2d  :  %.2d",[mydb hour:1],[mydb minute:1]];
            [_timeBtn7 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
        }
        else
        {
            timeString = [[NSString alloc]initWithFormat:@"自然醒"];
            [_timeBtn7 setTitleColor:blueColor forState:UIControlStateNormal];
            
        }
        [_timeBtn7 setTitle:timeString forState:UIControlStateNormal];
        _timeBtn7.backgroundColor = [UIColor clearColor];
        _timeBtn7.tag = 11;
        _timeBtn7.titleLabel.font = [UIFont systemFontOfSize:19.0f];
        [_timeBtn7 addTarget:self
                      action:@selector(timePick:)
            forControlEvents:UIControlEventTouchUpInside];
        [self.view insertSubview:_timeBtn7 belowSubview:_pickerView];
        
        
        _timeBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(110, 84, 80, 22)];
        if ([[mydb isON:2] isEqualToString:@"YES"])
        {
            timeString = [[NSString alloc]initWithFormat:@"%.2d  :  %.2d",[mydb hour:2],[mydb minute:2]];
            [_timeBtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
        }
        else
        {
            timeString = [[NSString alloc]initWithFormat:@"自然醒"];
            [_timeBtn1 setTitleColor:blueColor forState:UIControlStateNormal];
            
        }
        [_timeBtn1 setTitle:timeString forState:UIControlStateNormal];
        _timeBtn1.backgroundColor = [UIColor clearColor];
        _timeBtn1.tag = 12;
        _timeBtn1.titleLabel.font = [UIFont systemFontOfSize:19.0f];
        
        [_timeBtn1 addTarget:self
                      action:@selector(timePick:)
            forControlEvents:UIControlEventTouchUpInside];
        [self.view insertSubview:_timeBtn1 belowSubview:_pickerView];
        
        
        
        _timeBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(110, 1*22 + 1*41 + 84, 80, 22)];
        if ([[mydb isON:3] isEqualToString:@"YES"])
        {
            timeString = [[NSString alloc]initWithFormat:@"%.2d  :  %.2d",[mydb hour:3],[mydb minute:3]];
            [_timeBtn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
        }
        else
        {
            timeString = [[NSString alloc]initWithFormat:@"自然醒"];
            [_timeBtn2 setTitleColor:blueColor forState:UIControlStateNormal];
            
        }
        [_timeBtn2 setTitle:timeString forState:UIControlStateNormal];
        _timeBtn2.backgroundColor = [UIColor clearColor];
        _timeBtn2.tag = 13;
        _timeBtn2.titleLabel.font = [UIFont systemFontOfSize:19.0f];
        
        [_timeBtn2 addTarget:self
                      action:@selector(timePick:)
            forControlEvents:UIControlEventTouchUpInside];
        [self.view insertSubview:_timeBtn2 belowSubview:_pickerView];
        
        
        _timeBtn3 = [[UIButton alloc]initWithFrame:CGRectMake(110, 2*22 + 2*41 + 84, 80, 22)];
        if ([[mydb isON:4] isEqualToString:@"YES"])
        {
            timeString = [[NSString alloc]initWithFormat:@"%.2d  :  %.2d",[mydb hour:4],[mydb minute:4]];
            [_timeBtn3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
        }
        else
        {
            timeString = [[NSString alloc]initWithFormat:@"自然醒"];
            [_timeBtn3 setTitleColor:blueColor forState:UIControlStateNormal];
            
        }
        [_timeBtn3 setTitle:timeString forState:UIControlStateNormal];
        _timeBtn3.backgroundColor = [UIColor clearColor];
        _timeBtn3.tag = 14;
        _timeBtn3.titleLabel.font = [UIFont systemFontOfSize:19.0f];
        
        [_timeBtn3 addTarget:self
                      action:@selector(timePick:)
            forControlEvents:UIControlEventTouchUpInside];
        [self.view insertSubview:_timeBtn3 belowSubview:_pickerView];
        
        
        _timeBtn4 = [[UIButton alloc]initWithFrame:CGRectMake(110, 3*22 + 3*41 + 84, 80, 22)];
        if ([[mydb isON:5] isEqualToString:@"YES"])
        {
            timeString = [[NSString alloc]initWithFormat:@"%.2d  :  %.2d",[mydb hour:5],[mydb minute:5]];
            [_timeBtn4 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
        }
        else
        {
            timeString = [[NSString alloc]initWithFormat:@"自然醒"];
            [_timeBtn4 setTitleColor:blueColor forState:UIControlStateNormal];
            
        }
        [_timeBtn4 setTitle:timeString forState:UIControlStateNormal];
        _timeBtn4.backgroundColor = [UIColor clearColor];
        _timeBtn4.tag = 15;
        _timeBtn4.titleLabel.font = [UIFont systemFontOfSize:19.0f];
        
        [_timeBtn4 addTarget:self
                      action:@selector(timePick:)
            forControlEvents:UIControlEventTouchUpInside];
        [self.view insertSubview:_timeBtn4 belowSubview:_pickerView];
        
        
        _timeBtn5 = [[UIButton alloc]initWithFrame:CGRectMake(110, 4*22 + 4*41 + 84, 80, 22)];
        if ([[mydb isON:6] isEqualToString:@"YES"])
        {
            timeString = [[NSString alloc]initWithFormat:@"%.2d  :  %.2d",[mydb hour:6],[mydb minute:6]];
            [_timeBtn5 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
        }
        else
        {
            timeString = [[NSString alloc]initWithFormat:@"自然醒"];
            [_timeBtn5 setTitleColor:blueColor forState:UIControlStateNormal];
            
        }
        [_timeBtn5 setTitle:timeString forState:UIControlStateNormal];
        _timeBtn5.backgroundColor = [UIColor clearColor];
        _timeBtn5.tag = 16;
        _timeBtn5.titleLabel.font = [UIFont systemFontOfSize:19.0f];
        
        [_timeBtn5 addTarget:self
                      action:@selector(timePick:)
            forControlEvents:UIControlEventTouchUpInside];
        [self.view insertSubview:_timeBtn5 belowSubview:_pickerView];
        
        
        _timeBtn6 = [[UIButton alloc]initWithFrame:CGRectMake(110, 5*22 + 5*41 + 84, 80, 22)];
        if ([[mydb isON:7] isEqualToString:@"YES"])
        {
            timeString = [[NSString alloc]initWithFormat:@"%.2d  :  %.2d",[mydb hour:7],[mydb minute:7]];
            [_timeBtn6 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
        }
        else
        {
            timeString = [[NSString alloc]initWithFormat:@"自然醒"];
            [_timeBtn6 setTitleColor:blueColor forState:UIControlStateNormal];
            
        }
        [_timeBtn6 setTitle:timeString forState:UIControlStateNormal];
        _timeBtn6.backgroundColor = [UIColor clearColor];
        _timeBtn6.tag = 17;
        _timeBtn6.titleLabel.font = [UIFont systemFontOfSize:19.0f];
        
        [_timeBtn6 addTarget:self
                      action:@selector(timePick:)
            forControlEvents:UIControlEventTouchUpInside];
        [self.view insertSubview:_timeBtn6 belowSubview:_pickerView];

    }
        
    else//iPhone4
    {
        //星期天 第一个
        
        _timeBtn7 = [[UIButton alloc]initWithFrame:CGRectMake(110, 6*22 + 6*41 + 38, 80, 22)];
        if ([[mydb isON:1] isEqualToString:@"YES"])
        {
            timeString = [[NSString alloc]initWithFormat:@"%.2d  :  %.2d",[mydb hour:1],[mydb minute:1]];
            [_timeBtn7 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
        }
        else
        {
            timeString = [[NSString alloc]initWithFormat:@"自然醒"];
            [_timeBtn7 setTitleColor:blueColor forState:UIControlStateNormal];
            
        }
        [_timeBtn7 setTitle:timeString forState:UIControlStateNormal];
        _timeBtn7.backgroundColor = [UIColor clearColor];
        _timeBtn7.tag = 11;
        _timeBtn7.titleLabel.font = [UIFont systemFontOfSize:19.0f];
        [_timeBtn7 addTarget:self
                      action:@selector(timePick:)
            forControlEvents:UIControlEventTouchUpInside];
        [self.view insertSubview:_timeBtn7 belowSubview:_pickerView];
        
        
        _timeBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(110, 38, 80, 22)];
        if ([[mydb isON:2] isEqualToString:@"YES"])
        {
            timeString = [[NSString alloc]initWithFormat:@"%.2d  :  %.2d",[mydb hour:2],[mydb minute:2]];
            [_timeBtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
        }
        else
        {
            timeString = [[NSString alloc]initWithFormat:@"自然醒"];
            [_timeBtn1 setTitleColor:blueColor forState:UIControlStateNormal];
            
        }
        [_timeBtn1 setTitle:timeString forState:UIControlStateNormal];
        _timeBtn1.backgroundColor = [UIColor clearColor];
        _timeBtn1.tag = 12;
        _timeBtn1.titleLabel.font = [UIFont systemFontOfSize:19.0f];
        
        [_timeBtn1 addTarget:self
                      action:@selector(timePick:)
            forControlEvents:UIControlEventTouchUpInside];
        [self.view insertSubview:_timeBtn1 belowSubview:_pickerView];
        
        
        
        _timeBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(110, 1*22 + 1*41 + 38, 80, 22)];
        if ([[mydb isON:3] isEqualToString:@"YES"])
        {
            timeString = [[NSString alloc]initWithFormat:@"%.2d  :  %.2d",[mydb hour:3],[mydb minute:3]];
            [_timeBtn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
        }
        else
        {
            timeString = [[NSString alloc]initWithFormat:@"自然醒"];
            [_timeBtn2 setTitleColor:blueColor forState:UIControlStateNormal];
            
        }
        [_timeBtn2 setTitle:timeString forState:UIControlStateNormal];
        _timeBtn2.backgroundColor = [UIColor clearColor];
        _timeBtn2.tag = 13;
        _timeBtn2.titleLabel.font = [UIFont systemFontOfSize:19.0f];
        
        [_timeBtn2 addTarget:self
                      action:@selector(timePick:)
            forControlEvents:UIControlEventTouchUpInside];
        [self.view insertSubview:_timeBtn2 belowSubview:_pickerView];
        
        
        _timeBtn3 = [[UIButton alloc]initWithFrame:CGRectMake(110, 2*22 + 2*41 + 38, 80, 22)];
        if ([[mydb isON:4] isEqualToString:@"YES"])
        {
            timeString = [[NSString alloc]initWithFormat:@"%.2d  :  %.2d",[mydb hour:4],[mydb minute:4]];
            [_timeBtn3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
        }
        else
        {
            timeString = [[NSString alloc]initWithFormat:@"自然醒"];
            [_timeBtn3 setTitleColor:blueColor forState:UIControlStateNormal];
            
        }
        [_timeBtn3 setTitle:timeString forState:UIControlStateNormal];
        _timeBtn3.backgroundColor = [UIColor clearColor];
        _timeBtn3.tag = 14;
        _timeBtn3.titleLabel.font = [UIFont systemFontOfSize:19.0f];
        
        [_timeBtn3 addTarget:self
                      action:@selector(timePick:)
            forControlEvents:UIControlEventTouchUpInside];
        [self.view insertSubview:_timeBtn3 belowSubview:_pickerView];
        
        
        _timeBtn4 = [[UIButton alloc]initWithFrame:CGRectMake(110, 3*22 + 3*41 + 38, 80, 22)];
        if ([[mydb isON:5] isEqualToString:@"YES"])
        {
            timeString = [[NSString alloc]initWithFormat:@"%.2d  :  %.2d",[mydb hour:5],[mydb minute:5]];
            [_timeBtn4 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
        }
        else
        {
            timeString = [[NSString alloc]initWithFormat:@"自然醒"];
            [_timeBtn4 setTitleColor:blueColor forState:UIControlStateNormal];
            
        }
        [_timeBtn4 setTitle:timeString forState:UIControlStateNormal];
        _timeBtn4.backgroundColor = [UIColor clearColor];
        _timeBtn4.tag = 15;
        _timeBtn4.titleLabel.font = [UIFont systemFontOfSize:19.0f];
        
        [_timeBtn4 addTarget:self
                      action:@selector(timePick:)
            forControlEvents:UIControlEventTouchUpInside];
        [self.view insertSubview:_timeBtn4 belowSubview:_pickerView];
        
        
        _timeBtn5 = [[UIButton alloc]initWithFrame:CGRectMake(110, 4*22 + 4*41 + 38, 80, 22)];
        if ([[mydb isON:6] isEqualToString:@"YES"])
        {
            timeString = [[NSString alloc]initWithFormat:@"%.2d  :  %.2d",[mydb hour:6],[mydb minute:6]];
            [_timeBtn5 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
        }
        else
        {
            timeString = [[NSString alloc]initWithFormat:@"自然醒"];
            [_timeBtn5 setTitleColor:blueColor forState:UIControlStateNormal];
            
        }
        [_timeBtn5 setTitle:timeString forState:UIControlStateNormal];
        _timeBtn5.backgroundColor = [UIColor clearColor];
        _timeBtn5.tag = 16;
        _timeBtn5.titleLabel.font = [UIFont systemFontOfSize:19.0f];
        
        [_timeBtn5 addTarget:self
                      action:@selector(timePick:)
            forControlEvents:UIControlEventTouchUpInside];
        [self.view insertSubview:_timeBtn5 belowSubview:_pickerView];
        
        
        _timeBtn6 = [[UIButton alloc]initWithFrame:CGRectMake(110, 5*22 + 5*41 + 38, 80, 22)];
        if ([[mydb isON:7] isEqualToString:@"YES"])
        {
            timeString = [[NSString alloc]initWithFormat:@"%.2d  :  %.2d",[mydb hour:7],[mydb minute:7]];
            [_timeBtn6 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
        }
        else
        {
            timeString = [[NSString alloc]initWithFormat:@"自然醒"];
            [_timeBtn6 setTitleColor:blueColor forState:UIControlStateNormal];
            
        }
        [_timeBtn6 setTitle:timeString forState:UIControlStateNormal];
        _timeBtn6.backgroundColor = [UIColor clearColor];
        _timeBtn6.tag = 17;
        _timeBtn6.titleLabel.font = [UIFont systemFontOfSize:19.0f];
        
        [_timeBtn6 addTarget:self
                      action:@selector(timePick:)
            forControlEvents:UIControlEventTouchUpInside];
        [self.view insertSubview:_timeBtn6 belowSubview:_pickerView];

    }

}
- (void)onBtnClick:(id)sender
{
    MyDB * mydb = [[MyDB alloc]init];
    UIButton *onBtn = (UIButton *)sender;
    UIButton *offBtn = (UIButton *)[self.view viewWithTag:onBtn.tag - 100];

    [mydb setON:@"YES" day:onBtn.tag - 200];
    [onBtn setImage:[UIImage imageNamed:@"on高亮"] forState:UIControlStateNormal];
    [offBtn setImage:[UIImage imageNamed:@"off灰"] forState:UIControlStateNormal];

    NSString *timeString = [[NSString alloc]initWithFormat:@"%.2d  :  %.2d",[mydb hour:onBtn.tag - 200],[mydb minute:onBtn.tag - 200]];
    switch (offBtn.tag - 100) {

        case 1:
            [_timeBtn7 setTitle:timeString forState:UIControlStateNormal];
            [_timeBtn7 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            break;
        case 2:
            [_timeBtn1 setTitle:timeString forState:UIControlStateNormal];
            [_timeBtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            break;
        case 3:
            [_timeBtn2 setTitle:timeString forState:UIControlStateNormal];
            [_timeBtn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            break;
        case 4:
            [_timeBtn3 setTitle:timeString forState:UIControlStateNormal];
            [_timeBtn3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            break;
        case 5:
            [_timeBtn4 setTitle:timeString forState:UIControlStateNormal];
            [_timeBtn4 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            break;
        case 6:
            [_timeBtn5 setTitle:timeString forState:UIControlStateNormal];
            [_timeBtn5 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            break;
        case 7:
            [_timeBtn6 setTitle:timeString forState:UIControlStateNormal];
            [_timeBtn6 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
//    NSLog(@"onBtnClick %d  isON == %@",onBtn.tag - 200,[mydb isON:onBtn.tag - 200]);
}

- (void)offBtnClick:(id)sender
{
    UIColor *blueColor = [UIColor colorWithRed:(CGFloat)45/255
                                         green:(CGFloat)171/255
                                          blue:(CGFloat)229/255
                                         alpha:1];
    MyDB * mydb = [[MyDB alloc]init];
    UIButton *offBtn = (UIButton *)sender;
    UIButton *onBtn = (UIButton *)[self.view viewWithTag:offBtn.tag + 100];
    
    [mydb setON:@"NO" day:offBtn.tag - 100];
    [onBtn setImage:[UIImage imageNamed:@"on灰"] forState:UIControlStateNormal];
    [offBtn setImage:[UIImage imageNamed:@"off高亮"] forState:UIControlStateNormal];



    switch (offBtn.tag - 100) {
        case 1:
            [_timeBtn7 setTitle:@"自然醒" forState:UIControlStateNormal];
            [_timeBtn7 setTitleColor:blueColor forState:UIControlStateNormal];
            break;
        case 2:
            [_timeBtn1 setTitle:@"自然醒" forState:UIControlStateNormal];
            [_timeBtn1 setTitleColor:blueColor forState:UIControlStateNormal];
            break;
        case 3:
            [_timeBtn2 setTitle:@"自然醒" forState:UIControlStateNormal];
            [_timeBtn2 setTitleColor:blueColor forState:UIControlStateNormal];
            break;
        case 4:
            [_timeBtn3 setTitle:@"自然醒" forState:UIControlStateNormal];
            [_timeBtn3 setTitleColor:blueColor forState:UIControlStateNormal];
            break;
        case 5:
            [_timeBtn4 setTitle:@"自然醒" forState:UIControlStateNormal];
            [_timeBtn4 setTitleColor:blueColor forState:UIControlStateNormal];
            break;
        case 6:
            [_timeBtn5 setTitle:@"自然醒" forState:UIControlStateNormal];
            [_timeBtn5 setTitleColor:blueColor forState:UIControlStateNormal];
            break;
        case 7:
            [_timeBtn6 setTitle:@"自然醒" forState:UIControlStateNormal];
            [_timeBtn6 setTitleColor:blueColor forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    
//    NSLog(@"offBtnClick %d  isON == %@",onBtn.tag - 200,[mydb isON:offBtn.tag - 100]);

}

- (void)timePick:(id)sender
{
    UIButton *Btn = (UIButton *)sender;
    dayNum = Btn.tag - 10;//因为 设定的 tag 是从10开始的
//    _pickerView.hidden = NO;
    
    //////////////////////////////////////////////////////////////////////
    [UIView animateWithDuration:0.5 delay:0 options:0 animations:^(){
        _pickerView.frame = CGRectMake(0, 568, 320, 568);
        [_pickerView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
       _pickerView.frame = CGRectMake(0, 0, 320, 568);
    } completion:^(BOOL finished)
     {
         
     }];
    
    //////////////////////////////////////////////////////////////////////

    MyDB * mydb = [[MyDB alloc]init];
    UIButton *onBtn = (UIButton *)[self.view viewWithTag:Btn.tag - 10 + 200];
    UIButton *offBtn = (UIButton *)[self.view viewWithTag:Btn.tag - 10 + 100];
    
    [mydb setON:@"YES" day:onBtn.tag - 200];
    [onBtn setImage:[UIImage imageNamed:@"on高亮"] forState:UIControlStateNormal];
    [offBtn setImage:[UIImage imageNamed:@"off灰"] forState:UIControlStateNormal];
    NSString *timeString = [[NSString alloc]initWithFormat:@"%.2d  :  %.2d",[mydb hour:onBtn.tag - 200],[mydb minute:onBtn.tag - 200]];
    
    
    [self performSelector:@selector(selectSet) withObject:self afterDelay:0.0f];

    
    
    switch (dayNum) {
            
        case 1:
            [_timeBtn7 setTitle:timeString forState:UIControlStateNormal];
            [_timeBtn7 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            break;
        case 2:
            [_timeBtn1 setTitle:timeString forState:UIControlStateNormal];
            [_timeBtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            break;
        case 3:
            [_timeBtn2 setTitle:timeString forState:UIControlStateNormal];
            [_timeBtn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            break;
        case 4:
            [_timeBtn3 setTitle:timeString forState:UIControlStateNormal];
            [_timeBtn3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            break;
        case 5:
            [_timeBtn4 setTitle:timeString forState:UIControlStateNormal];
            [_timeBtn4 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            break;
        case 6:
            [_timeBtn5 setTitle:timeString forState:UIControlStateNormal];
            [_timeBtn5 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            break;
        case 7:
            [_timeBtn6 setTitle:timeString forState:UIControlStateNormal];
            [_timeBtn6 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}
//初始化 用于 储存 闹钟时间的两个字典
- (void)initTimeDictionary
{
    MyDB *mydb = [[MyDB alloc]init];
    
    NSMutableArray *hourTimeArray = [[NSMutableArray alloc]initWithCapacity:7];
    NSMutableArray *keysArray = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",nil];
    for (int i = 0; i < 7 ; i++)
    {
        NSString *tempHourString = [[NSString alloc]initWithFormat:@"%d",[mydb hour:i+1]];
        [hourTimeArray addObject:tempHourString];
    }
    _hourTime = [[NSMutableDictionary alloc]initWithObjects:hourTimeArray forKeys:keysArray];
    
    NSMutableArray *minuteTimeArray = [[NSMutableArray alloc]initWithCapacity:7];
    for (int i = 0; i < 7 ; i++)
    {
        NSString *tempMinuteString = [[NSString alloc]initWithFormat:@"%d",[mydb minute:i+1]];
        [minuteTimeArray addObject:tempMinuteString];
    }
    _minuteTime = [[NSMutableDictionary alloc]initWithObjects:minuteTimeArray forKeys:keysArray];
    
}
#pragma IZValueSelector dataSource
- (NSInteger)numberOfRowsInSelector:(IZValueSelectorView *)valueSelector {
    if (valueSelector == _hourPicker)
    {
        return 24;
    }
    if (valueSelector == _minutePicker)
    {
        return 60;
    }
    return 0;
}


- (CGFloat)rowHeightInSelector:(IZValueSelectorView *)valueSelector {
    
    return 198.0f/5.0f;
}

- (CGFloat)rowWidthInSelector:(IZValueSelectorView *)valueSelector {
    return 110.0f;
}


- (UIView *)selector:(IZValueSelectorView *)valueSelector viewForRowAtIndex:(NSInteger)index {
    UIColor *blueColor = [UIColor colorWithRed:(CGFloat)45/255
                                         green:(CGFloat)171/255
                                          blue:(CGFloat)229/255
                                         alpha:1];
    UILabel * label = nil;
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _hourPicker.frame.size.width, 202/5.0)];
    //年
    if (valueSelector == _hourPicker)
    {
        label.text = [NSString stringWithFormat:@"%d点", index ];
        [label setTextColor:blueColor];
        label.font = [UIFont systemFontOfSize:28.0f];
        label.textAlignment =  NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
    }
    //月 日
    else
    {
        label.text = [NSString stringWithFormat:@"%d分",index ];
        [label setTextColor:blueColor];
        label.font = [UIFont systemFontOfSize:28.0f];
        label.textAlignment =  NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
    }
    
    return label;
}

- (CGRect)rectForSelectionInSelector:(IZValueSelectorView *)valueSelector {
    
    // 选中框的 rect
    return CGRectMake(0.0,_hourPicker.frame.size.height/2 - 198/5.0/2, 92.0, 198/5.0);
}

#pragma IZValueSelector delegate
- (void)selector:(IZValueSelectorView *)valueSelector didSelectRowAtIndex:(NSInteger)index {
//    NSLog(@"Selected index %d",index);
    //获取 pickerView 选择的时间 存入全局变量

    if (valueSelector == _hourPicker)
    {
        NSString *dayNumString = [[NSString alloc]initWithFormat:@"%d",dayNum];
        NSString *timeString = [[NSString alloc]initWithFormat:@"%d",(index % 24)];
        [_hourTime setValue:timeString forKey:dayNumString];
//        NSLog(@"dayNum == %d",dayNum);
//        NSLog(@"index 余 24 == %d",(index % 24));
//        NSLog(@"[_hourTime valueForKey:dayNumString] == %@",[_hourTime valueForKey:dayNumString]);
    }
    if (valueSelector == _minutePicker)
    {
        NSString *dayNumString = [[NSString alloc]initWithFormat:@"%d",dayNum];
        NSString *timeString = [[NSString alloc]initWithFormat:@"%d",(index % 60)];
        [_minuteTime setValue:timeString forKey:dayNumString];
    }

}

- (IBAction)okClick:(id)sender
{
    //////////////////////////////////////////////////////////////////////
    [UIView animateWithDuration:0.5 delay:0 options:0 animations:^(){
        _pickerView.frame = CGRectMake(0, 0, 320, 568);
        [_pickerView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        _pickerView.frame = CGRectMake(0, 568, 320, 568);
    } completion:^(BOOL finished)
     {
         
     }];
    
    MyDB *mydb = [[MyDB alloc]init];
    //将字典中的信息 存入数据库中
    for (int i = 0; i < 7; i++)
    {
        NSString *dayNumString = [[NSString alloc]initWithFormat:@"%d",i+1];
        int hour =[[_hourTime valueForKey:dayNumString]intValue];
        
        
        [mydb setHour:hour day:i+1];
//        NSLog(@"[[_hourTime valueForKey:dayNumString]intValue] == %d",[[_hourTime valueForKey:dayNumString]intValue]);
//        NSLog(@"[mydb hour:i+1] == %d",[mydb hour:i+1]);
//        NSLog(@"dayNumString == %@,i+1 == %d",dayNumString,i+1);
        int minute =[[_minuteTime valueForKey:dayNumString]intValue];
        [mydb setMinute:minute day:i+1];
    }
    [_timeBtn1 removeFromSuperview];
    [_timeBtn2 removeFromSuperview];
    [_timeBtn3 removeFromSuperview];
    [_timeBtn4 removeFromSuperview];
    [_timeBtn5 removeFromSuperview];
    [_timeBtn6 removeFromSuperview];
    [_timeBtn7 removeFromSuperview];
    
    [self creatTimeBtn];
    
    //这里设置 本地推送
    PushNotification *pushNotification = [[PushNotification alloc]init];
    [pushNotification setClock];
}
- (IBAction)cancelClick:(id)sender
{
    //////////////////////////////////////////////////////////////////////
    [UIView animateWithDuration:0.5 delay:0 options:0 animations:^(){
        _pickerView.frame = CGRectMake(0, 0, 320, 568);
        [_pickerView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        _pickerView.frame = CGRectMake(0, 568, 320, 568);
    } completion:^(BOOL finished)
     {
         
     }];

}

- (void)selectSet
{
    MyDB *mydb = [[MyDB alloc]init];
    [_hourPicker selectIndex:[NSIndexPath indexPathForRow:[mydb hour:dayNum] inSection:0]];
    [_minutePicker selectIndex:[NSIndexPath indexPathForRow:[mydb minute:dayNum] inSection:0]];
}
@end
