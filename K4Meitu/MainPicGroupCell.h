//
//  MainPicGroupCell.h
//  K4Meitu
//
//  Created by simpleem on 6/26/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainPicGroupCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *picCount;
@property (weak, nonatomic) IBOutlet UILabel *date;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *SeplineLeftSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secSeplineLeftSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgCountLeftSpce;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picCountLabLeftSpace;
@property (weak, nonatomic) IBOutlet UIImageView *tagImg;
@property (weak, nonatomic) IBOutlet UIImageView *countImg;
@property (weak, nonatomic) IBOutlet UIImageView *clockImg;
@property (weak, nonatomic) IBOutlet UIView *textBgView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dateLabLeftSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagImgLeftSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeLabLeftSpace;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *clockImgLeftSpace;

@property (weak, nonatomic) IBOutlet UIImageView *bannerImg;
@property (weak, nonatomic) IBOutlet UILabel *latestLabel;
@property (weak, nonatomic) IBOutlet UIImageView *isVIP;


@end
