//
//  ForgetPsWdView.h
//  LoginDemo
//
//  Created by Apple on 2017/8/1.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterView.h"

@protocol ForgetPsWdViewAlertViewdelegate <NSObject>

-(void)ForgetPsWdRequestEventAction:(UIButton *)button;

@end

@interface ForgetPsWdView : UIView

@property(nonatomic,weak)id <ForgetPsWdViewAlertViewdelegate> delegate;

-(void)showForgetPsWdView;

-(void)closeForgetPsWdView;

@end
