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
@implementation DefaultRootView
- (void)dealloc
{
    [_defaultListTab release];
    [_animationView release];
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
        _defaultListTab.hidden = NO;
        _defaultListTab.backgroundColor = [UIColor whiteColor];
        [self addSubview:_defaultListTab];
        [_defaultListTab setDecelerationRate:0.3];
        
        [self requestNet];
    }
    return self;
}
-(void)requestNet
{
    self.tool = [[RequestTools alloc]init];
    [_tool setDelegate:self];
    NSArray *strArry = [NSArray arrayWithObjects:@"http://121.199.57.44:88/WebServer/HomeData.ashx",nil];
    [_tool requestWithUrl_Asynchronous:[MyNsstringTools groupStrByAStrArray:strArry]];
}
-(void)requestSuccessWithResultDictionary:(NSDictionary *)dic
{
    [self setMydic:dic];//接收到数据
    NSLog(@"%@",dic );
    [_defaultListTab reloadData];
    [_defaultListTab reloadInputViews];
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
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];//创建一个视图
    _animationView = [[Animation_Turn_View alloc]initWithFrame:CGRectMake(0, 7, 320, self.height/4)];
    [_animationView setSlideArry:[self.mydic valueForKey:@"bannerResult"]];
    [_animationView addChildViews];
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
    NSLog(@"--------%@",videoID);
    [self.target performSelector:self.action withObject:videoID];
}
-(void)addTarget:(id)target action:(SEL)action
{
    self.target = target;
    self.action = action;
}
@end
