//
//  MainPicGroupCell.m
//  K4Meitu
//
//  Created by simpleem on 6/26/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "MainPicGroupCell.h"
#import "Header.h"
@implementation MainPicGroupCell

- (void)awakeFromNib {
    [super awakeFromNib];
     self.selectionStyle = UITableViewCellSelectionStyleNone;//点击cell没点击阴影效果
    self.secSeplineLeftSpace.constant = IPHONE_WIDTH*0.666;
    self.SeplineLeftSpace.constant = IPHONE_WIDTH*0.333;
    self.imgCountLeftSpce.constant = IPHONE_WIDTH*0.42;
    self.picCountLabLeftSpace.constant = IPHONE_WIDTH*0.42+20;
    
    self.tagImgLeftSpace.constant = IPHONE_WIDTH*0.1;
    self.typeLabLeftSpace.constant = IPHONE_WIDTH*0.1+20;
    
    self.clockImgLeftSpace.constant = IPHONE_WIDTH*0.72;
    self.dateLabLeftSpace.constant = IPHONE_WIDTH*0.72+20;
    
    if (IPHONE_WIDTH > 375) {
        self.imgCountLeftSpce.constant = IPHONE_WIDTH*0.45;
        self.picCountLabLeftSpace.constant = IPHONE_WIDTH*0.45+20;
        
        
        self.tagImgLeftSpace.constant = IPHONE_WIDTH*0.13;
        self.typeLabLeftSpace.constant = IPHONE_WIDTH*0.13+20;
        
        self.clockImgLeftSpace.constant = IPHONE_WIDTH*0.77;
        self.dateLabLeftSpace.constant = IPHONE_WIDTH*0.77+20;
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
