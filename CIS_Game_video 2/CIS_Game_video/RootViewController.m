//
//  RootViewController.m
//  CIS_Game_video
//
//  Created by huangfangwang on 13-7-15.
//  Copyright (c) 2013年 huangfang. All rights reserved.
#import "RootViewController.h"
#import "Header.h"
#import "MovieCell.h"
#import "AuthorCell.h"
#import "AuthorMoviesListPage.h"
#import "AppDelegate.h"
#import "Tools.h"
#import "MovieDetailPage.h"
#import "HMSegmentedControl.h"
#import "RequestUrls.h"
#import "RequestTools.h"
#import "MyNsstringTools.h"
#import "CategoryListViewController.h"
@interface RootViewController ()
@end
@implementation RootViewController
- (void)dealloc
{
    [rootAuthorListTab release];;
    [_dataList release];
    [animationView release];
    self.rootRequest = nil;
    self.selectIndex = nil;
    [rootView release];
    self.collectResultDic = nil;

    categorySegmentedControl = nil;
    rootRefreshView = nil;
    self.rootBannerArry = nil;
    [staticCateGoryStr release];
    [_authorListArray release],_authorListArray = nil;
    [categorySegmentedControl release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSString *path  = [[NSBundle mainBundle] pathForResource:@"ExpansionTableTestData" ofType:@"plist"];
        //数据源为一个大数组,里面内嵌字典或者小数组等,可变化.
        _dataList = [[NSMutableArray alloc] initWithContentsOfFile:path];
        _authorListArray = [NSArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [Tools navigaionView:self deckVC:self.viewDeckController leftImageName:@"myFriends.png" rightImageName:@"myFriends.png" title:@"幻方"];
//首页界面
     rootView = [[DefaultRootView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.height-44)];
    [rootView addTarget:self action:@selector(transportVideoInformation:)];
    [self.view addSubview:rootView];
    [rootView setDelegate:self];
    
    //[Tools makeOneCautionViewOnView:self.view withString:@"啊啊啊啊啊啊啊啊"];
    
}
#pragma mark-----DefaultRootView代理
-(void)transferCategoryWithCategoryName:(NSString *)CategoryName
{
    CategoryListViewController * Category = [[CategoryListViewController alloc]init];
    [Category setTitle:CategoryName];
    [self.navigationController pushViewController:Category animated:YES];
    [Category release];
}
#pragma mark--切换浏览模式
-(void)topRightCorenerBtnAction
{
    if (!rootAuthorListTab) {
        [self rootAuthorListTab];
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.viewDeckController.view cache:YES];
    if (rootAuthorListTab.hidden == YES) {
        rootAuthorListTab.hidden = NO;
        rootView.hidden  = YES;
    }
    else{
        rootAuthorListTab.hidden =YES;
        rootView.hidden = NO;
    }
    
    [UIView commitAnimations];
}
-(void)rootAuthorListTab
{
    
    
    /*/配置默认界面/*/
    rootAuthorListTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.height) style:UITableViewStylePlain];
    rootAuthorListTab.delegate = self;
    rootAuthorListTab.dataSource = self;
    rootAuthorListTab.sectionFooterHeight = 0;
    rootAuthorListTab.sectionHeaderHeight = 0;
    self.isOpen = NO;
    rootAuthorListTab.hidden = YES;
    ///
    rootRefreshView = [[SRRefreshView alloc] init];
    rootRefreshView.delegate = self;
    rootRefreshView.upInset = 0;
    rootRefreshView.slimeMissWhenGoingBack = YES;
    rootRefreshView.slime.bodyColor = [UIColor blackColor];
    rootRefreshView.slime.skinColor = [UIColor blackColor];
    rootRefreshView.slime.lineWith = 5;
    rootRefreshView.activityIndicationView.color = [UIColor blackColor];
    ///
    [rootAuthorListTab addSubview:rootRefreshView];
    [self.view addSubview:rootAuthorListTab];
    /*/翻转后的页面/*/
    //测试
    self.rootRequest = [[RequestTools alloc]init];
    [_rootRequest setDelegate:self];
    NSArray *strArry = [NSArray arrayWithObjects:AUTHOR_LIST,@"?category=dota",nil];
    [_rootRequest requestWithUrl_Asynchronous:[MyNsstringTools groupStrByAStrArray:strArry]];
    [Tools openLoadsign:self.view WithString:@"正在加载..."];
}
#pragma mark--系统列表代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.row==0) {
            if (indexPath.section == 0&&indexPath.row==0) {
               return  40;
            }
            return 50;
        }else
        {
        return 120;
        }
}
//根据数据源,判断有几个分组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     NSLog(@"you jige%d",[_dataList count]);
     //分组来自于整个数据源内部统一属性比如作者数据的个数
    return [_authorListArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        //如果是打开状态,分组内的行数根据数据数量返回,
        if (self.isOpen) {
            if (self.selectIndex.section == section) {
                 int contentCount = [[[self.authorListArray objectAtIndex:section] objectForKey:@"movies"] count];
                return contentCount+1;
            }
        }
        //如果是关闭状态,则返回一个
        return 1;
}
#pragma mark--系统列表的代理方法
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (self.isOpen&&self.selectIndex.section == indexPath.section&&indexPath.row!=0)
        //打开了分组CELL
    {
        static NSString *CellIdentifier = @"Cell2";
        //可用自定义的cell替代展开列表中的CELL.
        MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[[MovieCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.categoryLabel.hidden = YES;
        }
        //根据数据源和下标配置展开cell内容,注意书写位置
        NSArray *list = [[self.authorListArray objectAtIndex:self.selectIndex.section] objectForKey:@"movies"];
                    cell.titleLabel.text = [[list objectAtIndex:indexPath.row-1] objectForKey:@"movieName"];
        cell.timeLab.text = [[list objectAtIndex:indexPath.row-1] objectForKey:@"m_duration"];
        NSString *popularStr = [NSString stringWithFormat:@"%@",[[list objectAtIndex:indexPath.row-1] objectForKey:@"m_popular"]];
        cell.popularLab.text =popularStr ;
       cell.logoImageView.imageURL = [MyNsstringTools changeStrWithUT8:[[list objectAtIndex:indexPath.row-1] objectForKey:@"thumbnail"]];
        [cell.collectBtn setTag:indexPath.row-1];//给收藏按钮加上标记值方便进行收藏操作
        [cell.collectBtn addTarget:self action:@selector(collectMovie:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else
        //没有打开分组CELL
    {
        //大分组的CEll样式
        static NSString *CellIdentifier = @"Cell1";
        AuthorCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[[AuthorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        //根据数据源配置分组CELL样式
        NSString *name = [[self.authorListArray objectAtIndex:indexPath.section] objectForKey:@"author"];
        cell.nameLabel.text = name;
        cell.countLabel.text = [NSString stringWithFormat:@"%@部",[[self.authorListArray objectAtIndex:indexPath.section] objectForKey:@"opusCount"]];
        [cell.moreBtn setTag:indexPath.section];
        [cell.moreBtn addTarget:self action:@selector(getAuthorlist:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}
-(void)getAuthorlist:(UIButton *)sender
{
    NSLog(@"找不到你了.........");
    //根据标记值渠道对应的作者ID,请求推进到作者作品列表
    AuthorMoviesListPage *authorMoviesList = [[AuthorMoviesListPage alloc] init];
    authorMoviesList.authorIDStr = [[self.authorListArray objectAtIndex:sender.tag] objectForKey:@"authorID"];
    authorMoviesList.authorNameStr = [[self.authorListArray objectAtIndex:sender.tag] objectForKey:@"author"];
    [self.navigationController pushViewController:authorMoviesList animated:YES];
    [authorMoviesList release];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击分组CELL和展开CELL时的不同响应.
    if (indexPath.row == 0)
    {
        if ([indexPath isEqual:self.selectIndex]) {
            self.isOpen = NO;
            [self didSelectCellRowFirstDo:NO nextDo:NO];
            self.selectIndex = nil;
        }else
        {
            if (!self.selectIndex) {
                self.selectIndex = indexPath;
                [self didSelectCellRowFirstDo:YES nextDo:NO];
            }else
            {
                [self didSelectCellRowFirstDo:NO nextDo:YES];
            }
        }
    }else
    {
        //点击展开的小Cell的方法写在这里,根据下标判断
     NSString *movieID =    [[[[self.authorListArray objectAtIndex:self.selectIndex.section] objectForKey:@"movies"] objectAtIndex:indexPath.row-1]objectForKey:@"movieID"];
        [self getTheMovieDetailInfoByMovieId:movieID];//前往详情页面
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark--此为展开闭合的列表代理方法
- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
{
    self.isOpen = firstDoInsert;
    //根据传进的布尔值,确定分组指示器的图标样式.并把布尔值会传到自定义cell中去.
    AuthorCell *cell = (AuthorCell *)[rootAuthorListTab cellForRowAtIndexPath:self.selectIndex];
    [cell changeArrowWithUp:firstDoInsert];
    [rootAuthorListTab beginUpdates];
    int section = self.selectIndex.section;
    int contentCount = [[[self.authorListArray objectAtIndex:section] objectForKey:@"movies"] count];
	NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
	for (NSUInteger i = 1; i < contentCount + 1; i++) {
		NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
		[rowToInsert addObject:indexPathToInsert];
	}
	if (firstDoInsert)
    {   [rootAuthorListTab insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
        NSLog(@"展开了");
    }
	else
    {
        [rootAuthorListTab deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
        NSLog(@"关闭了");
    }
	[rowToInsert release];
	[rootAuthorListTab endUpdates];
    if (nextDoInsert) {
        self.isOpen = YES;
        self.selectIndex = [rootAuthorListTab indexPathForSelectedRow];
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
    if (self.isOpen) [rootAuthorListTab scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
}
#pragma mark--配置滚动时轮显视图伴随
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        if (tableView == rootAuthorListTab) {
        if (section == 0) {
            return self.view.height/3;
        }
    }
    return 0;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
        if (section==0) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 20)] ;//创建一个视图
        headerView.backgroundColor = [UIColor redColor];
        //滑动推荐
        animationView = [[Animation_Turn_View alloc]initWithFrame:CGRectMake(0, 5, 320, self.view.height/3-37)];
        [animationView setSlideArry:self.rootBannerArry];
        [animationView addChildViews];

        [headerView addSubview:animationView];
        [animationView setDelegate:self];
        /*/分类标签/*/
        categorySegmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, animationView.bottom-2, 320, 32)];
            [categorySegmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
        NSArray * nameArry = [NSArray arrayWithObjects:@"英雄联盟",@"Dota",@"魔兽争霸",@"Dota2", @"星际争霸",nil];
        [categorySegmentedControl setSectionTitles:nameArry];
        [categorySegmentedControl setSelectionIndicatorHeight:5.0f];
            NSString *indexStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"index"];
            int index = [indexStr intValue];
            categorySegmentedControl.selectedIndex  = index;
        [categorySegmentedControl setBackgroundColor:[UIColor colorWithRed:205.0f/232.0f green:232.0f/255.0f blue:232.0f/255.0f alpha:1.0f]];
        [categorySegmentedControl setTextColor:[UIColor colorWithRed:47.0f/255.0f green:79.0f/255.0f blue:79.0f/255.0f alpha:0.8f]];
        [categorySegmentedControl setSelectionIndicatorColor:[UIColor colorWithRed:52.0f/255.0f green:181.0f/255.0f blue:229.0f/255.0f alpha:0.8f]];
        [categorySegmentedControl setSelectionIndicatorMode:
         HMSelectionIndicatorFillsSegment];
        [categorySegmentedControl setSegmentEdgeInset:UIEdgeInsetsMake(0, 5, 5, 0)];
        [categorySegmentedControl setTag:2];
        [headerView addSubview:categorySegmentedControl];
        rootAuthorListTab.tableHeaderView = headerView;
        return [headerView autorelease];
    }
    return nil;
}
#pragma mark--Banner的代理方法
-(void)transportVideoInformation:(NSString *)imageID
{
    NSLog(@"有没有传过来");
    [self getTheMovieDetailInfoByMovieId:imageID];
}
#pragma  mark--根据视频ID请求视频详情
-(void)getTheMovieDetailInfoByMovieId:(NSString *)movieID
{
    MovieDetailPage *detailPage = [[MovieDetailPage alloc] init];
    detailPage.movieId = movieID;
    [self.navigationController pushViewController:detailPage animated:YES];
    [detailPage release];
}
#pragma mark--视频收藏
-(void)collectMovie:(UIButton *)sender
{
 
    NSString *movieIDStr = [[[[self.authorListArray objectAtIndex:self.selectIndex.section] objectForKey:@"movies"] objectAtIndex:sender.tag]objectForKey:@"movieID"];
    NSLog(@"用来被收藏的视频ID是:%@",movieIDStr);
    RequestTools *collectRequest = [[RequestTools alloc] init];
    [collectRequest setDelegate:self];
    NSArray *strArry = [NSArray arrayWithObjects:COLLECT_VIDOE,@"?email=1823870397@qq.com&movieID=",movieIDStr, nil];
    [collectRequest requestWithUrl_Asynchronous:[MyNsstringTools groupStrByAStrArray:strArry]];
    //进行按钮颜色的变化等.
 }
#pragma mark--发起请求
-(void)startRequestWithCateStr:cateStr
{
   cateStr = cateStr==NULL?@"dota":cateStr;
    staticCateGoryStr = cateStr;
    NSString *newCateStr = [NSString stringWithFormat:@"?category=%@",cateStr];
    NSArray *strArry = [NSArray arrayWithObjects:AUTHOR_LIST,newCateStr,nil];
    [_rootRequest requestWithUrl_Asynchronous:[MyNsstringTools groupStrByAStrArray:strArry]];
    [Tools openLoadsign:self.view WithString:@"正在加载..."];

}
#pragma mark--请求的回调方法
-(void)requestSuccessWithResultDictionary:(NSDictionary *)dic
{
    [Tools closeLoadsign:self.view];
    [rootRefreshView endRefresh];

    if ([[dic allKeys] containsObject:@"AuthorResult"]==YES) {
        NSLog(@"字典是:%@",dic);
        self.authorListArray = [dic objectForKey:@"AuthorResult"];
        self.rootBannerArry = [dic objectForKey:@"bannerResult"];
        [rootAuthorListTab reloadData];
    } else
    {
        self.collectResultDic = dic;
    }
}
#pragma mark--标签选中的代理方法
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl
{
	NSLog(@"选中的是: %i", segmentedControl.selectedIndex);
    NSString *indexStr = [NSString stringWithFormat:@"%i",segmentedControl.selectedIndex];
    [[NSUserDefaults standardUserDefaults] setObject:indexStr forKey:@"index"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    switch (segmentedControl.selectedIndex) {
        case 0:
            [self startRequestWithCateStr:@"英雄联盟"];
            break;
            case 1:
            [self startRequestWithCateStr:@"dota"];
            break;
        case 2:
            [self startRequestWithCateStr:@"魔兽争霸3"];
            break;
        case 3:
            [self startRequestWithCateStr:@"dota2"];
            break;
        case 4:
            [self startRequestWithCateStr:@"星际大战2"];
            break;
        default:
            break;
    }
}
-(void)requestFailedWithResultDictionary:(NSDictionary *)dic
{
    [rootRefreshView endRefresh];
    [Tools closeLoadsign:self.view];


    
}
#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [rootRefreshView scrollViewDidScroll];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [rootRefreshView scrollViewDidEndDraging];
}
#pragma mark - 水滴下拉刷新
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    [self startRequestWithCateStr:staticCateGoryStr];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.rootRequest  setDelegate:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.rootRequest  setDelegate:self];

}
@end
