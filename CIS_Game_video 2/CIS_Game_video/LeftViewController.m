//
//  LeftViewController.m
//  CIS_Game_video
//
//  Created by huangfangwang on 13-7-16.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "LeftViewController.h"
#import "Header.h"
#import "UserViewController.h"
#import "AppDelegate.h"
#import "Public_ViewController.h"
#import "MyLikeAuthorListPage.h"
#import "SetTingPage.h"
#import "NetSettingPage.h"
#import "AboutUsPage.h"
#import "LoginPage.h"
#import "RequestUrls.h"
#import "RequestTools.h"
#import "MyNsstringTools.h"
#import "RecordViewController.h"
@interface LeftViewController ()
@end
@implementation LeftViewController
- (void)dealloc
{
    [_setTableView release];
    [_nameArry release];
    [_pictureArry release];
    [checkLabel release],checkLabel = nil;
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    _nameArry = [[NSArray alloc]initWithObjects:@"返回主页",@"我的收藏",@"观看记录",@"我的关注", nil];
    _pictureArry = [[NSArray alloc]initWithObjects:@"test.png",@"test.png",@"test.png",@"test.png",@"test.png",@"test.png", nil];
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //基础信息
    _setTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0,320, self.view.height*5/9) style:UITableViewStylePlain];
    [_setTableView setDelegate:self];
    [_setTableView setDataSource:self];
    [self.view addSubview:_setTableView];
   
    NSArray * arry = [NSArray arrayWithObjects:@"系统设置",@"应用推荐",@"网络设置",@"关于CIS", nil];
//有待更改
    for (int j=0; j<2; j++) {
        for (int i=0; i<2; i++) {
            if (2*j+i<5) {
                //but??????
            UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
            [but setFrame:CGRectMake(0+((320-44)/2)*i, _setTableView.bottom+j*self.view.height/9, (320-44)/2, self.view.height/9)];
            [self.view addSubview:but];
            [but setTag:100+2*j+i];
            [but.layer setBorderWidth:3];
            [but setShowsTouchWhenHighlighted:YES];
            [but setBackgroundColor:[UIColor brownColor]];
                [but addTarget:self action:@selector(configButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                [but setTitle:[arry objectAtIndex:2*j+i] forState:UIControlStateNormal];
            }
        }
    }
    //添加一个手势
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self.viewDeckController action:@selector(closeLeftView)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:recognizer];
    [recognizer release];
    //签到
    checkLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bottom-60, 320, 30)];
    checkLabel.text = @"每日签到(您已连续签到XX次)";
    checkLabel.textAlignment = NSTextAlignmentCenter;
    checkLabel.textColor = [UIColor grayColor];
    checkLabel.backgroundColor  =[UIColor clearColor];
    [self.view addSubview:checkLabel];
}
#pragma mark -----UItableView 的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 80;
    }return self.view.height*5/63;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * mark = @"mark";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:mark];
    if (nil==cell) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mark] autorelease];
        cell.textLabel.font = mainFont;
    }
    if (indexPath.row==0) {
//        NSString *namrStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"<#string#>"];
        [cell.textLabel setText:@"我是小强"];//
        cell.detailTextLabel.text = @"这个人很懒,不喜欢签名...";
        cell.imageView.image = [UIImage imageNamed:@"headerimage.png"];
        UITapGestureRecognizer *tapHeaerImageView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTheHeaerImageView)];
        [cell.imageView setUserInteractionEnabled:YES];
        [cell.imageView addGestureRecognizer:tapHeaerImageView];
        [tapHeaerImageView release];
    }else
    {
    [cell.textLabel setText:[_nameArry objectAtIndex:indexPath.row-1]];
        [cell.imageView setImage:[UIImage imageNamed:@"smile32.png"]];

    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:
            [self goIntoUserCenterWith:cell.textLabel.text];
            break;
        case 1:
            [self backToRootViewController];
            break;
        case 2:
            [self toSomePlace:cell.textLabel.text];//前往公共页
            break;
        case 3:{
            RecordViewController * Record = [[RecordViewController alloc]init];
            UINavigationController * RecordNVC =[[UINavigationController alloc]initWithRootViewController:Record];
            [self.viewDeckController setCenterController:RecordNVC ];
            [self.viewDeckController closeLeftViewAnimated:YES];
            [RecordNVC release];
            [Record release];
            }
            break;
        case 4:
            [self goToMyLikeAuthorListPageWith:cell.textLabel.text];
            break;
        default:
            break;
    }
}
#pragma mark-- cell的点击触发事件
- (void)goIntoUserCenterWith:(NSString *)name
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfor = [userDefaults valueForKey:@"UserInfo"];
    if (userInfor) {
        NSLog(@"存在");
        UserViewController* user = [[UserViewController alloc]init];
        [self judgeTheView:name changeViecontroller:user];
        [user release];
    }else
    {
        LoginPage *login = [[LoginPage alloc] init];
        UINavigationController *loginNavc = [[UINavigationController alloc] initWithRootViewController:login];
        [self presentViewController:loginNavc animated:YES completion:nil];
        [login release];
        [loginNavc release];
    }
}
#pragma mark--选择头像创建方式.点击时需确认是否登陆,如登陆执行如下动作
-(void)tapTheHeaerImageView
{
    UIActionSheet *imageActionSheet  =[[UIActionSheet alloc] initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从相册" otherButtonTitles:@"拍照", nil];
    [imageActionSheet showInView:self.view];
    [imageActionSheet release];
}
#pragma mark--选择头像创建方式.
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self congXiangCe];
            
            break;
        case 1:
            [self congXiangJi];
            break;
        default:
            break;
    }
}
#pragma matk-从相册
-(void)congXiangCe
{
    NSLog(@"从相册");
#pragma mark 从摄像头获取活动图片
    UIImagePickerController *pickC = [[UIImagePickerController alloc] init];
    pickC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    pickC.allowsEditing = YES;
    pickC.delegate = self;
    [self presentViewController:pickC animated:YES completion:nil];
    [pickC release];
    
}
#pragma matk-从相机
-(void)congXiangJi
{
    NSLog(@"相机");
    UIImagePickerController *pickC = [[UIImagePickerController alloc] init];
    pickC.sourceType = UIImagePickerControllerSourceTypeCamera;
    pickC.allowsEditing = YES;
    pickC.delegate = self;
    [self presentViewController:pickC animated:YES completion:nil];
    [pickC release];
}
#pragma matk-确定时
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _tempImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    [self dismissViewControllerAnimated:YES completion:^{
        NSData *data = UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerEditedImage"], 0.5);
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0];
        static int i = 0;
        self.photoPath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.png",i++]];
        [data writeToFile:self.photoPath atomically:YES];
    }];
    [self performSelector:@selector(selectPic:) withObject:[info objectForKey:@"UIImagePickerControllerEditedImage"] afterDelay:0.1];
}
#pragma mark--头像上传
- (void)selectPic:(UIImage*)image
{
    NSLog(@"image%@",image);
    NSString *str = [NSString stringWithFormat:@"http://121.199.57.44:88/webServer/HeadPhotoUpload.ashx?email=1823870397@qq.com"];
    
   NSDictionary *dic =  [RequestTools postHeaderImageToServerWitImage:image requestStr:str];
    NSLog(@"头像成功:%@",dic);
    [_setTableView reloadData];
[self.viewDeckController dismissViewControllerAnimated:YES completion:nil];
}
/*/-----------/*/
#pragma matk-取消时
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.viewDeckController dismissViewControllerAnimated:YES completion:nil];
}
-(void)upLoadHeaderImage
{
    
    
}
- (void)backToRootViewController
{
    AppDelegate * delegate = [UIApplication sharedApplication].delegate;
    [self.viewDeckController setCenterController:delegate.rootNvc];
    [self.viewDeckController closeLeftViewAnimated:YES];
}
//进入我的收藏
- (void)toSomePlace:(NSString *)cellName;
{
        Public_ViewController * public = [[Public_ViewController alloc]init];
        UINavigationController * publicNVC =[[UINavigationController alloc]initWithRootViewController:public];
        [self.viewDeckController setCenterController:publicNVC ];
        [self.viewDeckController closeLeftViewAnimated:YES];

        [publicNVC release];
        [public release];
}
//前往我的关注列表,此方法未添加是否该页面已经存在的判断.
-(void)goToMyLikeAuthorListPageWith:(NSString *)name
{
    MyLikeAuthorListPage *likeAuthorPage = [[MyLikeAuthorListPage alloc] init] ;
    UINavigationController * controllerNVC =[[UINavigationController alloc]initWithRootViewController:likeAuthorPage];
    [self.viewDeckController setCenterController:controllerNVC];

    [self.viewDeckController closeLeftViewAnimated:YES];
    [controllerNVC release];
    [likeAuthorPage release];
}
#pragma mark--判断显示是不是当前点击的方法___
//判断当前的center 是不是点击所选中的
- (void)judgeTheView:(NSString *)nowSelectionCell changeViecontroller:(UIViewController *)controller
{
       UINavigationController * controllerNVC =[[UINavigationController alloc]initWithRootViewController:controller];
    [self.viewDeckController setCenterController:controllerNVC];

    [self.viewDeckController closeLeftViewAnimated:YES];
    [controllerNVC release];
}
#pragma mark--设置按钮等的点击事件
-(void)configButtonClick:(UIButton *)sender
{
    NSLog(@"%d",sender.tag);
    switch (sender.tag) {
        case 100:
        {
            SetTingPage *configPage = [[SetTingPage alloc] init];
            [self judgeTheView:[sender titleForState:UIControlStateNormal] changeViecontroller:configPage];
            [configPage release];
        }
            break;
        case 102:
        {
            NetSettingPage *netConfigPage = [[NetSettingPage alloc] init];
            [self judgeTheView:[sender titleForState:UIControlStateNormal] changeViecontroller:netConfigPage];
            [netConfigPage release];
        }
            break;
        case 103:
        {
            AboutUsPage *usPage = [[AboutUsPage alloc] init];
            [self judgeTheView:[sender titleForState:UIControlStateNormal] changeViecontroller:usPage];
            [usPage release];
        }
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
