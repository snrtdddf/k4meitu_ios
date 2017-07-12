//
//  SecPageVCRequest.m
//  K4Meitu
//
//  Created by simpleem on 7/12/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "SecPageVCRequest.h"
#import <NSObject+YYModel.h>
#import "RequestManager.h"
#import "Header.h"
#import "funcBtnModel.h"

@implementation SecPageVCRequest
+ (void)requestFromKeywordList:(DataBlock)block{
    [RequestManager getKeyWordListIsOrderByCount:@"NO" CurPage:@0 pCount:@10 success:^(NSData *data) {
        NSMutableArray *dataArr = [NSMutableArray array];
        NSDictionary *resDict = myJsonSerialization;
        NSArray *resArr = resDict[@"res"][@"list"];
        if (resArr.count != 0) {
            for (NSDictionary *dict in resArr) {
                funcBtnModel *model = [funcBtnModel modelWithJSON:dict];
                [dataArr addObject:model];
            }
            block(dataArr);
        }
    } failed:^(NSError *error) {
        
    }];
}

+ (SecPageHotCmtView *)hotCommentViewFrame:(CGRect)frame{
   
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"SecPageHotCmtView" owner:nil options:nil];
    
    SecPageHotCmtView *hotCmtView = [nibContents lastObject];
    hotCmtView.frame = frame;
    hotCmtView.hotCmtLab1.layer.borderColor = Red_COLOR.CGColor;
    hotCmtView.hotCmtLab2.layer.borderColor = Red_COLOR.CGColor;
    hotCmtView.hotCmtLab1.layer.borderWidth = 1;
    hotCmtView.hotCmtLab2.layer.borderWidth = 1;
    hotCmtView.hotCmtLab1.layer.cornerRadius = 3;
    hotCmtView.hotCmtLab2.layer.cornerRadius = 3;
    hotCmtView.hotCmtLab1.clipsToBounds = YES;
    hotCmtView.hotCmtLab2.clipsToBounds = YES;
    hotCmtView.hotCmtLab1.textColor = Red_COLOR;
    hotCmtView.hotCmtLab2.textColor = Red_COLOR;
    
    return hotCmtView;
}


@end
