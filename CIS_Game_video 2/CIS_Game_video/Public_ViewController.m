//
//  Public_ViewController.m
//  CIS_Game_video
//
//  Created by huangfangwang on 13-7-16.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "Public_ViewController.h"
#import "Header.h"
#import "Tools.h"
#import "MyNsstringTools.h"
#import "RequestUrls.h"
#import "CategoryListCell.h"
@interface Public_ViewController ()

@end

@implementation Public_ViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    self.myArry = [NSMutableArray arrayWithCapacity:2];

    flag=1;
    [self setNenwCategory:@""];
    [self setOldCategory:@"huangfang"];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"我的收藏"];
    [Tools navigaionView:self deckVC:self.viewDeckController leftImageName:@"goBack.png"];
        //编辑按钮
    eiditBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    eiditBtn.frame = CGRectMake(280, 0, 40, 30);
    [eiditBtn addTarget:self action:@selector(setEditing:animated:) forControlEvents:UIControlEventTouchUpInside];
    [eiditBtn setBackgroundImage:[UIImage imageNamed:@"qie_110.png"] forState:UIControlStateNormal];
    UIBarButtonItem *eiditBar = [[UIBarButtonItem alloc] initWithCustomView:eiditBtn];
    self.navigationItem.rightBarButtonItem = eiditBar;
    [eiditBar release];
    //游戏类别分类
     NSArray * nameArry = [NSArray arrayWithObjects:@"全部",@"英雄联盟",@"DOTA",@"DOTA2",@"魔兽争霸3",@"星际大战2", nil];
    UISegmentedControl * segment = [[UISegmentedControl alloc]initWithItems:nameArry];
    [segment setSegmentedControlStyle:UISegmentedControlStyleBar];
    [segment setFrame:CGRectMake(0, 0, 320, 35)];
    [self.view addSubview:segment];
    [segment addTarget:self action:@selector(segementAction:) forControlEvents:UIControlEventValueChanged];
    [segment setTintColor:[UIColor colorWithRed:95/255.0 green:112/255.0 blue:38/255.0 alpha:1]];
    [segment setSelectedSegmentIndex:0];//初始化的时候显示的
    [segment release];
    
    self.showTab = [[UITableView alloc]initWithFrame:CGRectMake(0, segment.bottom, 320, self.view.height-44-segment.height) style:UITableViewStylePlain];
    [_showTab setDelegate:self];
    [_showTab setDataSource:self];
    [self.view addSubview:_showTab];
    [_showTab release];
    [Tools openLoadsign:self.view WithString:@"正在为你回调数据....."];
    [self createHeaderView];
    [self setFooterView];
    [self requestCategoryList];
}
-(void)segementAction:(UISegmentedControl *)sender
{
    flag = 1;
    if ([sender selectedSegmentIndex]==0) {
        self.nenwCategory = @"";
    }else{
        [self setNenwCategory:[sender titleForSegmentAtIndex:[sender selectedSegmentIndex]]];
    }
    [self requestCategoryList];
}
#pragma mark-- tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.myArry count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * mark = @"mark";
    CategoryListCell * cell = [tableView dequeueReusableCellWithIdentifier:mark];
    if (nil==cell) {
        cell = [[CategoryListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mark];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    if ([self.myArry count]==0) {
        return cell;
    }
    [cell.asImageView setImageURL:[MyNsstringTools changeStrWithUT8:[[self.myArry objectAtIndex:indexPath.row] valueForKey:@"thumbnail"]]];
    [cell.nameLabel setText:[[self.myArry objectAtIndex:indexPath.row] valueForKey:@"movieName"]];
    [cell setVideoID:[[self.myArry objectAtIndex:indexPath.row] valueForKey:@"movieID"]];
    [cell.attentionTimeLabel setText:[NSString stringWithFormat:@"%@",[[self.myArry objectAtIndex:indexPath.row] valueForKey:@"popular"]]];
    [cell.timeLabel setText:[[self.myArry objectAtIndex:indexPath.row] valueForKey:@"duration"]];
    return cell;
}
#pragma mark--cell删除
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(done)];
    [eiditBtn addGestureRecognizer:tap];
    [tap release];
    [_showTab setEditing:editing animated:animated];
}
- (void)done{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setEditing:animated:)];
    [eiditBtn addGestureRecognizer:tap];
    [tap release];
    [_showTab setEditing:NO animated:YES];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
#pragma mark--cell删除样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
#pragma mark--cell删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        //写删除方法
        
        CategoryListCell * cell = (CategoryListCell *)[tableView cellForRowAtIndexPath:indexPath];
        RequestTools *collectRequest = [[RequestTools alloc] init];
        [collectRequest setDelegate:self];
        
        NSArray *strArry = [NSArray arrayWithObjects:COLLECT_VIDOE,[NSString stringWithFormat:@"?email=1823870397@qq.com&movieID=%@&cancelLiked=%d",cell.videoID,1], nil];
        [collectRequest requestWithUrl_Asynchronous:[MyNsstringTools groupStrByAStrArray:strArry]];

        [self.myArry removeObjectAtIndex:indexPath.row];
        [_showTab reloadData];
    }
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
    
	[_showTab addSubview:_refreshHeaderView];
    
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
    CGFloat height = MAX(_showTab.contentSize.height, _showTab.frame.size.height);
    if (_refreshFooterView && [_refreshFooterView superview]) {
        // reset position
        _refreshFooterView.frame = CGRectMake(0.0f,
                                              height,
                                              _showTab.frame.size.width,
                                              _showTab.bounds.size.height);
    }else {
        // create the footerView
        _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:
                              CGRectMake(0.0f, height,
                                         _showTab.frame.size.width, self.view.bounds.size.height)];
        _refreshFooterView.delegate = self;
        [_showTab addSubview:_refreshFooterView];
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
		_showTab.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
        // scroll the table view to the top region
        [_showTab scrollRectToVisible:CGRectMake(0, 0.0f, 1, 1) animated:NO];
        [UIView commitAnimations];
	}
	else
	{
        _showTab.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
		[_showTab scrollRectToVisible:CGRectMake(0, 0.0f, 1, 1) animated:NO];
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
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_showTab];
    }
    
    if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:_showTab];
        [self setFooterView];
    }
    [_showTab reloadData];
    // overide, the actula reloading tableView operation and reseting position operation is done in the subclass
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:_showTab];
    }
	
	if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDidScroll:_showTab];
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
    flag = 1;
    [self requestCategoryList];
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
    self.request = [[RequestTools alloc]init] ;
    [_request setDelegate:self];
    NSArray *strArry = [NSArray arrayWithObjects:VIDOE_LIST,[NSString stringWithFormat:@"?isLikelist=%d&dataPage=%d&email=%@&category=%@",1,flag,@"1823870397@qq.com",self.nenwCategory],nil];
    [_request requestWithUrl_Asynchronous:[MyNsstringTools groupStrByAStrArray:strArry]];
}
//请求成功i
-(void)requestSuccessWithResultDictionary:(NSDictionary *)dic
{
    [Tools closeLoadsign:self.view];
    NSArray * arry =[dic valueForKey:@"result"];
    //NSLog(@"这个几个数据---%@",dic);
    if ([self checkCategory]&&flag==1) {
        
        if ([[dic valueForKey:@"count"]integerValue] ==0){
            [Tools addTipslabelWithTitle:@"没有了哦......"];
            NSLog(@"-----");
        }
        [self.myArry removeAllObjects];
        for (NSDictionary*obj in arry) {
            [self.myArry addObject:obj];
            
        }
        [_showTab reloadData];
        return;
    }
    else if([arry count]>0&&flag>=1&&![self checkCategory])
    {
        for (NSDictionary*obj in arry) {
            [self.myArry addObject:obj];
        }
        [_showTab reloadData];
        return;

    }else if ([[dic valueForKey:@"count"]integerValue] ==0){
        [Tools addTipslabelWithTitle:@"没有了哦......"];
        NSLog(@"-----");
        return;
    }
}
-(BOOL)checkCategory
{
    if ([self.oldCategory isEqualToString:self.nenwCategory]) {
        return NO;//相同的时候
    }else
    {
        [self setOldCategory:self.nenwCategory];
        return YES;//不同的时候
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
