//
//  FourthPageHeaderView.m
//  K4Meitu
//
//  Created by simpleem on 9/20/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "FourthPageHeaderView.h"
#import "Header.h"
#define frame_h frame.size.height
#define frame_w frame.size.width
@implementation FourthPageHeaderView

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
       
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, frame_h-8)];
        img.image = [UIImage imageNamed:@"jbs.jpg"];
        
        UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(img.frame)-8, IPHONE_WIDTH, 8)];
        separatorView.backgroundColor = S_Light_Gray;
        
        self.userIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        self.userIcon.frame = CGRectMake((IPHONE_WIDTH-85)/2, (frame_h-85)/2-frame_h*0.15, 85, 85);
        self.userIcon.layer.cornerRadius = 85/2;
        self.userIcon.clipsToBounds = YES;
        self.userIcon.layer.borderColor = White_COLOR.CGColor;
        self.userIcon.layer.borderWidth = 3;
        [self.userIcon setImage:[UIImage imageNamed:@"starSky_bg_2.jpg"] forState:UIControlStateNormal];
        
        self.nickNameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.nickNameBtn.frame = CGRectMake(0, CGRectGetMaxY(self.userIcon.frame)+15, IPHONE_WIDTH, 15);
        [self.nickNameBtn setTitle:@"爱在江南听雨" forState:UIControlStateNormal];
        [self.nickNameBtn setTitleColor:White_COLOR forState:UIControlStateNormal];
        
        self.vipIcon = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userIcon.frame)-20, CGRectGetMaxY(self.userIcon.frame)-20, 20, 20)];
        self.vipIcon.image = [UIImage imageNamed:@"icon_v"];

        
        [self addSubview:img];
        [self addSubview:separatorView];
        [self addSubview:self.userIcon];
        [self addSubview:self.nickNameBtn];
        [self addSubview:self.vipIcon];
        
        
    }
    return self;
}

@end
