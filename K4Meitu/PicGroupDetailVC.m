//
//  PicGroupDetailVC.m
//  K4Meitu
//
//  Created by simpleem on 6/21/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "PicGroupDetailVC.h"
#import "Header.h"
#import "PYPhotoBrowser.h"
#import "PicGroupDetailRequest.h"
#import "PicGroupDetailModel.h"
@interface PicGroupDetailVC ()

@end

@implementation PicGroupDetailVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackButton:NO];
    [self addStatusBlackBackground];
    [self addTitleWithName:@"套图" wordNun:4];
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    [self requestData];
    
}
- (UIButton *)addfloatBackButton{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(IPHONE_WIDTH*0.8, IPHONE_HEIGHT*0.9, SPW(30), SPW(50));
    backBtn.titleLabel.text = @"返回主页";
    backBtn.backgroundColor = [UIColor whiteColor];
    
    return backBtn;
}

- (void)requestData{

    [PicGroupDetailRequest requestData:self.groupId dataBlock:^(NSMutableArray *dataArr) {
        myWeakSelf;
        NSMutableArray *imgUrls = nil;
        imgUrls = [[NSMutableArray alloc] init];
        for (PicGroupDetailModel *model in dataArr) {
            [imgUrls addObject:model.imgUrl];
        }
        //缩略图列表
        UIScrollView *scroll = [PicGroupDetailRequest imgScrollView:imgUrls];
        
        [weakSelf.view addSubview:scroll];
       
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
