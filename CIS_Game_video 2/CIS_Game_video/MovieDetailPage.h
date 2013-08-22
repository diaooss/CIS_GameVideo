//
//  MovieDetailPage.h
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-8-22.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailPage : UIViewController<UIWebViewDelegate>
{
    UILabel *durationLable ;
    UIImageView *theAuthorImageView ;
    UILabel *movieNameLable;
    UITextView *movieInfoTextView;
    UIWebView *movieWeb;
}

@end
