//
//  mainPageRequest.h
//  K4Meitu
//
//  Created by simpleem on 6/20/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainPagePicCell.h"
#import "MainPagePicModel.h"
@interface mainPageRequest : NSObject

+ (MainPagePicCell *)returnMainPagePicCell:(MainPagePicCell *)cell Model:(MainPagePicModel *)model;

@end
