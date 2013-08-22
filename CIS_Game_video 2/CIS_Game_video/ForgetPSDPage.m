//
//  ForgetPSDPage.m
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-8-20.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "ForgetPSDPage.h"
#import "Header.h"
#import "Tools.h"
@interface ForgetPSDPage ()

@end

@implementation ForgetPSDPage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)dealloc
{
    emailField = nil;
    [super dealloc];
}
-(void)loadView
{
    self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    [Tools navigaionView:self leftImageName:@"goBack.png" title:@"忘记密码"];
    emailField = [[UITextField alloc] initWithFrame:CGRectMake(10, 50, 300, 40)];
    emailField.delegate= self;
    emailField.backgroundColor = [UIColor yellowColor];
    emailField.textColor = [UIColor grayColor];
    emailField.layer.cornerRadius = 5.0;
    emailField.autocorrectionType = UITextAutocorrectionTypeNo;
    emailField.textAlignment = NSTextAlignmentLeft;
    emailField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    emailField.font  =[UIFont systemFontOfSize:19];
    emailField.clearButtonMode = UITextFieldViewModeWhileEditing;
    emailField.placeholder = @"注册时所用邮箱";
    emailField.borderStyle = UITextBorderStyleBezel;
    [self.view addSubview:emailField];
    [emailField release];
    
    UIButton *getEmailCheckInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getEmailCheckInBtn.frame = CGRectMake(60, emailField.bottom+20, 200, 40);
    getEmailCheckInBtn.showsTouchWhenHighlighted = YES;
    [getEmailCheckInBtn setTitle:@"邮箱验证" forState:UIControlStateNormal];
    getEmailCheckInBtn.backgroundColor = [UIColor redColor];
    getEmailCheckInBtn.layer.cornerRadius = 5.0;
    [getEmailCheckInBtn addTarget:self action:@selector(checkInWithEmail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getEmailCheckInBtn];
    //提示
    UILabel *tipsLab = [[UILabel alloc] initWithFrame:CGRectMake(0, getEmailCheckInBtn.bottom+20, 320, 20)];
    tipsLab.text = @"我们将在稍后将验证信息发送至您的邮箱,请注意查收.";
    tipsLab.backgroundColor = [UIColor clearColor];
    tipsLab.textColor = [UIColor grayColor];
    tipsLab.font = [UIFont systemFontOfSize:13];
    tipsLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipsLab];
    [tipsLab release];
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackGround)];
    [self.view addGestureRecognizer:tap];
    [tap release];


}
#pragma mark--键盘消失
-(void)tapBackGround
{
    
    [emailField resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [emailField resignFirstResponder];
    return YES;
}
-(void)checkInWithEmail
{
    
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
