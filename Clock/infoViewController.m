//
//  InfoViewController.m
//  Clock
//
//  Created by Suncry on 13-7-1.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import "InfoViewController.h"
#import "DayViewController.h"
#import "UMSocial.h"
#import "SetYearViewController.h"
#import "ASIHTTPRequest.h"
#import "SBJson.h"



@interface InfoViewController ()

@end

@implementation InfoViewController

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
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [[self view] addGestureRecognizer:recognizer];

    

}
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{
    
      if(recognizer.direction==UISwipeGestureRecognizerDirectionRight)
    {
        
        //执行程序
        DayViewController *dayViewController = [[DayViewController alloc]init];
        [self presentViewController:dayViewController animated:YES completion:nil];
        
    }
}

- (IBAction)shareBtnClick:(id)sender
{
    //一般的默认 分享设置
    UMSocialIconActionSheet *iconActionSheet = [[UMSocialControllerService defaultControllerService] getSocialIconActionSheetInController:self];
    [iconActionSheet showInView:self.view];

    [UMSocialData defaultData].shareImage = [UIImage imageNamed:@"分享图片"];
    [UMSocialData defaultData].shareText = @"我正在使用【时光闹钟】，以时光的名义，提醒我们积极向上的迎接人生中的每一天。App Store 下载地址：https://itunes.apple.com/us/app/shi-guang-nao-zhong/id684557922?ls=1&mt=8";
    
    //微信的分享设置
    [UMSocialControllerService defaultControllerService].socialData.extConfig.wxMessageType = UMSocialWXMessageTypeImage;   //可以指定音乐类型或者视频类型
    [UMSocialData defaultData].extConfig.appUrl = @"https://itunes.apple.com/us/app/shi-guang-nao-zhong/id684557922?ls=1&mt=8";  //点击之后  跳转的链接

}

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
}

- (IBAction)feedbackBtnClick:(id)sender
{
    [feedbackView removeFromSuperview];
    textView.text = @"";
    [self.view addSubview:feedbackView];
    
    //////////////////////////////////////////////////////////////////////

    [UIView animateWithDuration:0.5 delay:0 options:0 animations:^(){
        feedbackView.frame = CGRectMake(0, 568, 320, 568);
        [feedbackView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        feedbackView.frame = CGRectMake(0, 0, 320, 568);
    } completion:^(BOOL finished)
     {
         
     }];
    
    //////////////////////////////////////////////////////////////////////
    [textView becomeFirstResponder];
}
- (IBAction)settingBtnClick:(id)sender
{
    [settingView removeFromSuperview];

    settingView.alpha = 1.0;
    [self.view addSubview:settingView];
    //////////////////////////////////////////////////////////////////////
    
    [UIView animateWithDuration:0.5 delay:0 options:0 animations:^(){
        settingView.frame = CGRectMake(0, 568, 320, 568);
        [settingView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        settingView.frame = CGRectMake(0, 0, 320, 568);
    } completion:^(BOOL finished)
     {
         
     }];
    
    //////////////////////////////////////////////////////////////////////
}
- (IBAction)helpBtnClick:(id)sender
{
    if (DEVICE_IS_IPHONE5)
    {
        [helpView removeFromSuperview];
        helpView.alpha = 1.0;
        
        helpView.frame = CGRectMake(0, 0, 320, 568);
        //////////////////////////////////////////////////////////////////////
        
        [UIView animateWithDuration:0.5 delay:0 options:0 animations:^(){
            helpView.frame = CGRectMake(0, 568, 320, 568);
            [helpView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
            helpView.frame = CGRectMake(0, 0, 320, 568);
        } completion:^(BOOL finished)
         {
             
         }];
        
        //////////////////////////////////////////////////////////////////////
        
        [self.view addSubview:helpView];
    }

    else
    {
        [helpView960 removeFromSuperview];
        helpView960.alpha = 1.0;
        
        helpView960.frame = CGRectMake(0, 0, 320, 480);
        //////////////////////////////////////////////////////////////////////
        
        [UIView animateWithDuration:0.5 delay:0 options:0 animations:^(){
            helpView960.frame = CGRectMake(0, 480, 320, 480);
            [helpView960 exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
            helpView960.frame = CGRectMake(0, 0, 320, 480);
        } completion:^(BOOL finished)
         {
             
         }];
        
        //////////////////////////////////////////////////////////////////////
        
        [self.view addSubview:helpView960];
    }
}
- (IBAction)sendBtnClick:(id)sender
{
    //////////////////////////////////////////////////////////////////////
    
    [UIView animateWithDuration:0.5 delay:0 options:0 animations:^(){
        feedbackView.frame = CGRectMake(0, 0, 320, 568);
        [feedbackView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        feedbackView.frame = CGRectMake(0, 568, 320, 568);
    } completion:^(BOOL finished)
     {
         
     }];
    
    //////////////////////////////////////////////////////////////////////

//    [feedbackView removeFromSuperview];
    [textView resignFirstResponder];

    
    NSLog(@"发送");

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.ipointek.com/feedback/api/feedback?appid=1007&content=%@&os_version=1&client_version=ios1&email=774164@qq.com",textView.text]];
    
    //@"http://www.ipointek.com/feedback/api/feedback
//    appid = 1007
//    content = 内容
//    os_version = 系统版本
//    client_version = 客户端版本
//    email = 邮箱
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setDelegate:self];
    
    [request startAsynchronous];
    
    

}

- (IBAction)cancelSendBtnClick:(id)sender
{
    //////////////////////////////////////////////////////////////////////
    
    [UIView animateWithDuration:0.5 delay:0 options:0 animations:^(){
        feedbackView.frame = CGRectMake(0, 0, 320, 568);
        [feedbackView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        feedbackView.frame = CGRectMake(0, 568, 320, 568);
    } completion:^(BOOL finished)
     {
         
     }];
    
    //////////////////////////////////////////////////////////////////////
    //    [feedbackView removeFromSuperview];
    [textView resignFirstResponder];
}

- (IBAction)resetTimeBtnClick:(id)sender
{
    SetYearViewController *setYearViewController = [[SetYearViewController alloc]init];
    [self presentViewController:setYearViewController animated:YES completion:nil];
}
- (IBAction)numTestBtnClick:(id)sender
{
    
    
    
    MBProgressHUD *sendLoading = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:sendLoading];
//    sendLoading.dimBackground = YES;

    [self.view bringSubviewToFront:sendLoading];
    sendLoading.labelText = @"正在检测新版本";
    [sendLoading show:YES];

//    [settingView addSubview:sendLoading];
    //获取版本号
    NSString *buildString = [[NSString alloc]init];
    buildString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString *urlString = [[NSString alloc]initWithFormat:@"http://www.ipointek.com/feedback/api/version?appid=1007&version=%@&platform=ios",buildString];
//    NSURL *url = [NSURL URLWithString:@"http://www.ipointek.com/feedback/api/version?appid=1007&version=1&platform=ios"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request startSynchronous];
    
    NSError *error = [request error];
    
    if (!error)
    {
        NSString *response = [request responseString];
        NSLog(@"response == %@",response);

        SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
        
        NSMutableDictionary *dict = [jsonParser objectWithString:response];
//        NSLog(@"%@",dict);

//         NSString *cross1= [dict objectForKey:@"inside_version"];
        
//        NSLog(@"[dict objectForKey:@\"inside_version\"] == %@",cross1);
//        
//        NSLog(@"[[dict objectForKey:@\"inside_version\"] isEqualToString:@\"2\"] == %d",[[dict objectForKey:@"inside_version"] isEqualToString:@"2"]);
        //有新版本
        if ([[dict objectForKey:@"inside_version"] isEqualToString:@"4"])
        {
            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"新版本 时光闹钟"
                                                        message:@"时光闹钟推出新版本了，请及时更新"
                                                       delegate:self
                                              cancelButtonTitle:@"下次提醒"
                                              otherButtonTitles:@"前往更新", nil];
            [av show];

        }
        //不用更新
        else
        {

            sendLoading.labelText = @"暂无更新";
            [sendLoading hide:YES afterDelay:4.0];
        }
        
    
    }
    
    [sendLoading hide:YES afterDelay:4.0];

//        [settingView removeFromSuperview];

    //////////////////////////////////////////////////////////////////////
    
    [UIView animateWithDuration:1.0 delay:0 options:0 animations:^(){
        settingView.alpha = 1.0;
        [settingView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        settingView.alpha = 0.0;
    } completion:^(BOOL finished)
     {
         
     }];
    
    //////////////////////////////////////////////////////////////////////

}
- (void)requestFinished:(ASIHTTPRequest *)request

{
    
    
    // 当以文本形式读取返回内容时用这个方法
    
    NSString *responseString = [request responseString];
    NSLog(@"异步请求responseString == %@",responseString);

    
    
}

- (void)requestFailed:(ASIHTTPRequest *)request

{
    
    NSError *error = [request error];
    NSLog(@"error == %@",error);
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //跳转到 下载页面
    if (buttonIndex == 1)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/shi-guang-nao-zhong/id684557922?ls=1&mt=8"]];
    }
}
//跳转下载页面
- (IBAction)sinaCQ:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/xin-lang-zhong-qing/id550394581?mt=8"]];

}
- (IBAction)shifan:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/shi-fan/id595575509?mt=8"]];

}
- (IBAction)SXCQ:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/shu-xiang-zhong-qing/id593784540?mt=8"]];

}
- (IBAction)VOVO:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/vovo-yu-yin-bian-qian/id606770926?mt=8"]];

}
- (IBAction)helpImageBtnClick:(id)sender
{
    if (DEVICE_IS_IPHONE5)
    {
        //////////////////////////////////////////////////////////////////////
        
        [UIView animateWithDuration:1.0 delay:0 options:0 animations:^(){
            helpView.alpha = 1.0;
            [helpView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
            helpView.alpha = 0.0;
        } completion:^(BOOL finished)
         {
             
         }];
        
        //////////////////////////////////////////////////////////////////////
        //    [helpView removeFromSuperview];

    }
    else
    {
        //////////////////////////////////////////////////////////////////////
        
        [UIView animateWithDuration:1.0 delay:0 options:0 animations:^(){
            helpView960.alpha = 1.0;
            [helpView960 exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
            helpView960.alpha = 0.0;
        } completion:^(BOOL finished)
         {
             
         }];
        
        //////////////////////////////////////////////////////////////////////
        //    [helpView removeFromSuperview];

    }
}
- (IBAction)settingCancelBtnClick:(id)sender
{
    
    //////////////////////////////////////////////////////////////////////
    
    [UIView animateWithDuration:0.5 delay:0 options:0 animations:^(){
        settingView.frame = CGRectMake(0, 0, 320, 568);
        [settingView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        settingView.frame = CGRectMake(0, 568, 320, 568);
    } completion:^(BOOL finished)
     {
         
     }];
    
    //////////////////////////////////////////////////////////////////////
}

@end
