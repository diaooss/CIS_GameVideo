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
    categorySegmentedControl = nil;
    [_authorListArray release],_authorListArray = nil;
    [categorySegmentedControl release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //使用测试数据
        NSString *path  = [[NSBundle mainBundle] pathForResource:@"ExpansionTableTestData" ofType:@"plist"];
        //数据源为一个大数组,里面内嵌字典或者小数组等,可变化.
        _dataList = [[NSMutableArray alloc] initWithContentsOfFile:path];
        _authorListArray = [NSArray array];
    }
    return self;
}
-(void)loadView
{
    self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [Tools navigaionView:self deckVC:self.viewDeckController leftImageName:@"myFriends.png" rightImageName:@"myFriends.png" title:@"幻方"];
    /*/配置默认界面/*/
    
    //列表展示
    //代理方法中,要记得判断是在对哪一个列表进行的操作!!!!
    rootAuthorListTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.height-44) style:UITableViewStylePlain];
    rootAuthorListTab.delegate = self;
    rootAuthorListTab.dataSource = self;
    rootAuthorListTab.sectionFooterHeight = 0;
    rootAuthorListTab.sectionHeaderHeight = 0;
    self.isOpen = NO;
    rootAuthorListTab.hidden = NO;
    [self.view addSubview:rootAuthorListTab];
    //测试
    self.rootRequest = [[RequestTools alloc]init];
    [_rootRequest setDelegate:self];
    NSArray *strArry = [NSArray arrayWithObjects:AUTHOR_LIST,@"?category=dota",nil];
    [_rootRequest requestWithUrl_Asynchronous:[MyNsstringTools groupStrByAStrArray:strArry]];
    
}
#pragma mark--标签选中的代理方法
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl
{
	NSLog(@"Selected index %i (via UIControlEventValueChanged)", segmentedControl.selectedIndex);

}


#pragma mark--切换浏览模式
-(void)topRightCorenerBtnAction
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.viewDeckController.view cache:YES];
        [UIView commitAnimations];
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
        return 100;
        }
    
}
//根据数据源,判断有几个分组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   if (tableView == rootAuthorListTab)//代理方法中,要记得判断是在对哪一个列表进行的操作!!!!
        {
            NSLog(@"you jige%d",[_dataList count]);
            //分组来自于整个数据源内部统一属性比如作者数据的个数
            return [_authorListArray count];
        }
   else{
       return 1;
   }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        //如果是打开状态,分组内的行数根据数据数量返回,
        if (self.isOpen) {
            if (self.selectIndex.section == section) {
                return 4;//在此多累加一行列表,以便添加更多按钮
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
        }
        //根据数据源和下标配置展开cell内容,注意书写位置.每个展开列表中的"更多按钮"也可以写在这里.
        NSArray *list = [[_dataList objectAtIndex:self.selectIndex.section] objectForKey:@"list"];
        NSLog(@"数组数目是:%d",[list count]);
                    cell.titleLabel.text = [list objectAtIndex:indexPath.row-1];
            cell.halfTitleLabel.text = @"我是副标题啊,你妹,哇哈哈哈";
            cell.logoImageView.image = [UIImage imageNamed:@"man.png"];
               //        cell.textLabel.text = [list objectAtIndex:indexPath.row-1];
        //更多按钮可在此添加.
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
        NSLog(@"图片地址:%@",[[self.authorListArray objectAtIndex:indexPath.section] objectForKey:@"photo"]);
        return cell;
    }
    
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
        AuthorMoviesListPage *authorMoviesList = [[AuthorMoviesListPage alloc] init];
        [self.navigationController pushViewController:authorMoviesList animated:YES];
        [authorMoviesList release];
        NSLog(@"点击的下标是:%d",indexPath.row);
        NSDictionary *dic = [_dataList objectAtIndex:indexPath.section];
        NSArray *list = [dic objectForKey:@"list"];
        NSString *item = [list objectAtIndex:indexPath.row-1];
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
    int contentCount = [[[_dataList objectAtIndex:section] objectForKey:@"list"] count];
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
        [headerView addSubview:animationView];
        [animationView setDelegate:self];
        /*/分类标签/*/
        categorySegmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, animationView.bottom-2, 320, 32)];
        [categorySegmentedControl setIndexChangeBlock:^(NSUInteger index) {
            NSLog(@"Selected index %i (via block)", index);
        }];
        NSArray * nameArry = [NSArray arrayWithObjects:@"英雄联盟",@"Data",@"魔兽争霸",@"Data2", @"星级争霸",nil];
        [categorySegmentedControl setSectionTitles:nameArry];
        [categorySegmentedControl setSelectionIndicatorHeight:5.0f];
        [categorySegmentedControl setBackgroundColor:[UIColor colorWithRed:205.0f/232.0f green:232.0f/255.0f blue:232.0f/255.0f alpha:1.0f]];
        [categorySegmentedControl setTextColor:[UIColor colorWithRed:47.0f/255.0f green:79.0f/255.0f blue:79.0f/255.0f alpha:0.8f]];
        [categorySegmentedControl setSelectionIndicatorColor:[UIColor colorWithRed:52.0f/255.0f green:181.0f/255.0f blue:229.0f/255.0f alpha:0.8f]];
        [categorySegmentedControl setSelectionIndicatorMode:HMSelectionIndicatorFillsSegment];
        [categorySegmentedControl setSegmentEdgeInset:UIEdgeInsetsMake(0, 5, 5, 0)];
        [categorySegmentedControl setTag:2];
        [headerView addSubview:categorySegmentedControl];
        rootAuthorListTab.tableHeaderView = headerView;
        return [headerView autorelease];
    }
    return nil;
            
}
#pragma mark--Animation_Turn_View的代理方法
-(void)transportVideoInformation:(UIImage *)imageID
{
    NSLog(@"有没有传过来");
    MovieDetailPage *detailPage = [[MovieDetailPage alloc] init];
    [self.navigationController pushViewController:detailPage animated:YES];
    [detailPage release];
}
#pragma mark--请求的回调方法
-(void)requestSuccessWithResultDictionary:(NSDictionary *)dic
{
    NSLog(@"请求回来的数据是:%@",dic);
    self.authorListArray = [dic objectForKey:@"result"];
    NSLog(@"%d",[_authorListArray count]);
    [rootAuthorListTab reloadData];
}
-(void)requestFailedWithResultDictionary:(NSDictionary *)dic
{
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
