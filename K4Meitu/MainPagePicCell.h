//
//  MainPagePicCell.h
//  K4Meitu
//
//  Created by simpleem on 6/19/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainPagePicCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgCover;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *date;
@property (nonatomic, strong) UILabel *count;
@property (nonatomic, strong) UIView *labelMask;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
