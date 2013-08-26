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
@interface Public_ViewController ()

@end

@implementation Public_ViewController
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
    [self.view setBackgroundColor:[UIColor whiteColor]];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
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
    NSArray * nameArry = [NSArray arrayWithObjects:@"全部",@"英雄联盟",@"Data",@"魔兽争霸",@"星级争霸",@"Data2", nil];
    UISegmentedControl * segment = [[UISegmentedControl alloc]initWithItems:nameArry];
    [segment setSegmentedControlStyle:UISegmentedControlStyleBar];
    [segment setFrame:CGRectMake(0, 5, 330, 30)];
    [self.view addSubview:segment];
    //[segment addTarget:self action:@selector(segementAction:) forControlEvents:UIControlEventValueChanged];
    [segment setTintColor:[UIColor colorWithRed:95/255.0 green:112/255.0 blue:38/255.0 alpha:1]];
    segment.momentary = YES;
    [segment setSelectedSegmentIndex:0];//初始化的时候显示的
    [segment release];
    self.showTab = [[UITableView alloc]initWithFrame:CGRectMake(0, segment.bottom, 320, self.view.height-44-segment.height) style:UITableViewStylePlain];
    [_showTab setDelegate:self];
    [_showTab setDataSource:self];
    [self.view addSubview:_showTab];
    [_showTab release];
}
#pragma mark-- tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * mark=@"mark";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:mark];
    if (nil==cell) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mark] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    [cell.imageView setImage:[UIImage imageNamed:@"test.test.png"]];
    cell.textLabel.font = [UIFont systemFontOfSize:18.0];
    [cell.textLabel setText:@"视频名字:复仇的萝卜"];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0];
    cell.detailTextLabel.textAlignment = NSTextAlignmentCenter;
    [cell.detailTextLabel setText:@"作者:老鸭"];
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
#pragma mark--cell删除
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
#pragma mark--cell删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        //写删除方法
                [_showTab reloadData];
    }
}
- (void)changeInformation:(NSString *)titleName
{
    [self setTitle:titleName];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
