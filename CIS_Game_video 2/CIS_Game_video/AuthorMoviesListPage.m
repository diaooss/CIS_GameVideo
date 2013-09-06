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
#import "Tools.h"
#import "RequestTools.h"
#import "MyNsstringTools.h"
#import "RequestUrls.h"
@interface AuthorMoviesListPage ()

@end

@implementation AuthorMoviesListPage
- (void)dealloc
{
    [authorListTab release];
    [getAuthorListByAuthorID release];
    self.authorIDStr = nil;
    self.authorNameStr = nil;
    self.authorListDic = nil;
    self.moviesOfTheAuthorArry = nil;
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
-(void)loadView
{
    self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.view.backgroundColor = [UIColor greenColor];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [Tools navigaionView:self leftImageName:@"goBack.png" rightImageName:@"goBack.png" title:_authorNameStr];
       authorListTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.height-50) style:UITableViewStylePlain];
    authorListTab.delegate = self;
    authorListTab.dataSource = self;
    [authorListTab setTag:1000];
    [self.view addSubview:authorListTab];
    [self getauthorListById];
}
-(void)getauthorListById
{
    getAuthorListByAuthorID = [[RequestTools alloc] init];
    [getAuthorListByAuthorID setDelegate:self];
    NSArray *strArry = [NSArray arrayWithObjects:GET_LIST_OF_A_AUTHOR,@"?AuthorID=4&email=1601883700@qq.com",nil];
    NSLog(@"拼接字符串是:%@",[MyNsstringTools groupStrByAStrArray:strArry]);
    [getAuthorListByAuthorID requestWithUrl_Asynchronous:[MyNsstringTools groupStrByAStrArray:strArry]];
    
}
#pragma mark--列表代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_moviesOfTheAuthorArry count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseName =@"reusename";
    MovieCell *moviesListCell = [tableView dequeueReusableCellWithIdentifier:reuseName];
    if (moviesListCell == nil) {
        moviesListCell = [[[MovieCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseName] autorelease];
    }
    moviesListCell.titleLabel.text = [[self.moviesOfTheAuthorArry objectAtIndex:indexPath.row] objectForKey:@"movieName"];
    moviesListCell.categoryLabel.text = [[self.moviesOfTheAuthorArry objectAtIndex:indexPath.row] objectForKey:@"category"];
     moviesListCell.timeLab.text = [[self.moviesOfTheAuthorArry objectAtIndex:indexPath.row] objectForKey:@"m_duration"];
    moviesListCell.popularLab.text =[MyNsstringTools makeNewStrByAnyObj:[[self.moviesOfTheAuthorArry objectAtIndex:indexPath.row] objectForKey:@"m_popular"]];
    moviesListCell.logoImageView.image = [UIImage imageNamed:@"test.png"];
    moviesListCell.collectBtn.tag = indexPath.row;
    NSString *isLikeStr = [MyNsstringTools makeNewStrByAnyObj:[[self.moviesOfTheAuthorArry objectAtIndex:indexPath.row] objectForKey:@"isLiked"]];
    if ([isLikeStr intValue]==0) {
        NSLog(@"没有被收藏");
        NSLog(@"%d",[isLikeStr intValue]);
        moviesListCell.collectBtn.backgroundColor = [UIColor greenColor];
    }else
    {
        moviesListCell.collectBtn.backgroundColor = [UIColor grayColor];
    }
    return moviesListCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma  mark--自定义headerview
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];//创建一个视图
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 5, 60, 60)];
    headerView.backgroundColor = [UIColor grayColor];
    headerImageView.backgroundColor = [UIColor  yellowColor];
    [headerView addSubview:headerImageView];    
    [headerImageView release];
    UILabel *headerLab = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.right, 30, 100, 20)];
    headerLab.backgroundColor = [UIColor clearColor];
    headerLab.textColor = [UIColor yellowColor];
    headerLab.font = [UIFont fontWithName:@"Arial" size:15];
    headerLab.textAlignment = NSTextAlignmentCenter;
    headerLab.shadowColor = [UIColor whiteColor];
    [headerLab setShadowOffset:CGSizeMake(0, 1)];
    [headerLab setHighlightedTextColor:[UIColor whiteColor]];
    //设置每组的的标题
    headerLab.text = @"魔兽阿川";
    [headerView addSubview:headerLab];    
    [headerLab release];
    authorListTab.tableHeaderView = headerView;
    return headerView;
    }
    return nil;
}
-(void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)topRightCorenerBtnAction
{
    //实现关注作者
}
-(void)requestSuccessWithResultDictionary:(NSDictionary *)dic
{
    NSLog(@"单一作者视频列表%@",dic);
    self.authorListDic = dic;
    self.moviesOfTheAuthorArry = [dic objectForKey:@"movies"];
    [authorListTab reloadData];
}
-(void)requestFailedWithResultDictionary:(NSDictionary *)dic
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
