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
@property (nonatomic, strong) UILabel *type;
@property (nonatomic, strong) UIView *labelMask;
@property (nonatomic, strong) UIImageView *clockIco;
@property (nonatomic, strong) UIImageView *pCountIco;
@property (nonatomic, strong) UIImageView *typeIco;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
