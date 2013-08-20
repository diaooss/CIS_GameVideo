//
//  AuthorMoviesListPage.m
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-7-18.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "AuthorMoviesListPage.h"
#import "MovieCell.h"
#import "Header.h"
@interface AuthorMoviesListPage ()

@end

@implementation AuthorMoviesListPage

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
    self.view.backgroundColor = [UIColor greenColor];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"作者名字:xxxx";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar.png"] forBarMetrics:UIBarMetricsDefault];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"goBack.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 44, 44)];
    [button addTarget:self action:@selector(backToFatherPage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:bar];
    [bar release];
    
    UITableView *authorListTab = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    authorListTab.delegate = self;
    authorListTab.dataSource = self;
    [self.view addSubview:authorListTab];
    [authorListTab release];

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y>10) {
        NSLog(@"越界了");
        //在此让headerview隐藏.
    }
    
}
#pragma mark--列表代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseName =@"reusename";
    MovieCell *moviesListCell = [tableView dequeueReusableCellWithIdentifier:reuseName];
    if (moviesListCell == nil) {
        moviesListCell = [[[MovieCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseName] autorelease];
    }
    moviesListCell.titleLabel.text = @"哈哈哈,我是大标题";
    moviesListCell.halfTitleLabel.text = @"哈哈,我是副标题";
    moviesListCell.logoImageView.image = [UIImage imageNamed:@"test.png"];
    return moviesListCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma  mark--自定义headerview
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 40;
//}
//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];//创建一个视图    
//    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
//    headerImageView.image = [UIImage imageNamed:@"next.png"];    
//    [headerView addSubview:headerImageView];    
//    [headerImageView release];
//    UILabel *headerLab = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.right, 10, 100, 20)];
//    headerLab.backgroundColor = [UIColor clearColor];
//    headerLab.textColor = [UIColor grayColor];
//    headerLab.font = [UIFont fontWithName:@"Arial" size:20];
//    headerLab.textAlignment = NSTextAlignmentCenter;
//    headerLab.shadowColor = [UIColor whiteColor];
//    [headerLab setShadowOffset:CGSizeMake(0, 1)];
//    [headerLab setHighlightedTextColor:[UIColor whiteColor]];
//    //设置每组的的标题
//    headerLab.text = @"魔兽阿川";
//    [headerView addSubview:headerLab];    
//    [headerLab release];
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn.frame = CGRectMake(headerLab.right+70, 0, 40, 40);
//    btn.backgroundColor = [UIColor greenColor];
//    btn.layer.cornerRadius = 20.0;
//    [headerView addSubview:btn];
//    [btn setTitle:@"LIKE" forState:UIControlStateNormal];
//    btn.backgroundColor = [UIColor redColor];
//    btn.showsTouchWhenHighlighted = YES;
//    return headerView;
//}
-(void)backToFatherPage
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
