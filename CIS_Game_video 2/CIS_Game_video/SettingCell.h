//
//  SettingCell.h
//  CustomCell
//
//  Created by huanfang_liu on 13-7-16.
//  Copyright (c) 2013年 huanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
//使用此类时,cell的返回高度不低于44或系统默认值,开关的方法自主添加 ,在使用类中实现.
@interface SettingCell : UITableViewCell
@property(nonatomic,retain)UIImageView *setImageView;
@property(nonatomic,retain)UILabel * setTitleLabel;//设置参数内容
@property(nonatomic,retain)UISwitch *setSwitch;//设置开关按钮


@end
