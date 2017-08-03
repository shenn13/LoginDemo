//
//  HelpView.m
//  LoginDemo
//
//  Created by Apple on 2017/8/1.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "HelpView.h"

#define kView_width self.frame.size.width
#define kView_height self.frame.size.height
#define kControl_height 50.0f
#define kMarg_left 115.0f
#define kMarg_top 50.0f
#define kMarg_buttom 50.0f
#define kMarg_right 115.0f
#define kMarg_interval 25.0f

@interface HelpView ()<UIScrollViewDelegate>{
    UIScrollView *_scrollView;
}
@property(nonatomic,strong)UIView *bgView;

@property(nonatomic,strong)UIButton *closeButton;

@property(nonatomic,strong)UIButton *loginBtn;
@end


@implementation HelpView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 8;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"bg"]];
        [self createHelpView];
    }
    return self;
}

-(void)createHelpView
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, kMarg_interval, kView_width - 60, 40)];
    label.text = @"帮助";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentLeft;
    [self addSubview:label];
    
    NSArray *titleArr = @[@"Q:为什么我找不到注册",@"Q:我没有密码啊，为该怎么登陆",@"Q:我密码忘记了该怎么登陆"];
    NSArray *conArr = @[@"A:目前乐宁APP只对在乐宁教育报名学习的孩子开发使用，未来会考虑提供给更多的孩子学习使用，敬请期待",@"A:没有密码的用户请使用手机验证码的方式登陆，您可以点击“忘记密码”来进行密码重置为自己设置密码",@"A:请确保您在乐宁教育注册的手机在身边，并通过“忘记密码”来进行密码重置"];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(label.frame) + kMarg_interval, kView_width - 60, kView_height - (CGRectGetMaxY(label.frame) + kMarg_interval)*2)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(0, 0);
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.contentOffset = CGPointMake(0, 0);
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    
    for (NSInteger i  = 0; i < titleArr.count; i ++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100 * i, _scrollView.frame.size.width, 20)];
        label.text = titleArr[i];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentLeft;
        [_scrollView addSubview:label];
        
        
        UILabel *conLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30 + 100 * i, _scrollView.frame.size.width, 60)];
        conLabel.text = conArr[i];
        conLabel.numberOfLines = 0;
        conLabel.textColor = [UIColor whiteColor];
        conLabel.textAlignment = NSTextAlignmentLeft;
        [_scrollView addSubview:conLabel];
        
    }
    
    _scrollView.contentSize = CGSizeMake(0, 390);
    
    
    UIButton *successBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    successBtn.frame = CGRectMake((self.frame.size.width - kMarg_left)/2, CGRectGetMaxY(_scrollView.frame) + kMarg_interval,kMarg_left, kControl_height);
    [successBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [successBtn setBackgroundImage:[UIImage imageNamed:@"login_bg"] forState:UIControlStateNormal];
    [successBtn setBackgroundImage:[UIImage imageNamed:@"loginclicked_bg"] forState:UIControlStateHighlighted];
    [successBtn setTitle:@"立即登陆" forState:UIControlStateNormal];
    [successBtn addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:successBtn];
    
}

#pragma mark ====展示view
- (void)showHelpView
{
    if (self.bgView) {
        return;
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeButton.frame = CGRectMake(self.frame.size.width - kControl_height, 0, kControl_height, kControl_height);
    CGPoint point = CGPointMake(self.frame.size.width + self.frame.origin.x, self.frame.origin.y);
    self.closeButton.center = point;
    
    [self.closeButton setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [self.closeButton setBackgroundImage:[UIImage imageNamed:@"closeclicked"] forState:UIControlStateHighlighted];
    [self.closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(closeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
   
    
    self.bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.bgView.userInteractionEnabled = YES;
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.6;
    [window addSubview:self.bgView];
    [window addSubview:self];
    [window addSubview:self.closeButton];
    
}

-(void)closeBtnAction:(UIButton *)sender
{
    [self closeHelpView];
}

- (void)closeHelpView
{
    [self.bgView removeFromSuperview];
     self.bgView = nil;
    self.closeButton.hidden = YES;
    [self removeFromSuperview];
}

-(void)sendAction:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(helpRequestEventAction:)]) {
        [self.delegate helpRequestEventAction:sender];
    }
    
}

@end
