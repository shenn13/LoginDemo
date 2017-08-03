//
//  LoginView.h
//  LoginDemo
//
//  Created by Apple on 2017/7/31.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LoginSalertViewdelegate <NSObject>

-(void)loginRequestEventAction1:(NSString *)phone passWord1:(NSString *)passWord;

-(void)loginRequestEventAction2:(NSString *)phone passWord2:(NSString *)passWord;

-(void)loginRequestRegisterViewEventAction:(UIButton *)button;
-(void)loginRequestForgetPassWordViewEventAction:(UIButton *)button;
-(void)loginRequestHelpViewEventAction:(UIButton *)button;

@end
@interface LoginView : UIView


@property(nonatomic,weak)id <LoginSalertViewdelegate> delegate;

-(void)showLoginView;

-(void)closeLoginView;
@end
