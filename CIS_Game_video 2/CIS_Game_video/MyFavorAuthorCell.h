//
//  MyFavorAuthorCell.h
//  CustomCell
//
//  Created by huanfang_liu on 13-7-16.
//  Copyright (c) 2013年 huanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsynImageView.h"
//使用时,需将cell的高度返回为100;
//关注与否的方法请写在使用类中.只需 [cell addtarget:.....即可
//点击头像的方法如上加上手势即可实现,交互已经打开.
//对整个cell增加了三种手势,左扫,右扫,长按,可唤醒取消关注按钮,取消关注的方法在使用类中实现即可.
@interface MyFavorAuthorCell : UITableViewCell
@property(nonatomic,retain)AsynImageView * authorLogoView;//作者头像
@property(nonatomic,retain)UILabel *authorNameLabel;//作者姓名
@property(nonatomic,retain)UIButton *favorBtn;//关注按钮
@property(nonatomic,retain)UIImageView *popularImg;
@property(nonatomic,retain)UILabel *popularLab;
@property(nonatomic,retain)UIImageView *countImg;
@property(nonatomic,retain)UILabel *countLab;

@end
