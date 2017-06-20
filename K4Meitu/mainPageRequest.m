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
    cell.labelMask.frame = CGRectMake(0, cell.imgCover.frame.size.height-SPH(50), IPHONE_WIDTH, SPH(50));
    
    //title
    cell.title.frame = CGRectMake(SPW(15), 0, IPHONE_WIDTH-SPW(15), cell.labelMask.frame.size.height*0.6);
    cell.title.text = model.title;
    
    //date
    cell.date.frame = CGRectMake(SPW(15), cell.labelMask.frame.size.height*0.6, IPHONE_WIDTH*0.5-SPW(15), cell.labelMask.frame.size.height*0.4);
    cell.date.text = model.date;
    
    
    //count
    cell.count.frame = CGRectMake(IPHONE_WIDTH*0.5, cell.labelMask.frame.size.height*0.6, IPHONE_WIDTH*0.5-SPW(15), cell.labelMask.frame.size.height*0.4);
    cell.count.text = [NSString stringWithFormat:@"%dP ",model.count];
    
    return cell;
}

@end
