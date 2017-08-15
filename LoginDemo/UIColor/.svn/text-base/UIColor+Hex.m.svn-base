//
//  UIColor+Hex.m
//  HuiYinApp
//
//  Created by   on 16/8/1.
//  Copyright © 2016年 Manager. All rights reserved.
//

#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]
#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+(CAGradientLayer *)shadowAsInverseWithColor:(UIColor *)color frame:(CGRect)rect
{
    CAGradientLayer *newShadow = [[CAGradientLayer alloc] init];
    CGRect newShadowFrame = rect;
    newShadow.frame = newShadowFrame;
    //添加渐变的颜色组合（颜色透明度的改变）
    newShadow.colors = [NSArray arrayWithObjects:
                        (id)[[color colorWithAlphaComponent:0.2] CGColor] ,
                        (id)[[color colorWithAlphaComponent:0.4] CGColor],
                        (id)[[color colorWithAlphaComponent:0.6] CGColor],
                        (id)[[color colorWithAlphaComponent:0.8] CGColor],
                        nil];
    newShadow.startPoint=CGPointMake(0, 0);
    newShadow.endPoint=CGPointMake(1, 1);
    return newShadow;
}
+(CAGradientLayer *)shadowAsInverseWithColors:(NSArray *)colors frame:(CGRect)rect
{
    CAGradientLayer *newShadow = [[CAGradientLayer alloc] init];
    CGRect newShadowFrame = rect;
    newShadow.frame = newShadowFrame;
    //添加渐变的颜色组合（颜色透明度的改变）
    NSMutableArray *colorArr=[NSMutableArray array];
    for (UIColor *color in colors) {
        [colorArr addObject:(id)[color CGColor]];
    }
    
    newShadow.colors = [NSArray arrayWithArray:colorArr];
    newShadow.startPoint=CGPointMake(1, 0.5);
    newShadow.endPoint=CGPointMake(0, 0.5);
    return newShadow;
}
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}

+ (UIColor *)colorWithRGB:(NSUInteger)aRGB
{
    return [UIColor colorWithRed:((float)((aRGB & 0xFF0000) >> 16))/255.0 green:((float)((aRGB & 0xFF00) >> 8))/255.0 blue:((float)(aRGB & 0xFF))/255.0 alpha:1.0];
}

+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length
{
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat:@"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString:fullHex] scanHexInt:&hexComponent];
    
    return hexComponent / 255.0;
}
+ (UIColor *)hex:(NSString *)hexString
{
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch([colorString length])
    {
        case 3: // #RGB
            alpha = 1.0f;
            red = [self colorComponentFrom:colorString start:0 length:1];
            green = [self colorComponentFrom:colorString start:1 length:1];
            blue = [self colorComponentFrom:colorString start:2 length:1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom:colorString start:0 length:1];
            red = [self colorComponentFrom:colorString start:1 length:1];
            green = [self colorComponentFrom:colorString start:2 length:1];
            blue = [self colorComponentFrom:colorString start:3 length:1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red = [self colorComponentFrom:colorString start:0 length:2];
            green = [self colorComponentFrom:colorString start:2 length:2];
            blue = [self colorComponentFrom:colorString start:4 length:2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom:colorString start:0 length:2];
            red = [self colorComponentFrom:colorString start:2 length:2];
            green = [self colorComponentFrom:colorString start:4 length:2];
            blue = [self colorComponentFrom:colorString start:6 length:2];
            break;
        default:
            return nil;
            break;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

//+ (UIColor *)bgColor
//{
//    return [ self colorWithRGB:0xeeeeee];
//}

+ (UIColor *)gray
{
    return [self colorWithRGB:0x757575];
}

+ (UIColor *)lightGray
{
    return [self colorWithRGB:0xbdbdbd];
}


+(UIColor *)darkGray
{
    return [self colorWithRGB:0x212121];
}

+ (UIColor *)red
{
    return [self colorWithRGB:0xff3c25];
}

+ (UIColor *)blue
{
    return [self colorWithRGB:0x157efb];
}

+ (UIColor *)orange
{
    return [self colorWithRGB:0xff9800];
}

+ (UIColor *)green
{
    return [self colorWithRGB:0x97d054];
}

+ (UIColor *)darkRed
{
    return [self colorWithRGB:0xd32d21];
}

+(UIColor*)lightGreen{
    
    return [self colorWithRGB:0x6cae38];
}

+(UIColor*)Blue{
    
    return [self colorWithRGB:0x007ac5];
}

+(UIColor*)allWhite{
    
    return [self colorWithRGB:0xFFFFFF];
}

+(UIColor*)allBlack{
    
    return [self colorWithRGB:0x000000];
}

+(UIColor*)heightBlack{
    
    return [self colorWithRGB:0x333333];
}

+(UIColor*)heightGray{
    
    return [self colorWithRGB:0x666666];
}

+(UIColor*)theLightGray{
    
    return [self colorWithRGB:0x999999];
}


+(UIColor*)lightBlack{
    
    return [self colorWithRGB:0xd5d5d5];
}

+(UIColor*)theGrayColor{
    
    return [self colorWithRGB:0xf1f1f1];
}

+(UIColor*)theRedColor{
    
    return [self colorWithRGB:0xF95E65];
}

+(UIColor*)theYellowColor{
    
    return [self colorWithRGB:0xffc107];
}

+(UIColor*)thePurpleColor{
    
    return [self colorWithRGB:0xce98d3];
}

+(UIColor*)theBlueColor{
    
    return [self colorWithRGB:0x00AEFC];
}

+(UIColor*)theOrangeColor{
    
    return [self colorWithRGB:0xFF8A65];
}

+(UIColor*)ligtGrayColor{
    
    return [self colorWithRGB:0xf9f9f9];
}

+(UIColor*)naveColor{
    
    return [self colorWithRGB:0x7f93f1];
}

+(UIColor*)paleRedColor{
    
    return [self colorWithRGB:0xfd686c];
}

+(UIColor*)theLightBlack{
    
    return [self colorWithRGB:0xe0e0e0];
}

+(UIColor*)waterGreenColor{
    
    return [self colorWithRGB:0x35ca85];
}


/**
 *	我店红，擦擦
 *
 *	@return UIColor
 */
+(UIColor*)bgRed {
    return [UIColor colorWithRed:220.0/255 green:0/255 blue:0/255 alpha:1];
}

/**
 *	我店字体灰，呵呵呵
 *
 *	@return UIColor
 */
+(UIColor*)textGray {
    return [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1];
}

+ (UIColor *)randomColor
{
    CGFloat hue = (arc4random() % 256 / 256.0);
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5;
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}

+ (UIColor *)otsBlueColor {
    return [self colorWithRGB:0x6890df];
}

+ (UIColor *)otsRedColor {
    return [self colorWithRGB:0xdc0000];
}

+ (UIColor *)shopingOrangeColor {
    return [self colorWithRGB:0xf63c2d];
}

+ (UIColor *)disableColor {
    return [self colorWithRGB:0xa9a9a9];
}
@end
