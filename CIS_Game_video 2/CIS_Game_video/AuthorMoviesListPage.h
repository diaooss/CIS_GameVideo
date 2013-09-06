//
//  AuthorMoviesListPage.h
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-7-18.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestTools.h"
@interface AuthorMoviesListPage : UIViewController<UITableViewDataSource,UITableViewDelegate,myHttpRequestDelegate>
{
    UITableView *authorListTab;
   RequestTools * getAuthorListByAuthorID;
}
@property(nonatomic,retain)NSString *authorIDStr;
@property(nonatomic ,copy)NSString *authorNameStr;
@property(nonatomic,retain)NSDictionary *authorListDic;//作者详情字典
@property(nonatomic,retain)NSArray *moviesOfTheAuthorArry;//该作者的详情
@end
