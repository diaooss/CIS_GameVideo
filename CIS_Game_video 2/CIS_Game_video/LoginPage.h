//
//  LoginPage.h
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-8-20.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestTools.h"
@interface LoginPage : UIViewController<UITextFieldDelegate,myHttpRequestDelegate>
{
    UITextField *nameTextField;//登录名:昵称/邮箱
    UITextField *psdTextField;//密码

}

@end
