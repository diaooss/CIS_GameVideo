//
//  RegisterPage.h
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-8-20.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestTools.h"
@interface RegisterPage : UIViewController<UITextFieldDelegate,myHttpRequestDelegate,UIAlertViewDelegate>
@property(nonatomic,assign)BOOL isEmailRingt;//邮箱是否正确
@property(nonatomic,assign)BOOL isEmailExist;//邮箱是否已经被注册

@end
