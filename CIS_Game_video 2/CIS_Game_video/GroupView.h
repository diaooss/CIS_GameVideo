//
//  GroupView.h
//  CELL
//
//  Created by huangfangwang on 13-8-28.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsynImageView.h"
@protocol GroupViewDelegate <NSObject>

-(void)clickThePictureWith:(NSString *)videoID;

@end
@interface GroupView : UIView
@property (nonatomic,retain)AsynImageView * asImageView;
@property (nonatomic,retain)UILabel * timeLabel;
@property (nonatomic,retain)UILabel * nameLabel;
@property (nonatomic,copy)NSString * videoID;

@property (nonatomic,assign)id<GroupViewDelegate>delegate;


@end
