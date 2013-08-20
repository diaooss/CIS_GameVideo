//
//  AboutUsPage.m
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-7-19.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "AboutUsPage.h"
#import "Header.h"
#import "FeedBackpage.h"
@interface AboutUsPage ()

@end

@implementation AboutUsPage

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
    self.navigationItem.title = @"关于CIS";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar.png"] forBarMetrics:UIBarMetricsDefault];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"goBack.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 44, 44)];
    [button addTarget:self.viewDeckController action:@selector(toggleLeftViewAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:bar];
    [bar release];
    
    UITableView *usTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.height-60) style:UITableViewStyleGrouped];
    usTab.backgroundView = nil;
    usTab.backgroundColor = [UIColor whiteColor];
    usTab.scrollEnabled = NO;
    usTab.delegate = self;
    usTab.dataSource = self;
    [usTab setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:usTab];
    [usTab release];
    NSLog(@"%f",usTab.bottom);
    UILabel *cNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, usTab.height-60, 320, 20)];
    cNameLabel.text = @"Copy Right@2013-2014 HuanFang InterNet Co.Ltd";
    cNameLabel.textAlignment = NSTextAlignmentCenter;
    cNameLabel.font = [UIFont systemFontOfSize:13];
    cNameLabel.backgroundColor = [UIColor clearColor];
    [self.view  addSubview:cNameLabel];
    [cNameLabel release];
    UILabel *rNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, cNameLabel.bottom, 320, 20)];
    rNameLabel.text = @"All Rights Reserved";
    rNameLabel.textAlignment = NSTextAlignmentCenter;
    rNameLabel.font = [UIFont systemFontOfSize:11];
    rNameLabel.backgroundColor = [UIColor clearColor];
    [self.view  addSubview:rNameLabel];
    [rNameLabel release];

}
#pragma mark--列表代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    return 3;
}
#pragma mark--列表的代理方法
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusename = @"reuse";
    UITableViewCell *usCell = [tableView dequeueReusableCellWithIdentifier:reusename];
    if (usCell == nil) {
        usCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusename] autorelease];
        usCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        usCell.selectedBackgroundView = [[[UIView alloc] initWithFrame:usCell.frame] autorelease];
        usCell.selectedBackgroundView.layer.cornerRadius = 4.0;
        usCell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:98/255.0 green:138/255.0 blue:14/255.0 alpha:1];
    }
    usCell.imageView.image = [UIImage imageNamed:@"smile32.png"];
    if (indexPath.section ==0) {
        if (indexPath.row ==0) {
            usCell.textLabel.text = @"为我打分";
        }else
        {
            usCell.textLabel.text = @"用户帮助";
        }
    }else{
        if (indexPath.row ==0) {
            usCell.textLabel.text = @"意见反馈";
        }else if (indexPath.row == 1)
        {
            usCell.textLabel.text = @"用户协议";
        }else
        {
            usCell.textLabel.text = @"新版本检测";
        }
            }
        return usCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
                
                break;
            case 1:
                break;
            default:
                break;
        }
    }else if (indexPath.section == 1)
    {
        switch (indexPath.row) {
            case 0:
                [self goToFeedBack];
                break;
            case 1:
                 break;
            case 2:
                break;
            default:
                break;
        }
    }
}

-(void)goToFeedBack
{
    FeedBackpage *feedbackPage = [[FeedBackpage alloc] init];
    [self.navigationController pushViewController:feedbackPage animated:YES];
    [feedbackPage release];
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
