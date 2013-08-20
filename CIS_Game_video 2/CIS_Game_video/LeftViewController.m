//
//  LeftViewController.m
//  CIS_Game_video
//
//  Created by huangfangwang on 13-7-16.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "LeftViewController.h"
#import "Header.h"
#import "UserViewController.h"
#import "AppDelegate.h"
#import "Public_ViewController.h"
#import "MyLikeAuthorListPage.h"
#import "SetTingPage.h"
#import "LogInViewController.h"
#import "NetSettingPage.h"
#import "AboutUsPage.h"
@interface LeftViewController ()

@end

@implementation LeftViewController

- (void)dealloc
{
    [_nameArry release];
    [_pictureArry release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    _nameArry = [[NSArray alloc]initWithObjects:@"用户中心",@"返回主页",@"我的收藏",@"下载记录",@"观看记录",@"我的关注", nil];
    _pictureArry = [[NSArray alloc]initWithObjects:@"test.png",@"test.png",@"test.png",@"test.png",@"test.png",@"test.png", nil];
    
    //增加一个判断  下面用
    _isCraete=NO;
    return self;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    //基础信息
    UITableView * setTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0,320, self.view.height*5/9) style:UITableViewStylePlain];
    [setTableView setDelegate:self];
    [setTableView setDataSource:self];
    [self.view addSubview:setTableView];
    [setTableView release];
    NSArray * arry = [NSArray arrayWithObjects:@"系统设置",@"分享设置",@"应用推荐",@"网络设置",@"关于CIS", nil];
//有待更改
    for (int j=0; j<3; j++) {
        for (int i=0; i<2; i++) {
            if (2*j+i<5) {
                //but??????
            UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
            [but setFrame:CGRectMake(0+((320-44)/2)*i, setTableView.bottom+j*self.view.height/9, (320-44)/2, self.view.height/9)];
            [self.view addSubview:but];
            [but setTag:100+2*j+i];
            [but.layer setBorderWidth:3];
            [but setShowsTouchWhenHighlighted:YES];
            [but setBackgroundColor:[UIColor brownColor]];
                [but addTarget:self action:@selector(configButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                [but setTitle:[arry objectAtIndex:2*j+i] forState:UIControlStateNormal];
            }
        }
    }
    //添加一个手势
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self.viewDeckController action:@selector(closeLeftView)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:recognizer];
    [recognizer release];
    
    //签到
    UILabel *checkLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 490, 320, 30)];
    checkLabel.text = @"     每日签到(您已连续签到XX次)";
    checkLabel.textAlignment = NSTextAlignmentLeft;
    checkLabel.textColor = [UIColor grayColor];
    checkLabel.backgroundColor  =[UIColor clearColor];
    [self.view addSubview:checkLabel];
    [checkLabel release];
}
#pragma mark -----UItableView 的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_nameArry count];
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return self.view.height*10/63;
    }return self.view.height*5/63;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * mark = @"mark";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:mark];
    if (nil==cell) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mark] autorelease];
    }
    [cell.textLabel setText:[_nameArry objectAtIndex:indexPath.row]];
    [cell.imageView setImage:[UIImage imageNamed:@"test.test.png"]];//[_pictureArry objectAtIndex:indexPath.row]]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:
            [self goIntoUserCenterWith:cell.textLabel.text];
            break;
        case 1:
            [self backToRootViewController];
            break;
        case 2:
            NSLog(@"%@",cell.textLabel.text);
            [self toSomePlace:cell.textLabel.text];//前往公共页
            break;
        case 3:
            NSLog(@"%@",cell.textLabel.text);
            [self toSomePlace:cell.textLabel.text];
            break;
        case 4:
            NSLog(@"%@",cell.textLabel.text);
            [self toSomePlace:cell.textLabel.text];
            break;
            
        case 5:
            NSLog(@"%@",cell.textLabel.text);//我的关注
            [self goToMyLikeAuthorListPageWith:cell.textLabel.text];
            break;
        default:
            break;
    }
}
#pragma mark-- cell的点击触发事件
- (void)goIntoUserCenterWith:(NSString *)name
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfor = [userDefaults valueForKey:@"UserInfo"];
    if (userInfor) {
        NSLog(@"存在");
        UserViewController* user = [[UserViewController alloc]init];
        [self judgeTheView:name changeViecontroller:user];
        [user release];
    }else
    {
        NSLog(@"不存在");
        LogInViewController * login = [[LogInViewController alloc]init];
        [login setIsHaveId:YES];
        [self judgeTheView:@"账号登陆" changeViecontroller:login];
        [login release];
    }
    
  
}
- (void)backToRootViewController
{
    _isCraete=NO;
    UIViewController * View = (UIViewController *)self.viewDeckController.centerController;
    if ([View.title isEqualToString:@"幻方视频"]) {
        [self.viewDeckController closeLeftViewAnimated:YES];
        return;
    }
    AppDelegate * delegate = [UIApplication sharedApplication].delegate;
    [self.viewDeckController closeLeftViewAnimated:YES];
    [self.viewDeckController setCenterController:delegate.rootNvc];
    
    
}
//根据标签判断去哪个页面
- (void)toSomePlace:(NSString *)cellName;
{
    if (_isCraete==NO) {
        Public_ViewController * public = [[Public_ViewController alloc]init];
        UINavigationController * publicNVC =[[UINavigationController alloc]initWithRootViewController:public];
        [self.viewDeckController closeLeftViewAnimated:YES];
        [self.viewDeckController setCenterController:publicNVC];
        [public changeInformation:cellName];//设置名字 并且更新数据
        [publicNVC release];
        [public release];
        _isCraete=YES;
        return;
    }
//如果当前的Viewcontroller存在 就需要判断是不是当前点击的
    UINavigationController * nowViewController = (UINavigationController *)self.viewDeckController.centerController;
    Public_ViewController *view=(Public_ViewController *)[nowViewController.viewControllers objectAtIndex:0];
//判断点击是不是重复的
    if ([view.title isEqualToString:cellName]) {
        [self.viewDeckController closeLeftViewAnimated:YES];
        return;
    }
//如果不是 需要冲洗夹杂数据
    [view changeInformation:cellName];//并且更新数据_____方法需要重新定义;
    [self.viewDeckController closeLeftViewAnimated:YES];
}
//前往我的关注列表,此方法未添加是否该页面已经存在的判断.
-(void)goToMyLikeAuthorListPageWith:(NSString *)name
{
    MyLikeAuthorListPage *likeAuthorPage = [[MyLikeAuthorListPage alloc] init] ;
    [self judgeTheView:name changeViecontroller:likeAuthorPage];
    [likeAuthorPage release];
}
#pragma mark--判断显示是不是当前点击的方法___
//判断当前的center 是不是点击所选中的
- (void)judgeTheView:(NSString *)nowSelectionCell changeViecontroller:(UIViewController *)controller
{
    _isCraete=NO;
    UIViewController *viewController = (UIViewController *)self.viewDeckController.centerController;
    if ([viewController.title isEqualToString:nowSelectionCell]) {
        [self.viewDeckController closeLeftViewAnimated:YES];
        return;
    }
    UINavigationController * controllerNVC =[[UINavigationController alloc]initWithRootViewController:controller];
    [self.viewDeckController closeLeftViewAnimated:YES];
    [self.viewDeckController setCenterController:controllerNVC];
    [controllerNVC release];
}
#pragma mark--设置按钮等的点击事件
-(void)configButtonClick:(UIButton *)sender
{
    NSLog(@"%d",sender.tag);
    switch (sender.tag) {
        case 100:
            NSLog(@"哈哈哈");
            SetTingPage *configPage = [[SetTingPage alloc] init];
            [self judgeTheView:[sender titleForState:UIControlStateNormal] changeViecontroller:configPage];
            [configPage release];
            break;
        case 103:
            NSLog(@"哈哈哈");
            NetSettingPage *netConfigPage = [[NetSettingPage alloc] init];
            [self judgeTheView:[sender titleForState:UIControlStateNormal] changeViecontroller:netConfigPage];
            [netConfigPage release];
            break;
        case 104:
            NSLog(@"哈哈哈");
            AboutUsPage *usPage = [[AboutUsPage alloc] init];
            [self judgeTheView:[sender titleForState:UIControlStateNormal] changeViecontroller:usPage];
            [usPage release];
            break;

        default:
            break;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
