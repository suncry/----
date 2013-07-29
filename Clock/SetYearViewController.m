//
//  SetYearViewController.m
//  Clock
//
//  Created by Suncry on 13-7-3.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import "SetYearViewController.h"
#import "YearViewController.h"
#import "MyDB.h"


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
    UIButton *okBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, DEVICE_HEIGHT-50, 320, 50)];
    [okBtn setTitle:@"确认" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    okBtn.backgroundColor = [UIColor redColor];
    [okBtn addTarget:self action:@selector(okBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:okBtn];
    
    
    yearPickerView.backgroundColor = [UIColor clearColor];
    monthPickerView.backgroundColor = [UIColor clearColor];
    dayPickerView.backgroundColor = [UIColor clearColor];
    

    yearPickerView.dataSource = self;
    yearPickerView.delegate = self;
    yearPickerView.shouldBeTransparent = YES;
    yearPickerView.horizontalScrolling = NO;
    
    yearPickerView.debugEnabled = NO;


    monthPickerView.dataSource = self;
    monthPickerView.delegate = self;
    monthPickerView.shouldBeTransparent = YES;
    monthPickerView.horizontalScrolling = NO;
    
    monthPickerView.debugEnabled = NO;
    
    dayPickerView.dataSource = self;
    dayPickerView.delegate = self;
    dayPickerView.shouldBeTransparent = YES;
    dayPickerView.horizontalScrolling = NO;
    
    dayPickerView.debugEnabled = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//okBtnClick
- (void)okBtnClick
{
    //储存年月日
    MyDB *mydb = [[MyDB alloc]init];
    [mydb setYear:year];
    [mydb setMonth:month];
    [mydb setDay:day];
    
    //跳转
    YearViewController *yearViewController = [[YearViewController alloc]init];
//    self.modalPresentationStyle = UIModalPresentationPageSheet;
    [self presentViewController:yearViewController animated:YES completion:nil];

}
#pragma IZValueSelector dataSource
- (NSInteger)numberOfRowsInSelector:(IZValueSelectorView *)valueSelector {
    if (valueSelector == yearPickerView)
    {
        return 90*100;
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

    return 30.0;
}

- (CGFloat)rowWidthInSelector:(IZValueSelectorView *)valueSelector {
    return 70.0;
}


- (UIView *)selector:(IZValueSelectorView *)valueSelector viewForRowAtIndex:(NSInteger)index {
    UILabel * label = nil;
    if (valueSelector == yearPickerView) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, yearPickerView.frame.size.height)];
    }
    else {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, yearPickerView.frame.size.width, 90)];
    }
    
    if (valueSelector == yearPickerView)
    {
        label.text = [NSString stringWithFormat:@"%d",yearNow - 90 + index +1];
        label.textAlignment =  NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
    }
    //月
    else
    {
        label.text = [NSString stringWithFormat:@"%d",index +1];
        label.textAlignment =  NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
    }
    
    return label;
}

- (CGRect)rectForSelectionInSelector:(IZValueSelectorView *)valueSelector {
    //Just return a rect in which you want the selector image to appear
    //Use the IZValueSelector coordinates
    //Basically the x will be 0
    //y will be the origin of your image
    //width and height will be the same as in your selector image
    if (valueSelector == yearPickerView) {
        return CGRectMake(yearPickerView.frame.size.width/2 - 35.0, 0.0, 70.0, 90.0);
    }
    else {
        return CGRectMake(0.0, yearPickerView.frame.size.height/2 - 35.0, 90.0, 70.0);
    }
    
}

#pragma IZValueSelector delegate
- (void)selector:(IZValueSelectorView *)valueSelector didSelectRowAtIndex:(NSInteger)index {
    NSLog(@"Selected index %d",index);
    //获取 pickerView 选择的时间 存入全局变量
    if (valueSelector == yearPickerView)
    {
        year = [[[NSString alloc]initWithFormat:@"%d",yearNow - 90 + index]intValue];
        NSLog(@"存入的year == %d",year);
    }
    if (valueSelector == monthPickerView)
    {
        month = [[[NSString alloc]initWithFormat:@"%d",index]intValue];
        NSLog(@"存入的month == %d",month);

    }
    if (valueSelector == dayPickerView)
    {
        day = [[[NSString alloc]initWithFormat:@"%d",index]intValue];
        NSLog(@"存入day == %d",day);

    }

}

@end
