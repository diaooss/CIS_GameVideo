//
//  RootViewController.h
//  CIS_Game_video
//
//  Created by huangfangwang on 13-7-15.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animation_Turn_View.h"
#import "SBView.h"
#import "IIViewDeckController.h"
@interface RootViewController : UIViewController<IIViewDeckControllerDelegate,AnimationViewDelegate,UITableViewDataSource,UITableViewDelegate>

{
    SBView * sbView;
    UITableView *AuthorListTab;//切换视图后作者的集合列表
    NSMutableArray *_dataList;//测试数据所用的数据源

}
@property (nonatomic,retain)NSIndexPath *selectIndex;//选中的标记

@property(nonatomic,assign)BOOL isOpen;//标记是否打开
@end
