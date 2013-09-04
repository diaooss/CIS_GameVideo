//
//  ForgetPSDPage.h
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-8-20.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestTools.h"
@interface ForgetPSDPage : UIViewController<UITextFieldDelegate,myHttpRequestDelegate>
{
    UITextField *emailField;//输入的验证邮箱
}

@end
