//
//  FeedbackViewController.h
//  Clock
//
//  Created by Suncry on 13-7-17.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedbackViewController : UIViewController
{
    IBOutlet UITextView *textView;

}
- (IBAction)sendBtnClick:(id)sender;
- (IBAction)cancelSendBtnClick:(id)sender;

@end
