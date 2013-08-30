//
//  Cell.h
//  CELL
//
//  Created by huangfangwang on 13-8-28.
//  Copyright (c) 2013年 com.huanfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupView.h"
@protocol CellDelegate <NSObject>

-(void)accessPlayViewControllerWithVideoID:(NSString *)videoID;

@end


@interface Cell : UITableViewCell<GroupViewDelegate>
@property(nonatomic,retain)UIScrollView * scrollerView;//滑动视图---------为cell的重用;;
@property(nonatomic,retain)NSMutableArray * PicArry;//装载scrollView 的12个子视图

@property (nonatomic ,assign)id<CellDelegate>delegate;
//调用后开始传递网络数据  加载图片
-(void)loadInforWithNetArry:(NSArray *)netArry;
@end



