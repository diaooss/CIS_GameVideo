//
//  MyLikeAuthorListPage.h
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-7-18.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestTools.h"
#import "EGORefreshTableFooterView.h"
#import "EGORefreshTableHeaderView.h"
@interface MyLikeAuthorListPage : UIViewController<UITableViewDataSource,UITableViewDelegate,myHttpRequestDelegate,EGORefreshTableDelegate,UIScrollViewDelegate>
{
    RequestTools *getMyLikeAuthorListRequest;
    UITableView *likeAuthorListTab;
    EGORefreshTableHeaderView *likeAuthorListHeaderView;//下拉刷新

    EGORefreshTableFooterView *likeAuthorListFooterView;//上拉加载更多
    BOOL isLoading;//是否在加载
    int flag;//标记值,以便上拉加载更多
    
}
@property(nonatomic,retain)NSDictionary *myLikeAuthorListDic;//
@end
