//
//  ControlEncapsTool.h
//  LoginDemo
//
//  Created by 沈增光 on 2017/8/14.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Lottie/Lottie.h>

@interface ControlEncapsTool : NSObject


#pragma mark 创建UIView
+(UIView *)viewWithFrame:(CGRect )frame color:(NSString *)color;

#pragma mark 创建UIImageView
+(UIImageView *)imageViewWithFrame:(CGRect )frame imageName:(NSString *)imageName;

#pragma mark 创建UILable
+(UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font color:(NSString *)color;


#pragma mark 创建UIButton  点击有声音+标题+图片的
+(UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(NSString *)titleColor titleFont:(UIFont *)titleFont setImage:(NSString *)imageName setHighlightImage:(NSString *)highlightImageName Target:(id)target Action:(SEL)action;
#pragma mark 创建UIButton 点击有声音+标题的
+(UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(NSString *)titleColor titleFont:(UIFont *)titleFont Target:(id)target Action:(SEL)action;
#pragma mark 创建UIButton 点击有声音+图片的
+(UIButton *)buttonWithFrame:(CGRect)frame setImage:(NSString *)imageName setHighlightImage:(NSString *)highlightImageName Target:(id)target Action:(SEL)action;

#pragma mark 创建UITextField 有左右视图的
+(UITextField *)textFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder font:(UIFont *)font color:(NSString *)color secureText:(BOOL)yesOrNo leftView:(UIView *)leftView rightView:(UIView *)rightView ;

#pragma mark 创建UITextField 只有左视图的
+(UITextField *)textFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder font:(UIFont *)font color:(NSString *)color secureText:(BOOL)yesOrNo leftView:(UIView *)leftView;


#pragma mark 创建LOTAnimationView 动画视图加载GIF
+(LOTAnimationView *)viewWithFrame:(CGRect )frame withData:(NSString *)data loopAnimation:(BOOL)yesorno;

#pragma mark 创建NSMutableAttributedString字体 错误提示语用
+(NSMutableAttributedString *)stringWithString:(NSString *)string;

@end
