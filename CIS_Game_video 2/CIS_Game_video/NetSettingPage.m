//
//  NetSettingPage.m
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-7-19.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "NetSettingPage.h"
#import "Header.h"
#import "SettingCell.h"
#import "Tools.h"
@interface NetSettingPage ()

@end

@implementation NetSettingPage

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
    self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]]autorelease];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [Tools navigaionView:self deckVC:self.viewDeckController leftImageName:@"goBack.png" title:@"网络设置"];
    //列表
    
    UITableView *netTab = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    netTab.dataSource = self;
    netTab.delegate = self;
    [self.view addSubview:netTab];
    [netTab release];
    

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
        
    }
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusename = @"reuse";
    SettingCell *netSetCell = [tableView dequeueReusableCellWithIdentifier:reusename];
    if (netSetCell == nil) {
        netSetCell = [[[SettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusename] autorelease];
        netSetCell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            netSetCell.setImageView.image = [UIImage imageNamed:@"smile32.png"];
            netSetCell.setTitleLabel.text = @"非WIFI时提醒";
            

        }else{
            
            netSetCell.setImageView.image = [UIImage imageNamed:@"smile32.png"];
            netSetCell.setTitleLabel.text = @"3G下观看";
        }
           }else
           {
               netSetCell.setImageView.image = [UIImage imageNamed:@"smile32.png"];
               netSetCell.setTitleLabel.text = @"流量统计";
               netSetCell.setSwitch.hidden = YES;
               netSetCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
               
           }
    return netSetCell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
