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
        self.labelMask.backgroundColor = [UIColor whiteColor];
        self.labelMask.alpha = 0.9;
        
        self.title = [[UILabel alloc] init];
        self.title.font = [UIFont systemFontOfSize:17.0f];
        self.title.textAlignment = NSTextAlignmentLeft;
        self.title.textColor = [UIColor colorWithRed:252.0/255 green:127.0/255 blue:171.0/255 alpha:1];
        
        self.date = [[UILabel alloc] init];
        self.date.font = [UIFont systemFontOfSize:14.0f];
        self.date.textAlignment = NSTextAlignmentRight;
        self.date.textColor = [UIColor grayColor];
        
        self.type = [[UILabel alloc] init];
        self.type.font = [UIFont systemFontOfSize:14.0f];
        self.type.textAlignment = NSTextAlignmentLeft;
        self.type.textColor = [UIColor grayColor];

        
        self.count = [[UILabel alloc] init];
        self.count.font = [UIFont systemFontOfSize:14.0f];
        self.count.textAlignment = NSTextAlignmentLeft;
        self.count.textColor = [UIColor grayColor];
        
        self.clockIco = [[UIImageView alloc] init];
        self.typeIco = [[UIImageView alloc] init];
        self.pCountIco = [[UIImageView alloc] init];
        
        [self.contentView addSubview:self.imgCover];
        [self.contentView addSubview:self.labelMask];
        [self.labelMask addSubview:self.title];
        [self.labelMask addSubview:self.date];
        [self.labelMask addSubview:self.count];
        [self.labelMask addSubview:self.type];
        [self.labelMask addSubview:self.pCountIco];
        [self.labelMask addSubview:self.clockIco];
        [self.labelMask addSubview:self.typeIco];
    }
    return self;
}
@end
