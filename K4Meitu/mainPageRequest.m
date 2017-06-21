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

+ (MainPagePicCell *)returnMainPagePicCell:(MainPagePicCell *)cell Model:(MainPagePicModel *)model{
    
    //image
    cell.imgCover.frame = CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_WIDTH * model.imgCoverHeight/model.imgCoverWidth);
    [cell.imgCover sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"photo"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//点击cell没点击阴影效果
    
    //mask
    cell.labelMask.frame = CGRectMake(0, cell.imgCover.frame.size.height-SPH(60), IPHONE_WIDTH, SPH(60));
    
    //title
    cell.title.frame = CGRectMake(SPW(15), 0, IPHONE_WIDTH-SPW(15), cell.labelMask.frame.size.height*0.6);
    cell.title.text = model.title;
    
    //clockIco
    cell.clockIco.frame = CGRectMake(IPHONE_WIDTH*0.68, cell.labelMask.frame.size.height*0.63, SPW(16), SPW(16));
    cell.clockIco.image = [UIImage imageNamed:@"clockMain"];
    
    //date
    cell.date.frame = CGRectMake(IPHONE_WIDTH*0.67, cell.labelMask.frame.size.height*0.55, IPHONE_WIDTH*0.3, cell.labelMask.frame.size.height*0.4);
    cell.date.text = model.date;
    
    //typeIco
    cell.typeIco.frame = CGRectMake(SPW(15), cell.labelMask.frame.size.height*0.63, SPW(24), SPW(16));
    cell.typeIco.image = [UIImage imageNamed:@"tagMain"];
    
    //type
    cell.type.frame = CGRectMake(SPW(40), cell.labelMask.frame.size.height*0.55, SPW(100), cell.labelMask.frame.size.height*0.4);
    cell.type.text = @"标签:性感";
    
    //pCountIco
    cell.pCountIco.frame = CGRectMake(model.count>9?IPHONE_WIDTH*0.6-SPW(69):IPHONE_WIDTH-SPW(62), cell.labelMask.frame.size.height*0.63, SPW(20), SPW(16));
    cell.pCountIco.image = [UIImage imageNamed:@"imgCount"];
    
    //count
    cell.count.frame = CGRectMake(IPHONE_WIDTH*0.6-SPW(45), cell.labelMask.frame.size.height*0.55, SPW(40), cell.labelMask.frame.size.height*0.4);
    cell.count.text = [NSString stringWithFormat:@"%d张",model.count];
    
    return cell;
}

@end
