//
//  UserViewController.m
//  CIS_Game_video
//
//  Created by huangfangwang on 13-7-16.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "UserViewController.h"
#import "Header.h"
#import "PublciViewsTools.h"
@interface UserViewController ()

@end

@implementation UserViewController

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
    [self.view setBackgroundColor:[UIColor brownColor]];
    [self setTitle:@"用户中心"];
	// Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar.png"] forBarMetrics:UIBarMetricsDefault];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"goBack.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 44, 44)];
    [button addTarget:self.viewDeckController action:@selector(toggleLeftViewAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:bar];
    [bar release];
    /*/ 配置用户中心/*/
    //仿新浪微薄,背景
    UIImageView *userCenterBgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
    userCenterBgImgView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:userCenterBgImgView];
    [userCenterBgImgView release];
    //头像
    UIImageView *userHeaderImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, userCenterBgImgView.bottom-30, 80, 80)];
    userHeaderImgView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:userHeaderImgView];
    [userHeaderImgView release];
    UILabel *nameLab = [UILabel labelLinesWithRect:CGRectMake(userHeaderImgView.right+20, userCenterBgImgView.bottom+10, 150, 35) txt:@"我是小强" font:[UIFont systemFontOfSize:14]];
    nameLab.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:nameLab];
    
    
    
    
    
    
    
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
