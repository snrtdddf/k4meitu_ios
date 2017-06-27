//
//  PicGroupDetailTitleView.h
//  K4Meitu
//
//  Created by simpleem on 6/23/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicGroupDetailTitleView : UIView

@property (strong, nonatomic) UILabel *zTitle;
@property (strong, nonatomic) UILabel *zDate;
@property (strong, nonatomic) UILabel *zCommentCount;
@property (strong, nonatomic) UILabel *zType;
@property (strong, nonatomic) UILabel *zPicCount;
@property (strong, nonatomic) UILabel *likeCount;

- (id)init;
@end
