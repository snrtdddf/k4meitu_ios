//
//  SecPageVC1.h
//  K4Meitu
//
//  Created by simpleem on 7/6/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "YXViewPagerBaseSubViewController.h"
#import <YYDiskCache.h>
#import <YYCache.h>
@interface SecPageVC1 : YXViewPagerBaseSubViewController
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIScrollView *scroll;
@property (strong, nonatomic) NSMutableArray *dataArr;
@property (assign, nonatomic) int curPage;
@property (assign, nonatomic) int maxPage;
@property (strong, nonatomic) YYDiskCache *cache;
@end
