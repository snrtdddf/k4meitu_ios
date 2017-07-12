//
//  funcBtnListView.m
//  GoldWallet
//
//  Created by simpleem on 16/10/29.
//  Copyright © 2016年 China_Gold_Infomation. All rights reserved.
//

#import "funcBtnListView.h"
#import "Header.h"
#import "funcBtnModel.h"
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
        CGFloat btnHeight = btnWidth*1.2;
        
        for(NSInteger i=0; i<row; i++){
            for (NSInteger j=0; j<((arrayCount-lineCount*i)>=lineCount?lineCount:col); j++) {
                funcBtnModel *model = funcBtnArray[i*lineCount+j];
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
                            (self.funcBtn.frame.size.width-btnWidth*0.7)/2,
                            (self.funcBtn.frame.size.height-btnWidth*0.7)/4, btnWidth*0.7,
                                btnWidth*0.7)];
                self.image.layer.cornerRadius = btnWidth*0.7/2;
                self.image.clipsToBounds = YES;
                 [self.image sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"photo"]];
                //按钮文字
                self.title = [[UILabel alloc]initWithFrame:CGRectMake(0, self.image.frame.size.height + self.image.frame.origin.y + self.funcBtn.frame.size.height*0.05, btnWidth, 0.2*btnHeight)];
                self.title.text = model.showTxt;
                self.title.font = (IS_Phone4S||IS_Phone5S) ? ([UIFont systemFontOfSize:15]) : ([UIFont systemFontOfSize:16]);
                self.title.textAlignment = NSTextAlignmentCenter;
                [self.funcBtn addTarget:self action:@selector(funcListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                
                //按钮链接
                self.linkUrl = model.linkUrl;
                
                
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
