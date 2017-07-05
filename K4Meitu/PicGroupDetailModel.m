//
//  PicGroupDetailModel.m
//  K4Meitu
//
//  Created by simpleem on 6/21/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "PicGroupDetailModel.h"

@implementation PicGroupDetailModel
- (void)encodeWithCoder:(NSCoder *)coder
{
    /*
     @property (nonatomic, strong) NSString * _Nullable groupId;
     @property (nonatomic, strong) NSString * _Nullable date;
     @property (nonatomic, strong) NSString * _Nullable imgTitle;
     @property (nonatomic, strong) NSString * _Nullable imgContent;
     @property (nonatomic, strong) NSString * _Nullable imgUrl;
     @property (nonatomic, assign) int imgId;
     @property (nonatomic, assign) int imgHeight;
     @property (nonatomic, assign) int imgWidth;
     */
    [coder encodeInt:_imgId forKey:@"imgId"];
    [coder encodeInt:_imgHeight forKey:@"imgHeight"];
    [coder encodeInt:_imgWidth forKey:@"imgWidth"];
    
    [coder encodeObject:_groupId forKey:@"groupId"];
    [coder encodeObject:_date forKey:@"date"];
    [coder encodeObject:_imgTitle forKey:@"imgTitle"];
    [coder encodeObject:_imgContent forKey:@"imgContent"];
    [coder encodeObject:_imgUrl forKey:@"imgUrl"];
    
    NSLog(@"进入归档");
}

//归档协议中必须实现的解档方法
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        //encodeObject:解档类类型的属性
        //encodeInteger:解档普通类型的属性
        //注意：归档与解档设定的KEY要相同，否则取不到数据

        _imgId = [coder decodeIntForKey:@"imgId"];
        _imgHeight = [coder decodeIntForKey:@"imgHeight"];
        _imgWidth= [coder decodeIntForKey:@"imgWidth"];
 
        _groupId = [coder decodeObjectForKey:@"groupId"];
        _date = [coder decodeObjectForKey:@"date"];
        _imgTitle = [coder decodeObjectForKey:@"imgTitle"];
        _imgContent = [coder decodeObjectForKey:@"imgContent"];
        _imgUrl = [coder decodeObjectForKey:@"imgUrl"];
        
        NSLog(@"进入解档");
    }
    return self;
}

@end
