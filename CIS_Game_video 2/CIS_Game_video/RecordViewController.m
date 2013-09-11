//
//  RecordViewController.m
//  CIS_Game_video
//
//  Created by huangfangwang on 13-9-11.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "RecordViewController.h"
#import "Video.h"
#import "HandleData.h"
#import "CategoryListCell.h"
#import "Tools.h"
#import "IIViewDeckController.h"
#import "MovieDetailPage.h"
@interface RecordViewController ()

@end

@implementation RecordViewController
-(void)dealloc
{
    [_recordTab release];
    [eiditBtn release];
    [self.recordArry release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    [self setRecordArry:[HandleData allVideosInformation]];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    eiditBtn = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    eiditBtn.frame = CGRectMake(280, 0, 40, 30);
    [eiditBtn addTarget:self action:@selector(setEditing:animated:) forControlEvents:UIControlEventTouchUpInside];
    [eiditBtn setBackgroundImage:[UIImage imageNamed:@"qie_110.png"] forState:UIControlStateNormal];
    UIBarButtonItem *eiditBar = [[UIBarButtonItem alloc] initWithCustomView:eiditBtn];
    self.navigationItem.rightBarButtonItem = eiditBar;
    [eiditBar release];

  [Tools navigaionView:self deckVC:self.viewDeckController leftImageName:@"goBack.png"];
    _recordTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-44) style:UITableViewStylePlain];
    [self.view addSubview:_recordTab];
    [_recordTab setDelegate:self];
    [_recordTab setDataSource:self];
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(done)];
    [eiditBtn addGestureRecognizer:tap];
    [tap release];
    [_recordTab setEditing:editing animated:animated];
}
- (void)done{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setEditing:animated:)];
    [eiditBtn addGestureRecognizer:tap];
    [tap release];
    [_recordTab setEditing:NO animated:YES];
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
        Video * video = [[Video alloc]initWithID:cell.ID];
        [HandleData deleteOneVideo:video];
        self.recordArry = [HandleData allVideosInformation];
        [_recordTab reloadData];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.recordArry count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * mark = @"mark";
    CategoryListCell * cell = [tableView dequeueReusableCellWithIdentifier:mark];
    if (nil==cell) {
        cell = [[CategoryListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mark];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    Video * video = [self.recordArry objectAtIndex:indexPath.row];
    [cell.asImageView setImage:[UIImage imageWithContentsOfFile:video.videoPicture]];
    [cell.nameLabel setText:video.videoName];
    [cell setVideoID:video.videoID];
    [cell.attentionTimeLabel setText:video.videoPopular];
    [cell.timeLabel setText:video.videoTime];
    cell.ID = video.ID;
    return cell;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    CategoryListCell * cell = (CategoryListCell *)[tableView cellForRowAtIndexPath:indexPath];
    MovieDetailPage *detailPage = [[MovieDetailPage alloc] init];
    detailPage.movieId = cell.videoID;
    [self.navigationController pushViewController:detailPage animated:YES];
    [detailPage release];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
