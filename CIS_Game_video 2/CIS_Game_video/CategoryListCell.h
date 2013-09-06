//
//  CategoryListCell.h
//  CIS_Game_video
//
//  Created by huangfangwang on 13-9-3.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsynImageView.h"
@interface CategoryListCell : UITableViewCell
{
    UIImageView * _popularityImageView;
    UIImageView * _timeImageView;
}
@property(nonatomic,retain)AsynImageView * asImageView;
@property(nonatomic,copy)NSString * videoID;
@property(nonatomic,retain)UILabel * nameLabel;
@property(nonatomic,retain)UILabel * attentionTimeLabel;
@property(nonatomic,retain)UILabel *timeLabel;
@end
