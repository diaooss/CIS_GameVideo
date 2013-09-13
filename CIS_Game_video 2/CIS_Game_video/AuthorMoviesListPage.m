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
#import "AsynImageView.h"
#import "SqCached.h"
#import "JSONKit.h"
#import "MovieDetailPage.h"
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
    [_refreshFooterView release];
    [_refreshHeaderView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.moviesOfTheAuthorArry = [NSMutableArray arrayWithCapacity:10];
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
    flag = 1;
    [self.view addSubview:authorListTab];
    [self createHeaderView];
    [self setFooterView];
    [self getauthorListById];
}
#pragma mark--通过ID PAGE请求作品列表
-(void)getauthorListById
{
    [Tools openLoadsign:self.view WithString:@"正在加载..."];

    getAuthorListByAuthorID = [[RequestTools alloc] init];
    [getAuthorListByAuthorID setDelegate:self];
    NSString *authorIdStr = [NSString stringWithFormat:@"?AuthorID=%@",self.authorIDStr];
    NSString *pageStr = [NSString stringWithFormat:@"&dataPage=%d",flag];
    NSArray *strArry = [NSArray arrayWithObjects:GET_LIST_OF_A_AUTHOR,authorIdStr,pageStr,nil];
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
    moviesListCell.logoImageView.imageURL = [MyNsstringTools changeStrWithUT8:[[self.moviesOfTheAuthorArry objectAtIndex:indexPath.row] objectForKey:@"thumbnail"]];
    moviesListCell.collectBtn.tag = indexPath.row;
    [moviesListCell.collectBtn addTarget:self action:@selector(collectMovie:) forControlEvents:UIControlEventTouchUpInside];
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

#pragma  mark--自定义headerview
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];//创建一个视图
    AsynImageView *headerImageView = [[AsynImageView alloc] initWithFrame:CGRectMake(15, 10, 60, 60)];
        NSLog(@"在这头像%d",[_authorListDic retainCount]);
        headerImageView.imageURL = [self.authorListDic objectForKey:@"authImg"];
        
    [headerView addSubview:headerImageView];
    [headerImageView release];
    UITextView *headerLab = [[UITextView alloc] initWithFrame:CGRectMake(headerImageView.right, 5, 250, 60)];
    headerLab.backgroundColor = [UIColor clearColor];
    headerLab.textColor = [UIColor blackColor];
    headerLab.font = [UIFont fontWithName:@"Arial" size:11];
    headerLab.textAlignment = NSTextAlignmentLeft;

        
    //设置每组的的标题
    headerLab.text = [self.authorListDic objectForKey:@"intro"];
    [headerView addSubview:headerLab];    
    [headerLab release];
    authorListTab.tableHeaderView = headerView;
    return headerView;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MovieDetailPage *detailPage = [[MovieDetailPage alloc] init];
    detailPage.movieId = [[self.moviesOfTheAuthorArry objectAtIndex:indexPath.row] objectForKey:@"movieID"];
    [self.navigationController pushViewController:detailPage animated:YES];
    [detailPage release];
}
-(void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark--收藏视频/关注作者
-(void)collectMovie:(UIButton *)sender
{
    NSString *movieID = [[self.moviesOfTheAuthorArry objectAtIndex:sender.tag] objectForKey:@"movieID"];
    RequestTools *collectRequest = [[RequestTools alloc] init];
    [collectRequest setDelegate:self];
    NSArray *strArry = [NSArray arrayWithObjects:COLLECT_VIDOE,@"?email=1823870397@qq.com&movieID=",movieID, nil];
    [collectRequest requestWithUrl_Asynchronous:[MyNsstringTools groupStrByAStrArray:strArry]];
    //进行按钮颜色的变化等.
    

    
    
}
#pragma mark--收藏视频/关注作者

-(void)topRightCorenerBtnAction
{
    //实现关注作者
}
-(void)requestSuccessWithResultDictionary:(NSDictionary *)dic
{
    [Tools closeLoadsign:self.view];
    NSLog(@"请求字典详情:%@",dic);
    //self.authorListDic = dic;
   [self setAuthorListDic:dic];//
        NSArray * arry =[dic valueForKey:@"movies"];
    if ([arry count]>0) {
        for (NSDictionary*obj in arry) {
            [self.moviesOfTheAuthorArry addObject:obj];
        }
        [authorListTab reloadData];
        [self readCache];
    }
    else
    {
        NSLog(@"没数据啊-------");
    }
}
///读取缓存
-(void)readCache
{
    NSDictionary *dic =  [[SqCached shareCache] cacheDataForKey:@"aList"];
    NSLog(@"缓存的数据解析是:%@",dic);
}
-(void)requestFailedWithResultDictionary:(NSDictionary *)dic
{
    [Tools closeLoadsign:self.view];
  
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
//初始化刷新视图
//＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark
#pragma methods for creating and removing the header view

-(void)createHeaderView{
    if (_refreshHeaderView && [_refreshHeaderView superview]) {
        [_refreshHeaderView removeFromSuperview];
    }
	_refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:
                          CGRectMake(0.0f, 0.0f - self.view.bounds.size.height,
                                     self.view.frame.size.width, self.view.bounds.size.height)];
    _refreshHeaderView.delegate = self;
    
	[authorListTab addSubview:_refreshHeaderView];
    [_refreshHeaderView refreshLastUpdatedDate];
}

-(void)removeHeaderView{
    if (_refreshHeaderView && [_refreshHeaderView superview]) {
        [_refreshHeaderView removeFromSuperview];
    }
    _refreshHeaderView = nil;
}

-(void)setFooterView{
    // if the footerView is nil, then create it, reset the position of the footer
    CGFloat height = MAX(authorListTab.contentSize.height, authorListTab.frame.size.height);
    if (_refreshFooterView && [_refreshFooterView superview]) {
        // reset position
        _refreshFooterView.frame = CGRectMake(0.0f,
                                              height,
                                              authorListTab.frame.size.width,
                                              authorListTab.bounds.size.height);
    }else {
        // create the footerView
        _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:
                              CGRectMake(0.0f, height,
                                         authorListTab.frame.size.width, self.view.bounds.size.height)];
        _refreshFooterView.delegate = self;
        [authorListTab addSubview:_refreshFooterView];
    }
    if (_refreshFooterView) {
        [_refreshFooterView refreshLastUpdatedDate];
    }
}

-(void)removeFooterView{
    if (_refreshFooterView && [_refreshFooterView superview]) {
        [_refreshFooterView removeFromSuperview];
    }
    _refreshFooterView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

#pragma mark-
#pragma mark force to show the refresh headerView
-(void)showRefreshHeader:(BOOL)animated{
	if (animated)
	{
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		authorListTab.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
        // scroll the table view to the top region
        [authorListTab scrollRectToVisible:CGRectMake(0, 0.0f, 1, 1) animated:NO];
        [UIView commitAnimations];
	}
	else
	{
        authorListTab.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
		[authorListTab scrollRectToVisible:CGRectMake(0, 0.0f, 1, 1) animated:NO];
	}
    
    [_refreshHeaderView setState:EGOOPullRefreshLoading];
}
//===============
//刷新delegate
#pragma mark -
#pragma mark data reloading methods that must be overide by the subclass

-(void)beginToReloadData:(EGORefreshPos)aRefreshPos{
	
	//  should be calling your tableviews data source model to reload
	_reloading = YES;
    
    if (aRefreshPos == EGORefreshHeader) {
        // pull down to refresh data
        [self performSelector:@selector(refreshView) withObject:nil afterDelay:2.0];
    }else if(aRefreshPos == EGORefreshFooter){
        // pull up to load more data
        [self performSelector:@selector(getNextPageView) withObject:nil afterDelay:2.0];
    }
    
	// overide, the actual loading data operation is done in the subclass
}

#pragma mark -
#pragma mark method that should be called when the refreshing is finished
- (void)finishReloadingData{
	
	//  model should call this when its done loading
	_reloading = NO;
    
	if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:authorListTab];
    }
    
    if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:authorListTab];
        [self setFooterView];
    }
    [authorListTab reloadData];
    // overide, the actula reloading tableView operation and reseting position operation is done in the subclass
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:authorListTab];
    }
	if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDidScroll:authorListTab];
        [self setFooterView];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
	
	if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}

#pragma mark EGORefreshTableDelegate Methods
- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos{
	
	[self beginToReloadData:aRefreshPos];
}
- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view{
	
	return _reloading; // should return if data source model is reloading
}
// if we don't realize this method, it won't display the refresh timestamp
- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

//刷新调用的方法----------下拉刷新
-(void)refreshView{
    
    if ([self.moviesOfTheAuthorArry count]>0) {
        [authorListTab reloadData];
    }else
    {
        flag = 0;
        [self getauthorListById];
    }
    
    [self testFinishedLoadData];
    
}
//加载调用的方法----------上拉加载
-(void)getNextPageView{
    [self removeFooterView];
    flag ++;
    [self getauthorListById];
    [self testFinishedLoadData];
    
    
    
}-(void)testFinishedLoadData{
    
    [self finishReloadingData];
    [self setFooterView];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [getAuthorListByAuthorID setDelegate:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];//可以成功取消全部延迟方法。
}

@end
