//
//  PicGroupCommentModel.m
//  K4Meitu
//
//  Created by simpleem on 6/22/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "PicGroupCommentModel.h"

@implementation PicGroupCommentModel
/*
 @property (nonatomic, assign) int commentId;
 @property (nonatomic, assign) int isCmtShow;
 @property (nonatomic, strong) NSString *groupId;
 @property (nonatomic, strong) NSString *userId;
 @property (nonatomic, strong) NSString *imgComment;
 @property (assign, nonatomic) int commentLike;
 @property (assign, nonatomic) int commentDislike;
 @property (nonatomic, strong) NSString *date;
 @property (nonatomic) BOOL isSetCmtLike;
 @property (nonatomic) BOOL isSetDiscmtLike;
 */
//归档协议中必须实现的归档方法

- (void)encodeWithCoder:(NSCoder *)coder
{
    //归档的格式都是以键值的形式,key自定义，但是要与解档对应,value是我们存储的数据
    //encodeObject:归档类类型的属性
    //encodeInteger:归档普通类型的属性
    [coder encodeInt:_commentId forKey:@"commentId"];
    [coder encodeInt:_isCmtShow forKey:@"isCmtShow"];
    [coder encodeInt:_commentLike forKey:@"commentLike"];
    [coder encodeInt:_commentDislike forKey:@"commentDislike"];
    
    
    [coder encodeObject:_groupId forKey:@"groupId"];
    [coder encodeObject:_userId forKey:@"userId"];
    [coder encodeObject:_imgComment forKey:@"imgComment"];
    [coder encodeObject:_date forKey:@"date"];
    
    [coder encodeBool:_isSetCmtLike forKey:@"isSetCmtLike"];
    [coder encodeBool:_isSetDiscmtLike forKey:@"isSetDiscmtLike"];
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
        _commentId = [coder decodeIntForKey:@"commentId"];
        _isCmtShow = [coder decodeIntForKey:@"isCmtShow"];
        _commentLike= [coder decodeIntForKey:@"commentLike"];
        _commentDislike = [coder decodeIntForKey:@"commentDislike"];
        
        
        _groupId = [coder decodeObjectForKey:@"groupId"];
        _userId = [coder decodeObjectForKey:@"userId"];
        _imgComment = [coder decodeObjectForKey:@"imgComment"];
        _date = [coder decodeObjectForKey:@"date"];
        
        _isSetCmtLike = [coder decodeBoolForKey:@"isSetCmtLike"];
        _isSetDiscmtLike = [coder decodeBoolForKey:@"isSetDiscmtLike"];
        NSLog(@"进入解档");
    }
    return self;
}
 

@end
