//
//  ThirdTujianCell.m
//  K4Meitu
//
//  Created by simpleem on 8/16/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "ThirdTujianCell.h"

@implementation ThirdTujianCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.Title.numberOfLines = 0;
    self.Title.textAlignment = NSTextAlignmentLeft;
    [self.Title sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
