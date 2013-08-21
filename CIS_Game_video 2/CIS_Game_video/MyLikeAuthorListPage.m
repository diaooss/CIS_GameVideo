//
//  MyLikeAuthorListPage.m
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-7-18.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import "MyLikeAuthorListPage.h"
#import "Header.h"
#import "MyFavorAuthorCell.h"
#import "Tools.h"
@interface MyLikeAuthorListPage ()

@end

@implementation MyLikeAuthorListPage

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
    [self.view setBackgroundColor:[UIColor brownColor]];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [Tools navigaionView:self deckVC:self.viewDeckController leftImageName:@"goBack.png" title:@"我的关注"];
    
    UITableView *likeAuthorListTab = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    likeAuthorListTab.dataSource = self;
    likeAuthorListTab.delegate = self;
    [self.view addSubview:likeAuthorListTab];
    [likeAuthorListTab release];
    
    

}
#pragma mark--列表代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseName = @"reuse";
     MyFavorAuthorCell*myCell = [tableView dequeueReusableCellWithIdentifier:reuseName ];
    if (myCell== nil) {
        myCell = [[[MyFavorAuthorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseName] autorelease];
        //左扫手势
               UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:myCell action:@selector(cancelLike)];
        [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
               [myCell addGestureRecognizer:swipeLeft];
                //右扫手势
                UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:myCell action:@selector(cancelLike)];
                [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
                [myCell addGestureRecognizer:swipeRight];
        
                //长按手势
                UILongPressGestureRecognizer *longPressCell = [[UILongPressGestureRecognizer alloc] initWithTarget:myCell action:@selector(cancelLike)];
        
                [myCell addGestureRecognizer:longPressCell];
        //书写取消按钮方法
//        [myCell.favorBtn addTarget:<#(id)#> action:<#(SEL)#> forControlEvents:<#(UIControlEvents)#>]
               [longPressCell release];
        [swipeLeft release];
        [swipeRight release];

        myCell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
        
        //3
        myCell.authorLogoView.image = [UIImage imageNamed:@"test.png"];
       myCell.authorNameLabel.text = @"魔兽大仙-只哈哈哈哈哈看看";

       
    return myCell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
