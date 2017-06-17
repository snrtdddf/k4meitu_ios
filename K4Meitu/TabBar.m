//
//  TabBar.m
//  myself - tabbar
//
//  Created by xshhanjuan on 15/10/14.
//  Copyright © 2015年 xsh. All rights reserved.
//

#import "TabBar.h"

@implementation TabBar

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //设置背景
        
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_pull_background"]];
 
    }
    return self;
}

//没添加一个item，就增加一个button
-(void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    //1.创建按钮
    UpDownButton *button = [[UpDownButton alloc]init];
    [self addSubview:button];
    
    //2. 添加按钮到数组中
    //    [self.tabBarButtons addObject:button];
    //3.设置数据
    button.item = item;
    
    //4.
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    
    //5.默认选中第0个按钮
    if (self.subviews.count == 1) {
        [self buttonClick:button];
    }
    
}

/**
 *按钮的监听事件
 */
-(void)buttonClick:(UpDownButton *)button
{
    //1.通知代理
    
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:button.tag];
    }
    //2.设置按钮的状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}


//重写layoutSubViews方法，设置各个button的frame属性
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //按钮的frame数据
    CGFloat buttonHight = self.frame.size.height;
    CGFloat buttonY = 0;
    //     CGFloat buttonWidth = self.frame.size.width/self.tabBarButtons.count;
    //在tabBar上每个按钮分到的尺寸
    CGFloat buttonWidth = self.frame.size.width/self.subviews.count;
    
    for (int index = 0; index<self.subviews.count; index++) {
        
        UpDownButton *button = self.subviews[index];
        //        [button setBackgroundImage:[UIImage imageNamed:@"tabBar_item4_1_7"] forState:UIControlStateNormal];
        CGFloat buttonX = index * buttonWidth;
        
        button.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHight);
        
        button.tag = index;
    }
}

@end
