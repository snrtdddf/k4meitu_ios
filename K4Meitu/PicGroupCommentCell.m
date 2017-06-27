//
//  PicGroupCommentCell.m
//  K4Meitu
//
//  Created by simpleem on 6/22/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "PicGroupCommentCell.h"

@implementation PicGroupCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.comment.numberOfLines = 0;
    [self.comment sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
