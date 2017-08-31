//
//  ArticleModel.m
//  K4Meitu
//
//  Created by simpleem on 8/21/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "ArticleModel.h"

@implementation ArticleModel
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"cid" : @"id",
            };
}
/*
 @property (assign, nonatomic) int cid;
 @property (strong, nonatomic) NSString *groupId;
 @property (strong, nonatomic) NSString *type;
 @property (strong, nonatomic) NSString *subType;
 @property (strong, nonatomic) NSString *title;
 @property (strong, nonatomic) NSString *preContent;
 @property (strong, nonatomic) NSString *content;
 @property (strong, nonatomic) NSString *imgUrl;
 @property (strong, nonatomic) NSString *linkUrl;
 @property (assign, nonatomic) int browseCount;
 @property (assign, nonatomic) int shareCount;
 @property (assign, nonatomic) int likeCount;
 @property (assign, nonatomic) int dislikeCount;
 @property (assign, nonatomic) int commentCount;
 @property (nonatomic, strong) NSString *date;
 */
- (void)encodeWithCoder:(NSCoder *)coder
{
    //归档的格式都是以键值的形式,key自定义，但是要与解档对应,value是我们存储的数据
    //encodeObject:归档类类型的属性
    //encodeInteger:归档普通类型的属性
    [coder encodeInt:_cid forKey:@"cid"];
    [coder encodeInt:_browseCount forKey:@"browseCount"];
    [coder encodeInt:_shareCount forKey:@"shareCount"];
    [coder encodeInt:_likeCount forKey:@"likeCount"];
    [coder encodeInt:_dislikeCount forKey:@"dislikeCount"];
    [coder encodeInt:_commentCount forKey:@"commentCount"];

    [coder encodeObject:_groupId forKey:@"groupId"];
    [coder encodeObject:_type forKey:@"type"];
    [coder encodeObject:_subType forKey:@"subType"];
    [coder encodeObject:_title forKey:@"title"];
    [coder encodeObject:_preContent forKey:@"preContent"];
    [coder encodeObject:_content forKey:@"content"];
    [coder encodeObject:_imgUrl forKey:@"imgUrl"];
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
        _cid = [coder decodeIntForKey:@"cid"];
        _browseCount = [coder decodeIntForKey:@"browseCount"];
        _shareCount = [coder decodeIntForKey:@"shareCount"];
        _likeCount = [coder decodeIntForKey:@"likeCount"];
        _dislikeCount = [coder decodeIntForKey:@"dislikeCount"];
        _commentCount = [coder decodeIntForKey:@"commentCount"];
       
        
        _groupId = [coder decodeObjectForKey:@"groupId"];
        _type = [coder decodeObjectForKey:@"type"];
        _subType = [coder decodeObjectForKey:@"subType"];
        _title = [coder decodeObjectForKey:@"title"];
        _preContent = [coder decodeObjectForKey:@"preContent"];
        _content = [coder decodeObjectForKey:@"content"];
        _imgUrl = [coder decodeObjectForKey:@"imgUrl"];
        _linkUrl = [coder decodeObjectForKey:@"linkUrl"];
        _type = [coder decodeObjectForKey:@"type"];
        _date = [coder decodeObjectForKey:@"date"];
        
        
        NSLog(@"进入解档");
    }
    return self;
}

@end
