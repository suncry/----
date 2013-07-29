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
    [self addGesture];
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
    for (int i = 0; i < 7; i++)
    {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(30, (i+1)*(DEVICE_HEIGHT/9), 60, 20)];
        NSString *string = [[NSString alloc]initWithFormat:@"星期 %d",i+1];
        [lable setText:string];
        [self.view addSubview:lable];
    }

}


//创建 开关按钮
- (void)creatBtn
{ 
    MyDB * mydb = [[MyDB alloc]init];
    //星期天 开关
    _switchBtn7 = [[UIButton alloc]initWithFrame:CGRectMake(230, 7*(DEVICE_HEIGHT/9), 40, 20)];
    _switchBtn7.tag = 1; //星期天 为第一天 tag 为1
    [_switchBtn7 addTarget:self
                    action:@selector(switchBtnClick:)
          forControlEvents:UIControlEventTouchUpInside];
    if ([[mydb isON:1] isEqualToString:@"YES"])
    {
        _switchBtn7.backgroundColor = [UIColor redColor];
        
    }
    if ([[mydb isON:1] isEqualToString:@"NO"])
    {
        _switchBtn7.backgroundColor = [UIColor blackColor];
    }
    [self.view addSubview:_switchBtn7];

    //星期1 开关
    _switchBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(230, 1*(DEVICE_HEIGHT/9), 40, 20)];
    _switchBtn1.tag = 2; //星期天 为第一天 tag 为1
    [_switchBtn1 addTarget:self
                    action:@selector(switchBtnClick:)
          forControlEvents:UIControlEventTouchUpInside];
    if ([[mydb isON:2] isEqualToString:@"YES"])
    {
        _switchBtn1.backgroundColor = [UIColor redColor];
        
    }
    if ([[mydb isON:2] isEqualToString:@"NO"])
    {
        _switchBtn1.backgroundColor = [UIColor blackColor];
    }
    [self.view addSubview:_switchBtn1];

    //星期2 开关
    _switchBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(230, 2*(DEVICE_HEIGHT/9), 40, 20)];
    _switchBtn2.tag = 3; //星期天 为第一天 tag 为1
    [_switchBtn2 addTarget:self
                    action:@selector(switchBtnClick:)
          forControlEvents:UIControlEventTouchUpInside];
    if ([[mydb isON:3] isEqualToString:@"YES"])
    {
        _switchBtn2.backgroundColor = [UIColor redColor];
        
    }
    if ([[mydb isON:3] isEqualToString:@"NO"])
    {
        _switchBtn2.backgroundColor = [UIColor blackColor];
    }
    [self.view addSubview:_switchBtn2];

    //星期3 开关
    _switchBtn3 = [[UIButton alloc]initWithFrame:CGRectMake(230, 3*(DEVICE_HEIGHT/9), 40, 20)];
    _switchBtn3.tag = 4; //星期天 为第一天 tag 为1
    [_switchBtn3 addTarget:self
                    action:@selector(switchBtnClick:)
          forControlEvents:UIControlEventTouchUpInside];
    if ([[mydb isON:4] isEqualToString:@"YES"])
    {
        _switchBtn3.backgroundColor = [UIColor redColor];
        
    }
    if ([[mydb isON:4] isEqualToString:@"NO"])
    {
        _switchBtn3.backgroundColor = [UIColor blackColor];
    }
    [self.view addSubview:_switchBtn3];

    //星期4 开关
    _switchBtn4 = [[UIButton alloc]initWithFrame:CGRectMake(230, 4*(DEVICE_HEIGHT/9), 40, 20)];
    _switchBtn4.tag = 5; //星期天 为第一天 tag 为1
    [_switchBtn4 addTarget:self
                    action:@selector(switchBtnClick:)
          forControlEvents:UIControlEventTouchUpInside];
    if ([[mydb isON:5] isEqualToString:@"YES"])
    {
        _switchBtn4.backgroundColor = [UIColor redColor];
        
    }
    if ([[mydb isON:5] isEqualToString:@"NO"])
    {
        _switchBtn4.backgroundColor = [UIColor blackColor];
    }
    [self.view addSubview:_switchBtn4];

    //星期5 开关
    _switchBtn5 = [[UIButton alloc]initWithFrame:CGRectMake(230, 5*(DEVICE_HEIGHT/9), 40, 20)];
    _switchBtn5.tag = 6; //星期天 为第一天 tag 为1
    [_switchBtn5 addTarget:self
                    action:@selector(switchBtnClick:)
          forControlEvents:UIControlEventTouchUpInside];
    if ([[mydb isON:6] isEqualToString:@"YES"])
    {
        _switchBtn5.backgroundColor = [UIColor redColor];
        
    }
    if ([[mydb isON:6] isEqualToString:@"NO"])
    {
        _switchBtn5.backgroundColor = [UIColor blackColor];
    }
    [self.view addSubview:_switchBtn5];

    
    //星期6 开关
    _switchBtn6 = [[UIButton alloc]initWithFrame:CGRectMake(230, 6*(DEVICE_HEIGHT/9), 40, 20)];
    _switchBtn6.tag = 7; //星期天 为第一天 tag 为1
    [_switchBtn6 addTarget:self
                    action:@selector(switchBtnClick:)
          forControlEvents:UIControlEventTouchUpInside];
    if ([[mydb isON:7] isEqualToString:@"YES"])
    {
        _switchBtn6.backgroundColor = [UIColor redColor];
        
    }
    if ([[mydb isON:7] isEqualToString:@"NO"])
    {
        _switchBtn6.backgroundColor = [UIColor blackColor];
    }
    [self.view addSubview:_switchBtn6];


}
//创建 显示时间的button
- (void)creatTimeBtn
{

    MyDB * mydb = [[MyDB alloc]init];
    
    //星期天 第一个
    NSString *timeString = [[NSString alloc]initWithFormat:@"%.2d:%.2d",[mydb hour:1],[mydb minute:1]];
    _timeBtn7 = [[UIButton alloc]initWithFrame:CGRectMake(120, 7*(DEVICE_HEIGHT/9), 60, 20)];
    [_timeBtn7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_timeBtn7 setTitle:timeString forState:UIControlStateNormal];
    _timeBtn7.backgroundColor = [UIColor clearColor];
    _timeBtn7.tag = 11;
    [_timeBtn7 addTarget:self
                  action:@selector(timePick:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_timeBtn7];
    
    timeString = [[NSString alloc]initWithFormat:@"%.2d:%.2d",[mydb hour:2],[mydb minute:2]];
    _timeBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(120, 1*(DEVICE_HEIGHT/9), 60, 20)];
    [_timeBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_timeBtn1 setTitle:timeString forState:UIControlStateNormal];
    _timeBtn1.backgroundColor = [UIColor clearColor];
    _timeBtn1.tag = 12;
    [_timeBtn1 addTarget:self
                      action:@selector(timePick:)
            forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_timeBtn1];
    
    timeString = [[NSString alloc]initWithFormat:@"%.2d:%.2d",[mydb hour:3],[mydb minute:3]];
    _timeBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(120, 2*(DEVICE_HEIGHT/9), 60, 20)];
    [_timeBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_timeBtn2 setTitle:timeString forState:UIControlStateNormal];
    _timeBtn2.backgroundColor = [UIColor clearColor];
    _timeBtn2.tag = 13;
    [_timeBtn2 addTarget:self
                  action:@selector(timePick:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_timeBtn2];
    
    timeString = [[NSString alloc]initWithFormat:@"%.2d:%.2d",[mydb hour:4],[mydb minute:4]];
    _timeBtn3 = [[UIButton alloc]initWithFrame:CGRectMake(120, 3*(DEVICE_HEIGHT/9), 60, 20)];
    [_timeBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_timeBtn3 setTitle:timeString forState:UIControlStateNormal];
    _timeBtn3.backgroundColor = [UIColor clearColor];
    _timeBtn3.tag = 14;
    [_timeBtn3 addTarget:self
                  action:@selector(timePick:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_timeBtn3];
    
    timeString = [[NSString alloc]initWithFormat:@"%.2d:%.2d",[mydb hour:5],[mydb minute:5]];
    _timeBtn4 = [[UIButton alloc]initWithFrame:CGRectMake(120, 4*(DEVICE_HEIGHT/9), 60, 20)];
    [_timeBtn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_timeBtn4 setTitle:timeString forState:UIControlStateNormal];
    _timeBtn4.backgroundColor = [UIColor clearColor];
    _timeBtn4.tag = 15;
    [_timeBtn4 addTarget:self
                  action:@selector(timePick:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_timeBtn4];
    
    timeString = [[NSString alloc]initWithFormat:@"%.2d:%.2d",[mydb hour:6],[mydb minute:6]];
    _timeBtn5 = [[UIButton alloc]initWithFrame:CGRectMake(120, 5*(DEVICE_HEIGHT/9), 60, 20)];
    [_timeBtn5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_timeBtn5 setTitle:timeString forState:UIControlStateNormal];
    _timeBtn5.backgroundColor = [UIColor clearColor];
    _timeBtn5.tag = 16;
    [_timeBtn5 addTarget:self
                  action:@selector(timePick:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_timeBtn5];
    
    timeString = [[NSString alloc]initWithFormat:@"%.2d:%.2d",[mydb hour:7],[mydb minute:7]];
    _timeBtn6 = [[UIButton alloc]initWithFrame:CGRectMake(120, 6*(DEVICE_HEIGHT/9), 60, 20)];
    [_timeBtn6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_timeBtn6 setTitle:timeString forState:UIControlStateNormal];
    _timeBtn6.backgroundColor = [UIColor clearColor];
    _timeBtn6.tag = 17;
    [_timeBtn6 addTarget:self
                  action:@selector(timePick:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_timeBtn6];
    


}
//创建pickerView
- (void)creatPickerView
{
    MyDB *mydb = [[MyDB alloc]init];


    _timePicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 200, 320, 60)];
    _timePicker.delegate = self;
    [self.view addSubview:_timePicker];
    [_timePicker selectRow:1200+[mydb hour:dayNum] inComponent:0 animated:YES];
    [_timePicker selectRow:3000+[mydb minute:dayNum] inComponent:1 animated:YES];
    
    
    _okBtn = [[UIButton alloc]initWithFrame:CGRectMake(280, 170, 50, 30)];
    _okBtn.backgroundColor = [UIColor blackColor];
    [_okBtn addTarget:self
              action:@selector(okBtnClick)
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_okBtn];
    
    _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 170, 50, 30)];
    _cancelBtn.backgroundColor = [UIColor redColor];
    [_cancelBtn addTarget:self
              action:@selector(cancelBtnClick)
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelBtn];
    
}


- (void)switchBtnClick:(id)sender
{
    MyDB * mydb = [[MyDB alloc]init];
    UIButton *Btn = (UIButton *)sender;    
    if ([[mydb isON:Btn.tag] isEqualToString:@"YES"])
    {
        [mydb setON:@"NO" day:Btn.tag];
        Btn.backgroundColor = [UIColor blackColor];
    }
    else if  ([[mydb isON:Btn.tag] isEqualToString:@"NO"])
    {
        [mydb setON:@"YES" day:Btn.tag];
        Btn.backgroundColor = [UIColor redColor];

    }

}

- (void)timePick:(id)sender
{
    UIButton *Btn = (UIButton *)sender;
    dayNum = Btn.tag - 10;//因为 设定的 tag 是从10开始的
    [self creatPickerView];
}

#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //实现pickerView的循环滚动
    if (component == 0)
    {
        return 2400;
    }
    else
        return 6000;
}

#pragma mark UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 60;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //获取 pickerView 选择的时间 存入2个字典中
    if (component == 0)
    {
        NSString *dayNumString = [[NSString alloc]initWithFormat:@"%d",dayNum];
        NSString *timeString = [[NSString alloc]initWithFormat:@"%d",(row % 24)];
        [_hourTime setValue:timeString forKey:dayNumString];
    }
    if (component == 1)
    {
        NSString *dayNumString = [[NSString alloc]initWithFormat:@"%d",dayNum];
        NSString *timeString = [[NSString alloc]initWithFormat:@"%d",(row % 60)];
        [_minuteTime setValue:timeString forKey:dayNumString];
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //设置 pickerView 每一行的标题
    if (component == 0)
    {
        return [[NSString alloc]initWithFormat:@"%d",row%24];
    }
    else
        return [[NSString alloc]initWithFormat:@"%d",row%60];
}

//确定按钮 响应事件
- (void)okBtnClick
{
    MyDB *mydb = [[MyDB alloc]init];
    //将字典中的信息 存入数据库中
    for (int i = 0; i < 7; i++)
    {
        NSString *dayNumString = [[NSString alloc]initWithFormat:@"%d",i+1];
        int hour =[[_hourTime valueForKey:dayNumString]intValue];
        [mydb setHour:hour day:i+1];
        
        int minute =[[_minuteTime valueForKey:dayNumString]intValue];
        [mydb setMinute:minute day:i+1];
    }
    
    

    _okBtn.hidden = YES;
    _cancelBtn.hidden = YES;
    _timePicker.hidden = YES;
    
    [_timeBtn1 removeFromSuperview];
    [_timeBtn2 removeFromSuperview];
    [_timeBtn3 removeFromSuperview];
    [_timeBtn4 removeFromSuperview];
    [_timeBtn5 removeFromSuperview];
    [_timeBtn6 removeFromSuperview];
    [_timeBtn7 removeFromSuperview];

    [self creatTimeBtn];
}
//取消按钮 响应事件
- (void)cancelBtnClick
{
    //点击取消 将字典中的数据 恢复到和数据库一致
    MyDB *mydb = [[MyDB alloc]init];
    for (int i = 0; i < 7; i++)
    {
        NSString *dayNumString = [[NSString alloc]initWithFormat:@"%d",i+1];
        NSString *hourString = [[NSString alloc]initWithFormat:@"%d",[mydb hour:i+1]];
        [_hourTime setValue:hourString forKey:dayNumString];
        
        NSString *minuteString = [[NSString alloc]initWithFormat:@"%d",[mydb minute:i+1]];
        [_minuteTime setValue:minuteString forKey:dayNumString];
    }

    _okBtn.hidden = YES;
    _cancelBtn.hidden = YES;
    _timePicker.hidden = YES;
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
@end
