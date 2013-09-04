//
//  DefaultRootView.h
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-9-4.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animation_Turn_View.h"
#import "Cell.h"


@interface DefaultRootView : UIView<UITableViewDataSource,UITableViewDelegate,CellDelegate,AnimationViewDelegate>
{
    Animation_Turn_View * _animationView;//轮显
    UITableView * _defaultListTab;
    
    
}
@property(nonatomic,assign)int mark;//
@property(nonatomic,assign)id target;
@property(nonatomic,assign)SEL action;
-(void)addTarget:(id)target action:(SEL)action;
@end
