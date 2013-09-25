//
//  RecommendationAPPCell.h
//  时光闹钟
//
//  Created by Suncry on 13-9-24.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendationAPPCell : UITableViewCell
{
     UIImageView *_appImageView;
     UILabel *_appNameLable;
     UILabel *_appInfoLable;
     UIButton *_downloadBtn;
}
@property(nonatomic,retain) UIImageView *appImageView;
@property(nonatomic,retain) UILabel *appNameLable;
@property(nonatomic,retain) UILabel *appInfoLable;
@property(nonatomic,retain) UIButton *downloadBtn;

@end
