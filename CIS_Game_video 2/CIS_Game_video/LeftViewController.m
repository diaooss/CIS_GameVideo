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
    _nameArry = [[NSArray alloc]initWithObjects:@"返回主页",@"我的收藏",@"下载记录",@"观看记录",@"我的关注", nil];
    _pictureArry = [[NSArray alloc]initWithObjects:@"test.png",@"test.png",@"test.png",@"test.png",@"test.png",@"test.png", nil];
    //增加一个判断  下面用
    _isCraete=NO;
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"出现几次啊");
    [_setTableView reloadData];
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //基础信息
    _setTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0,320, self.view.height*5/9) style:UITableViewStylePlain];
    [_setTableView setDelegate:self];
    [_setTableView setDataSource:self];
    [self.view addSubview:_setTableView];
   
    NSArray * arry = [NSArray arrayWithObjects:@"系统设置",@"分享设置",@"应用推荐",@"网络设置",@"关于CIS", nil];
//有待更改
    for (int j=0; j<3; j++) {
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
    return 6;
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return self.view.height*10/63;
    }return self.view.height*5/63;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * mark = @"mark";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:mark];
    if (nil==cell) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mark] autorelease];
        cell.textLabel.font = mainFont;
    }
    if (indexPath.row==0) {
        [cell.textLabel setText:@"我是小强"];
        UITapGestureRecognizer *tapHeaerImageView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTheHeaerImageView)];
        [cell.imageView setUserInteractionEnabled:YES];
        [cell.imageView addGestureRecognizer:tapHeaerImageView];
        [tapHeaerImageView release];
    }else
    {
    [cell.textLabel setText:[_nameArry objectAtIndex:indexPath.row-1]];
    }
    if (self.photoPath) {
        [cell.imageView setImage:[UIImage imageWithContentsOfFile:self.photoPath]];
    }else
    {
        [cell.imageView setImage:[UIImage imageNamed:@"smile32.png"]];
    }
    
    //[_pictureArry objectAtIndex:indexPath.row]]];
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
            NSLog(@"%@",cell.textLabel.text);
            [self toSomePlace:cell.textLabel.text];//前往公共页
            break;
        case 3:
            NSLog(@"%@",cell.textLabel.text);
            [self toSomePlace:cell.textLabel.text];
            break;
        case 4:
            NSLog(@"%@",cell.textLabel.text);
            [self toSomePlace:cell.textLabel.text];
            break;
        case 5:
            NSLog(@"%@",cell.textLabel.text);//我的关注
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
- (void)selectPic:(UIImage*)image
{
    NSLog(@"image%@",image);
    [_setTableView reloadData];
[self.viewDeckController dismissViewControllerAnimated:YES completion:nil];
}
/*/-----------/*/
#pragma matk-取消时
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"-------");
    [self.viewDeckController dismissViewControllerAnimated:YES completion:nil];
}
- (void)backToRootViewController
{
    _isCraete=NO;
    UIViewController * View = (UIViewController *)self.viewDeckController.centerController;
    if ([View.title isEqualToString:@"幻方视频"]) {
        [self.viewDeckController closeLeftViewAnimated:YES];
        return;
    }
    AppDelegate * delegate = [UIApplication sharedApplication].delegate;
    [self.viewDeckController setCenterController:delegate.rootNvc];
    [self.viewDeckController closeLeftViewAnimated:YES];
}
//根据标签判断去哪个页面
- (void)toSomePlace:(NSString *)cellName;
{
    if (_isCraete==NO) {
        Public_ViewController * public = [[Public_ViewController alloc]init];
        UINavigationController * publicNVC =[[UINavigationController alloc]initWithRootViewController:public];
        [self.viewDeckController closeLeftViewAnimated:YES];
        [self.viewDeckController setCenterController:publicNVC];
        [public changeInformation:cellName];//设置名字 并且更新数据
        [publicNVC release];
        [public release];
        _isCraete=YES;
        return;
    }
//如果当前的Viewcontroller存在 就需要判断是不是当前点击的
    UINavigationController * nowViewController = (UINavigationController *)self.viewDeckController.centerController;
    Public_ViewController *view=(Public_ViewController *)[nowViewController.viewControllers objectAtIndex:0];
//判断点击是不是重复的
    if ([view.title isEqualToString:cellName]) {
        [self.viewDeckController closeLeftViewAnimated:YES];
        return;
    }
//如果不是 需要冲洗夹杂数据
    [view changeInformation:cellName];//并且更新数据_____方法需要重新定义;
    [self.viewDeckController closeLeftViewAnimated:YES];
}
//前往我的关注列表,此方法未添加是否该页面已经存在的判断.
-(void)goToMyLikeAuthorListPageWith:(NSString *)name
{
    MyLikeAuthorListPage *likeAuthorPage = [[MyLikeAuthorListPage alloc] init] ;
    [self judgeTheView:name changeViecontroller:likeAuthorPage];
    [likeAuthorPage release];
}
#pragma mark--判断显示是不是当前点击的方法___
//判断当前的center 是不是点击所选中的
- (void)judgeTheView:(NSString *)nowSelectionCell changeViecontroller:(UIViewController *)controller
{
    _isCraete=NO;
    UIViewController *viewController = (UIViewController *)self.viewDeckController.centerController;
    if ([viewController.title isEqualToString:nowSelectionCell]) {
        [self.viewDeckController closeLeftViewAnimated:YES];
        return;
    }
    UINavigationController * controllerNVC =[[UINavigationController alloc]initWithRootViewController:controller];
    [self.viewDeckController closeLeftViewAnimated:YES];
    [self.viewDeckController setCenterController:controllerNVC];
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
        case 103:
        {
            NetSettingPage *netConfigPage = [[NetSettingPage alloc] init];
            [self judgeTheView:[sender titleForState:UIControlStateNormal] changeViecontroller:netConfigPage];
            [netConfigPage release];
        }
            break;
        case 104:
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
