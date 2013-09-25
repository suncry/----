//
//  RingViewController.h
//  Clock
//
//  Created by Suncry on 13-6-24.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface RingViewController : UIViewController<AVAudioPlayerDelegate>
{
    IBOutlet UILabel *dayNumLable;
    AVAudioPlayer *_ring;
}

@property(nonatomic,retain)AVAudioPlayer *ring;

- (IBAction)getUpBtnClick:(id)sender;
- (IBAction)sleepBtnClick:(id)sender;

@end
