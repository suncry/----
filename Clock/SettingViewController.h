//
//  SettingViewController.h
//  Clock
//
//  Created by Suncry on 13-6-24.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IZValueSelectorView.h"

@interface SettingViewController : UIViewController<IZValueSelectorViewDataSource,IZValueSelectorViewDelegate>
{
    IBOutlet IZValueSelectorView *_hourPicker;
    IBOutlet IZValueSelectorView *_minutePicker;
    IBOutlet UIView *_pickerView;
    
        
    UIButton *_timeBtn1;
    UIButton *_timeBtn2;
    UIButton *_timeBtn3;
    UIButton *_timeBtn4;
    UIButton *_timeBtn5;
    UIButton *_timeBtn6;
    UIButton *_timeBtn7;

    int dayNum;//用于确定是设置的哪天的时间
    //星期天为一星期的第一天 key为1
    NSMutableDictionary *_hourTime;
    NSMutableDictionary *_minuteTime;

    UIButton *_iKnowBtn;
    UIImageView *_alertImageView;
    UIButton *_lineBtn;
    
    UIView *_backgroundView;

}
- (IBAction)okClick:(id)sender;
- (IBAction)cancelClick:(id)sender;
@end
