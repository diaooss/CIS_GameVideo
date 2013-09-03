//
//  Animation_Turn_View.h
//  CIS_Game_video
//
//  Created by huangfangwang on 13-7-15.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "GroupView.h"
#import "RequestTools.h"
@protocol AnimationViewDelegate <NSObject>
@required
-(void)transportVideoInformation:(NSString *)imageID;

@end
@interface Animation_Turn_View : UIView<iCarouselDataSource,iCarouselDelegate,GroupViewDelegate,myHttpRequestDelegate>

{
    iCarousel * _icarousel;
    
}
@property(nonatomic,retain)NSArray * slideArry;
@property (nonatomic,assign)id <AnimationViewDelegate> delegate;






@end
