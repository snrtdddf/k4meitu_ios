//
//  TabBar.h
//  myself - tabbar
//
//  Created by xshhanjuan on 15/10/14.
//  Copyright © 2015年 xsh. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UpDownButton.h"


@class TabBar;

/**
 *定义一个协议，当重写的这个TabBar View中某个按钮跳到另一个按钮时，捕获到的
 */
//可以用通知，也可以用KVO


@protocol TabBarDelegate <NSObject>

-(void)tabBar:(TabBar*)bar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)destination;
@end


@interface TabBar : UIView

@property (nonatomic,strong) UpDownButton *selectedButton;     //管理选中的按钮，使某一按钮从选中状态转换成未选中状态，这个按钮的属性可以做相应的变化

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property (nonatomic,strong) id<TabBarDelegate> delegate;

-(void)buttonClick:(UpDownButton*)button;

@end
