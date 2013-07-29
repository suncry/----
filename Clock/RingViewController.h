//
//  RingViewController.h
//  Clock
//
//  Created by Suncry on 13-6-24.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RingViewController : UIViewController
{
    IBOutlet UILabel *dayNumLable;
}
- (IBAction)getUpBtnClick:(id)sender;
- (IBAction)sleepBtnClick:(id)sender;

@end
