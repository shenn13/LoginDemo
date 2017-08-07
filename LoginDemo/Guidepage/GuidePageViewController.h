//
//  GuidePageViewController.h
//  LoginDemo
//
//  Created by 沈增光 on 2017/8/7.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GuidePageViewDelegate <NSObject>

- (void)clickEnter;

@end

@interface GuidePageViewController : UIViewController

@property (nonatomic, strong) UIButton *btnEnter;

- (void)guidePageControllerWithImages:(NSArray *)images;

+ (BOOL)isShow;

@property (nonatomic, assign) id<GuidePageViewDelegate> delegate;

@end
