//
//  mainPageRequest.m
//  K4Meitu
//
//  Created by simpleem on 6/20/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "mainPageRequest.h"
#import <UIImageView+WebCache.h>
#import "Header.h"
@implementation mainPageRequest


+ (MainPicGroupCell *)returnMainPicGroupCell:(MainPicGroupCell *)cell Model:(MainPagePicModel *)model{
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"photo"]];
    
    cell.title.text = model.title;
    cell.date.text = [model.date substringFromIndex:5];
    
    cell.type.text = @"性感";
    
    cell.picCount.text = [NSString stringWithFormat:@"%d张",model.count];
    
    return cell;
}
@end
