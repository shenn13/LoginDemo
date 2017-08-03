//
//  RegisterView.h
//  LoginDemo
//
//  Created by Apple on 2017/7/31.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegisterViewSalertViewdelegate <NSObject>

-(void)registerRequestEventAction:(UIButton *)button;

@end


@interface RegisterView : UIView



@property(nonatomic,weak)id <RegisterViewSalertViewdelegate> delegate;

-(void)showRegisterView;

-(void)closeRegisterView;

@end
