//
//  PublciViewsTools.h
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-8-21.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//

#import <Foundation/Foundation.h>
//MD5的相关
@interface NSString (stringCategory)

- (id)md5;

@end

//label的类目
@interface UILabel (labelCategory)

+ (id)labelWithRect:(CGRect)rect txt:(NSString *)txt font:(UIFont *)font;

+ (id)labelWithRect:(CGRect)rect font:(UIFont *)font;

+ (id)labelLinesWithRect:(CGRect)rect txt:(NSString *)txt font:(UIFont *)font;

- (void)setFrame:(CGRect)frame font:(UIFont *)font;

- (void)setFitWithText:(NSString *)txt;

- (void)setText:(NSString *)txt font:(UIFont *)font;

- (void)setText:(NSString *)txt font:(UIFont *)font txtColor:(UIColor *)txtColor;

- (CGFloat)getLabelHeightOfWidth:(CGFloat)width;

@end
//uiimageView 的类目
@interface UIImageView (imageViewCategory)

+ (id)imageViewWithRect:(CGRect)rect image:(UIImage *)image interaction:(BOOL)interaction;

- (void)setFrame:(CGRect)rect image:(UIImage *)image interaction:(BOOL)interaction;

@end
//uibutton的类目
@interface UIButton (buttonCategory)

- (void)setTitle:(NSString *)title frame:(CGRect)frame font:(UIFont *)font bgImage:(UIImage *)bgImage;

- (void)setFrame:(CGRect)frame font:(UIFont *)font bgImage:(UIImage *)bgImage;

+ (id)buttonWithType:(UIButtonType)buttonType image:(UIImage *)image frame:(CGRect)frame target:(id)target action:(SEL)action;

@end
//uiscrollview 的类目
@interface UIScrollView (scrollViewCategory)

+ (id)scrollViewWithRect:(CGRect)rect contentSize:(CGSize)size;

@end
