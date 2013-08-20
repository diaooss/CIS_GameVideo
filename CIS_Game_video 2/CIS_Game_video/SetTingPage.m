//
//  SetTingPage.m
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-7-18.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "SetTingPage.h"
#import "Header.h"
#import "SettingCell.h"
@interface SetTingPage ()

@end

@implementation SetTingPage

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
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"系统设置";
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar.png"] forBarMetrics:UIBarMetricsDefault];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"goBack.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 44, 44)];
    [button addTarget:self.viewDeckController action:@selector(toggleLeftViewAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * bar = [[UIBarButtonItem alloc]initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:bar];
    [bar release];
    
    UITableView *setListTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.height) style:UITableViewStyleGrouped];
    setListTab.dataSource = self;
    setListTab.delegate = self;
    [self.view addSubview:setListTab];
    [setListTab release];
    
    
}
-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
        
    }else if (section==1)
    {
        return 2;
    }
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseName = @"reuse";
    SettingCell *setCell = [tableView dequeueReusableCellWithIdentifier:reuseName];
    if (setCell==nil) {
        setCell = [[[SettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseName] autorelease];
        //        setCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        setCell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    setCell.setImageView.image = [UIImage imageNamed:@"smile32.png"];
    
    if (indexPath.section == 0) {
        setCell.setTitleLabel.text = @"夜间模式";
        
    }else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            setCell.setTitleLabel.text = @"声音";
            
        }else
        {
            setCell.setTitleLabel.text = @"震动";
            
        }
    }else
    {
        if (indexPath.row == 0) {
            setCell.setTitleLabel.text = @"离线推送";
            
        }else if (indexPath.row == 1)
        {
            setCell.setTitleLabel.text = @"通知设置";
            
            
        }else
        {
            setCell.setTitleLabel.text = @"免扰时间";
            
            
        }
    }
    
    
    
    return setCell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
