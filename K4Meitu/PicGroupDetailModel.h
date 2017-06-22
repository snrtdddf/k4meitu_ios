//
//  PicGroupDetailModel.h
//  K4Meitu
//
//  Created by simpleem on 6/21/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PicGroupDetailModel : NSObject

@property (nonatomic, strong) NSString * _Nullable groupId;
@property (nonatomic, strong) NSString * _Nullable date;
@property (nonatomic, strong) NSString * _Nullable imgTitle;
@property (nonatomic, strong) NSString * _Nullable imgContent;
@property (nonatomic, strong) NSString * _Nullable imgUrl;
@property (nonatomic, assign) int imgId;
@property (nonatomic, assign) int imgHeight;
@property (nonatomic, assign) int imgWidth;


@end
