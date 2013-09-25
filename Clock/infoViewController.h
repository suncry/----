//
//  InfoViewController.h
//  Clock
//
//  Created by Suncry on 13-7-1.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface InfoViewController : UIViewController<MBProgressHUDDelegate,UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIView *feedbackView;
    IBOutlet UIView *settingView;
    IBOutlet UITextView *textView;
    IBOutlet UIView *helpView;
    IBOutlet UIView *helpView960;
    IBOutlet UITableView *_recommendationAppTable;
    

}

@property (nonatomic, retain) NSMutableArray *appDatas;

- (IBAction)shareBtnClick:(id)sender;
- (IBAction)feedbackBtnClick:(id)sender;
- (IBAction)settingBtnClick:(id)sender;
- (IBAction)helpBtnClick:(id)sender;
- (IBAction)sendBtnClick:(id)sender;
- (IBAction)resetTimeBtnClick:(id)sender;
- (IBAction)numTestBtnClick:(id)sender;
- (IBAction)cancelSendBtnClick:(id)sender;


- (IBAction)sinaCQ:(id)sender;
- (IBAction)shifan:(id)sender;
- (IBAction)SXCQ:(id)sender;
- (IBAction)VOVO:(id)sender;

- (IBAction)helpImageBtnClick:(id)sender;
- (IBAction)settingCancelBtnClick:(id)sender;




@end
