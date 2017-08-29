//
//  SecPageVC3.m
//  K4Meitu
//
//  Created by simpleem on 7/6/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "SecPageVC3.h"
#import "Header.h"
#import "SexySkillArticleRequest.h"
#import "ArticleModel.h"
@interface SecPageVC3 ()

@end

@implementation SecPageVC3

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)requestData{
    
    myWeakSelf;
    [SexySkillArticleRequest   requestType: @"性爱宝典" subType:@"两性话题" CurPage:self.curPage pCount:10 dataBlock:^(NSMutableArray *dataArr, NSInteger maxPage) {
        for (ArticleModel *model in dataArr) {
            [weakSelf.dataArr addObject:model];
        }
        weakSelf.maxPage = (int)maxPage;
        
        [weakSelf.tableView reloadData];
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
