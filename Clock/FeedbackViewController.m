//
//  FeedbackViewController.m
//  Clock
//
//  Created by Suncry on 13-7-17.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import "FeedbackViewController.h"
#import "DayViewController.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "MMDrawerBarButtonItem.h"
#import "SettingViewController.h"
#import "InfoViewController.h"
#import "ASIFormDataRequest.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

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
    [textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sendBtnClick:(id)sender
{
    NSLog(@"发送");
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.ipointek.com/feedback/api/feedback"]];

    //@"http://www.ipointek.com/feedback/api/feedback
    //    appid = 1007
    //    content = 内容
    //    os_version = 系统版本
    //    client_version = 客户端版本
    //    email = 邮箱
    ASIFormDataRequest *requestForm = [[ASIFormDataRequest alloc] initWithURL:url];
    [requestForm setRequestMethod:@"POST"];
    [requestForm setPostValue:@"1007" forKey:@"appid"];
    [requestForm setPostValue:[NSString stringWithFormat:@"%@",textView.text] forKey:@"content"];
    [requestForm setPostValue:@"iOS" forKey:@"os_version"];
    [requestForm setPostValue:@"Client V1.3 Build 4" forKey:@"client_version"];
    [requestForm setPostValue:@"nil" forKey:@"email"];
//    [requestForm startSynchronous];
//    
//    NSError *error = [requestForm error];
//    if (!error)
//    {
//        NSString *response = [requestForm responseString];
//        NSLog(@"response == %@",response);
//    }
    
    [requestForm setDelegate:self];
    
    [requestForm startAsynchronous];
    
    
    
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
- (IBAction)cancelSendBtnClick:(id)sender
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


@end
