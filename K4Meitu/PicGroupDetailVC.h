//
//  PicGroupDetailVC.h
//  K4Meitu
//
//  Created by simpleem on 6/21/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "BaseViewController.h"

@interface PicGroupDetailVC : BaseViewController

@property (nonatomic, strong) NSString *groupId;
@property (assign, nonatomic) int picCount;
@property (strong, nonatomic) NSString *picTitle;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *picDate;
@end
