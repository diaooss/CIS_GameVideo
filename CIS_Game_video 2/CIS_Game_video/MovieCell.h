//
//  MovieCell.h
//  CustomCell
//
//  Created by huanfang_liu on 13-7-16.
//  Copyright (c) 2013年 huanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsynImageView.h"

//使用时,需将cell的高度返回为100或120;
//收藏与否的方法请写在使用类中.只需 [cell addtarget:.....即可
//点击LOGO的方法如上加上手势即可实现,交互已经打开.
@interface MovieCell : UITableViewCell
@property(nonatomic,retain)AsynImageView *logoImageView;//视频缩略图
@property(nonatomic,retain)UILabel *titleLabel;//视频标题
@property(nonatomic,retain)UILabel *categoryLabel;//副标题,在视频标题下....
@property(nonatomic,retain)UIButton *collectBtn;//收藏按钮
@property(nonatomic,retain)UIImageView *timeImg;//时长前小图标
@property(nonatomic,retain)UILabel *timeLab;//显示时长
@property(nonatomic,retain)UIImageView *popularImg;//人气小图标
@property(nonatomic,retain)UILabel * popularLab;//显示人气
@end
