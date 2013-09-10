//
//  LoginPage.m
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-8-20.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "LoginPage.h"
#import "Header.h"
#import "RegisterPage.h"
#import "ForgetPSDPage.h"
#import "Tools.h"
//
#import "MyNsstringTools.h"
#import "RequestTools.h"
#import "RequestUrls.h"
@interface LoginPage ()

@end

@implementation LoginPage
- (void)dealloc
{
    nameTextField = nil;
    psdTextField = nil;
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
    self.view.backgroundColor = [UIColor whiteColor];
    [Tools navigaionView:self leftImageName:@"goBack.png" title:@"用户登录"];
    /*/布局登陆面板/*/
    UIImageView *logoImg = [[UIImageView alloc]  initWithFrame:CGRectMake(100, 40, 120, 120)];
    logoImg.backgroundColor = [UIColor blueColor];
    logoImg.layer.cornerRadius = 5.0;
    logoImg.image = [UIImage imageNamed:@"headerimage.png"];
    [self.view addSubview:logoImg];
    [logoImg release];
    nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, logoImg.bottom+30, 280, 35)];
    nameTextField.delegate= self;
    nameTextField.backgroundColor = [UIColor yellowColor];
    nameTextField.textColor = [UIColor grayColor];
    nameTextField.keyboardType = UIKeyboardTypeEmailAddress;
    nameTextField.layer.cornerRadius = 5.0;
    nameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    nameTextField.textAlignment = NSTextAlignmentLeft;
    nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    nameTextField.font  =[UIFont systemFontOfSize:19];
    nameTextField.clearButtonMode = UITextFieldViewModeUnlessEditing;
    nameTextField.placeholder = @"登陆邮箱";
    nameTextField.borderStyle = UITextBorderStyleBezel;
    [self.view addSubview:nameTextField];
    [nameTextField release];
    //密码
    psdTextField = [[UITextField alloc] initWithFrame:CGRectMake(nameTextField.left, nameTextField.bottom+30, 280, 35)];
    psdTextField.delegate= self;
    psdTextField.backgroundColor = [UIColor yellowColor];
    psdTextField.textColor = [UIColor grayColor];
    psdTextField.layer.cornerRadius = 5.0;
    psdTextField.textAlignment = NSTextAlignmentLeft;
    psdTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    psdTextField.borderStyle = UITextBorderStyleBezel;
    psdTextField.font  =[UIFont systemFontOfSize:19];
    psdTextField.secureTextEntry = YES;
    psdTextField.clearButtonMode = UITextFieldViewModeUnlessEditing;
    psdTextField.placeholder = @"密码";
    [self.view addSubview:psdTextField];
    [psdTextField release];
    //登陆
    UIButton *login_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    login_btn.backgroundColor = [UIColor greenColor];
    login_btn.frame = CGRectMake(psdTextField.left, psdTextField.bottom+30, 280, 50);
    [login_btn setTitle:@"登陆" forState:UIControlStateNormal];
    login_btn.layer.cornerRadius = 5.0;
    login_btn.showsTouchWhenHighlighted = YES;
    [login_btn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login_btn];
    //注册和忘记密码
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.backgroundColor = [UIColor brownColor];
    registerBtn.frame = CGRectMake(login_btn.left, login_btn.bottom+30, 90, 30);
    [registerBtn setTitle:@"注册账号" forState:UIControlStateNormal];
    [registerBtn setShowsTouchWhenHighlighted:YES];
    registerBtn.layer.cornerRadius = 2.0;
    [registerBtn addTarget:self action:@selector(newRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    //忘记密码
    UIButton *forgetPsdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPsdBtn.backgroundColor = [UIColor brownColor];
    forgetPsdBtn.frame = CGRectMake(registerBtn.right+100, login_btn.bottom+30, registerBtn.width, registerBtn.height);
    [forgetPsdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPsdBtn setShowsTouchWhenHighlighted:YES];
    [forgetPsdBtn addTarget:self action:@selector(forgetPSD) forControlEvents:UIControlEventTouchUpInside];
    forgetPsdBtn.layer.cornerRadius = 2.0;
    [self.view addSubview:forgetPsdBtn];
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackGround)];
    [self.view addGestureRecognizer:tap];
    [tap release];
}
-(void)newRegister
{
    RegisterPage *newRegisterPage = [[RegisterPage alloc] init];
    [self.navigationController pushViewController:newRegisterPage animated:YES];
    [newRegisterPage release];
}
#pragma mark--面板上下移动
//面板上移.下移
-(void)keyboardWillShow
{
    int a  =   self.view.frame.origin.y;
    if (a!=-150) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        CGRect frame = self.view.frame;
        frame.origin.y -=150;
        frame.size.height +=150;
        self.view.frame = frame;
        [UIView commitAnimations];
    }
}
-(void)keyboardWillHide
{
    int a  =   self.view.frame.origin.y;
    if (a!=150) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        CGRect frame = self.view.frame;
        frame.origin.y +=150;
        frame.size.height -=150;
        self.view.frame = frame;
        [UIView commitAnimations];
    }
}
#pragma mark--键盘消失
-(void)tapBackGround
{
    [nameTextField resignFirstResponder];
    [psdTextField resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [nameTextField resignFirstResponder];
    [psdTextField resignFirstResponder];
    return YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [nameTextField resignFirstResponder];
    [psdTextField resignFirstResponder];
}
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)login
{
    //做邮箱格式及所有内容是否为空的判断
    if ([Tools cheeckEmail:nameTextField.text]==YES) {
    NSString *nameStr = [NSString stringWithFormat:@"?email=%@",nameTextField.text];
    NSString *pswStr = [NSString stringWithFormat:@"&psw=%@",psdTextField.text];
  BOOL isLogin =   [RequestTools requestReturnYesOrOkWithCheckUrl_Synchronous:[MyNsstringTools groupStrByAStrArray:[NSArray arrayWithObjects:LOGIN,nameStr,pswStr,nil]]];
        [self loginIsSuccess:isLogin];
       //需重新定义一个在中央显示的提示块.淡入淡出,可以用在正误提醒,收藏关注成功与否等提醒.
  }
}
-(void)loginIsSuccess:(BOOL)flag
{
    if (flag == YES) {
        
    //存起来用户名(邮箱)和登陆密码
    [[NSUserDefaults standardUserDefaults] setObject:nameTextField.text forKey:@"user_email"];
    [[NSUserDefaults standardUserDefaults] setObject:psdTextField.text forKey:@"user_psw"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self back];
    }
    
}
#pragma mark--忘记密码
-(void)forgetPSD
{
    ForgetPSDPage *missPSDpage = [[ForgetPSDPage alloc] init];
    [self.navigationController pushViewController:missPSDpage animated:YES];
    [missPSDpage release];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
	// Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [nameTextField setText:[[NSUserDefaults standardUserDefaults] valueForKey:@"user_email"]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
