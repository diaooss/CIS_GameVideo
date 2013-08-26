//
//  RootViewController.m
//  CIS_Game_video
//
//  Created by huangfangwang on 13-7-15.
//  Copyright (c) 2013年 huangfang. All rights reserved.
#import "RootViewController.h"
#import "SBView.h"
#import "Header.h"
#import "MovieCell.h"
#import "AuthorCell.h"
#import "AuthorMoviesListPage.h"
#import "AppDelegate.h"
#import "Tools.h"
#import "MovieDetailPage.h"
#import "HMSegmentedControl.h"
//just test first
@interface RootViewController ()
@end
@implementation RootViewController
- (void)dealloc
{
    sbView = nil;
    AuthorListTab = nil;
    _dataList = nil;
    self.selectIndex = nil;
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
    //滑动推荐
    Animation_Turn_View * animationView = [[Animation_Turn_View alloc]initWithFrame:CGRectMake(0, 3, 320, self.view.height/4)];
    [self.view addSubview:animationView];
    [animationView setDelegate:self];
    [animationView release];
    NSArray * nameArry = [NSArray arrayWithObjects:@"英雄联盟",@"Data",@"魔兽争霸",@"Data2", @"星级争霸",nil];
    /*/分类标签/*/
    HMSegmentedControl *categorySegmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, animationView.bottom+5, 320, 32)];
    [categorySegmentedControl setIndexChangeBlock:^(NSUInteger index) {
        NSLog(@"Selected index %i (via block)", index);
    }];
    [categorySegmentedControl setSectionTitles:nameArry];
    [categorySegmentedControl setSelectionIndicatorHeight:5.0f];
    [categorySegmentedControl setBackgroundColor:[UIColor colorWithRed:205.0f/232.0f green:232.0f/255.0f blue:232.0f/255.0f alpha:1.0f]];
    [categorySegmentedControl setTextColor:[UIColor colorWithRed:47.0f/255.0f green:79.0f/255.0f blue:79.0f/255.0f alpha:0.8f]];
    [categorySegmentedControl setSelectionIndicatorColor:[UIColor colorWithRed:52.0f/255.0f green:181.0f/255.0f blue:229.0f/255.0f alpha:0.8f]];
    [categorySegmentedControl setSelectionIndicatorMode:HMSelectionIndicatorFillsSegment];
    [categorySegmentedControl setSegmentEdgeInset:UIEdgeInsetsMake(0, 5, 5, 0)];
    [categorySegmentedControl setTag:2];
    [self.view addSubview:categorySegmentedControl];
    [categorySegmentedControl release];
    /*/分类标签/*/
    sbView = [[SBView alloc]initWithFrame:CGRectMake(0, categorySegmentedControl.bottom, 320, self.view.height-30-44-animationView.height)];
    [self.view addSubview:sbView];
    [sbView addTaget:self action:@selector(transportVideoInformation:)];
    //列表展示
    AuthorListTab = [[UITableView alloc] initWithFrame:CGRectMake(0, categorySegmentedControl.bottom, 320, self.view.height-categorySegmentedControl.height-44-animationView.height-12) style:UITableViewStylePlain];
    AuthorListTab.delegate = self;
    AuthorListTab.dataSource = self;
    [self.view addSubview:AuthorListTab];
    AuthorListTab.sectionFooterHeight = 0;
    AuthorListTab.sectionHeaderHeight = 0;
    self.isOpen = NO;
    AuthorListTab.hidden = YES;
}
#pragma mark--标签选中的代理方法
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl
{
	NSLog(@"Selected index %i (via UIControlEventValueChanged)", segmentedControl.selectedIndex);
}
#pragma mark--翻转下半部分的视图
-(void)topRightCorenerBtnAction
{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1.0];
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.viewDeckController.view cache:YES];
//    if (sbView.hidden ==YES) {
//        sbView.hidden = NO;
//        AuthorListTab.hidden = YES;
//    }
//    else
//    {
//        sbView.hidden = YES;
//        AuthorListTab.hidden = NO;
//    }
//    [UIView commitAnimations];
    [Tools makeShare];
}
#pragma mark--系统列表代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 40;
    }
    return 100;
}
//根据数据源,判断有几个分组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //分组来自于整个数据源内部统一属性比如作者数据的个数
    return [_dataList count];;
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
        NSString *name = [[_dataList objectAtIndex:indexPath.section] objectForKey:@"name"];
        cell.nameLabel.text = name;
        cell.countLabel.text = @"108部作品";
        //在此设置为表示图标,为未打开样式.传入布尔值到自定义cell中去.
        //        [cell changeArrowWithUp:([self.selectIndex isEqual:indexPath]?YES:NO)];
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
- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert
{
    self.isOpen = firstDoInsert;
    //根据传进的布尔值,确定分组指示器的图标样式.并把布尔值会传到自定义cell中去.
    AuthorCell *cell = (AuthorCell *)[AuthorListTab cellForRowAtIndexPath:self.selectIndex];
    [cell changeArrowWithUp:firstDoInsert];
    [AuthorListTab beginUpdates];
    int section = self.selectIndex.section;
    int contentCount = [[[_dataList objectAtIndex:section] objectForKey:@"list"] count];
	NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
	for (NSUInteger i = 1; i < contentCount + 1; i++) {
		NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
		[rowToInsert addObject:indexPathToInsert];
	}
	if (firstDoInsert)
    {   [AuthorListTab insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
	else
    {
        [AuthorListTab deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
	[rowToInsert release];
	[AuthorListTab endUpdates];
    if (nextDoInsert) {
        self.isOpen = YES;
        self.selectIndex = [AuthorListTab indexPathForSelectedRow];
        [self didSelectCellRowFirstDo:YES nextDo:NO];
    }
    if (self.isOpen) [AuthorListTab scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
}
#pragma mark--Animation_Turn_View的代理方法
-(void)transportVideoInformation:(UIImage *)image
{
    NSLog(@"有没有传过来");
    MovieDetailPage *detailPage = [[MovieDetailPage alloc] init];
    [self.navigationController pushViewController:detailPage animated:YES];
    [detailPage release];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
