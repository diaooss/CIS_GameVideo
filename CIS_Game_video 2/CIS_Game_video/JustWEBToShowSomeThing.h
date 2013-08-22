//
//  JustWEBToShowSomeThing.h
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-8-22.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JustWEBToShowSomeThing : UIViewController<UIWebViewDelegate>
{
    UIWebView *m_web;

}
-(id)initWithRequestUrl:(NSString *)urlStr;
@property(nonatomic,retain)NSURLRequest *request;
@end
