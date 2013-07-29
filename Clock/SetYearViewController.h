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
    //设置出生年月
    IZValueSelectorView *_yearSelectorView;
    IZValueSelectorView *_monthSelectorView;
    IZValueSelectorView *_daySelectorView;

    //用于记录 pickerView 的值
    int year;
    int month;
    int day;
    //当前年
    int yearNow;
//    IBOutlet UIImageView *backgoundImageView;
//    IBOutlet UIImageView *pickerBackgoundImageView;
//    IBOutlet UIImageView *selectImageView;
    IBOutlet IZValueSelectorView *yearPickerView;
    IBOutlet IZValueSelectorView *monthPickerView;
    IBOutlet IZValueSelectorView *dayPickerView;


}
@end
