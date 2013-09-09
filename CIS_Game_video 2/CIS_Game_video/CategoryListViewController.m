//
//  CategoryListViewController.m
//  CIS_Game_video
//
//  Created by huangfangwang on 13-9-3.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "CategoryListViewController.h"
#import "CategoryListCell.h"
#import "MovieDetailPage.h"
#import "MyNsstringTools.h"
#import "RequestUrls.h"
#import "MyNsstringTools.h"
#import "Tools.h"
@interface CategoryListViewController ()

@end

@implementation CategoryListViewController
-(void)dealloc
{
    [_refreshHeaderView release];
    [_refreshFooterView release];
    [self.categoryArry release];
    [self setCategoryRequest:nil];
    [_categoryTable release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    self.categoryArry = [NSMutableArray arrayWithCapacity:2];
    
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [Tools navigaionView:self leftImageName:@"goBack.png"];
    _categoryTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 440)];
    [Tools navigaionView:self leftImageName:@"goBack.png" rightImageName:nil title:self.title];

    _categoryTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-44)];
    [_categoryTable setDelegate:self];
    [_categoryTable setDataSource:self];
    [self.view addSubview:_categoryTable];
//第一次请求数据
    [self requestCategoryList];
//加载下拉加载 和上啦刷新
    [self createHeaderView];
    [self setFooterView];
}

//导航条 返回事件
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ====tableView代理
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.categoryArry count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * mark = @"mark";
    CategoryListCell * cell = [tableView dequeueReusableCellWithIdentifier:mark];
    if (nil==cell) {
        cell = [[CategoryListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mark];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    if ([self.categoryArry count]==0) {
        return cell;
    }
        [cell.asImageView setImageURL:[MyNsstringTools changeStrWithUT8:[[_categoryArry objectAtIndex:indexPath.row] valueForKey:@"thumbnail"]]];
        [cell.nameLabel setText:[[_categoryArry objectAtIndex:indexPath.row] valueForKey:@"movieName"]];
        [cell setVideoID:[[_categoryArry objectAtIndex:indexPath.row] valueForKey:@"movieID"]];
        [cell.attentionTimeLabel setText:[NSString stringWithFormat:@"%@",[[_categoryArry objectAtIndex:indexPath.row] valueForKey:@"popular"]]];
        [cell.timeLabel setText:[[_categoryArry objectAtIndex:indexPath.row] valueForKey:@"duration"]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryListCell * cell = (CategoryListCell *)[tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MovieDetailPage *detailPage = [[MovieDetailPage alloc] init];
    [detailPage setMovieId:cell.videoID];
    [self.navigationController pushViewController:detailPage animated:YES];
    [detailPage release];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
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
    
	[_categoryTable addSubview:_refreshHeaderView];
    
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
    CGFloat height = MAX(_categoryTable.contentSize.height, _categoryTable.frame.size.height);
    if (_refreshFooterView && [_refreshFooterView superview]) {
        // reset position
        _refreshFooterView.frame = CGRectMake(0.0f,
                                              height,
                                              _categoryTable.frame.size.width,
                                              _categoryTable.bounds.size.height);
    }else {
        // create the footerView
        _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:
                              CGRectMake(0.0f, height,
                                         _categoryTable.frame.size.width, self.view.bounds.size.height)];
        _refreshFooterView.delegate = self;
        [_categoryTable addSubview:_refreshFooterView];
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
		_categoryTable.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
        // scroll the table view to the top region
        [_categoryTable scrollRectToVisible:CGRectMake(0, 0.0f, 1, 1) animated:NO];
        [UIView commitAnimations];
	}
	else
	{
        _categoryTable.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
		[_categoryTable scrollRectToVisible:CGRectMake(0, 0.0f, 1, 1) animated:NO];
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
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_categoryTable];
    }
    
    if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:_categoryTable];
        [self setFooterView];
    }
    [_categoryTable reloadData];
    // overide, the actula reloading tableView operation and reseting position operation is done in the subclass
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:_categoryTable];
    }
	
	if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDidScroll:_categoryTable];
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


#pragma mark -
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
//下拉刷新--------
    if ([self.categoryArry count]>0) {
        [self testFinishedLoadData];
    }else
    {
        flag = 1;
        [self requestCategoryList];
    }
    
    [self testFinishedLoadData];
    
}
//加载调用的方法----------上拉加载
-(void)getNextPageView{
    [self removeFooterView];
    flag ++;
    [self requestCategoryList];
    [self testFinishedLoadData];
}-(void)testFinishedLoadData{
    
    [self finishReloadingData];
    [self setFooterView];
}
//请求网络
-(void)requestCategoryList
{
    self.categoryRequest = [[RequestTools alloc]init] ;
    [_categoryRequest setDelegate:self];
    NSArray *strArry = [NSArray arrayWithObjects:VIDOE_LIST,[NSString stringWithFormat:@"?category=%@&dataPage=%d",self.title,flag],nil];
    [_categoryRequest requestWithUrl_Asynchronous:[MyNsstringTools groupStrByAStrArray:strArry]];
}
//请求成功i
-(void)requestSuccessWithResultDictionary:(NSDictionary *)dic
{
    NSArray * arry =[dic valueForKey:@"result"];
    if ([arry count]>0) {
        for (NSDictionary*obj in arry) {
            [self.categoryArry addObject:obj];
        }
        [_categoryTable reloadData];
    }
    else
    {
        //数据被加载完成 提示用户已经加载完成-------没有数据
        NSLog(@"没数据啊-------");
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];//可以成功取消全部。
    [_categoryRequest setDelegate:nil];
    
}
@end
