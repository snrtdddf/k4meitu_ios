//
//  JiongPicNewestVC.h
//  K4Meitu
//
//  Created by simpleem on 7/26/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface JiongPicNewestVC : BaseViewController
@property (strong, nonatomic) NSString *groupId;
@property (strong, nonatomic) NSString *Title;
@property (strong, nonatomic) UITableView *picTable;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, assign) int curPage;
@property (nonatomic, assign) int maxPage;
- (void)requestData;
- (void)initTableView;
- (void)refreshData;
@end
