//
//  MainPagePicCell.m
//  K4Meitu
//
//  Created by simpleem on 6/19/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "MainPagePicCell.h"
#import "Header.h"
@implementation MainPagePicCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imgCover = [[UIImageView alloc] init];
       
        self.labelMask = [[UIView alloc] init];
        self.labelMask.backgroundColor = [UIColor blackColor];
        self.labelMask.alpha = 0.7;
        
        self.title = [[UILabel alloc] init];
        self.title.font = [UIFont systemFontOfSize:17.0f];
        self.title.textAlignment = NSTextAlignmentLeft;
        self.title.textColor = [UIColor whiteColor];
        
        self.date = [[UILabel alloc] init];
        self.date.font = [UIFont systemFontOfSize:15.0f];
        self.date.textAlignment = NSTextAlignmentLeft;
        self.date.textColor = [UIColor whiteColor];
        
        self.count = [[UILabel alloc] init];
        self.count.font = [UIFont systemFontOfSize:15.0f];
        self.count.textAlignment = NSTextAlignmentRight;
        self.count.textColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.imgCover];
        [self.contentView addSubview:self.labelMask];
        [self.labelMask addSubview:self.title];
        [self.labelMask addSubview:self.date];
        [self.labelMask addSubview:self.count];
        
    }
    return self;
}
@end
