//
//  GroupMenuBtnModel.h
//  K4Meitu
//
//  Created by simpleem on 7/15/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupMenuBtnModel : NSObject
/*

 imgUrl1: "",
 imgUrl2: "",
 imgUrl3: "",
 imgUrl4: "",
 linkUrl: "",
 date: 1500084963000
 */
@property (assign, nonatomic) int gid;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *groupId;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *subTitle;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *titleImgUrl;
@property (strong, nonatomic) NSString *imgUrl1;
@property (strong, nonatomic) NSString *imgUrl2;
@property (strong, nonatomic) NSString *imgUrl3;
@property (strong, nonatomic) NSString *imgUrl4;
@property (strong, nonatomic) NSString *linkUrl;
@property (strong, nonatomic) NSString *date;
+ (NSDictionary *)modelCustomPropertyMapper;
@end
