//
//  RegisterPage.m
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-8-20.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "RegisterPage.h"
#import "Header.h"
#import "Tools.h"
@interface RegisterPage ()

@end
@implementation RegisterPage
- (void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];

    
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //注册键盘出现和消失时的通知.
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil]; [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}
-(void)loadView
{
    self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    [Tools navigaionView:self leftImageName:@"goBack.png" title:@"注册-幻方网络,精彩无限"];

    for (int i = 0; i<3; i++) {
        UITextField *contentFiled = [[UITextField alloc] initWithFrame:CGRectMake(10, 50+i*17+i*40, 300, 35)];
        contentFiled.tag = 100*i+100;
        contentFiled.backgroundColor = [UIColor yellowColor];
        contentFiled.delegate= self;
        contentFiled.textColor = [UIColor grayColor];
        contentFiled.layer.cornerRadius = 5.0;
        contentFiled.autocorrectionType = UITextAutocorrectionTypeNo;
        contentFiled.textAlignment = NSTextAlignmentLeft;
        contentFiled.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        contentFiled.font  =[UIFont systemFontOfSize:19];
        contentFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        contentFiled.borderStyle = UITextBorderStyleBezel;
        if (i==0) {
            contentFiled.placeholder = @"请输入昵称(不超过八位字符)";
        }else if (i==1)
        {
            contentFiled.placeholder = @"请输入邮箱";
        }else
        {
            contentFiled.placeholder = @"请输入密码";
            contentFiled.secureTextEntry = YES;
        }
        [self.view addSubview:contentFiled];
        [contentFiled release];
    }
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(10, 240, 300, 40);
    registerBtn.layer.cornerRadius = 5.0;
    registerBtn.backgroundColor = [UIColor greenColor];
    [registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [registerBtn setShowsTouchWhenHighlighted:YES];
    [self.view addSubview:registerBtn];
    
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackGround)];
    [self.view addGestureRecognizer:tap];
    [tap release];

}
#pragma mark--取消键盘
-(void)tapBackGround
{
    for (int i = 0; i<3; i++) {
        UITextField *ff = (UITextField *)[self.view viewWithTag:100*i+100];
        [ff resignFirstResponder];
    }
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    for (int i = 0; i<3; i++) {
        UITextField *ff = (UITextField *)[self.view viewWithTag:100*i+100];
        [ff resignFirstResponder];
    }
    return YES;
    
}
#pragma mark--面板上下移动
//面板上移.下移
-(void)keyboardWillShow
{
    int a  =   self.view.frame.origin.y;
    if (a!=-40) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        CGRect frame = self.view.frame;
        frame.origin.y -=40;
        frame.size.height +=40;
        self.view.frame = frame;
        [UIView commitAnimations];

    }

}
-(void)keyboardWillHide
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGRect frame = self.view.frame;
    frame.origin.y +=40;
    frame.size.height -=40;
    self.view.frame = frame;
    [UIView commitAnimations];
 
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
