//
//  PublciViewsTools.m
//  CIS_Game_video
//
//  Created by huanfang_liu on 13-8-21.
//  Copyright (c) 2013年 huangfang. All rights reserved.
//
/*
 公共类目，包含：
 UILabel,UITextfield,UIButton,UIImageView
 */


#import "PublciViewsTools.h"
#import "AppDelegate.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSString (stringCategory)

- (id)md5{
    if (self) {
        const char*cStr =[self UTF8String];
        unsigned char result[16];
        CC_MD5(cStr, strlen(cStr), result);
        return [NSString stringWithFormat:
                @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                result[0], result[1], result[2], result[3],
                result[4], result[5], result[6], result[7],
                result[8], result[9], result[10], result[11],
                result[12], result[13], result[14], result[15]
                ];
    }else{
        return nil;
    }
}


@end


@implementation UILabel (labelCategory)

+ (id)labelWithRect:(CGRect)rect txt:(NSString *)txt font:(UIFont *)font{
    UILabel *label = [[[UILabel alloc] init] autorelease];
    CGFloat labelWidth = [txt sizeWithFont:font].width;
    [label setFrame:CGRectMake(rect.origin.x, rect.origin.y, labelWidth, rect.size.height)];
    [label setText:txt];
    [label setFont:font];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    return label;
}

+ (id)labelWithRect:(CGRect)rect font:(UIFont *)font{
    UILabel *label = [[[UILabel alloc] init] autorelease];
    [label setFrame:rect];
    [label setFont:font];
    [label setBackgroundColor:[UIColor clearColor]];
    return label;
}

+ (id)labelLinesWithRect:(CGRect)rect txt:(NSString *)txt font:(UIFont *)font{
    UILabel *label = [[[UILabel alloc] init] autorelease];
    [label setFrame:rect];
    [label setText:txt];
    [label setFont:font];
    [label setLineBreakMode:NSLineBreakByCharWrapping];
    [label setNumberOfLines:0];
    [label setBackgroundColor:[UIColor clearColor]];
    return label;
}

- (void)setFrame:(CGRect)frame font:(UIFont *)font{
    [self setFrame:frame];
    [self setFont:font];
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)setFitWithText:(NSString *)txt{
    CGFloat labelWidth = [txt sizeWithFont:self.font].width;
    if (txt.length>3) {
        [self setFrame:CGRectMake(self.frame.origin.x-15, self.frame.origin.y, labelWidth, self.frame.size.height)];
    }else if (txt.length == 3){
        [self setFrame:CGRectMake(self.frame.origin.x-10, self.frame.origin.y, labelWidth, self.frame.size.height)];
    }
    else if (txt.length == 2){
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, labelWidth, self.frame.size.height)];
    }
    
    [self setText:txt];
}

- (void)setText:(NSString *)txt font:(UIFont *)font{
    [self setText:txt];
    [self setFont:font];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setLineBreakMode:NSLineBreakByCharWrapping];
    [self setNumberOfLines:0];
}

- (void)setText:(NSString *)txt font:(UIFont *)font txtColor:(UIColor *)txtColor{
    [self setText:txt];
    [self setFont:font];
    [self setTextColor:txtColor];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setLineBreakMode:NSLineBreakByCharWrapping];
    [self setNumberOfLines:0];
}

- (CGFloat)getLabelHeightOfWidth:(CGFloat)width{
    CGFloat height = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(width, 10000) lineBreakMode:NSLineBreakByCharWrapping].height;
    return height;
}

@end

@implementation UIImageView (imageViewCategory)

+ (id)imageViewWithRect:(CGRect)rect image:(UIImage *)image interaction:(BOOL)interaction{
    UIImageView *imageView = [[[self alloc] initWithFrame:rect] autorelease];
    [imageView setImage:image];
    [imageView setUserInteractionEnabled:interaction];
    return imageView;
}

- (void)setFrame:(CGRect)rect image:(UIImage *)image interaction:(BOOL)interaction{
    [self setFrame:rect];
    [self setImage:image];
    [self setUserInteractionEnabled:interaction];
}

@end


@implementation UIButton (buttonCategory)

- (void)setTitle:(NSString *)title frame:(CGRect)frame font:(UIFont *)font bgImage:(UIImage *)bgImage{
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setFrame:frame];
    [self.titleLabel setFont:font];
    [self setBackgroundImage:bgImage forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame font:(UIFont *)font bgImage:(UIImage *)bgImage{
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setFrame:frame];
    [self.titleLabel setFont:font];
    [self setBackgroundImage:bgImage forState:UIControlStateNormal];
}

+ (id)buttonWithType:(UIButtonType)buttonType image:(UIImage *)image frame:(CGRect)frame target:(id)target action:(SEL)action{
    UIButton * button = [self buttonWithType:buttonType];
    [button setImage:image forState:UIControlStateNormal];
    [button setFrame:frame];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end

@implementation UIScrollView (scrollViewCategory)

+ (id)scrollViewWithRect:(CGRect)rect contentSize:(CGSize)size{
    UIScrollView *scrollView = [[[self alloc] initWithFrame:rect] autorelease];
    [scrollView setContentSize:size];
    return scrollView;
}

@end

