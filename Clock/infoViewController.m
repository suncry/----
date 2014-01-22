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
#import "FeedbackViewController.h"
#import "RecommendationAPPCell.h"
#import "DataCenter.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "KK_JsonValueTransformed.h"
//#import "AFNetworking.h"
//#import "AFHTTPRequestOperation.h"
//#import "DataCenter.h"
@interface InfoViewController ()

@end

@implementation InfoViewController
@synthesize appDatas;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    self.appDatas = [[NSMutableArray alloc]initWithCapacity:3];
    NSString *urlString2 = @"http://www.ipointek.com/feedback/api/apps/recommend?appid=1007&platform=ios";
    NSURL *url2 = [NSURL URLWithString:[urlString2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url2];
    __block ASIHTTPRequest *requestBlock = request;
    [request setCompletionBlock :^{
        NSString *appString = [requestBlock responseString];
        SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
        NSMutableDictionary *appDict = [jsonParser objectWithString:appString];
        if (appDict && [[appDict objectForKey:@"status"] integerValue] == 200) {
            //            NSLog(@"应用推荐 获取到了应用信息！");
            NSArray *appsArray = [NSArray arrayWithArray:[appDict objectForKey:@"data"]];
            NSMutableString *appsUrl = [[NSMutableString alloc]initWithCapacity:0];
            [appsUrl appendString:@"https://itunes.apple.com/cn/lookup?id="];
            int count = [appsArray count];
            //            NSLog(@"count == %d",count);
            if (count > 0) {
                for (int i = 0; i < count; i++) {
                    [appsUrl appendString:[[appsArray objectAtIndex:i] objectForKey:@"ios_appid"]];
                    if (i!= count-1) {
                        [appsUrl appendString:@","];
                    }
                }
                NSURL *appUrl = [NSURL URLWithString:[appsUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                NSLog(@"要搜去APP信息的地址为appUrl === %@",appUrl);
                ASIHTTPRequest *request2 = [ASIHTTPRequest requestWithURL:appUrl];
                __block ASIHTTPRequest *requestBlock2 = request2;
                [request2 setCompletionBlock :^{
//                    NSData *appInfoData = [requestBlock2 responseData];
                    NSString *appInfoString = [requestBlock2 responseString];
                    NSLog(@"appInfoString == %@",appInfoString);
//                    [appInfoString dataUsingEncoding:NSASCIIStringEncoding];
//                    NSLog(@"[appInfoString dataUsingEncoding:NSASCIIStringEncoding] == %@",[appInfoString dataUsingEncoding:NSASCIIStringEncoding]);
                    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
                    NSMutableDictionary *appInfoDict = [jsonParser objectWithString:appInfoString];

                    
                    NSLog(@"appInfoDict == %@",appInfoDict);

                    if (appInfoDict && [[appInfoDict objectForKey:@"resultCount"] integerValue] != 0)
                    {
                        [self.appDatas addObjectsFromArray:[appInfoDict objectForKey:@"results"]];
                        [_recommendationAppTable reloadData];
                        
                        NSLog(@"_recommendationAppTable 刷新了");
                    }

                }];
                [request2 setFailedBlock :^{
                    // 请求响应失败，返回错误信息
                    NSError *error = [requestBlock error ];
                    NSLog ( @"appinfo出错:%@" ,[error userInfo ]);
                }];
                [request2 startAsynchronous];
            }
        }
    }];
    [request setFailedBlock :^{
        // 请求响应失败，返回错误信息
        NSError *error = [requestBlock error ];
        NSLog ( @"推荐app信息下载出错:%@" ,[error userInfo ]);
    }];
    [request startAsynchronous];

    [super viewWillAppear:animated];
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
    [UMSocialData defaultData].shareText = NSLocalizedString(@"downloadAdd", @"");
    
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
    
    
    //////////////////////////////////////////////////////////////////////

//    [UIView animateWithDuration:0.5 delay:0 options:0 animations:^(){
//        feedbackView.frame = CGRectMake(0, 568, 320, 568);
//        [feedbackView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
//        feedbackView.frame = CGRectMake(0, 0, 320, 568);
//    } completion:^(BOOL finished)
//     {
//         
//     }];
    
    //////////////////////////////////////////////////////////////////////
    
    
//    [UIView beginAnimations:@"animationID" context:nil];
//    [UIView setAnimationDuration:0.7f];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationRepeatAutoreverses:NO];
//    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
////    [self.view removeFromSuperview];
//    [self.view addSubview:feedbackView];
//    
//    
//    [UIView commitAnimations];
    
    
    FeedbackViewController *feedView = [[FeedbackViewController alloc]init];
    [self presentViewController:feedView animated:YES completion:nil];
    
    
    
    
//    [textView becomeFirstResponder];
    
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
//    //////////////////////////////////////////////////////////////////////
//    
//    [UIView animateWithDuration:0.5 delay:0 options:0 animations:^(){
//        feedbackView.frame = CGRectMake(0, 0, 320, 568);
//        [feedbackView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
//        feedbackView.frame = CGRectMake(0, 568, 320, 568);
//    } completion:^(BOOL finished)
//     {
//         
//     }];
//    
//    //////////////////////////////////////////////////////////////////////

    
    [UIView beginAnimations:@"animationIDUp" context:nil];
    [UIView setAnimationDuration:0.7f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
    [feedbackView removeFromSuperview];
    //    [self.view addSubview:feedbackView];
    [UIView commitAnimations];

    
    
    
    
    
    
    
    
    
    
    
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
    
//    [UIView animateWithDuration:0.5 delay:0 options:0 animations:^(){
//        feedbackView.frame = CGRectMake(0, 0, 320, 568);
//        [feedbackView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
//        feedbackView.frame = CGRectMake(0, 568, 320, 568);
//    } completion:^(BOOL finished)
//     {
//         
//     }];
    
    //////////////////////////////////////////////////////////////////////
    //    [feedbackView removeFromSuperview];
    
    
    [UIView beginAnimations:@"animationIDUp" context:nil];
    [UIView setAnimationDuration:0.7f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
    [feedbackView removeFromSuperview];
//    [self.view addSubview:feedbackView];
    [UIView commitAnimations];
    
    
    
    
    [textView resignFirstResponder];
}

- (IBAction)resetTimeBtnClick:(id)sender
{
    SetYearViewController *setYearViewController = [[SetYearViewController alloc]init];
    [self presentViewController:setYearViewController animated:YES completion:nil];
}
- (IBAction)numTestBtnClick:(id)sender
{
    //用于判断语言
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    

    
    
    MBProgressHUD *sendLoading = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:sendLoading];
//    sendLoading.dimBackground = YES;

    [self.view bringSubviewToFront:sendLoading];
    sendLoading.labelText = @"正在检测新版本";
    if([currentLanguage isEqualToString:@"en"])
    {
        sendLoading.labelText = @"checking...";

    }
    [sendLoading show:YES];

//    [settingView addSubview:sendLoading];
    //获取版本号
    NSString *buildString = [[NSString alloc]init];
    buildString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString *urlString = [[NSString alloc]initWithFormat:@"http://www.ipointek.com/feedback/api/version?appid=1007&version=0&platform=ios"];
//    http://www.ipointek.com/feedback/api/version?appid=1007&version=0&platform=ios
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

        NSLog(@"inside_version == %d",[[dict objectForKey:@"inside_version"]intValue]);
        NSLog(@"[buildString intValue] == %d",[buildString intValue]);
        

        //有新版本
        if ([[dict objectForKey:@"inside_version"]intValue] > [buildString intValue])
        {
            UIAlertView *av;
            if([currentLanguage isEqualToString:@"en"])
            {
                av = [[UIAlertView alloc]initWithTitle:@"Time Alarm"
                                                            message:@"have a new version to download"
                                                           delegate:self
                                                  cancelButtonTitle:@"Not now"
                                                  otherButtonTitles:@"Download", nil];
                
            }
            else
            {
                av = [[UIAlertView alloc]initWithTitle:@"新版本 时光闹钟"
                                                            message:@"时光闹钟推出新版本了，请及时更新"
                                                           delegate:self
                                                  cancelButtonTitle:@"下次提醒"
                                                  otherButtonTitles:@"前往更新", nil];

            }

            [av show];

        }
        //不用更新
        else
        {

            sendLoading.labelText = @"暂无更新";
            if([currentLanguage isEqualToString:@"en"])
            {
                sendLoading.labelText = @"No update";

            }
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
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
//    if ([_appDatas retainCount] == 1) {
//        [_appDatas retain];
//    }
//    NSLog(@"self.appDatas == %@",self.appDatas);
    return [self.appDatas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RecommendationAPPCell";
    RecommendationAPPCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[RecommendationAPPCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //config the cell
    NSDictionary *appdata = [self.appDatas objectAtIndex:indexPath.row];
//    NSLog(@"appdata == %@",appdata);
    cell.appNameLable.text = [appdata objectForKey:@"trackName"];
//    if ([[appdata objectForKey:@"trackName"] isEqualToString:@"示范"]) {
//        cell.appInfoLable.text = @"以\"全球视野，示范天下\"为目标，寻找示范，关注示范，解读示范，成就示范\u2014\u2014重庆市北部新区管委会。";
//    }
//    else
//    {
    //string为乱码字符
//    const char *c = [[appdata objectForKey:@"description"] cStringUsingEncoding:NSISOLatin1StringEncoding];
//    cell.appInfoLable.text = [[NSString alloc] initWithCString:c encoding:NSUTF8StringEncoding];

        cell.appInfoLable.text = [appdata objectForKey:@"description"];


//    }
//    NSLog(@"cell.appInfoLable.text == %@",cell.appInfoLable.text);
    [cell.downloadBtn addTarget:self action:@selector(downloadApp:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.downloadBtn setTitle:[appdata objectForKey:@"formattedPrice"] forState:UIControlStateNormal];
    
    cell.appImageView.layer.masksToBounds = YES; //没这句话它圆不起来
    cell.appImageView.layer.cornerRadius = 5.0; //设置图片圆角的尺度。
    [cell.appImageView setImageWithURL:[NSURL URLWithString:[appdata objectForKey:@"artworkUrl60"]] placeholderImage:[UIImage imageNamed:@"defineAPPImage.png"]];

    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 80;
}
- (void)downloadApp:(id)sender
{
    UITableViewCell *cell = (UITableViewCell*)[[sender superview]superview];
    NSInteger index = [_recommendationAppTable indexPathForCell:cell].row;
    NSString *_idStr = [NSString stringWithFormat:@"%@",[[self.appDatas objectAtIndex:index] objectForKey:@"trackViewUrl"]];
    
//    NSLog(@"_idStr == %@",_idStr);
    //跳转到应用页面
//    NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%d",appid];

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_idStr]];
    
    
}
- (id)toArrayOrNSDictionary:(NSData *)jsonData{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
    
}

@end
