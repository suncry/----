//
//  SetYearViewController.h
//  Clock
//
//  Created by Suncry on 13-7-3.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IZValueSelectorView.h"


@interface SetYearViewController : UIViewController<IZValueSelectorViewDataSource,IZValueSelectorViewDelegate>
{
    //用于记录 pickerView 的值
    int year;
    int month;
    int day;
    //当前年
    int yearNow;
    IBOutlet IZValueSelectorView *yearPickerView;
    IBOutlet IZValueSelectorView *monthPickerView;
    IBOutlet IZValueSelectorView *dayPickerView;
    
    //用于控制 取消按钮的隐藏
    IBOutlet UIButton *_cancelBtn;
    IBOutlet UIButton *_cancelBtn2;

}
- (IBAction)okBtnClick:(id)sender;
- (IBAction)cancelBtnClick:(id)sender;

@end
