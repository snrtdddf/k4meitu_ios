//
//  funcBtnListView.h
//  GoldWallet
//
//  Created by simpleem on 16/10/29.
//  Copyright © 2016年 China_Gold_Infomation. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol funcBtnListDelegate <NSObject>

- (void)funcBtnAction:(UIButton *)btn;

@end

@interface funcBtnListView : UIView
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) NSString *linkUrl;
@property (nonatomic, strong) UIButton *funcBtn;
@property (nonatomic, weak) id<funcBtnListDelegate> delegate;
- (id)initWithFrame:(CGRect)frame funcBtnList:(NSMutableArray *)funcBtnArray CountPerline:(int)lineCount;
@end
