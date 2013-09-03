//
//  MovieDetailPage.h
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-8-22.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestTools.h"
@interface MovieDetailPage : UIViewController<UIWebViewDelegate,myHttpRequestDelegate>
{
    UILabel *durationLable ;
    UIImageView *theAuthorImageView ;
    UILabel *movieNameLable;
    UITextView *movieInfoTextView;
    UIWebView *movieWeb;
   
}
@property(nonatomic,retain)RequestTools*detailRequest;//请求单一视频详情.
@property(nonatomic,retain)NSMutableDictionary *detailDic;//请求详情回来的字典
@property(nonatomic,copy)NSString * movieId;//等待被请求的视频ID
@end
