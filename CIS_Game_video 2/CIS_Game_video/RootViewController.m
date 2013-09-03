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
#import "Cell.h"
#import "RequestUrls.h"
#import "RequestTools.h"
@interface RootViewController ()
@end
@implementation RootViewController
- (void)dealloc
{
    rootAuthorListTab = nil;
    _dataList = nil;
    animationView = nil;
    defaultListTab = nil;
    self.rootRequest = nil;
    self.selectIndex = nil;
    categorySegmentedControl = nil;
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
        self.mark=0;//初始化标记值
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
    defaultListTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.height-44) style:UITableViewStylePlain];
    [defaultListTab setDelegate:self];
    [defaultListTab setDataSource:self];
    defaultListTab.hidden = NO;
    defaultListTab.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:defaultListTab];
    [defaultListTab setDecelerationRate:0.3];
    //列表展示
    //代理方法中,要记得判断是在对哪一个列表进行的操作!!!!
    rootAuthorListTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.height-44) style:UITableViewStylePlain];
    rootAuthorListTab.delegate = self;
    rootAuthorListTab.dataSource = self;
    rootAuthorListTab.sectionFooterHeight = 0;
    rootAuthorListTab.sectionHeaderHeight = 0;
    self.isOpen = NO;
    rootAuthorListTab.hidden = YES;
    [self.view addSubview:rootAuthorListTab];
    //测试
    self.rootRequest = [[[RequestTools alloc]init] autorelease];
    [_rootRequest setDelegate:self];
    //检验邮箱
    NSLog(@"邮箱检测结果----%@",[RequestTools checkEmail:@"1010@.com"]);
    //注册
    NSLog(@"注册结果--------%@",[RequestTools registerWithUserName:@"张三" withEamil:@"1010@.com" andPassWord:@"123456"]);
    //登陆是否成功
    NSLog(@"登陆结果-------%@",[RequestTools loginWithEamil:@"1010@.com" andPassWord:@"123456"]);
    [RequestTools attentionOneAuthorWith:@"魔王" ByUserEmaiil:@"1010@.com"];
}
#pragma mark--标签选中的代理方法
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl
{
	NSLog(@"Selected index %i (via UIControlEventValueChanged)", segmentedControl.selectedIndex);
}
#pragma mark--请求的代理值回传
-(void)backOneDic:(NSDictionary* )dic
{
    NSLog(@"代理值回传:%@",dic);
}
#pragma mark--切换浏览模式
-(void)topRightCorenerBtnAction
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.viewDeckController.view cache:YES];
        [UIView commitAnimations];
    if (rootAuthorListTab.hidden == YES) {
        defaultListTab.hidden = YES;
        rootAuthorListTab.hidden = NO;
    }else
    {
        defaultListTab.hidden = NO;
        rootAuthorListTab.hidden = YES;
    }
//    [Tools makeShare];
}
#pragma mark--系统列表代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == rootAuthorListTab) {
        if (indexPath.row==0) {
            if (indexPath.section == 0&&indexPath.row==0) {
               return  40;
            }
            return 50;
        }else
        {
        return 100;
        }
    }else
    {
        if (indexPath.row%2==0)
            return 30;
        return 230;
    }
}
//根据数据源,判断有几个分组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   if (tableView == rootAuthorListTab)//代理方法中,要记得判断是在对哪一个列表进行的操作!!!!
        {
            //分组来自于整个数据源内部统一属性比如作者数据的个数
            return [_dataList count];
        }
   else{
       return 1;
   }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==rootAuthorListTab) {
        //如果是打开状态,分组内的行数根据数据数量返回,
        if (self.isOpen) {
            if (self.selectIndex.section == section) {
                return 4;//在此多累加一行列表,以便添加更多按钮
            }
        }
        //如果是关闭状态,则返回一个
        return 1;
    }else
    {
        return 10;
    }
}
#pragma mark--系统列表的代理方法
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == rootAuthorListTab) {
        
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
    }else
    {
        NSArray * arry = [NSArray arrayWithObjects:
                          @"http://121.199.57.44:88/images/m001.png",
                          @"http://121.199.57.44:88/images/m002.png",
                          @"http://121.199.57.44:88/images/003.gif",
                          @"http://121.199.57.44:88/images/m004.png",
                          @"http://121.199.57.44:88/images/m005.png",
                          @"http://121.199.57.44:88/images/m006.png",
                          @"http://121.199.57.44:88/images/m007.png",
                          @"http://121.199.57.44:88/images/m008.png",
                          @"http://121.199.57.44:88/images/m009.png",
                          @"http://121.199.57.44:88/images/m010.png",
                          @"http://121.199.57.44:88/images/m011.png",
                          @"http://121.199.57.44:88/images/m012.png",
                          nil];
        NSArray * nameArry = [NSArray arrayWithObjects:@"英雄联盟",@"DOTA",@"DOTA2",@"魔兽争霸",@"星际争霸2", nil];
        //加载标题
        if (indexPath.row%2==0) {
            static NSString *mark = @"mark";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:mark];
            if (cell==nil) {
                cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mark] autorelease];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            }
            [cell.textLabel setText:[nameArry objectAtIndex:indexPath.row/2]];
            return cell;
        }
        //加载标题下的数据
        static NSString *identity = @"cell";
        Cell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
        if (cell==nil) {
            cell = [[[Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity]autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        //*****************确保重用的cell起始位置不变
        [cell.scrollerView setContentOffset:CGPointMake(0, 0)];
        //***加载过以后不再加载-------很重要-----
        if (self.mark>indexPath.row||self.mark==19) {
            return cell;
        }
        //调用----加载数据
        [cell loadInforWithNetArry:arry];
        [cell setDelegate:self];
        self.mark=indexPath.row;
        return cell;

    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == rootAuthorListTab) {
        
    
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
    }else
    {
        NSLog(@"点击栏目");

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
    if (tableView == defaultListTab) {
        return self.view.height/4;
    }
    if (tableView == rootAuthorListTab) {
        if (section == 0) {
            return self.view.height/3;
        }
    }
    return 0;
        
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == rootAuthorListTab) {
        
    if (section==0) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 20)] ;//创建一个视图
        headerView.backgroundColor = [UIColor redColor];
        //        //滑动推荐
        animationView = [[Animation_Turn_View alloc]initWithFrame:CGRectMake(0, 5, 320, self.view.height/3-37)];
        [headerView addSubview:animationView];
        [animationView setDelegate:self];
        
        //        /*/分类标签/*/
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
            }else{
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];//创建一个视图
        animationView = [[Animation_Turn_View alloc]initWithFrame:CGRectMake(0, 7, 320, self.view.height/4)];
        [headerView addSubview:animationView];
        [animationView setDelegate:self];
        defaultListTab.tableHeaderView = headerView;
        
        return headerView;

    
}
    return nil;
           
}
#pragma mark--Animation_Turn_View的代理方法
-(void)transportVideoInformation:(UIImage *)image
{
    NSLog(@"有没有传过来");
    MovieDetailPage *detailPage = [[MovieDetailPage alloc] init];
    [self.navigationController pushViewController:detailPage animated:YES];
    [detailPage release];
}
//自定义cell的代理 找到当前点击的视频
-(void)accessPlayViewControllerWithVideoID:(NSString *)videoID
{
    //可以在这里面推界面 参数 已经传过来
    NSLog(@"%@",videoID);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
