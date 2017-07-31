//
//  JiongPicNewestCell.h
//  K4Meitu
//
//  Created by simpleem on 7/26/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLAnimatedImage.h"
@interface JiongPicNewestCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIButton *likeCount;
@property (weak, nonatomic) IBOutlet UIButton *dislikeCount;
@property (weak, nonatomic) IBOutlet UIButton *cmtCount;
@property (weak, nonatomic) IBOutlet UIButton *share;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consRight;

@end
