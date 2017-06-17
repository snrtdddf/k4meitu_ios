//
//  commonTools.m
//  DealGold
//
//  Created by simpleem on 16/8/9.
//  Copyright © 2016年 China_Gold_Infomation. All rights reserved.
//

#import "commonTools.h"
#import "MBProgressHUD.h"
@implementation commonTools

// 验证是否为中国邮政编码
+ (BOOL)isPostCodeWithCodeString:(NSString *)codeString
{
    NSString *codeRegex = @"[1-9]\\d{5}(?!\\d)";
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",codeRegex];
    
    BOOL isPostCode = [codeTest evaluateWithObject:codeString];
    
    return isPostCode;
}
/**
 *  检测是否电话号码
 *
 *  @param mobileNum 电话号码
 *
 *  @return bool
 */
+ (BOOL)checkPhoneNumInput:(NSString *)mobileNum
{
    /**
     *手机号码
     *移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     *联通：130,131,132,152,155,156,185,186
     *电信：133,1349,153,180,189
     *4G号码段：178，177，176
     */
    
    
    NSString* MOBILE =@"^(\\+?\\d{2,3}\\-)?1\\d{10}$";//不需要配备这么多规则，只用验证11位且开头是1的数字即可
    
    /**
     10         *中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString* CM =@"^1(34[0-8]|(3[5-9]|5[017-9]|8[278]|78)\\d)\\d{7}$";
    /**
     15         *中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString* CU =@"^1(3[0-2]|5[256]|8[56]|7[6])\\d{8}$";
    /**
     20         *中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString* CT =@"^1((33|53|8[09]|77)[0-9]|349)\\d{7}$";
    /**
     25         *大陆地区固话及小灵通
     26         *区号：010,020,021,022,023,024,025,027,028,029
     27         *号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    /**
     29         *国际长途中国区(+86)
     30         *区号：+86
     31         *号码：十一位
     32         */
    NSString* IPH =@"^\\+861(3|5|7|8)\\d{9}$";
    
    //判断是否为正确格式的手机号码
    NSPredicate* regextestmobile;
    NSPredicate* regextestcm;
    NSPredicate* regextestcu;
    NSPredicate* regextestct;
    NSPredicate* regextestiph;
    
    regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    regextestiph = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IPH];
    
    if(([regextestmobile evaluateWithObject:mobileNum] == YES)
       || ([regextestcm evaluateWithObject:mobileNum] == YES)
       || ([regextestct evaluateWithObject:mobileNum] == YES)
       || ([regextestcu evaluateWithObject:mobileNum] == YES)
       || ([regextestiph evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        
        return NO;
    }
    
}

// 检查是否是电话号码^1[3|4|5|7|8]\d{9}$
+ (BOOL)isPhoneNumInput:(NSString *)phoneNum
{
    NSString *phoneRegex = @"^1[3|4|5|7|8]\\d{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    BOOL isPhone = [phoneTest evaluateWithObject:phoneNum];
    
    return isPhone;
}

//身份证号
+ (BOOL)isIdentityCard:(NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
// 验证银行卡号
+ (BOOL)isBankCardNo:(NSString*)cardNo
{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}


//现在只检查是数字
+(BOOL)isValidNumber:(NSString*)number
{
    if(!number || number.length == 0) {
        return NO;
    }
    else{
        for(int index =0; index < number.length; index++) {
            unichar curChar_f = [number characterAtIndex:index];
            if(!(curChar_f>='0'&& curChar_f<='9')) {
                return NO;
            }
        }
        return YES;
    }
}


/**
 *  检测是否是浮点数字
 */
+(BOOL)isFloatNumber:(NSString *)number{
    NSRange range = [number rangeOfString:@"."];
    if (range.location == NSNotFound) {
        return NO;
    }
    NSArray *numArray = [number componentsSeparatedByString:@"."];
    NSString *num = @"";
    if (numArray.count == 2) {
        num = [NSString stringWithFormat:@"%@%@",numArray[0],numArray[1]];
        
        if ([self isValidNumber:num]) {
            return YES;
        }
    }
    return NO;
}


// 纯汉字
+ (BOOL)isChinese:(NSString *)validChinese
{
    NSString *chineseRegex = @"^[\u4e00-\u9fa5]+$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",chineseRegex];
    return [pre evaluateWithObject:validChinese];
}
//判断是否是正确中文名字
+(BOOL)isCHNameWithName:(NSString *)name
{
    if (!name || name.length == 0 || ![name isKindOfClass:[NSString class]]) {
        return NO;
    }
    NSString *check = @"[\u4E00-\u9FA5]{1,10}·{0,1}•{0,1}[\u4E00-\u9FA5]{1,63}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",check];
    return [predicate evaluateWithObject:name];
}
//是否包含中文
+ (BOOL)isIncludeChineseInString:(NSString*)str {
    for (int i=0; i<str.length; i++) {
        unichar ch = [str characterAtIndex:i];
        if (0x4e00 < ch  && ch < 0x9fff) {
            return true;
        }
    }
    return false;
}
/**
 *	设置UITextField Placeholder 的字体大小，颜色。
 *
 *	@param 	textField 	要设置的UITextField
 *	@param 	fontSize 	字体大小
 *	@param 	color 	字体颜色（如使用默认的颜色，使用nil值）
 */
+ (void)setPlaceholderAttributed:(UITextField *)textField withSystemFontSize:(CGFloat)fontSize withColor:(UIColor *)color
{
    
    if (color)
    {
        textField.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString: textField.placeholder ? textField.placeholder : @""
                                        attributes:@{
                                                     NSForegroundColorAttributeName : color,
                                                     NSFontAttributeName : [UIFont systemFontOfSize:fontSize]
                                                     }
         ];
        
    }else
    {
        textField.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:textField.placeholder ? textField.placeholder : @""
                                        attributes:@{
                                                     NSFontAttributeName : [UIFont systemFontOfSize:fontSize]
                                                     }
         ];
    }
}


/**
 *功能：获取字体高度，用于动态计算label高度。
 *   @param  value 要计算高度的字符串
 *   @param  fontSize 设置字符串字体
 *   @param  width    设置label的宽度
 *   返回：高度值
 */
+ (float) heightForString:(NSString*)value fontSize:(float)fontSize andWidth:(float)width
{
    
    CGSize sizeToFit = [value sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],NSFontAttributeName, nil]];
    
    return  sizeToFit.height;
}


/**
 *	NSDate 转换为字符串格式：yyyy-MM-dd HH:mm:ss
 *
 *	@param 	date 	要转换的NSDate
 *
 *	@return yyyy-MM-dd HH:mm:ss 格式的字符串时间
 */
+ (NSString *)dateToString:(NSDate *)date
{
    return [self dateToString:date dateFormat:@"yyyy-MM-dd HH:mm:ss"];
}


/**
 *	NSDate 转换为字符串格式
 *
 *	@param 	date 	要转换的NSDate
 *	@param 	dateFormat 	格式的字符串，如：yyyy-MM-dd HH:mm:ss 、yyyy-MM-dd
 *
 *	@return	格式化后的时间字符串
 */
+ (NSString *)dateToString:(NSDate *)date dateFormat:(NSString *)dateFormat
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:dateFormat];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

/**
 *  拨打号码
 *
 */
+ (void)callPhoneWithPhoneNumber:(NSString *)phoneNumber showInView:(UIView *)view

{
    if (phoneNumber.length == 0) {
        return;
    }
    
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phoneNumber]]]];
    [view addSubview:callWebview];
}

//生成二维码
+ (UIImage *)createQRImageWithString:(NSString *)qrString size:(CGSize)size
{
    
    // Need to convert the string to a UTF-8 encoded NSData object
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // Create the filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // Set the message content and error-correction level
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    CGRect extent = CGRectIntegral(qrFilter.outputImage.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));
    // create a bitmap image that we'll draw into a bitmap context at the desired size;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:qrFilter.outputImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // Create an image with the contents of our bitmap
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    // Cleanup
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
    
}


//判断是否包含表情
+ (BOOL)isContainEmoji:(NSString *)str{
   return [NSString isContainsEmoji:str];
}


/*
    将正在textField数字转成以下格式
    银行卡号：8888 8888 8888 8888 888
    手机号：136 1234 5678
    身份证号：420982 19900705 1016
*/
+(void)formatTFNum:(UITextField *)textField TextFieldType:(TextFiledNumType)type{
    //手机号输入框显示
    if (type == 0) {
        if (textField.text.length >13) {
            textField.text = [textField.text substringToIndex:13];
        }
        NSString *oldLengthStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"telNumTFoldLength"];
        if (oldLengthStr == NULL) {
            oldLengthStr = @"0";
        }
        NSInteger oldLength =  oldLengthStr.integerValue;
        if (textField.text.length > oldLength) {
            switch (textField.text.length) {
                case 3:
                    textField.text = [NSString stringWithFormat:@"%@ ",textField.text];
                    break;
                case 8:
                    textField.text = [NSString stringWithFormat:@"%@ ",textField.text];
                    break;
                default:
                    break;
            }
        }else{
            if (textField.text.length==3) {
                textField.text = [textField.text substringToIndex:2];
            }else if (textField.text.length==8){
                textField.text = [textField.text substringToIndex:7];
            }
        }
        oldLength = textField.text.length;
        NSString *str = [NSString stringWithFormat:@"%ld",oldLength];
        [[NSUserDefaults standardUserDefaults] setValue:str forKey:@"telNumTFoldLength"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    //身份证号输入框显示
    else if (type == 1) {
        if (textField.text.length >20) {
            textField.text = [textField.text substringToIndex:20];
        }
        NSString *oldLengthStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"idCardNumTFoldLength"];
        if (oldLengthStr == NULL) {
            oldLengthStr = @"0";
        }
        NSInteger oldLength =  oldLengthStr.integerValue;
        if (oldLength < textField.text.length) {
            switch (textField.text.length) {
                case 6:
                    textField.text = [NSString stringWithFormat:@"%@ ",textField.text];
                    break;
                case 15:
                    textField.text = [NSString stringWithFormat:@"%@ ",textField.text];
                    break;
                default:
                    break;
            }
        }else{
            if (textField.text.length==6) {
                textField.text = [textField.text substringToIndex:5];
            }else if (textField.text.length==15){
                textField.text = [textField.text substringToIndex:14];
            }
        }

        oldLength = textField.text.length;
        NSString *str = [NSString stringWithFormat:@"%ld",oldLength];
        [[NSUserDefaults standardUserDefaults] setValue:str forKey:@"idCardNumTFoldLength"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    //银行卡号输入框显示
    else if (type == 2) {
        if (textField.text.length >26) {
            textField.text = [textField.text substringToIndex:26];
        }
        NSString *oldLengthStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"bankCardNumTFoldLength"];
        if (oldLengthStr == NULL) {
            oldLengthStr = @"0";
        }
        NSInteger oldLength =  oldLengthStr.integerValue;
        if (oldLength < textField.text.length) {
            switch (textField.text.length) {
                case 4:
                    textField.text = [NSString stringWithFormat:@"%@ ",textField.text];
                    break;
                case 9:
                    textField.text = [NSString stringWithFormat:@"%@ ",textField.text];
                    break;
                case 14:
                    textField.text = [NSString stringWithFormat:@"%@ ",textField.text];
                    break;
                case 19:
                    textField.text = [NSString stringWithFormat:@"%@ ",textField.text];
                    break;
                case 24:
                    textField.text = [NSString stringWithFormat:@"%@ ",textField.text];
                    break;
                default:
                    break;
            }
        }else{
            if (textField.text.length==4) {
                textField.text = [textField.text substringToIndex:3];
            }else if (textField.text.length==9){
                textField.text = [textField.text substringToIndex:8];
            }else if (textField.text.length==14){
                textField.text = [textField.text substringToIndex:13];
            }else if (textField.text.length==19){
                textField.text = [textField.text substringToIndex:18];
            }else if (textField.text.length==24){
                textField.text = [textField.text substringToIndex:23];
            }
        }

        oldLength = textField.text.length;
        NSString *str = [NSString stringWithFormat:@"%ld",oldLength];
        [[NSUserDefaults standardUserDefaults] setValue:str forKey:@"bankCardNumTFoldLength"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


//将上面4位一空格的形式还原，得到最终不带空格的号码
+(NSString *)recoverCardTFText:(UITextField *)textField{
    NSString *ylTFText = textField.text;
    if (ylTFText.length != 0) {
        NSArray *TFArr = [ylTFText componentsSeparatedByString:@" "];
        ylTFText = @"";
        for (NSString *str in TFArr) {
            ylTFText = [ylTFText stringByAppendingString:str];
        }
        return ylTFText;
    }
    
    return @"";
}


//view震动效果
+ (void)shakeView:(UIView *)view
{
    
    CAKeyframeAnimation* shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    shakeAnimation.values = @[ @-10, @0, @10, @0 ];
    shakeAnimation.repeatCount = 3;
    shakeAnimation.duration = 0.1;
    [view.layer addAnimation:shakeAnimation forKey:nil];
}


// 截取三位小数
+(NSString*)takeFloatTreeWithString:(NSString *)String afterPoint:(int)position
{
    NSRange range = [String rangeOfString:@"."];
    
    if ((int)range.location == -1) {
        return String;
    }
    else
    {
        return [String substringToIndex:range.location + 1 + position];
    }
    return  nil;
}

// 进位
+(NSString *)notRounding:(double)price afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundUp scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithDouble:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    NSString *resultString = [NSString stringWithFormat:@"%@",roundedOunces];
    
    NSRange range = [resultString rangeOfString:@"."];
    if ((int)range.location == -1) {
        resultString  = [resultString stringByAppendingString:@".00"];
        return resultString;
    }
    
    return resultString;
}


/*
 舍尾并进一
 */
+(NSString *)addOneAndDeleteLastBit:(double)price afterPoint:(int)position
{
    NSString *finalStr;
    NSString *str = [NSString stringWithFormat:@"%lf",price];
    NSArray *strArr = [str componentsSeparatedByString:@"."];
    NSString *SuffixStr = strArr[1];
    NSString *lastLetter = [SuffixStr substringWithRange:NSMakeRange(position, 1)];
    NSInteger lastNum = [lastLetter integerValue];
    if (lastNum >= 0) {
        NSString *realLetters = [SuffixStr substringWithRange:NSMakeRange(0, position)];
        NSInteger realNum = [realLetters integerValue];
        realNum = realNum + 1;
        finalStr = [NSString stringWithFormat:@"%@.%ld",strArr[0],realNum];
    }
    
    return finalStr;
}


/*
 保留小数位数不四舍五入
 */
+(NSString *)savePointBit:(double)price afterPoint:(int)position
{
    NSString *finalStr;
    NSString *str = [NSString stringWithFormat:@"%lf",price];
    NSArray *strArr = [str componentsSeparatedByString:@"."];
    NSString *SuffixStr = strArr[1];
    NSString *lastLetters = [SuffixStr substringToIndex:position];
    
    finalStr = [NSString stringWithFormat:@"%@.%@",strArr[0],lastLetters];
    
    return finalStr;
    
}

/*  MBP */
+(void)showStatusWithMessage:(NSString*)message toView:(UIView*)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = MYMARGIN;
    hud.cornerRadius = 3;
    [hud hide:YES afterDelay:MYAFTERDELAY];
    
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
}

+(void)showProgressToView:(UIView*)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = @"请稍候";
}

+ (void)hiddenProgressToView:(UIView*)view
{
    [MBProgressHUD hideHUDForView:view  animated:YES];
}

/* 添加整个屏幕的遮罩 */
+ (void)showFullBackGroundHudTo:(UIView *)view{
    
    UIView *hudView = [[UIView alloc] initWithFrame:view.bounds];
    hudView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    hudView.tag = 123;
    hudView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [view addSubview:hudView];
}

/* 隐藏整个屏幕的遮罩 */
+ (void)hideFullBackGroundHudTo:(UIView *)view{
    for (UIView *subView in view.subviews) {
        if (subView.tag == 123) {
            [subView removeFromSuperview];
        }
    }
}


/**
 *  富文本设置
 *
 *  @param title   整个字符串
 *  @param keyword 要设置的字符串
 *  @param color   关键字符串颜色
 *  @param font    关键字符串字体
 */
+ (NSAttributedString *)setKeywordStyle:(NSString *)title keyword:(NSString *)keyword Color:(UIColor *)color font:(UIFont *)font{
    
    NSString *titleStr = title;
    NSString *keyWord = keyword;
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:titleStr];
    NSRange range = [titleStr rangeOfString:keyWord];
    [attriStr setAttributes:@{NSForegroundColorAttributeName : color,   NSFontAttributeName : font} range:range];
    
    return attriStr;
}

//提示语弹框
+ (void)showBriefAlert:(NSString *)message{
    [MBManager showBriefAlert:message];
}

//是否整型数字
+ (BOOL)isIntNumber:(NSString *)num{
    NSString *chineseRegex = @"^[0-9]\\d*$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",chineseRegex];
    return [pre evaluateWithObject:num];
}

@end
