//
//  PicGroupCommentCell.h
//  K4Meitu
//
//  Created by simpleem on 6/22/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicGroupCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UILabel *commentFloor;
@property (weak, nonatomic) IBOutlet UILabel *cmtLikeCount;
@property (weak, nonatomic) IBOutlet UILabel *cmtDislikeCount;
@property (weak, nonatomic) IBOutlet UIButton *cmtDislikeBtn;
@property (weak, nonatomic) IBOutlet UIButton *cmtLikeBtn;

@end
