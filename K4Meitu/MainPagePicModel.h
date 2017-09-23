//
//  MainPagePicModel.h
//  K4Meitu
//
//  Created by simpleem on 6/19/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainPagePicModel : NSObject

@property (nonatomic, strong) NSString *groupId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) int count;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *imgCoverName;
@property (nonatomic, assign) int imgCoverHeight;
@property (nonatomic, assign) int imgCoverWidth;
@property (assign, nonatomic) int vip;


@end
