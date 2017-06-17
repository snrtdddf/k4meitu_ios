//
//  NSString+ASCIILength.m
//  GoldWallet
//
//  Created by simpleem on 16/10/11.
//  Copyright © 2016年 China_Gold_Infomation. All rights reserved.
//

#import "NSString+ASCIILength.h"

@implementation NSString (ASCIILength)

- (int)getASCIILength{
    if ((self == NULL) || (self == nil)) {
        return 0;
    }
    int strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
}

@end
