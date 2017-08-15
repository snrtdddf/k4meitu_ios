//
//  MainViewController.h
//  K4Meitu
//
//  Created by simpleem on 6/17/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "ViewController.h"
#import "BaseViewController.h"
@interface MainViewController : BaseViewController

@property (nonatomic, strong) UITableView *picTable;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, assign) int curPage;
@property (nonatomic, assign) int maxPage;
@property (strong, nonatomic) NSString *keyword;


- (void)picTableInit;
- (void)requestData;
- (void)refreshData;

@end
