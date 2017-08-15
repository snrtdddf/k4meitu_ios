//
//  MainPagePicModel.m
//  K4Meitu
//
//  Created by simpleem on 6/19/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "MainPagePicModel.h"

@implementation MainPagePicModel

/*
 @property (nonatomic, strong) NSString *groupId;
 @property (nonatomic, strong) NSString *title;
 @property (nonatomic, assign) int count;
 @property (nonatomic, strong) NSString *type;
 @property (nonatomic, strong) NSString *imgUrl;
 @property (nonatomic, strong) NSString *date;
 @property (nonatomic, strong) NSString *imgCoverName;
 @property (nonatomic, assign) int imgCoverHeight;
 @property (nonatomic, assign) int imgCoverWidth;
 */
- (void)encodeWithCoder:(NSCoder *)coder
{
    //归档的格式都是以键值的形式,key自定义，但是要与解档对应,value是我们存储的数据
    //encodeObject:归档类类型的属性
    //encodeInteger:归档普通类型的属性
    [coder encodeInt:_count forKey:@"count"];
    [coder encodeInt:_imgCoverHeight forKey:@"imgCoverHeight"];
    [coder encodeInt:_imgCoverWidth forKey:@"imgCoverWidth"];
    
    [coder encodeObject:_groupId forKey:@"groupId"];
    [coder encodeObject:_title forKey:@"title"];
    [coder encodeObject:_type forKey:@"type"];
    [coder encodeObject:_imgUrl forKey:@"imgUrl"];
    [coder encodeObject:_imgCoverName forKey:@"imgCoverName"];
    [coder encodeObject:_date forKey:@"date"];
    
   
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
        //_name = [coder decodeObjectForKey:@"name"];
        // _age = [coder decodeIntegerForKey:@"age"];
        _count = [coder decodeIntForKey:@"count"];
        _imgCoverHeight = [coder decodeIntForKey:@"imgCoverHeight"];
        _imgCoverWidth = [coder decodeIntForKey:@"imgCoverWidth"];
        
        _groupId = [coder decodeObjectForKey:@"groupId"];
        _title = [coder decodeObjectForKey:@"title"];
        _type = [coder decodeObjectForKey:@"type"];
        _imgUrl = [coder decodeObjectForKey:@"imgUrl"];
        _imgCoverName = [coder decodeObjectForKey:@"imgCoverName"];
        _date = [coder decodeObjectForKey:@"date"];
        
    }
    return self;
}

@end
