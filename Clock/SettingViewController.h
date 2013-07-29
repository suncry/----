//
//  SettingViewController.h
//  Clock
//
//  Created by Suncry on 13-6-24.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIPickerView *_timePicker;//设置闹钟时间
    UIButton *_okBtn;//确认按钮
    UIButton *_cancelBtn;//取消按钮
    UIButton *_timeBtn1;
    UIButton *_timeBtn2;
    UIButton *_timeBtn3;
    UIButton *_timeBtn4;
    UIButton *_timeBtn5;
    UIButton *_timeBtn6;
    UIButton *_timeBtn7;
    UIButton *_switchBtn1;
    UIButton *_switchBtn2;
    UIButton *_switchBtn3;
    UIButton *_switchBtn4;
    UIButton *_switchBtn5;
    UIButton *_switchBtn6;
    UIButton *_switchBtn7;
    int dayNum;//用于确定是设置的哪天的时间
    //星期天为一星期的第一天 key为1
    NSMutableDictionary *_hourTime;
    NSMutableDictionary *_minuteTime;


}

@end
