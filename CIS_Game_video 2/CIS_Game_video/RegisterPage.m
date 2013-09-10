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
#import "MyNsstringTools.h"
#import "RequestTools.h"
#import "RequestUrls.h"
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
            contentFiled.placeholder = @"请输入正确邮箱以便找回密码...";
            contentFiled.delegate= self;
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
    [registerBtn addTarget:self action:@selector(goToRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackGround)];
    [self.view addGestureRecognizer:tap];
    [tap release];
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    UITextField *emailText =(UITextField *)[self.view viewWithTag:200];
    self.isEmailRingt = [Tools cheeckEmail:emailText.text];//将格式值取出
    if (emailText.text.length==0) {
        [self remindBoxWith:@"邮箱不能为空"];
        return YES;
    }
    if (!self.isEmailRingt)
    {
        [self remindBoxWith:@"邮箱格式错误"];
        return YES;
    }
    [self performSelectorInBackground:@selector(cheeckEmail:) withObject:emailText.text];
    return YES;
}
-(void)cheeckEmail:(NSString *)email//邮箱格式是否正确提醒
{
    self.isEmailExist = [RequestTools requestReturnYesOrOkWithCheckUrl_Synchronous:[NSString stringWithFormat:@"%@?email=%@",CHECK_EMAIL,email]];
    if (!self.isEmailExist) {
        [self performSelectorOnMainThread:@selector(remindBoxWith:) withObject:@"邮箱已被注册.." waitUntilDone:NO];
        UITextField * emailText = (UITextField *)[self.view viewWithTag:200];
        [emailText becomeFirstResponder];
    }
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
-(void)goToRegister
{
    //做不为空判断
    UITextField * nameText = (UITextField *)[self.view viewWithTag:100];
    UITextField * emailText = (UITextField *)[self.view viewWithTag:200];
    UITextField * pswText = (UITextField *)[self.view viewWithTag:300];
    //名字检测.....
    if (nameText.text.length==0) {
        [self remindBoxWith:@"名字不能为空.."];
        [nameText becomeFirstResponder];
        return;
    }else if (nameText.text.length>10)
    {
        [self remindBoxWith:@"名字太长...."];
        [nameText becomeFirstResponder];
        return;
    }
    //邮箱注册前检测....
    if (emailText.text.length==0) {
        [self remindBoxWith:@"邮箱不能为空"];
        [emailText becomeFirstResponder];
        return;
    }
    if (!self.isEmailRingt) {
        [self remindBoxWith:@"邮箱格式不对..."];
        [emailText becomeFirstResponder];
        return;
    }
    if (!self.isEmailExist)
    {
        [self remindBoxWith:@"邮箱已被注册...."];
        [emailText becomeFirstResponder];
        return;
    }
    //密码检测..
    if (pswText.text.length==0) {
        [self remindBoxWith:@"密码不能为空.."];
        [pswText becomeFirstResponder];
        return;
    }else if (pswText.text.length<6)
    {
        UIAlertView  * alert = [[UIAlertView alloc]initWithTitle:nil message:@"密码不安全.." delegate:self cancelButtonTitle:@"增加密码" otherButtonTitles:@"继续注册", nil];
        [alert show];
        [alert release];
        return;
    }
    [self login];
}
//警告处理
-(void)remindBoxWith:(NSString *)string
{
    UIAlertView  * alert = [[UIAlertView alloc]initWithTitle:@"Waring" message:string delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField * pswText = (UITextField *)[self.view viewWithTag:300];
    if (buttonIndex==0) {
        [pswText becomeFirstResponder];
    }
    else
    {
        [self login];
    }
}
//真正注册
-(void)login
{
    UITextField * nameText = (UITextField *)[self.view viewWithTag:100];
    UITextField * emailText = (UITextField *)[self.view viewWithTag:200];
    UITextField * pswText = (UITextField *)[self.view viewWithTag:300];
    NSArray *newArry  =[NSArray arrayWithObjects:REGISTER,[NSString stringWithFormat:@"?user_Name=%@email=%@psw=%@",nameText.text,emailText.text,pswText.text], nil];
    BOOL registrIsOk = [RequestTools requestReturnYesOrOkWithCheckUrl_Synchronous:[MyNsstringTools groupStrByAStrArray:newArry]];
    [self registerIsSuccess:registrIsOk];
    [Tools openLoadsign:self.view WithString:@"正在注册......."];
}
-(void)registerIsSuccess:(BOOL)flag
{
    UITextField * nameText = (UITextField *)[self.view viewWithTag:100];
    UITextField * emailText = (UITextField *)[self.view viewWithTag:200];
    UITextField * pswText = (UITextField *)[self.view viewWithTag:300];
    [[NSUserDefaults standardUserDefaults] setObject:nameText.text forKey:@"user_name"];
    [[NSUserDefaults standardUserDefaults] setObject:emailText.text forKey:@"user_email"];
    [[NSUserDefaults standardUserDefaults] setObject:pswText.text forKey:@"user_psw"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [Tools closeLoadsign:self.view];
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
