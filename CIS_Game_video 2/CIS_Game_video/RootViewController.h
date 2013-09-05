//
//  RootViewController.h
//  CIS_Game_video
//
//  Created by huangfangwang on 13-7-15.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Animation_Turn_View.h"
#import "IIViewDeckController.h"
#import "RequestTools.h"
#import "DefaultRootView.h"
#import "SRRefreshView.h"
@class HMSegmentedControl;
@interface RootViewController : UIViewController<IIViewDeckControllerDelegate,AnimationViewDelegate,UITableViewDataSource,UITableViewDelegate,myHttpRequestDelegate,DefaultRootViewDelegate,SRRefreshDelegate,UIScrollViewDelegate>
{
    UITableView *rootAuthorListTab;//切换视图后作者的集合列表
    NSMutableArray *_dataList;//测试数据所用的数据源
    Animation_Turn_View * animationView;//轮显
    HMSegmentedControl *categorySegmentedControl;//标签
    SRRefreshView*rootRefreshView;//下拉刷新.
    NSString *staticCateGoryStr;//保留每次分类选择选中的类目,以便刷新时使用
    DefaultRootView * rootView;//默认视图
}
@property(nonatomic,retain)RequestTools * rootRequest;//请求的代理,方便回传值.
@property (nonatomic,retain)NSIndexPath *selectIndex;//选中的标记
@property(nonatomic,assign)BOOL isOpen;//标记是否打开
@property(nonatomic,retain) NSArray *authorListArray;//作者列表数组
@property(nonatomic,retain)NSArray *rootBannerArry;//首页banner信息-作者列表
@end
