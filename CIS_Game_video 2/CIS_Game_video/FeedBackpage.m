//
//  FeedBackpage.m
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-8-20.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "FeedBackpage.h"
#import "Header.h"
#import "Tools.h"
@interface FeedBackpage ()

@end

@implementation FeedBackpage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)loadView
{
    self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255. blue:240/255. alpha:1];
    UITextField *feedTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, 320, self.view.height/4+10)];
    feedTextField.tag = 1000;
    feedTextField.delegate= self;
    feedTextField.backgroundColor = [UIColor whiteColor];
    feedTextField.textColor = [UIColor grayColor];
    feedTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    feedTextField.textAlignment = NSTextAlignmentLeft;
    feedTextField.font  =[UIFont systemFontOfSize:17];
    feedTextField.clearButtonMode = UITextFieldViewModeUnlessEditing;
    feedTextField.placeholder = @"您的反馈将帮助我们更快的成长";
    [self.view addSubview:feedTextField];
    [feedTextField release];
    UITextField *qqOrPhoneField = [[UITextField alloc] initWithFrame:CGRectMake(feedTextField.left, feedTextField.bottom+5, feedTextField.width, 35)];
    qqOrPhoneField.tag = 1100;
    qqOrPhoneField.delegate= self;
    qqOrPhoneField.backgroundColor = [UIColor colorWithRed:220/255.0 green:223/255. blue:223/255. alpha:1];
    qqOrPhoneField.placeholder = @"留下您的QQ(选填)";
    qqOrPhoneField.textColor = [UIColor colorWithRed:102/255.0 green:108/255. blue:120/255. alpha:1];
    qqOrPhoneField.layer.cornerRadius = 3.0;
    qqOrPhoneField.font = [UIFont systemFontOfSize:15];
    qqOrPhoneField.textAlignment = NSTextAlignmentCenter;
    qqOrPhoneField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    qqOrPhoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
    qqOrPhoneField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:qqOrPhoneField];
    [qqOrPhoneField release];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackGround)];
    [self.view addGestureRecognizer:tap];
    [tap release];
    
    /*/顶部定制 /*/
    [Tools navigaionView:self deckVC:self.viewDeckController leftImageName:@"goBack.png" title:@"关于CIS"];
    UIBarButtonItem *sendBtn = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(sendMessage)];
    self.navigationItem.rightBarButtonItem = sendBtn;
    [sendBtn release];
    /*/ 初始化一些东西/*/
    [self getPhoneAndAppInfo];
    [Tools addNotlabel:self.view];
    
}

-(void)goback
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
#pragma mark--获得系统版本号,手机类型,APP版本号.
-(void)getPhoneAndAppInfo
{
    UIDevice *device_=[UIDevice currentDevice];
    NSLog(@"设备所有者的名称－－%@",device_.name);
    NSLog(@"设备的类别－－－－－%@",device_.model);
    NSLog(@"设备运行的系统－－－%@",device_.systemName);
    NSLog(@"当前系统的版本－－－%@",device_.systemVersion);
    //得到设备屏幕高度,判断是爱疯5或以下.
    float screenHeight=[UIScreen mainScreen].bounds.size.height;
    
}
#pragma mark--提交意见
-(void)sendMessage
{
    //提交反馈意见
    
}
-(void)tapBackGround
{
    UITextField *f = (UITextField *)[self.view viewWithTag:1000];
    UITextField *ff = (UITextField *)[self.view viewWithTag:1100];
    [ff resignFirstResponder];
    [f resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    UITextField *f = (UITextField *)[self.view viewWithTag:1000];
    UITextField *ff = (UITextField *)[self.view viewWithTag:1100];
    [ff resignFirstResponder];
    [f resignFirstResponder];
    
    return YES;

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
