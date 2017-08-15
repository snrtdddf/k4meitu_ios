//
//  SexyGirlPicGroupTypeRequest.h
//  K4Meitu
//
//  Created by simpleem on 8/12/17.
//  Copyright © 2017 YangLei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainPagePicModel.h"
#import "MainPicGroupCell.h"

@interface SexyGirlPicGroupTypeRequest : NSObject
+ (MainPicGroupCell *)returnMainPicGroupCell:(MainPicGroupCell *)cell Model:(MainPagePicModel *)model;
@end
