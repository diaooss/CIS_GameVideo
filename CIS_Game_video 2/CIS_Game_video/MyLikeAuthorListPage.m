//
//  MyLikeAuthorListPage.m
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-7-18.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "MyLikeAuthorListPage.h"
#import "Header.h"
#import "MyFavorAuthorCell.h"
#import "Tools.h"
#import "RequestTools.h"
#import "RequestUrls.h"
#import "MyNsstringTools.h"
@interface MyLikeAuthorListPage ()

@end

@implementation MyLikeAuthorListPage
- (void)dealloc
{
    [likeAuthorListTab release];
    self.myLikeAuthorListDic = nil;
    [getMyLikeAuthorListRequest setDelegate:nil];
    [getMyLikeAuthorListRequest release];
    [likeAuthorListHeaderView release];
    [likeAuthorListFooterView release];
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
    [self.view setBackgroundColor:[UIColor brownColor]];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [Tools navigaionView:self deckVC:self.viewDeckController leftImageName:@"goBack.png" title:@"我的关注"];
    
    likeAuthorListTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-44) style:UITableViewStylePlain];
    likeAuthorListTab.dataSource = self;
    likeAuthorListTab.delegate = self;
    [self.view addSubview:likeAuthorListTab];
    [self setFooterView];
    [self createHeaderView];
    flag = 1;
    [self getMyLikeAuthorListDic];

}
#pragma mark--抓取到关注列表
-(void)getMyLikeAuthorListDic
{
    getMyLikeAuthorListRequest = [[RequestTools alloc] init];
    NSString *emailStr = [NSString stringWithFormat:@"?email=1601883700@qq.com"];
    getMyLikeAuthorListRequest.delegate = self;
    NSArray *strArry  =[NSArray arrayWithObjects:AUTHOR_LIST,emailStr,@"&isCarelist=1&dataPage=1", nil];
    [getMyLikeAuthorListRequest requestWithUrl_Asynchronous:[MyNsstringTools groupStrByAStrArray:strArry]];
}
#pragma mark--列表代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.myLikeAuthorListDic objectForKey:@"AuthorCount"] integerValue];//值转换
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseName = @"reuse";
     MyFavorAuthorCell*myCell = [tableView dequeueReusableCellWithIdentifier:reuseName ];
    if (myCell== nil) {
        myCell = [[[MyFavorAuthorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseName] autorelease];
        //左扫手势
               UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:myCell action:@selector(cancelLike)];
        [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
               [myCell addGestureRecognizer:swipeLeft];
                //右扫手势
                UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:myCell action:@selector(cancelLike)];
                [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
                [myCell addGestureRecognizer:swipeRight];
                //长按手势
                UILongPressGestureRecognizer *longPressCell = [[UILongPressGestureRecognizer alloc] initWithTarget:myCell action:@selector(cancelLike)];
                [myCell addGestureRecognizer:longPressCell];
        //书写取消按钮方法
//        [myCell.favorBtn addTarget:<#(id)#> action:<#(SEL)#> forControlEvents:<#(UIControlEvents)#>]
               [longPressCell release];
        [swipeLeft release];
        [swipeRight release];

        myCell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    myCell.authorNameLabel.text = [[[self.myLikeAuthorListDic objectForKey:@"AuthorResult"] objectAtIndex:indexPath.row] objectForKey:@"author"];
    NSString *popStr = [MyNsstringTools makeNewStrByAnyObj:[[[self.myLikeAuthorListDic objectForKey:@"AuthorResult"] objectAtIndex:indexPath.row] objectForKey:@"popular"]];
    myCell.popularLab.text = popStr;
    NSString *countStr  = [MyNsstringTools makeNewStrByAnyObj:[[[self.myLikeAuthorListDic objectForKey:@"AuthorResult"] objectAtIndex:indexPath.row] objectForKey:@"opusCount"]];
    myCell.countLab.text = countStr;

        myCell.authorLogoView.imageURL = [[[self.myLikeAuthorListDic objectForKey:@"AuthorResult"] objectAtIndex:indexPath.row] objectForKey:@"photo"];

       
    return myCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark--请求的代理方法
-(void)requestSuccessWithResultDictionary:(NSDictionary *)dic
{
    NSLog(@"关注列表%@",dic);
    self.myLikeAuthorListDic = dic;
    [likeAuthorListTab reloadData];
    
}
-(void)requestFailedWithResultDictionary:(NSDictionary *)dic
{
    
}
//初始化刷新视图
//＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark
#pragma methods for creating and removing the header view

-(void)createHeaderView{
    if (likeAuthorListHeaderView && [likeAuthorListHeaderView superview]) {
        [likeAuthorListHeaderView removeFromSuperview];
    }
	likeAuthorListHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:
                          CGRectMake(0.0f, 0.0f - self.view.bounds.size.height,
                                     self.view.frame.size.width, self.view.bounds.size.height)];
    likeAuthorListHeaderView.delegate = self;
    
	[likeAuthorListTab addSubview:likeAuthorListHeaderView];
    [likeAuthorListHeaderView refreshLastUpdatedDate];
}

-(void)removeHeaderView{
    if (likeAuthorListHeaderView && [likeAuthorListHeaderView superview]) {
        [likeAuthorListHeaderView removeFromSuperview];
    }
    likeAuthorListHeaderView = nil;
}

-(void)setFooterView{
    // if the footerView is nil, then create it, reset the position of the footer
    CGFloat height = MAX(likeAuthorListTab.contentSize.height, likeAuthorListTab.frame.size.height);
    if (likeAuthorListFooterView && [likeAuthorListFooterView superview]) {
        // reset position
        likeAuthorListFooterView.frame = CGRectMake(0.0f,
                                              height,
                                              likeAuthorListTab.frame.size.width,
                                              likeAuthorListTab.bounds.size.height);
    }else {
        // create the footerView
        likeAuthorListFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:
                              CGRectMake(0.0f, height,
                                         likeAuthorListTab.frame.size.width, self.view.bounds.size.height)];
        likeAuthorListFooterView.delegate = self;
        [likeAuthorListTab addSubview:likeAuthorListFooterView];
    }
    if (likeAuthorListFooterView) {
        [likeAuthorListFooterView refreshLastUpdatedDate];
    }
}

-(void)removeFooterView{
    if (likeAuthorListFooterView && [likeAuthorListFooterView superview]) {
        [likeAuthorListFooterView removeFromSuperview];
    }
    likeAuthorListFooterView = nil;
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
		likeAuthorListTab.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
        // scroll the table view to the top region
        [likeAuthorListTab scrollRectToVisible:CGRectMake(0, 0.0f, 1, 1) animated:NO];
        [UIView commitAnimations];
	}
	else
	{
        likeAuthorListTab.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
		[likeAuthorListTab scrollRectToVisible:CGRectMake(0, 0.0f, 1, 1) animated:NO];
	}
    
    [likeAuthorListHeaderView setState:EGOOPullRefreshLoading];
}
//===============
//刷新delegate
#pragma mark -
#pragma mark data reloading methods that must be overide by the subclass

-(void)beginToReloadData:(EGORefreshPos)aRefreshPos{
	
	//  should be calling your tableviews data source model to reload
	isLoading = YES;
    
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
	isLoading = NO;
    
	if (likeAuthorListHeaderView) {
        [likeAuthorListHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:likeAuthorListTab];
    }
    
    if (likeAuthorListFooterView) {
        [likeAuthorListFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:likeAuthorListTab];
        [self setFooterView];
    }
    [likeAuthorListTab reloadData];
    // overide, the actula reloading tableView operation and reseting position operation is done in the subclass
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	if (likeAuthorListHeaderView) {
        [likeAuthorListHeaderView egoRefreshScrollViewDidScroll:likeAuthorListTab];
    }
	if (likeAuthorListFooterView) {
        [likeAuthorListFooterView egoRefreshScrollViewDidScroll:likeAuthorListTab];
        [self setFooterView];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	if (likeAuthorListHeaderView) {
        [likeAuthorListHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
	
	if (likeAuthorListFooterView) {
        [likeAuthorListFooterView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}

#pragma mark EGORefreshTableDelegate Methods
- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos{
	
	[self beginToReloadData:aRefreshPos];
}
- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view{
	
	return isLoading; // should return if data source model is reloading
}
// if we don't realize this method, it won't display the refresh timestamp
- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

//刷新调用的方法----------下拉刷新
-(void)refreshView{
    
        
    [self testFinishedLoadData];
    
}
//加载调用的方法----------上拉加载
-(void)getNextPageView{
    [self removeFooterView];
    flag ++;
    [self getMyLikeAuthorListDic];
   
    [self testFinishedLoadData];
    
    
    
}-(void)testFinishedLoadData{
    
    [self finishReloadingData];
    [self setFooterView];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [getMyLikeAuthorListRequest setDelegate:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];//可以成功取消全部延迟方法。
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
