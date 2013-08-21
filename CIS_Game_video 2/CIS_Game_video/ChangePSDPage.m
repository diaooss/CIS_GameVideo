//
//  ChangePSDPage.m
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-8-21.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "ChangePSDPage.h"
#import "Header.h"
#import "Tools.h"
#import "PublciViewsTools.h"
@interface ChangePSDPage ()

@end

@implementation ChangePSDPage

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
    [Tools navigaionView:self leftImageName:@"goBack.png" title:@"修改密码"];
    

    
    
    for (int i = 0; i<3; i++) {
        UITextField *text_field = [[UITextField alloc] initWithFrame:CGRectMake(10, 60+i*60, 300, 40)];
        text_field.tag = 100*i+100;
        text_field.backgroundColor = [UIColor yellowColor];
        text_field.delegate= self;
        text_field.textColor = [UIColor grayColor];
        text_field.layer.cornerRadius = 5.0;
        text_field.autocorrectionType = UITextAutocorrectionTypeNo;
        text_field.textAlignment = NSTextAlignmentLeft;
        text_field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        text_field.font  =[UIFont systemFontOfSize:19];
        text_field.clearButtonMode = UITextFieldViewModeWhileEditing;
        text_field.borderStyle = UITextBorderStyleBezel;
        if (i==0) {
            text_field.placeholder = @"请输入当前密码";
        }else if (i==1)
        {
            text_field.placeholder = @"请输入新密码";
            text_field.secureTextEntry = YES;

        }else
        {
            text_field.placeholder = @"请再次输入新密码";
            text_field.secureTextEntry = YES;
        }
        [self.view addSubview:text_field];
        [text_field release];
    }
    
    
    UIButton*confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom image:nil frame:CGRectMake(20, 240, 280, 40) target:self action:@selector(confirmChangePSD) ];
    confirmBtn.backgroundColor = [UIColor brownColor];
    [confirmBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [self.view addSubview:confirmBtn];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)confirmChangePSD
{
    
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
