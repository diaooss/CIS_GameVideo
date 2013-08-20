//
//  LogInViewController.m
//  CIS_Game_video
//
//  Created by huangfangwang on 13-7-19.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "LogInViewController.h"
#import "Header.h"
#import "My_MakeVipView.h"
@interface LogInViewController ()

@end

@implementation LogInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    [self setTitle:@"账号登陆"];
	// Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar.png"] forBarMetrics:UIBarMetricsDefault];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"goBack.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 44, 44)];

    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:bar];
    [bar release];

//拉出登陆界面
    if (_isHaveId==YES) {
        UIScrollView * login_view = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.height)];
        [self.view addSubview:login_view];
        [login_view setContentSize:CGSizeMake(320, 560)];
        [login_view release];
        
        UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backKeyBord)];
        [login_view addGestureRecognizer:tap];
        [tap release];
    //bar 的方法
        [button addTarget:self.viewDeckController action:@selector(toggleLeftViewAnimated:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *logoImage =[[UIImageView alloc]initWithFrame:CGRectMake(320/3, login_view.height/10, 320/3, 320/3)];
        [logoImage setImage:[UIImage imageNamed:@"test.test.png"]];
        [login_view addSubview:logoImage];
        [logoImage release];
        //账号
        UILabel * IDlabel = [[UILabel alloc]initWithFrame:CGRectMake(30, logoImage.bottom+30, 40, 40)];
        [login_view addSubview:IDlabel];
        [IDlabel setBackgroundColor:[UIColor clearColor]];
        [IDlabel setText:@"账号:"];
        [IDlabel release];
        
        UITextField * IDtext = [[UITextField alloc]initWithFrame:CGRectMake(80, logoImage.bottom+30, 200, 40)];
        [IDtext setBorderStyle:UITextBorderStyleRoundedRect];
        [login_view addSubview:IDtext];
        [IDtext setDelegate:self];
        [IDtext setPlaceholder:@"邮箱:"];
        [IDtext release];
        //密码
        UILabel *passWordlabel = [[UILabel alloc]initWithFrame:CGRectMake(30, IDlabel.bottom+20, 40, 40)];
        [login_view addSubview:passWordlabel];
        [passWordlabel release];
        [passWordlabel setBackgroundColor:[UIColor clearColor]];
        [passWordlabel setText:@"密码:"];
        
        UITextField * passWordtext = [[UITextField alloc]initWithFrame:CGRectMake(80, IDlabel.bottom+20, 200, 40)];
        [passWordtext setBorderStyle:UITextBorderStyleRoundedRect];
        [login_view addSubview:passWordtext];
        [passWordtext setDelegate:self];
        [passWordtext setPlaceholder:@"密码"];
        [passWordtext release];
        //登陆
        UIButton * loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [loginButton setFrame:CGRectMake(80, passWordtext.bottom+20, 200, 40)];
        [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
        [login_view addSubview:loginButton];
        //注册
        UIButton * signButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [signButton setFrame:CGRectMake(40, loginButton.bottom+20, 95, 40)];
        [signButton setTitle:@"注册" forState:UIControlStateNormal];
        [signButton addTarget:self action:@selector(makeOneVip) forControlEvents:UIControlEventTouchUpInside];
        [login_view addSubview:signButton];
        //忘记密码
        UIButton * forgotBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [forgotBtn setFrame:CGRectMake(190, loginButton.bottom+20, 95, 40)];
        [forgotBtn setTitle:@"密码忘记?" forState:UIControlStateNormal];
        [login_view addSubview:forgotBtn];
    }else
    {

        [button addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside];
        UITextField * Idlabel = [[UITextField alloc]initWithFrame:CGRectMake(50, 50, 220, 40)];
        [Idlabel setPlaceholder:@"邮箱:"];
        [Idlabel setBorderStyle:UITextBorderStyleRoundedRect];
        [self.view addSubview:Idlabel];
        [Idlabel release];
        [Idlabel setDelegate:self];
        
        
        UITextField * passLabel = [[UITextField alloc]initWithFrame:CGRectMake(50, 120, 220, 40)];
        [self.view addSubview:passLabel];
        [passLabel setBorderStyle:UITextBorderStyleRoundedRect];
        [passLabel setPlaceholder:@"密码"];
        [passLabel release];
        [passLabel setDelegate:self];
        
        UIButton * pressButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [pressButton setFrame:CGRectMake(50, 180, 220, 40)];
        [self.view addSubview:pressButton];
        [pressButton setTitle:@"注册" forState:UIControlStateNormal];
        [pressButton addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backKeyBord)];
    [self.view addGestureRecognizer:tap];
    [tap release];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//回收键盘
- (void)backKeyBord
{
    NSLog(@"不走");
    for(id sub in [self.view subviews] )
    {
        [sub resignFirstResponder];
    }
}
//返回方法
- (void)backTo
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)makeOneVip{
    LogInViewController * make = [[LogInViewController alloc]init];
    [make setIsHaveId:NO];
    [self.navigationController pushViewController:make animated:YES];
    [make release];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 是不是邮箱
 -(BOOL)isValidateEmail:(NSString *)email
 {
 
 NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
 
 NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
 
 return [emailTest evaluateWithObject:email];
 }
 */
@end
