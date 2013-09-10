//
//  CategoryListViewController.h
//  CIS_Game_video
//
//  Created by huangfangwang on 13-9-3.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestTools.h"
#import "EGORefreshTableFooterView.h"
#import "EGORefreshTableHeaderView.h"
@interface CategoryListViewController : UIViewController<EGORefreshTableDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,myHttpRequestDelegate>
{
    UITableView * _categoryTable;
    
    //EGOHeader
    EGORefreshTableHeaderView *_refreshHeaderView;
    //EGOFoot
    EGORefreshTableFooterView *_refreshFooterView;
    //
    BOOL _reloading;//状态提示
    
    int flag;//请求的page值

}
@property(nonatomic,retain)RequestTools * categoryRequest;
@property(nonatomic,retain)NSMutableArray * categoryArry;
@end
