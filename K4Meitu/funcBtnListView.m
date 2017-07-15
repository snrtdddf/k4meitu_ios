//
//  funcBtnListView.m
//  GoldWallet
//
//  Created by simpleem on 16/10/29.
//  Copyright © 2016年 China_Gold_Infomation. All rights reserved.
//

#import "funcBtnListView.h"
#import "Header.h"
#import "GroupMenuBtnModel.h"
#import "commonTools.h"
#import <UIImageView+WebCache.h>
#define frame_w frame.size.width
#define frame_h frame.size.height
@implementation funcBtnListView

- (id)initWithFrame:(CGRect)frame funcBtnList:(NSMutableArray *)funcBtnArray CountPerline:(int)lineCount{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSInteger row = funcBtnArray.count/lineCount + 1;
        NSInteger col = funcBtnArray.count%lineCount;
        NSInteger arrayCount = funcBtnArray.count;
        CGFloat btnWidth = IPHONE_WIDTH / lineCount;
        CGFloat btnHeight = frame_h/row;
        
        if (funcBtnArray.count == 0) {
            for (int i=0; i<10; i++) {
                GroupMenuBtnModel *model = [[GroupMenuBtnModel alloc]init];
                model.gid = i;
                model.titleImgUrl = @"photo.png";
                model.title = @"...";
                model.date = @"1497336042000";
            }
            row = 2;
            col = 5;
            arrayCount = 10;
        }
        
        for(NSInteger i=0; i<row; i++){
            for (NSInteger j=0; j<((arrayCount-lineCount*i)>=lineCount?lineCount:col); j++) {
                GroupMenuBtnModel *model = funcBtnArray[i*lineCount+j];
                //按钮
                self.funcBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                self.funcBtn.backgroundColor = [UIColor whiteColor];
                self.funcBtn.frame =CGRectMake(
                                               frame_w*j/lineCount,
                                               btnHeight*i,
                                               btnWidth,
                                               btnHeight
                                               );
                self.funcBtn.tag = 1000 + i*lineCount+j;
                //按钮图片
                self.image = [[UIImageView alloc]initWithFrame:CGRectMake(
                            (self.funcBtn.frame.size.width-btnHeight*0.7)/2,
                            (self.funcBtn.frame.size.height-btnHeight*0.7)/4, btnHeight*0.7,
                                btnHeight*0.7)];
                self.image.layer.cornerRadius = btnHeight*0.7/2;
                self.image.clipsToBounds = YES;
               
                if ([model.titleImgUrl hasPrefix:@"http"]) {
                     [self.image sd_setImageWithURL:[NSURL URLWithString:model.titleImgUrl] placeholderImage:[UIImage imageNamed:@"photo"]];
                }else{
                    self.image.image = [UIImage imageNamed:@"photo"];
                }
                //按钮文字
                self.title = [[UILabel alloc]initWithFrame:CGRectMake(0,  CGRectGetMaxY(self.image.frame), btnWidth, 0.2*btnHeight)];
                self.title.text = model.title;
                self.title.font = (IS_Phone4S||IS_Phone5S) ? ([UIFont systemFontOfSize:13]) : ([UIFont systemFontOfSize:14]);
                self.title.textColor = [UIColor grayColor];
                self.title.textAlignment = NSTextAlignmentCenter;
                [self.funcBtn addTarget:self action:@selector(funcListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                
                
                [self.funcBtn addSubview:self.image];
                [self.funcBtn addSubview:self.title];
        
                [self addSubview:self.funcBtn];
            }
        }
    }
    return self;
}


- (void)funcListBtnClick:(UIButton *)btn{
    [self.delegate funcBtnAction:(UIButton *)btn];
//    if ([self.linkUrl hasPrefix:@"http://"]||[self.linkUrl hasPrefix:@"https://"]) {
//       [self.delegate funcBtnAction:(UIButton *)btn];
//    }else{
//        [commonTools showBriefAlert:@"开发中，敬请期待"];
//    }

}

@end
