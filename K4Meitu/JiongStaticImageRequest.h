//
//  JiongStaticImageRequest.h
//  K4Meitu
//
//  Created by simpleem on 8/2/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import "JiongPicNewestRequest.h"

@interface JiongStaticImageRequest : JiongPicNewestRequest
+ (void)requestCurPage:(int)curPage type:(NSString *)type dataBlock:(dataBlock)block;
@end
