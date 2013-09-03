//
//  CategoryListViewController.m
//  CIS_Game_video
//
//  Created by huangfangwang on 13-9-3.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "CategoryListViewController.h"
#import "CategoryListCell.h"
#import "MovieDetailPage.h"
@interface CategoryListViewController ()

@end

@implementation CategoryListViewController
-(void)dealloc
{
    [_categoryTable release];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    _categoryTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 440)];
    [_categoryTable setDelegate:self];
    [_categoryTable setDataSource:self];
    [self.view addSubview:_categoryTable];
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
    static NSString * mark = @"mark";
    CategoryListCell * cell = [tableView dequeueReusableCellWithIdentifier:mark];
    if (nil==cell) {
        cell = [[CategoryListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mark];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    [cell.asImageView setImageURL:[arry objectAtIndex:indexPath.row]];
    [cell.nameLabel setText:@"----aDiaos-是不是一样的呢"];
    
    [cell.attentionTimeLabel setText:@"200"];
    [cell.timeLabel setText:@"10:20"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
