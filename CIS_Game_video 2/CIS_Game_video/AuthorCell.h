//
//  AuthorCell.h
//  CustomCell
//
//  Created by huanfang_liu on 13-7-16.
//  Copyright (c) 2013年 huanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
//在首页的作者列表
@interface AuthorCell : UITableViewCell
@property(nonatomic,retain)UIImageView *stateImgView;//盛放向上,向下的箭头.
@property(nonatomic,retain)UILabel *nameLabel;//作者姓名
@property(nonatomic,retain)UILabel *countLabel;//作者作品总数
@property(nonatomic,retain)UIButton *likeBtn;//快捷关注按钮
- (void)changeArrowWithUp:(BOOL)up;//指示器向上,向下翻转

@end
