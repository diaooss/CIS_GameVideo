//
//  AuthorMoviesListPage.h
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-7-18.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestTools.h"
#import "EGORefreshTableFooterView.h"
#import "EGORefreshTableHeaderView.h"
@interface AuthorMoviesListPage : UIViewController<EGORefreshTableDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,myHttpRequestDelegate>
{
    UITableView *authorListTab;
   RequestTools * getAuthorListByAuthorID;
    //EGOHeader
    EGORefreshTableHeaderView *_refreshHeaderView;
    //EGOFoot
    EGORefreshTableFooterView *_refreshFooterView;
    //
    BOOL _reloading;//状态提示
    int flag;//请求的page值

}
@property(nonatomic,retain)NSString *authorIDStr;
@property(nonatomic ,copy)NSString *authorNameStr;
@property(nonatomic,retain)NSDictionary *authorListDic;//作者详情字典
@property(nonatomic,retain)NSMutableArray *moviesOfTheAuthorArry;//该作者的详情
@end
