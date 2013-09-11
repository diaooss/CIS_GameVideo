//
//  MovieDetailPage.h
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-8-22.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestTools.h"
#import "AsynImageView.h"
@interface MovieDetailPage : UIViewController<UIWebViewDelegate,myHttpRequestDelegate>
{
    UILabel *movieNameLable;//电影名
    UIImageView *nameBgImg;//电影名背景图片
    UILabel *durationLable ;//显示时长
    UIImageView *popularImg;//人气小图标
    UILabel *popularLab;//显示人气
    AsynImageView *theAuthorImageView ;//作者头像
    UILabel *authorNameLab;//作者姓名
    UITextView *movieInfoTextView;//电影简介
    UIWebView *movieWeb;//电影
    RequestTools *collectRequest;//收藏视频
    
    RequestTools * _attentionTool;
   
}
@property(nonatomic,retain)RequestTools*detailRequest;//请求单一视频详情.
@property(nonatomic,retain)NSMutableDictionary *detailDic;//请求详情回来的字典
@property(nonatomic,copy)NSString * movieId;//等待被请求的视频ID
@end
