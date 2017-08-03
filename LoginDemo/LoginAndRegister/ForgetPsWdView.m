//
//  ForgetPsWdView.m
//  LoginDemo
//
//  Created by Apple on 2017/8/1.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "ForgetPsWdView.h"
#import "SVProgressHUD.h"

#define kScreen_width [UIScreen mainScreen].bounds.size.width
#define kScreen_height [UIScreen mainScreen].bounds.size.height
#define kView_width self.frame.size.width
#define kView_height self.frame.size.height

#define kControl_height 50.0f
#define kMarg_left 115.0f
#define kMarg_top 50.0f
#define kMarg_buttom 50.0f
#define kMarg_right 115.0f

#define kMarg_interval 25.0f

@interface ForgetPsWdView ()
@property(nonatomic,strong)UIView *forgetPhoneView;

@property(nonatomic,strong)UIView *forgetPassWordView;

@property(nonatomic,strong)UIView *forgetSuccessView;

@property(nonatomic,strong)UITextField *phoneNum;

@property(nonatomic,strong)UITextField *codeNum;

@property(nonatomic,strong)UITextField *txtPassWord;

@property(nonatomic,strong)UITextField *aginTxtPassWord;

@property(nonatomic,strong)UITextField *codeTxtPassWord;

@property(nonatomic,strong)UIButton *codeImageBtn;

@property(nonatomic,strong)UIView *bgView;

@property(nonatomic,strong)UIButton *codeBtn;

@property(nonatomic,strong)UIButton *nextBtn;

@property(assign, nonatomic) NSInteger timeCount;

@property(strong, nonatomic) NSTimer *timer;

@property(nonatomic,strong)UIButton *closeButton;

@property(assign, nonatomic) NSString *codeResultStr;
@end

@implementation ForgetPsWdView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 8;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"bg"]];
        [self createRegisterView];
        [self createforgetPassWordView];
        [self createforgetSuccessView];
    }
    return self;
}

-(void)createRegisterView
{
    self.forgetPhoneView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kView_width, kView_height)];
    self.forgetPhoneView.userInteractionEnabled = YES;
    
    
    self.phoneNum = [[UITextField alloc] initWithFrame:CGRectMake(kMarg_left, 100,kView_width - kMarg_left*2 , kControl_height)];
    self.phoneNum.placeholder = @"请输入手机号 ";
    self.phoneNum.backgroundColor = [UIColor whiteColor];
    self.phoneNum.layer.masksToBounds = YES;
    self.phoneNum.layer.cornerRadius = 4;
    self.phoneNum.clipsToBounds = YES;
    UIImageView *userNameLeftViewIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ico_phone"]];
    //图片的显示模式
    userNameLeftViewIV.contentMode = UIViewContentModeCenter;
    //图片的位置和大小
    userNameLeftViewIV.frame = CGRectMake(0,0,55,20);
    //左视图默认是不显示的 设置为始终显示
    self.phoneNum.leftViewMode = UITextFieldViewModeAlways;
    self.phoneNum.leftView = userNameLeftViewIV;
//    self.phoneNum.textColor = [UIColor colorWithHexString:@"#00b0f0"];
//    self.phoneNum.font = font(20);
    self.phoneNum.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.forgetPhoneView addSubview:self.phoneNum];
    
    
    self.codeNum = [[UITextField alloc] initWithFrame:CGRectMake(kMarg_left,CGRectGetMaxY(self.phoneNum.frame) + kMarg_interval , 2*(kView_width - kMarg_left *2)/3, kControl_height)];
    self.codeNum.backgroundColor = [UIColor whiteColor];
    self.codeNum.placeholder = @"请输入验证码";
    UIImageView *codeLeftViewIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ico_code"]];
    codeLeftViewIV.contentMode = UIViewContentModeCenter;
    codeLeftViewIV.frame = CGRectMake(0,0,55,20);
    self.codeNum.leftViewMode = UITextFieldViewModeAlways;
    self.codeNum.leftView = codeLeftViewIV;
    self.codeNum.layer.masksToBounds = YES;
    self.codeNum.layer.cornerRadius = 4;
    self.codeNum.clipsToBounds = YES;
//    self.codeNum.textColor = [UIColor colorWithHexString:@"#00b0f0"];
//    self.codeNum.font = font(20);
    [self.forgetPhoneView addSubview:self.codeNum];
    
    self.codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.codeBtn.frame = CGRectMake(CGRectGetMaxX(self.codeNum.frame) + 13, CGRectGetMaxY(self.phoneNum.frame) + kMarg_interval ,(kView_width - kMarg_left *2)/3 - 13 , kControl_height);
    [self.codeBtn setBackgroundColor:[UIColor whiteColor]];
    [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.codeBtn addTarget:self action:@selector(codeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.codeBtn.layer.masksToBounds = YES;
    self.codeBtn.layer.cornerRadius = 4;
    self.codeBtn.clipsToBounds = YES;
//    self.codeBtn.titleLabel.font = font(15);
//    [self.codeBtn setTitleColor:[UIColor colorWithHexString:@"#dbdbdb"] forState:UIControlStateNormal];
    [self.forgetPhoneView addSubview:self.codeBtn];
    
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextBtn.frame = CGRectMake(kMarg_left, CGRectGetMaxY(self.codeNum.frame) + kMarg_interval, kView_width - kMarg_left *2, kControl_height);
    [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextBtn setBackgroundImage:[UIImage imageNamed:@"login_bg"] forState:UIControlStateNormal];
    [self.nextBtn setBackgroundImage:[UIImage imageNamed:@"loginclicked_bg"] forState:UIControlStateHighlighted];
    [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
//    [self.nextBtn setTitleColor:[UIColor colorWithHexString:@"#fffefe"] forState:UIControlStateNormal];
    [self.nextBtn addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.forgetPhoneView addSubview:self.nextBtn];
    
}

-(void)createforgetPassWordView{
    
    self.forgetPassWordView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kView_width, kView_height)];
    self.forgetPassWordView.userInteractionEnabled = YES;
    
    self.txtPassWord = [[UITextField alloc] initWithFrame:CGRectMake(kMarg_left, 100 ,self.frame.size.width - kMarg_left *2 , kControl_height)];
    self.txtPassWord.placeholder = @"请输入初始密码 ";
    UIImageView *txtPassLeftViewIV = [[UIImageView alloc] init];
    txtPassLeftViewIV.contentMode = UIViewContentModeCenter;
    txtPassLeftViewIV.frame = CGRectMake(0,0,20,20);
    self.txtPassWord.leftViewMode = UITextFieldViewModeAlways;
    self.txtPassWord.leftView = txtPassLeftViewIV;
    self.txtPassWord.backgroundColor = [UIColor whiteColor];
    self.txtPassWord.layer.masksToBounds = YES;
    self.txtPassWord.layer.cornerRadius = 4;
    self.txtPassWord.clipsToBounds = YES;
    self.txtPassWord.secureTextEntry = YES;
    self.txtPassWord.clearButtonMode = UITextFieldViewModeWhileEditing;
//    self.txtPassWord.textColor = [UIColor colorWithHexString:@"#00b0f0"];
//    self.txtPassWord.font = font(20);
    [self.forgetPassWordView addSubview:self.txtPassWord];
    
    
    self.aginTxtPassWord = [[UITextField alloc] initWithFrame:CGRectMake(kMarg_left,CGRectGetMaxY(self.txtPassWord.frame) + kMarg_interval , (self.frame.size.width - kMarg_left*2), kControl_height)];
    self.aginTxtPassWord.backgroundColor = [UIColor whiteColor];
    self.aginTxtPassWord.placeholder = @"请再次输入初始密码";
    UIImageView *aginTxtPassLeftViewIV = [[UIImageView alloc] init];
    aginTxtPassLeftViewIV.contentMode = UIViewContentModeCenter;
    aginTxtPassLeftViewIV.frame = CGRectMake(0,0,20,20);
    self.aginTxtPassWord.leftViewMode = UITextFieldViewModeAlways;
    self.aginTxtPassWord.leftView = aginTxtPassLeftViewIV;
    self.aginTxtPassWord.layer.masksToBounds = YES;
    self.aginTxtPassWord.layer.cornerRadius = 4;
    self.aginTxtPassWord.clipsToBounds = YES;
    self.aginTxtPassWord.secureTextEntry = YES;
//    self.aginTxtPassWord.textColor = [UIColor colorWithHexString:@"#00b0f0"];
//    self.aginTxtPassWord.font = font(20);
    [self.forgetPassWordView addSubview:self.aginTxtPassWord];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(kMarg_left, CGRectGetMaxY(self.aginTxtPassWord.frame) + kMarg_interval, self.frame.size.width - kMarg_left*2, kControl_height);
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"login_bg"] forState:UIControlStateNormal];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"loginclicked_bg"] forState:UIControlStateHighlighted];
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
//    [sureBtn setTitleColor:[UIColor colorWithHexString:@"#fffefe"] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(passWordsendAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.forgetPassWordView addSubview:sureBtn];
    
    
}
-(void)createforgetSuccessView{
    
    self.forgetSuccessView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kView_width, kView_height)];
    self.forgetSuccessView.userInteractionEnabled = YES;
    
    UIImageView *successViewIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"success"]];
    successViewIV.frame = CGRectMake((self.frame.size.width - 118)/2, 45, 118, 118);
    [self.forgetSuccessView addSubview:successViewIV];
    
    
    UILabel *successLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(successViewIV.frame) + 16, self.frame.size.width - 60, kControl_height)];
    successLabel.text = @"密码设置成功!";
    successLabel.textColor = [UIColor whiteColor];
    successLabel.textAlignment = NSTextAlignmentCenter;
    [self.forgetSuccessView addSubview:successLabel];
    
    
    UIButton *successBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    successBtn.frame = CGRectMake(kMarg_left, CGRectGetMaxY(self.aginTxtPassWord.frame) + kMarg_interval, self.frame.size.width - kMarg_left*2, kControl_height);
    [successBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [successBtn setBackgroundImage:[UIImage imageNamed:@"login_bg"] forState:UIControlStateNormal];
    [successBtn setBackgroundImage:[UIImage imageNamed:@"loginclicked_bg"] forState:UIControlStateHighlighted];
    [successBtn setTitle:@"立即登陆" forState:UIControlStateNormal];
//    [successBtn setTitleColor:[UIColor colorWithHexString:@"#fffefe"] forState:UIControlStateNormal];
    [successBtn addTarget:self action:@selector(successBtnSendAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.forgetSuccessView addSubview:successBtn];
}


-(void)successBtnSendAction:(UIButton *)sender
{
    //重新提交密码成功之后 关闭忘记密码页 打开登陆页
    if ([self.delegate respondsToSelector:@selector(ForgetPsWdRequestEventAction:)]) {
        [self.delegate ForgetPsWdRequestEventAction:sender];
    }
}

//判断两次密码是否相同
-(void)passWordsendAction:(UIButton *)sender
{
    if ([self.txtPassWord.text isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"亲,请输入密码"];
        [self performSelector:@selector(dismiss:) withObject:nil afterDelay:1.5];
        
        return;
    }
    else if (self.txtPassWord.text.length < 6)
    {
        [SVProgressHUD showInfoWithStatus:@"密码需要大于6位数"];
        [self performSelector:@selector(dismiss:) withObject:nil afterDelay:1.5];
        return;
    }
    else  {
        
        if ([self.txtPassWord.text isEqualToString:self.aginTxtPassWord.text]) {
            
            [self.forgetPassWordView removeFromSuperview];
            [self addSubview:self.forgetSuccessView];
            
            
//            NSMutableDictionary *params =[NSMutableDictionary dictionary];
//            NSDictionary *dic = @{@"contactPhone":self.phoneNum.text,
//                                  @"studentPwd":self.txtPassWord.text
//                                  };
//            params[@"data"] = dic;
//            params[@"source"] =  @"IOS";
//    
//            NSString *url = student_updatePassword;
//            [TPHttpTool requestWithMethod:@"post" url:url params:params inView:nil success:^(NSDictionary  *responseObj) {
//                
//                
//                NSLog(@"重新提交密码------%@",responseObj);
//                
//            } failure:^(NSError *error) {
//                NSLog(@"%@",error);
//            }];
        }else{
            
            [SVProgressHUD showInfoWithStatus:@"两次密码不正确"];
            [self performSelector:@selector(dismiss:) withObject:nil afterDelay:1.5];
        }
    }
}

//获取验证码之后 判断手机验证码是否填写 与手机短信是否一致
-(void)sendAction:(UIButton *)sender
{
    if ([self.phoneNum.text isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"亲,请输入注册手机号码"];
        [self performSelector:@selector(dismiss:) withObject:nil afterDelay:1.5];
        
        return;
    }
    else if (self.phoneNum.text.length !=11)
    {
        [SVProgressHUD showInfoWithStatus:@"您输入的手机号码格式不正确"];
        [self performSelector:@selector(dismiss:) withObject:nil afterDelay:1.5];
        return;
    }
    else if (self.phoneNum.text.length == 11)
    {
        
        if ([self.codeNum.text isEqualToString:@""]) {
            
            NSLog(@"没有填验证码密码");
            [SVProgressHUD showInfoWithStatus:@"没有填验证码密码"];
            [self performSelector:@selector(dismiss:) withObject:nil afterDelay:1.5];
            
        }else if (self.codeNum.text.length !=6) {
            
            NSLog(@"验证码格式不对");
            [SVProgressHUD showInfoWithStatus:@"验证码格式不对"];
            [self performSelector:@selector(dismiss:) withObject:nil afterDelay:1.5];
    
        } else if ([self.codeNum.text isEqualToString:self.codeResultStr])
        {
            [self.forgetPhoneView removeFromSuperview];
            [self addSubview:self.forgetPassWordView];
                
            }
        }

}

//获取验证码 判断手机号是否已经注册
-(void)codeBtnClicked:(UIButton *)btn{
    
    if ([self.phoneNum.text isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"亲,请输入注册手机号码"];
        [self performSelector:@selector(dismiss:) withObject:nil afterDelay:1.5];
        
        return;
    }
    else if (self.phoneNum.text.length !=11)
    {
        [SVProgressHUD showInfoWithStatus:@"您输入的手机号码格式不正确"];
        [self performSelector:@selector(dismiss:) withObject:nil afterDelay:1.5];
        return;
    }
    else if (self.phoneNum.text.length == 11)
    {
//        NSMutableDictionary *params =[NSMutableDictionary dictionary];
//        NSDictionary *dic = @{@"contactPhone":self.phoneNum.text};
//        params[@"data"] = dic;
//        params[@"source"] =  @"IOS";
//        NSString *url = student_getVerificationCode;
//        [TPHttpTool requestWithMethod:@"post" url:url params:params inView:nil success:^(NSDictionary  *responseObj) {
//            self.codeResultStr = responseObj[@"result"][@"verificationCode"];
//            
//            NSLog(@"%@",responseObj);
//            
//        } failure:^(NSError *error) {
//            NSLog(@"%@",error);
//        }];
        //在这里获取验证码
        self.timeCount = 60;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:btn repeats:YES];
        
    }
}

//申请三次不过 需要输入验证码
-(UITextField *)codeTxtPassWord
{
    if (!_codeTxtPassWord) {
        _codeTxtPassWord = [[UITextField alloc] initWithFrame:CGRectMake(kMarg_left,CGRectGetMaxY(self.codeNum.frame) + kMarg_interval , 2*(self.frame.size.width - kMarg_left *2)/3, kControl_height)];
        _codeTxtPassWord.backgroundColor = [UIColor whiteColor];
        _codeTxtPassWord.placeholder = @"请输入验证码";
        UIImageView *codeLeftViewIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ico_codepic"]];
        codeLeftViewIV.contentMode = UIViewContentModeCenter;
        codeLeftViewIV.frame = CGRectMake(0,0,55,20);
        _codeTxtPassWord.leftViewMode = UITextFieldViewModeAlways;
        _codeTxtPassWord.leftView = codeLeftViewIV;
        _codeTxtPassWord.layer.masksToBounds = YES;
        _codeTxtPassWord.layer.cornerRadius = 4;
        _codeTxtPassWord.clipsToBounds = YES;
        _codeTxtPassWord.hidden = YES;
        [self.forgetPhoneView addSubview:_codeTxtPassWord];
    }
    return _codeTxtPassWord;
}
//验证码
-(UIButton *)codeImageBtn{
    
    if (!_codeImageBtn) {
        _codeImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _codeImageBtn.frame = CGRectMake(CGRectGetMaxX(self.codeTxtPassWord.frame) + 13, CGRectGetMaxY(self.codeNum.frame) + kMarg_interval ,(self.frame.size.width - kMarg_left*2)/3 - 13 , kControl_height);
        [_codeImageBtn setBackgroundColor:[UIColor whiteColor]];
        [_codeImageBtn setTitle:@"4678" forState:UIControlStateNormal];
        [_codeImageBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_codeImageBtn addTarget:self action:@selector(codeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _codeImageBtn.layer.masksToBounds = YES;
        _codeImageBtn.layer.cornerRadius = 4;
        _codeImageBtn.clipsToBounds = YES;
        _codeImageBtn.hidden = YES;
        [self.forgetPhoneView addSubview:_codeImageBtn];
    }
    return _codeImageBtn;
}

//重新获取验证码
- (void)reduceTime:(NSTimer *)codeTimer
{
    self.timeCount--;
    if (self.timeCount == 0) {
        
        [self.codeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        UIButton *info = codeTimer.userInfo;
        info.enabled = YES;
        self.codeBtn.userInteractionEnabled = YES;
        [self.timer invalidate];
        
        [UIView animateWithDuration:.25 animations:^{
            
            self.codeTxtPassWord.hidden = NO;
            self.codeImageBtn.hidden = NO;
            self.nextBtn.frame = CGRectMake(kMarg_left, CGRectGetMaxY(self.codeTxtPassWord.frame) + 26, kView_width - kMarg_left *2, kControl_height);
        }];
        
    } else {
        [self.codeBtn setTitle:[NSString stringWithFormat:@"重新获取(%lu)", self.timeCount] forState:UIControlStateNormal];
        self.codeBtn.userInteractionEnabled = NO;
        
    }
}

//弹出框调用消失
- (void)dismiss:(id)sender {
    [SVProgressHUD dismiss];
}

#pragma mark ====展示view
- (void)showForgetPsWdView
{
    if (self.bgView) {
        return;
    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    self.bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.bgView.userInteractionEnabled = YES;
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.6;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30 , kMarg_interval, kView_width - 60, 40)];
    label.text = @"找回密码";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentLeft;
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeButton.frame = CGRectMake(self.frame.size.width - kControl_height, 0, kControl_height, kControl_height);
    CGPoint point = CGPointMake(self.frame.size.width + self.frame.origin.x, self.frame.origin.y);
    self.closeButton.center = point;
    
    [self.closeButton setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [self.closeButton setBackgroundImage:[UIImage imageNamed:@"closeclicked"] forState:UIControlStateHighlighted];
    [self.closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(closeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [window addSubview:self.bgView];
    [window addSubview:self];
    [self addSubview:self.forgetPhoneView];
    [self addSubview:label];
    [window addSubview:self.closeButton];

}

-(void)closeBtnAction:(UIButton *)sender
{
    [self closeForgetPsWdView];
}

- (void)closeForgetPsWdView
{
    [self.bgView removeFromSuperview];
    self.bgView = nil;
    self.closeButton.hidden = YES;
    [self removeFromSuperview];
    [self.forgetSuccessView removeFromSuperview];
 
}


@end
