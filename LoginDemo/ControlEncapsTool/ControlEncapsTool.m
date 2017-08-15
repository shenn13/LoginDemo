//
//  ControlEncapsTool.m
//  LoginDemo
//
//  Created by 沈增光 on 2017/8/14.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "ControlEncapsTool.h"
#import "UIColor+Hex.h"
#import "WYButton.h"


@implementation ControlEncapsTool

#pragma mark 创建UIView
+(UIView *)viewWithFrame:(CGRect )frame color:(NSString *)color
{
    UIView *myView = [[UIView alloc] initWithFrame:frame];
    myView.backgroundColor = [UIColor colorWithHexString:color];
    return myView;
}

#pragma mark 创建UIImageView
+(UIImageView *)imageViewWithFrame:(CGRect )frame imageName:(NSString *)imageName
{
    UIImageView *myImageView = [[UIImageView alloc] initWithFrame:frame];
    myImageView.image = [UIImage imageNamed:imageName];
    return myImageView;
}

#pragma mark 创建UILable
+(UILabel *)labelWithFrame:(CGRect )frame text:(NSString *)text font:(UIFont *)font  color:(NSString *)color
{
    UILabel *myLabel = [[UILabel alloc]initWithFrame:frame];
    myLabel.numberOfLines = 0;//限制行数
    myLabel.textAlignment = NSTextAlignmentLeft;//对齐的方式
    myLabel.backgroundColor = [UIColor clearColor];//背景色
    myLabel.font = font;//字号
    myLabel.textColor = [UIColor colorWithHexString:color];//颜色默认是白色，现在默认是黑色
    myLabel.lineBreakMode = NSLineBreakByCharWrapping;
    myLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    myLabel.text = text;
    return myLabel;
}

#pragma mark 创建UIButton
+(UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(NSString *)titleColor titleFont:(UIFont *)titleFont setImage:(NSString *)imageName setHighlightImage:(NSString *)highlightImageName Target:(id)target Action:(SEL)action
{
    
    WYButton *myButton = [[WYButton alloc] initWithFrame:frame];
    [myButton setTitle:title forState:UIControlStateNormal];
    [myButton setTitleColor:[UIColor colorWithHexString:titleColor] forState:UIControlStateNormal];
    myButton.titleLabel.font = titleFont;
    if (imageName) {
        [myButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (highlightImageName) {
        [myButton setImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    }
    [myButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return myButton;
}

#pragma mark 创建UIButton 只有标题的
+(UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(NSString *)titleColor titleFont:(UIFont *)titleFont Target:(id)target Action:(SEL)action
{
    WYButton *myButton = [[WYButton alloc] initWithFrame:frame];
    [myButton setTitle:title forState:UIControlStateNormal];
    [myButton setTitleColor:[UIColor colorWithHexString:titleColor] forState:UIControlStateNormal];
    myButton.titleLabel.font = titleFont;
    [myButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return myButton;
}
#pragma mark 创建UIButton 只有图片的
+(UIButton *)buttonWithFrame:(CGRect)frame setImage:(NSString *)imageName setHighlightImage:(NSString *)highlightImageName Target:(id)target Action:(SEL)action
{
    WYButton *myButton = [[WYButton alloc] initWithFrame:frame];
    if (imageName) {
        [myButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (highlightImageName) {
        [myButton setImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    }
    [myButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return myButton;
}




#pragma mark 创建UITextField 有左右视图的
+(UITextField *)textFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder font:(UIFont *)font color:(NSString *)color secureText:(BOOL)yesOrNo leftView:(UIView *)leftView rightView:(UIView *)rightView
{
    UITextField *myTextField = [[UITextField alloc] initWithFrame:frame];
    myTextField.placeholder = placeholder;
    myTextField.font = font;
    myTextField.backgroundColor = [UIColor whiteColor];
    myTextField.layer.masksToBounds = YES;
    myTextField.layer.cornerRadius = 4;
    myTextField.clipsToBounds = YES;
    myTextField.textColor = [UIColor colorWithHexString:color];
    myTextField.secureTextEntry = yesOrNo;
    myTextField.leftView = leftView;
    myTextField.leftViewMode = UITextFieldViewModeAlways;
    myTextField.rightView = rightView;
    myTextField.leftViewMode = UITextFieldViewModeAlways;
    myTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    return myTextField;
}

#pragma mark 创建UITextField 只有左视图的
+(UITextField *)textFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder font:(UIFont *)font color:(NSString *)color secureText:(BOOL)yesOrNo leftView:(UIView *)leftView
{
    
    UITextField *myTextField = [[UITextField alloc] initWithFrame:frame];
    myTextField.placeholder = placeholder;
    myTextField.font = font;
    myTextField.backgroundColor = [UIColor whiteColor];
    myTextField.layer.masksToBounds = YES;
    myTextField.layer.cornerRadius = 4;
    myTextField.clipsToBounds = YES;
    myTextField.textColor = [UIColor colorWithHexString:color];
    myTextField.secureTextEntry = yesOrNo;
    myTextField.leftView = leftView;
    myTextField.leftViewMode = UITextFieldViewModeAlways;
    myTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    return myTextField;
    
}

#pragma mark 创建LOTAnimationView 动画视图加载GIF
+(LOTAnimationView *)viewWithFrame:(CGRect )frame withData:(NSString *)data loopAnimation:(BOOL)yesorno
{
    LOTAnimationView *myLotView = [LOTAnimationView animationNamed:data];
    myLotView.frame = frame;
    myLotView.loopAnimation = yesorno;
    myLotView.contentMode = UIViewContentModeScaleToFill;
    return myLotView;
}


#pragma mark 创建NSMutableAttributedString字体 错误提示语用
+(NSMutableAttributedString *)stringWithString:(NSString *)string
{
    NSMutableAttributedString *myAttri = [[NSMutableAttributedString alloc] initWithString:string];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:@"ico_error"];
    attch.bounds = CGRectMake(0, -2, 15, 15);
    NSAttributedString *str = [NSAttributedString attributedStringWithAttachment:attch];
    [myAttri insertAttributedString:str atIndex:0];
    return myAttri;
}

@end
