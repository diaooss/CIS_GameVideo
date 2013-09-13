//
//  DefaultRootView.m
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-9-4.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "DefaultRootView.h"
#import "Header.h"
#import "Animation_Turn_View.h"
#import "MyNsstringTools.h"
#import "Tools.h"
#import "SqCached.h"
#import "JSONKit.h"
@implementation DefaultRootView
- (void)dealloc
{
    [self setTool:nil];
    [self.mydic release];
    [_defaultListTab release];
    [_animationView release];
    [rootRefreshView release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.mark=0;//初始化标记值

        _defaultListTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.height) style:UITableViewStylePlain];
        [_defaultListTab setDelegate:self];
        [_defaultListTab setDataSource:self];
        _defaultListTab.backgroundColor = [UIColor whiteColor];
        [self addSubview:_defaultListTab];
        /*/水滴/*/
        
        rootRefreshView = [[SRRefreshView alloc] init];
        rootRefreshView.delegate = self;
        rootRefreshView.upInset = 0;
        rootRefreshView.slimeMissWhenGoingBack = YES;
        rootRefreshView.slime.bodyColor = [UIColor blackColor];
        rootRefreshView.slime.skinColor = [UIColor blackColor];
        rootRefreshView.slime.lineWith = 5;
        rootRefreshView.activityIndicationView.color = [UIColor blackColor];
        [_defaultListTab addSubview:rootRefreshView];
    //初次请求数据
        [self requestNet];
    }
    return self;
}
//开始请求数据
-(void)requestNet
{
    self.tool = [[[RequestTools alloc]init] autorelease];
    [_tool setDelegate:self];
    NSArray *strArry = [NSArray arrayWithObjects:@"http://121.199.57.44:88/WebServer/HomeData.ashx",nil];
    if ([Tools isHaveNet]==YES) {
        [Tools openLoadsign:self WithString:@"正在为你辛勤加载...."];

        [_tool requestWithUrl_Asynchronous:[MyNsstringTools groupStrByAStrArray:strArry]];

    }else
    {
        [self defaultLoadCacheData];
    }
}
#pragma mark----请求数据
-(void)requestSuccessWithResultDictionary:(NSDictionary *)dic
{
    [self setMydic:dic];//接收到数据
    [self setCacheData:dic];//写入缓存
    [_defaultListTab reloadData];
    [_defaultListTab reloadInputViews];
    [rootRefreshView endRefresh];
    [Tools closeLoadsign:self];
}
-(void)requestFailedWithResultDictionary:(NSDictionary *)dic
{
    NSLog(@"------%@",dic);
    //  提醒用户加载失败原因-------------
    [Tools closeLoadsign:self];
    [self defaultLoadCacheData];

    [rootRefreshView endRefresh];
}
#pragma mark--补偿加载
-(void)setCacheData:(NSDictionary *)dic
{
    
    NSString *tempStr = [dic JSONString];
    NSData *tempData = [tempStr dataUsingEncoding:NSUTF8StringEncoding];
    [[SqCached shareCache] setCacheData:tempData ForKey:@"defaultData"];

}

-(NSDictionary *)readerCacheData
{
    NSDictionary *dic = [[SqCached shareCache] cacheDataForKey:@"defaultData"];
    return dic;
    
}
-(void)defaultLoadCacheData
{
    self.mydic = [self readerCacheData];
    [_defaultListTab reloadData];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2==0)
        return 30;
    return 230;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSArray * nameArry = [NSArray arrayWithObjects:@"英雄联盟",@"DOTA",@"DOTA2",@"魔兽争霸3",@"星际大战2", nil];
    //加载标题
    if (indexPath.row%2==0) {
        static NSString *mark = @"mark";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:mark];
        if (cell==nil) {
            cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mark] autorelease];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        }
        [cell.imageView setImage:[UIImage imageNamed:@"smile32.png"]];
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
    if (self.mark>indexPath.row||self.mark==9) {
        return cell;
    }
    if ([[self.mydic valueForKey:@"dota"]count]>0) {
        [cell loadInforWithNetArry:[self.mydic valueForKey:@"dota"]];
        [cell setDelegate:self];
        self.mark=indexPath.row;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(transferCategoryWithCategoryName:)]) {
        [self.delegate performSelector:@selector(transferCategoryWithCategoryName:) withObject:cell.textLabel.text];
    }
}
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.height/4;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320,0.5)];//创建一个视图
    self.animationView = [[Animation_Turn_View alloc]initWithFrame:CGRectMake(0, 7, 320, self.height/4-14)];
//    [self.animationView setCenter: headerView.center];
    [_animationView setSlideArry:[self.mydic valueForKey:@"bannerResult"]];
    [_animationView addChildViews];//布局子视图
    [headerView addSubview:_animationView];
    [_animationView setDelegate:self];
    _defaultListTab.tableHeaderView = headerView;
    [_animationView release];
    return headerView;
}
#pragma mark--Animation_Turn_View的代理方法
-(void)transportVideoInformation:(UIImage *)imageID
{
    [self.target performSelector:self.action withObject:imageID];
}
//自定义cell的代理 找到当前点击的视频
-(void)accessPlayViewControllerWithVideoID:(NSString *)videoID
{
    //可以在这里面推界面 参数 已经传过来
    [self.target performSelector:self.action withObject:videoID];
}
-(void)addTarget:(id)target action:(SEL)action
{
    self.target = target;
    self.action = action;
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
//刷新界面 //加载一次之后再 加载就不会请求数据-----界面就不会真的刷新
           [self requestNet];
    
    //刷新
}

@end
