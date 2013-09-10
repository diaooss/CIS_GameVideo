//
//  MyLikeAuthorListPage.h
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-7-18.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestTools.h"
@interface MyLikeAuthorListPage : UIViewController<UITableViewDataSource,UITableViewDelegate,myHttpRequestDelegate>
{
    RequestTools *getMyLikeAuthorListRequest;
    UITableView *likeAuthorListTab;
    
}
@property(nonatomic,retain)NSDictionary *myLikeAuthorListDic;//
@end
