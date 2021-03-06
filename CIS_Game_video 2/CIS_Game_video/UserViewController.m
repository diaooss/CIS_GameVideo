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
#import "Tools.h"
#import "ChangePSDPage.h"
#import "SqCached.h"
#import "MyNsstringTools.h"
@interface UserViewController ()

@end

@implementation UserViewController
- (void)dealloc
{
    self.userInfoDic = nil;
    [super dealloc];
}
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
    [self readerCache];

    [self.view setBackgroundColor:[UIColor brownColor]];
[Tools navigaionView:self deckVC:self.viewDeckController leftImageName:@"goBack.png" title:@"用户中心"];
    /*/ 配置用户中心/*/
    //仿新浪微薄,背景
    UIImageView *userCenterBgImgView = [UIImageView imageViewWithRect:CGRectMake(0, 0, 320, 150) image:nil interaction:NO];
    userCenterBgImgView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:userCenterBgImgView];
    //头像
    UIImageView *userHeaderImgView = [UIImageView imageViewWithRect:CGRectMake(20, userCenterBgImgView.bottom-40, 80, 80) image:nil interaction:YES];
    
    userHeaderImgView.layer.cornerRadius = 5.0;
    [self.view addSubview:userHeaderImgView];
    //添加头像点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeaderImageView)];
    [userHeaderImgView addGestureRecognizer:tap];
    [tap release];
    /*/ 姓名/*/
    UILabel *nameLab = [UILabel labelLinesWithRect:CGRectMake(userHeaderImgView.right+10, userCenterBgImgView.bottom-30, 150, 35) txt:[self.userInfoDic objectForKey:@"userName"] font:[UIFont systemFontOfSize:14]];
    nameLab.textAlignment = NSTextAlignmentLeft;
    nameLab.layer.cornerRadius = 2.0;
    nameLab.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nameLab];
    UIImageView *movieImg = [UIImageView imageViewWithRect:CGRectMake(nameLab.left, nameLab.bottom+10, 30, 30) image:nil interaction:NO];
        
    movieImg.backgroundColor = [UIColor blackColor];
    [self.view addSubview:movieImg];
    
    UILabel *movieLab = [UILabel labelLinesWithRect:CGRectMake(movieImg.right,movieImg.top, 45, 30) txt:[MyNsstringTools makeNewStrByAnyObj:[self.userInfoDic objectForKey:@"likedCount"]] font:[UIFont systemFontOfSize:14]];
    movieLab.textAlignment = NSTextAlignmentLeft;
    movieLab.layer.cornerRadius = 2.0;
    movieLab.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:movieLab];
    
    UIImageView *authorImg = [UIImageView imageViewWithRect:CGRectMake(movieLab.right, nameLab.bottom+10, 30, 30) image:nil interaction:NO];
    authorImg.backgroundColor = [UIColor blackColor];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"user_image"]) {
        userHeaderImgView.image = [UIImage imageWithContentsOfFile:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_image"]];
    }else if ([self.userInfoDic objectForKey:@"photo"]!=NULL)
    {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self.userInfoDic objectForKey:@"photo"]]];
        userHeaderImgView.image = [UIImage imageWithData:data];
        
    }else
    {
        userHeaderImgView.image = [UIImage imageNamed:@"plant1.jpg"];
        
    }
    [self.view addSubview:authorImg];


    
    UILabel *authorLab = [UILabel labelLinesWithRect:CGRectMake(authorImg.right,movieImg.top, 45, 30) txt:[MyNsstringTools makeNewStrByAnyObj:[self.userInfoDic objectForKey:@"caredCount"]] font:[UIFont systemFontOfSize:14]];
    authorLab.textAlignment = NSTextAlignmentLeft;
    authorLab.layer.cornerRadius = 2.0;
    authorLab.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:authorLab];

    
    
    
    //退出登录按钮
    for (int i = 0; i<3; i++) {
        UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom image:nil frame:CGRectMake(userHeaderImgView.left+30, userHeaderImgView.bottom+70*i+30, 200, 40) target:self action:@selector(userCenterOpration:)];
        exitBtn.tag = 100*i+100;
        if (i==0) {
            [exitBtn setTitle:@"修改密码" forState:UIControlStateNormal];

        }else if (i==1)
        {
            [exitBtn setTitle:@"分享给朋友" forState:UIControlStateNormal];
        }else
        {
            [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        }
        exitBtn.layer.cornerRadius = 5.0;
        exitBtn.showsTouchWhenHighlighted = YES;
        exitBtn.backgroundColor = [UIColor greenColor];
        [self.view addSubview:exitBtn];
    }
}
-(void)readerCache
{
    self.userInfoDic = [[SqCached shareCache] cacheDataForKey:@"userInfo"];

}
-(void)tapHeaderImageView
{
    
}
-(void)userCenterOpration:(UIButton *)sender
{
    switch (sender.tag) {
        case 100:
            [self goToChangePSD];
            break;
        case 200:
            break;

            
        default:
            break;
    }
}
-(void)goToChangePSD
{
    ChangePSDPage *newAPSD = [[ChangePSDPage alloc] init];
    [self.navigationController pushViewController:newAPSD animated:YES];
    [newAPSD release];
}
-(void)shareToFriends
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
