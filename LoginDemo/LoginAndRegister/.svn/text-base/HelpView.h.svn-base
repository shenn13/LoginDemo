//
//  HelpView.h
//  LoginDemo
//
//  Created by Apple on 2017/8/1.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HelpViewAlertViewdelegate <NSObject>

-(void)helpRequestEventAction:(UIButton *)button;

@end

@interface HelpView : UIView

@property(nonatomic,strong)UITextView *help;

@property(nonatomic,weak)id <HelpViewAlertViewdelegate> delegate;

-(void)showHelpView;

-(void)closeHelpView;

@end
