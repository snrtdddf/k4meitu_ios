//
//  commonTools.h
//  DealGold
//
//  Created by simpleem on 16/8/9.
//  Copyright © 2016年 China_Gold_Infomation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"
#import "NSString+isContainEmoji.h"
#import "MBManager.h"
#import <UIKit/UIKit.h>
@interface commonTools : NSObject

//TextField的类型枚举，格式化TextField用的             
typedef NS_ENUM(NSInteger, TextFiledNumType) {
    tel = 0,
    idCard = 1,
    bankCard = 2
};

// 检查是否是电话号码
+ (BOOL)checkPhoneNumInput:(NSString *)mobileNum;
/**
 *   验证是否为中国邮政编码
 */
+ (BOOL)isPostCodeWithCodeString:(NSString *)codeString;

/**
 *  检查是否是电话号码
 */
+ (BOOL)isPhoneNumInput:(NSString *)phoneNum;


/**
 *  检查身份证号
 */
+ (BOOL)isIdentityCard:(NSString *)identityCard;


/**
 *   纯汉字
 */
+ (BOOL)isChinese:(NSString *)validChinese;


/**
 *  验证银行卡号
 */
+(BOOL)isBankCardNo:(NSString*)cardNo;


/**
 *  检测是否是数字
 */
+(BOOL)isValidNumber:(NSString*)number;


/**
 *  检测是否是浮点数字
 */
+(BOOL)isFloatNumber:(NSString *)number;

/**
 *  判断是否是正确中文名字
 */
+(BOOL)isCHNameWithName:(NSString *)name;


/**
 *  是否包含中文
 */
+ (BOOL)isIncludeChineseInString:(NSString*)str;


/**
 *	设置UITextField Placeholder 的字体大小，颜色。
 *
 *	@param 	textField 	要设置的UITextField
 *	@param 	fontSize 	字体大小
 *	@param 	color 	字体颜色（如使用默认的颜色，使用nil值）
 */
+ (void)setPlaceholderAttributed:(UITextField *)textField withSystemFontSize:(CGFloat)fontSize withColor:(UIColor *)color;


/**
 *功能：获取字体高度，用于动态计算label高度。
 *   @param  value 要计算高度的字符串
 *   @param  fontSize 设置字符串字体
 *   @param  width    设置label的宽度
 *   返回：高度值
 */
+ (float) heightForString:(NSString*)value fontSize:(float)fontSize andWidth:(float)width;


/**
 *	NSDate 转换为字符串格式：yyyy-MM-dd HH:mm:ss
 *
 *	@param 	date 	要转换的NSDate
 *
 *	@return yyyy-MM-dd HH:mm:ss 格式的字符串时间
 */
+ (NSString *)dateToString:(NSDate *)date;


/**
 *	NSDate 转换为字符串格式
 *
 *	@param 	date 	要转换的NSDate
 *	@param 	dateFormat 	格式的字符串，如：yyyy-MM-dd HH:mm:ss 、yyyy-MM-dd
 *
 *	@return	格式化后的时间字符串
 */
+ (NSString *)dateToString:(NSDate *)date dateFormat:(NSString *)dateFormat;


/**
 *  拨打电话号码
 *
 *  @param phoneNumber 号码
 *  @param view        要将提示显示在哪个视图
 */
+ (void)callPhoneWithPhoneNumber:(NSString *)phoneNumber showInView:(UIView *)view;


/**
 *  生成二维码
 *
 *  @param qrString 原文
 *  @param size     二维码的大小
 *
 *  @return UIImage
 */
+ (UIImage *)createQRImageWithString:(NSString *)qrString size:(CGSize)size;


//判断是否包含表情
+ (BOOL)isContainEmoji:(NSString *)str;


/*
 将正在textField数字转成以下格式
 银行卡号：8888 8888 8888 8888 888
 手机号：130 1234 5678
 身份证号：420982 19900705 1016
 */
+(void)formatTFNum:(UITextField *)textField TextFieldType:(TextFiledNumType)type;


//将上面4位一空格的形式还原，得到最终不带空格的卡号
+(NSString *)recoverCardTFText:(UITextField *)textField;


//view震动效果
+ (void)shakeView:(UIView *)view;


/**
 *
 *截取浮点数后几位
 */
+(NSString*)takeFloatTreeWithString:(NSString *)String afterPoint:(int)position;


/**
 *
 *进位
 */
+(NSString *)notRounding:(double)price afterPoint:(int)position;


/*
 舍尾并进一
 */
+(NSString *)addOneAndDeleteLastBit:(double)price afterPoint:(int)position;


/*
 保留小数位数不四舍五入
 */
+(NSString *)savePointBit:(double)price afterPoint:(int)position;


/*  MBP */
+(void)showStatusWithMessage:(NSString*)message toView:(UIView*)view;


+(void)showProgressToView:(UIView*)view;


+ (void)hiddenProgressToView:(UIView*)view;


/* 添加整个屏幕的遮罩 */
+ (void)showFullBackGroundHudTo:(UIView *)view;


+ (void)hideFullBackGroundHudTo:(UIView *)view;

/*富文本设置*/
+ (NSAttributedString *)setKeywordStyle:(NSString *)title keyword:(NSString *)keyword Color:(UIColor *)color font:(UIFont *)font;


+ (void)showBriefAlert:(NSString *)message;

//是否是整型数字
+ (BOOL)isIntNumber:(NSString *)num;

//隐藏菊花
+ (void)HideActivityIndicator;

//sd_setImg
+ (void)sd_setImg:(UIImageView *)img imgUrl:(NSString *)url placeHolderImgName:(NSString *)imgName;

@end
