//
//  GroupMenuBtnModel.m
//  K4Meitu
//
//  Created by simpleem on 7/15/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "GroupMenuBtnModel.h"

@implementation GroupMenuBtnModel
/*
 id: 1,
 type: "funcBtn",
 groupId: "",
 title: "美臀",
 subTitle: "",
 content: null,
 titleImgUrl: "http://ys-k.ys168.com/342481687/nxqtxit7M3J565S5Q73/1.png",
 imgUrl1: "",
 imgUrl2: "",
 imgUrl3: "",
 imgUrl4: "",
 linkUrl: "",
 date: 1500084963000
 */
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"gid" : @"id",
             @"type" : @"type",
             @"groupId" : @"groupId",
             @"title" : @"title",
             @"subTitle" : @"subTitle",
             @"content" : @"content",
             @"titleImgUrl" : @"titleImgUrl",
             @"imgUrl1" : @"imgUrl1",
             @"imgUrl2" : @"imgUrl2",
             @"imgUrl3" : @"imgUrl3",
             @"imgUrl4" : @"imgUrl4",
             @"linkUrl" : @"linkUrl",
             @"date" : @"date",
             };
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    //归档的格式都是以键值的形式,key自定义，但是要与解档对应,value是我们存储的数据
    //encodeObject:归档类类型的属性
    //encodeInteger:归档普通类型的属性
    [coder encodeInt:_gid forKey:@"gid"];
   
    [coder encodeObject:_type forKey:@"type"];
    [coder encodeObject:_groupId forKey:@"groupId"];
    [coder encodeObject:_title forKey:@"title"];
    [coder encodeObject:_subTitle forKey:@"subTitle"];
    [coder encodeObject:_content forKey:@"content"];
    [coder encodeObject:_titleImgUrl forKey:@"titleImgUrl"];
    [coder encodeObject:_imgUrl1 forKey:@"imgUrl1"];
    [coder encodeObject:_imgUrl2 forKey:@"imgUrl2"];
    [coder encodeObject:_imgUrl3 forKey:@"imgUrl3"];
    [coder encodeObject:_imgUrl4 forKey:@"imgUrl4"];
    [coder encodeObject:_linkUrl forKey:@"linkUrl"];
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
        _gid = [coder decodeIntForKey:@"gid"];
        
        _groupId = [coder decodeObjectForKey:@"groupId"];
        _title = [coder decodeObjectForKey:@"title"];
        _subTitle = [coder decodeObjectForKey:@"subTitle"];
        _content = [coder decodeObjectForKey:@"content"];
        _titleImgUrl = [coder decodeObjectForKey:@"titleImgUrl"];
        _imgUrl1 = [coder decodeObjectForKey:@"imgUrl1"];
        _imgUrl2 = [coder decodeObjectForKey:@"imgUrl2"];
        _imgUrl3 = [coder decodeObjectForKey:@"imgUrl3"];
        _imgUrl4 = [coder decodeObjectForKey:@"imgUrl4"];
        _linkUrl = [coder decodeObjectForKey:@"linkUrl"];
        _type = [coder decodeObjectForKey:@"type"];
        _date = [coder decodeObjectForKey:@"date"];
        
       
        NSLog(@"进入解档");
    }
    return self;
}


@end
