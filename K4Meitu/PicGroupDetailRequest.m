//
//  PicGroupDetailRequest.m
//  K4Meitu
//
//  Created by simpleem on 6/21/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "PicGroupDetailRequest.h"
#import "RequestManager.h"
#import "Header.h"
#import "commonTools.h"
#import "PicGroupDetailModel.h"
#import "GetCurrentTime.h"
#import "PYPhotoBrowser.h"

@implementation PicGroupDetailRequest

+ (void)requestData:(NSString *)groupId  dataBlock:(DataBlock)block{
    [RequestManager getMainPagePicListDetailGroupId:groupId success:^(NSData *data) {
        NSDictionary *resDict = myJsonSerialization;
        NSMutableArray *dataArr = [NSMutableArray array];
        NSLog(@"res:%@",resDict);
        [commonTools HideActivityIndicator];
        if ([resDict[@"success"] boolValue]) {
            NSArray *list = resDict[@"res"][@"list"];
            if (list.count != 0) {
                for (NSDictionary *dict in list) {
                    PicGroupDetailModel *model = [[PicGroupDetailModel alloc] init];
                    model.groupId = dict[@"groupId"];
                    model.imgTitle = dict[@"imgTitle"];
                    model.imgWidth = [dict[@"imgWidth"] intValue];
                    model.imgHeight = [dict[@"imgHeight"] intValue];
                    model.date = [GetCurrentTime GetTimeFromTimeStamp:[NSString stringWithFormat:@"%@",dict[@"date"]] andReturnTimeType:YYYY_MM_DD];
                    model.imgContent = dict[@"imgContent"];
                    model.imgId = [dict[@"imgId"] intValue];
                    model.imgUrl = dict[@"imgUrl"];
                    [dataArr addObject:model];
                }
                
                block(dataArr);
            }
        }else{
            [commonTools showBriefAlert:ErrorMsg];
        }
    } failed:^(NSError *error) {
        
    }];
}

+ (UIScrollView *)imgScrollView:(NSMutableArray *)imgUrls{
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT-64)];
    
    
    // 2.1 创建一个流水布局photosView(默认为流水布局)
    PYPhotosView *flowPhotosView = [PYPhotosView photosView];
    //flowPhotosView.frame = CGRectMake(0, 40, IPHONE_WIDTH, IPHONE_HEIGHT);
    // 设置缩略图数组
    flowPhotosView.thumbnailUrls = imgUrls;
    // 设置原图地址
    flowPhotosView.originalUrls = imgUrls;
    // 设置分页指示类型
    flowPhotosView.pageType = PYPhotosViewPageTypeLabel;
    //flowPhotosView.py_centerX = weakSelf.view.py_centerX;
    flowPhotosView.py_y = SPH(11);
    flowPhotosView.py_x = SPW(11);
    flowPhotosView.photoWidth = SPW(114);
    flowPhotosView.photoHeight = SPW(114);
    flowPhotosView.photoMargin = SPW(5);
    
    
    scroll.contentSize = CGSizeMake(IPHONE_WIDTH, flowPhotosView.frame.size.height+SPH(10));
     [scroll addSubview:flowPhotosView];
    
    return scroll;
}
@end
