//
//  PicGroupDetailTitleDetailView.h
//  K4Meitu
//
//  Created by simpleem on 6/26/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicGroupDetailTitleDetailView : UIView
@property (weak, nonatomic) IBOutlet UILabel *picTitle;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *picCount;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UIView *CenterSepLine;
@property (weak, nonatomic) IBOutlet UIView *LeftSepLine;
@property (weak, nonatomic) IBOutlet UIView *RightSepLine;

@end
