//
//  SexyGirlPicGroupTypeRequest.m
//  K4Meitu
//
//  Created by simpleem on 8/12/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "SexyGirlPicGroupTypeRequest.h"
#import <UIImageView+WebCache.h>
#import "GetCurrentTime.h"
#import "Header.h"
#import "commonTools.h"
@implementation SexyGirlPicGroupTypeRequest
+ (MainPicGroupCell *)returnMainPicGroupCell:(MainPicGroupCell *)cell Model:(MainPagePicModel *)model{
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"photo"]];
    
    cell.title.text = model.title;
   
    
    cell.date.text = [[model.date substringFromIndex:5] substringToIndex:5];
    
    cell.type.text = model.type;
    
    if ([[[[GetCurrentTime GetCurrentBeijingTimeandReturnTimeType:YYYY_MM_DD_and_HH_MM_SS] substringFromIndex:5] substringToIndex:5]  isEqualToString:cell.date.text]) {
        cell.latestLabel.hidden = NO;
        cell.bannerImg.hidden = NO;
        cell.latestLabel.text= @"最新";
        cell.bannerImg.image = [UIImage imageNamed:@"banner_pink"];
    }else{
        cell.latestLabel.hidden = YES;
        cell.bannerImg.hidden = YES;
        //cell.latestLabel = nil;
        //cell.bannerImg = nil;
    }
    
    cell.picCount.text = [NSString stringWithFormat:@"%d张",model.count];
    
    return cell;
}
@end
