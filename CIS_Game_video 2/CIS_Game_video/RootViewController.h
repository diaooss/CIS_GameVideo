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
#import "RequestTools.h"
#import "Cell.h"
@class HMSegmentedControl;
@interface RootViewController : UIViewController<IIViewDeckControllerDelegate,AnimationViewDelegate,UITableViewDataSource,UITableViewDelegate,myHttpRequestDelegate,CellDelegate>
{
    UITableView *defaultListTab;
    UITableView *rootAuthorListTab;//切换视图后作者的集合列表
    NSMutableArray *_dataList;//测试数据所用的数据源
    Animation_Turn_View * animationView;//轮显
    HMSegmentedControl *categorySegmentedControl;//标签
    
}
@property(nonatomic,assign)int mark;//
@property(nonatomic,retain)RequestTools * rootRequest;//请求的代理,方便回传值.
@property (nonatomic,retain)NSIndexPath *selectIndex;//选中的标记
@property(nonatomic,assign)BOOL isOpen;//标记是否打开
@property(nonatomic,retain) NSArray *authorListArray;//作者列表数组

@end
