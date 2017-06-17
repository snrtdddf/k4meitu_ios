//
//  UpDownButton.m
//  myself - tabbar
//
//  Created by xshhanjuan on 15/10/14.
//  Copyright © 2015年 xsh. All rights reserved.
//

#import "UpDownButton.h"

#import "VersionedImage.h"
#import "Header.h"
#define buttonImageRation 0.5

// 按钮的默认文字颜色
#define  IWTabBarButtonTitleColor (iOS7 ? [UIColor blackColor] : [UIColor whiteColor])
// 按钮的选中文字颜色
#define  IWTabBarButtonTitleSelectedColor (iOS7 ? IWColor(234, 103, 7) : IWColor(248, 139, 0))


@interface UpDownButton ()

@end

@implementation UpDownButton


-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        // 图标居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        //文字颜色
        [self setTitleColor:IWTabBarButtonTitleColor forState:UIControlStateNormal];
        
        
        if (!iOS7) { // 非iOS7下,设置按钮选中时的背景
            [self setBackgroundImage:[VersionedImage imageWithName:@"tabbar_slider"] forState:UIControlStateSelected];
        }
    }
    return self;
}

//重写去掉高亮状态
-(void)setHighlighted:(BOOL)highlighted{}

//重写set方法，同时设置button的标题和图像
-(void)setItem:(UITabBarItem *)item
{
    _item = item;
//    [self setTitle:self.item.title forState:UIControlStateNormal];
//    [self setTitle:self.item.title forState:UIControlStateSelected];
    
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage: self.item.selectedImage forState:UIControlStateSelected];
}

#pragma mark --- 为了使button的标题在图像的下面，需要重写标题和图像的rect
// 图像的frame
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageWidth = contentRect.size.width;
    CGFloat imageHight = contentRect.size.height;// * buttonImageRation;
    
    return CGRectMake(0, 0, imageWidth, imageHight);
}

// title的frame
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * buttonImageRation;
    CGFloat titleWidth = contentRect.size.width;
    CGFloat titleHight = contentRect.size.height - titleY;
    
    return CGRectMake(0, titleY, titleWidth, titleHight);
}


@end
