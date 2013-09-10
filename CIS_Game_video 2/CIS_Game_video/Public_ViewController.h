//
//  Public_ViewController.h
//  CIS_Game_video
//
//  Created by huangfangwang on 13-7-16.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableFooterView.h"
#import "EGORefreshTableHeaderView.h"
#import "RequestTools.h"
@interface Public_ViewController : UIViewController<EGORefreshTableDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,myHttpRequestDelegate>
{
    //EGOHeader
    EGORefreshTableHeaderView *_refreshHeaderView;
    //EGOFoot
    EGORefreshTableFooterView *_refreshFooterView;
    //
    BOOL _reloading;//状态提示
    
    int flag;//请求的page值
    UIButton *eiditBtn;
    int flagTow;
}
@property (nonatomic,retain)UITableView * showTab;
@property (nonatomic,retain)RequestTools * request;
@property (nonatomic,retain)NSMutableArray * myArry;
@property (nonatomic,copy)NSString * nenwCategory;
@property (nonatomic,copy)NSString * oldCategory;


@end
