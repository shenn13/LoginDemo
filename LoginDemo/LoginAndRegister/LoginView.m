//
//  LoginView.m
//  LoginDemo
//
//  Created by Apple on 2017/7/31.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "LoginView.h"
#import "SVProgressHUD.h"
#import "UnderLineButtonView.h"

#define kView_width self.frame.size.width
#define kView_height self.frame.size.height

#define kControl_height 50.0f
#define kMarg_left 115.0f
#define kMarg_top 50.0f
#define kMarg_buttom 50.0f
#define kMarg_right 115.0f
#define kMarg_interval 25.0f

@interface LoginView ()<UIScrollViewDelegate,UITextFieldDelegate>


@property(nonatomic,strong)UIView *accountView;
@property(nonatomic,strong)UIView *phoneLoginView;

@property(nonatomic,strong)UITextField *phoneNum;
@property(nonatomic,strong)UITextField *txtPassWord;

@property(nonatomic,strong)UIButton *accountBtn;

@property(nonatomic,strong)UITextField *phoneNum2;
@property(nonatomic,strong)UITextField *codeNum;
@property(nonatomic,strong)UITextField *codeTxtPassWord;
@property(nonatomic,strong)UIButton *codeImageBtn;

@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIButton *codeBtn;
@property(nonatomic,strong)UIButton *accountLoginBtn;
@property(nonatomic,strong)UIButton *phoneLoginBtn;
@property(assign, nonatomic) NSInteger timeCount;
@property(strong, nonatomic) NSTimer *timer;

@property(assign, nonatomic) NSInteger index;

@property(assign, nonatomic) NSString *codeResultStr;

@property(nonatomic,strong)UIButton *closeButton;

@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 8;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"bg"]];
        
        [self createLoginView];
        [self createPhoneLoginView];
    }
    return self;
}
-(void)createLoginView
{
    _index = 0;
    
    NSArray *arr = @[@"账号密码登录",@"手机快速登陆"];
    UnderLineButtonView *button = [[UnderLineButtonView alloc] initWithItems:arr];
    button.frame = CGRectMake(115, 26, self.frame.size.width - 230, kControl_height);
    [button addTarget:self action:@selector(accountBtnSendAction:)];
    [self addSubview:button];
    
    
    self.accountView = [[UIView alloc] initWithFrame:CGRectMake(115 , 100 ,self.frame.size.width - 230 , self.frame.size.height - 126)];
    self.accountView.userInteractionEnabled = YES;
    [self addSubview:self.accountView];
    
    self.phoneNum = [[UITextField alloc] initWithFrame:CGRectMake(0, 0,self.accountView.frame.size.width, kControl_height)];
    self.phoneNum.placeholder = @"请输入手机号 ";
    self.phoneNum.backgroundColor = [UIColor whiteColor];
    self.phoneNum.layer.masksToBounds = YES;
    self.phoneNum.layer.cornerRadius = 4;
    self.phoneNum.clipsToBounds = YES;
    UIImageView *userNameLeftViewIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ico_user"]];
    userNameLeftViewIV.contentMode = UIViewContentModeCenter;
    userNameLeftViewIV.frame = CGRectMake(0,0,55,20);
    self.phoneNum.leftViewMode = UITextFieldViewModeAlways;
    self.phoneNum.leftView = userNameLeftViewIV;
    self.phoneNum.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.accountView addSubview:self.phoneNum];
    
    
    self.txtPassWord = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.phoneNum.frame) + kMarg_interval,self.accountView.frame.size.width, kControl_height)];
    self.txtPassWord.placeholder = @"请输入密码 ";
    self.txtPassWord.backgroundColor = [UIColor whiteColor];
    self.txtPassWord.layer.masksToBounds = YES;
    self.txtPassWord.layer.cornerRadius = 4;
    self.txtPassWord.clipsToBounds = YES;
    UIImageView *txtLeftViewIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ico_password"]];
    txtLeftViewIV.contentMode = UIViewContentModeCenter;
    txtLeftViewIV.frame = CGRectMake(0,0,55,20);
    self.txtPassWord.leftViewMode = UITextFieldViewModeAlways;
    self.txtPassWord.leftView = txtLeftViewIV;
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kControl_height, kControl_height)];
    [rightBtn setImage:[UIImage imageNamed:@"ico_hidepassword"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"ico_showpassword"] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(textFieldRightBtnTouchDown:) forControlEvents:UIControlEventTouchDown];
    [rightBtn addTarget:self action:@selector(textFieldRightBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    self.txtPassWord.secureTextEntry = YES;
    self.txtPassWord.rightView = rightBtn;
    self.txtPassWord.rightViewMode = UITextFieldViewModeAlways;
    self.txtPassWord.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.txtPassWord.delegate = self;
    [self.accountView addSubview:self.txtPassWord];
    
    
    self.accountLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.accountLoginBtn.frame = CGRectMake(0, CGRectGetMaxY(self.txtPassWord.frame) + kMarg_interval, self.accountView.frame.size.width, kControl_height);
    [self.accountLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.accountLoginBtn setBackgroundImage:[UIImage imageNamed:@"login_bg"] forState:UIControlStateNormal];
    [self.accountLoginBtn setBackgroundImage:[UIImage imageNamed:@"loginclicked_bg"] forState:UIControlStateHighlighted];
    [self.accountLoginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [self.accountLoginBtn addTarget:self action:@selector(loginBtnSendAction1:) forControlEvents:UIControlEventTouchUpInside];
    [self.accountView addSubview:self.accountLoginBtn];
    
    NSArray *arrName = @[@"注册账号",@"忘记密码",@"帮助"];
    NSArray *arrPic = @[@"",@"ico_forgetword",@"ico_help"];
    for (NSInteger i = 0; i <arrName.count ; i ++) {
        
        UIButton *forgetNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [forgetNumBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [forgetNumBtn setImage:[UIImage imageNamed:arrPic[i]] forState:UIControlStateNormal];
        [forgetNumBtn setTitle:arrName[i] forState:UIControlStateNormal];
//        forgetNumBtn.titleLabel.font = font(15);
        forgetNumBtn.tag = i;
        [forgetNumBtn addTarget:self action:@selector(forgetNumBtnSendAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (0 == i ) {
            forgetNumBtn.frame = CGRectMake(0, CGRectGetMaxY(self.accountLoginBtn.frame) + 15, self.accountView.frame.size.width/3, 20);
            forgetNumBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        }else{
            forgetNumBtn.frame = CGRectMake(25 + self.accountView.frame.size.width/3 *i, CGRectGetMaxY(self.accountLoginBtn.frame) + 15, 90, 20);
            forgetNumBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [forgetNumBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 5)];
            [forgetNumBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - 15, 0, 5)];
        }
        
        [self.accountView addSubview:forgetNumBtn];
        
    }
    
}

-(void)createPhoneLoginView{
    
    self.phoneLoginView = [[UIView alloc] initWithFrame:CGRectMake(115 , 100 ,self.frame.size.width - 230 , self.frame.size.height - 126)];
    self.accountView.userInteractionEnabled = YES;
    
    
    self.phoneNum2 = [[UITextField alloc] initWithFrame:CGRectMake(0, 0,self.phoneLoginView.frame.size.width, kControl_height)];
    self.phoneNum2.placeholder = @"请输入手机号 ";
    self.phoneNum2.backgroundColor = [UIColor whiteColor];
    self.phoneNum2.layer.masksToBounds = YES;
    self.phoneNum2.layer.cornerRadius = 4;
    self.phoneNum2.clipsToBounds = YES;
    UIImageView *userNameLeftViewIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ico_user"]];
    userNameLeftViewIV.contentMode = UIViewContentModeCenter;
    userNameLeftViewIV.frame = CGRectMake(0,0,55,20);
    self.phoneNum2.leftViewMode = UITextFieldViewModeAlways;
    self.phoneNum2.leftView = userNameLeftViewIV;
    self.phoneNum2.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.phoneLoginView  addSubview:self.phoneNum2];
    
    
    self.codeNum = [[UITextField alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.phoneNum.frame) + kMarg_interval , 2*self.phoneLoginView .frame.size.width/3, kControl_height)];
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
    [self.phoneLoginView  addSubview:self.codeNum];
    
    self.codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.codeBtn.frame = CGRectMake(CGRectGetMaxX(self.codeNum.frame) + 13, CGRectGetMaxY(self.phoneNum.frame) + kMarg_interval ,self.phoneLoginView .frame.size.width/3 - 13 , kControl_height);
    [self.codeBtn setBackgroundColor:[UIColor whiteColor]];
    [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeBtn addTarget:self action:@selector(codeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.codeBtn.layer.masksToBounds = YES;
    self.codeBtn.layer.cornerRadius = 4;
    self.codeBtn.clipsToBounds = YES;
    [self.phoneLoginView  addSubview:self.codeBtn];
    
    
    self.phoneLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.phoneLoginBtn.frame = CGRectMake(0, CGRectGetMaxY(self.codeNum.frame) + kMarg_interval, self.phoneLoginView .frame.size.width, kControl_height);
    [self.phoneLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.phoneLoginBtn setBackgroundImage:[UIImage imageNamed:@"login_bg"] forState:UIControlStateNormal];
    [self.phoneLoginBtn setBackgroundImage:[UIImage imageNamed:@"loginclicked_bg"] forState:UIControlStateHighlighted];
    [self.phoneLoginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [self.phoneLoginBtn addTarget:self action:@selector(loginBtnSendAction2:) forControlEvents:UIControlEventTouchUpInside];
    [self.phoneLoginView  addSubview:self.phoneLoginBtn];
}

//选择登陆方式
-(void)accountBtnSendAction:(UIButton *)btn{
    
    if (1000 == btn.tag) {
        [self.phoneLoginView removeFromSuperview];
        [self addSubview:self.accountView];
    }if (1001 == btn.tag) {
        [self.accountView removeFromSuperview];
        [self addSubview:self.phoneLoginView];
    }
}

//登陆请求1
-(void)loginBtnSendAction1:(UIButton *)sender{
    
    
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
        
        if ([self.txtPassWord.text isEqualToString:@""]) {
            
            NSLog(@"没有填写密码");
        }else if(self.txtPassWord.text.length < 6){
            NSLog(@"密码必须超过6位");
        }else{
            
            if ([self.delegate respondsToSelector:@selector(loginRequestEventAction1:passWord1:)]) {
                [self.delegate loginRequestEventAction1:self.phoneNum.text passWord1:self.txtPassWord.text];
            }
        }
    }
    
    [self createCodeView];
    
}
//登陆请求2
-(void)loginBtnSendAction2:(UIButton *)sender{
    
    if ([self.phoneNum2.text isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"亲,请输入注册手机号码"];
        [self performSelector:@selector(dismiss:) withObject:nil afterDelay:1.5];
        
        return;
    }
    else if (self.phoneNum2.text.length !=11)
    {
        [SVProgressHUD showInfoWithStatus:@"您输入的手机号码格式不正确"];
        [self performSelector:@selector(dismiss:) withObject:nil afterDelay:1.5];
        return;
    }
    else if (self.phoneNum2.text.length == 11)
    {
        
        if ([self.codeNum.text isEqualToString:@""]) {
            
            NSLog(@"没有填验证码密码");
            [SVProgressHUD showInfoWithStatus:@"没有填验证码密码"];
            [self performSelector:@selector(dismiss:) withObject:nil afterDelay:1.5];
        }else if ([self.codeNum.text isEqualToString:self.codeResultStr]){
   
            if ([self.delegate respondsToSelector:@selector(loginRequestEventAction2:passWord2:)]) {
                [self.delegate loginRequestEventAction2:self.phoneNum2.text passWord2:nil];
            }
        }else{
            NSLog(@"---验证码填写错误不对");
        }
    }
    if (_index > 3) {
        
        [self createCodeView];
    }
    _index ++;
}

-(void)createCodeView{
    
    //三次登陆失败需要显示验证码。。。。。。
    
    self.codeTxtPassWord = [[UITextField alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.codeNum.frame) + kMarg_interval , 2*self.phoneLoginView.frame.size.width/3, kControl_height)];
    self.codeTxtPassWord.backgroundColor = [UIColor whiteColor];
    self.codeTxtPassWord.placeholder = @"请输入验证码";
    UIImageView *codeLeftViewIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ico_codepic"]];
    codeLeftViewIV.contentMode = UIViewContentModeCenter;
    codeLeftViewIV.frame = CGRectMake(0,0,55,20);
    self.codeTxtPassWord.leftViewMode = UITextFieldViewModeAlways;
    self.codeTxtPassWord.leftView = codeLeftViewIV;
    self.codeTxtPassWord.layer.masksToBounds = YES;
    self.codeTxtPassWord.layer.cornerRadius = 4;
    self.codeTxtPassWord.clipsToBounds = YES;
    [self.phoneLoginView addSubview:self.codeTxtPassWord];
    
    self.codeImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.codeImageBtn.frame = CGRectMake(CGRectGetMaxX(self.codeTxtPassWord.frame) + 13, CGRectGetMaxY(self.codeNum.frame) + kMarg_interval ,self.phoneLoginView.frame.size.width /3 - 13 , kControl_height);
    [self.codeImageBtn setBackgroundColor:[UIColor whiteColor]];
    [self.codeImageBtn setTitle:@"4678" forState:UIControlStateNormal];
    [self.codeImageBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.codeImageBtn addTarget:self action:@selector(codeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.codeImageBtn.layer.masksToBounds = YES;
    self.codeImageBtn.layer.cornerRadius = 4;
    self.codeImageBtn.clipsToBounds = YES;
    [self.phoneLoginView addSubview:self.codeImageBtn];
    
    self.phoneLoginBtn.frame = CGRectMake(0, CGRectGetMaxY(self.codeImageBtn.frame) + kMarg_interval, self.phoneLoginView.frame.size.width, kControl_height);
}
//注册 忘记密码 帮助
-(void)forgetNumBtnSendAction:(UIButton *)sender{
    
    if (0 == sender.tag)
    {
        if ([self.delegate respondsToSelector:@selector(loginRequestRegisterViewEventAction:)]) {
            [self.delegate loginRequestRegisterViewEventAction:sender];
        }
    }
    if (1 == sender.tag)
    {
        if ([self.delegate respondsToSelector:@selector(loginRequestForgetPassWordViewEventAction:)]) {
            [self.delegate loginRequestForgetPassWordViewEventAction:sender];
        }
    }
    if (2 == sender.tag) {
        
        if ([self.delegate respondsToSelector:@selector(loginRequestHelpViewEventAction:)]) {
            [self.delegate loginRequestHelpViewEventAction:sender];
        }
    }
}

//获取验证码 判断手机号是否已经注册
-(void)codeBtnClicked:(UIButton *)btn{
    
    if ([self.phoneNum2.text isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"亲,请输入注册手机号码"];
        [self performSelector:@selector(dismiss:) withObject:nil afterDelay:1.5];
        
        return;
    }
    else if (self.phoneNum2.text.length !=11)
    {
        [SVProgressHUD showInfoWithStatus:@"您输入的手机号码格式不正确"];
        [self performSelector:@selector(dismiss:) withObject:nil afterDelay:1.5];
        
        return;
    }
    else if (self.phoneNum2.text.length == 11)
    {
        
        //在这里获取验证码
        self.timeCount = 60;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:btn repeats:YES];
    }
}

- (void)reduceTime:(NSTimer *)codeTimer
{
    self.timeCount--;
    if (self.timeCount == 0) {
        [self.codeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        UIButton *info = codeTimer.userInfo;
        info.enabled = YES;
        self.codeBtn.userInteractionEnabled = YES;
        [self.timer invalidate];
        
    } else {
        [self.codeBtn setTitle:[NSString stringWithFormat:@"重新获取(%lu)", self.timeCount] forState:UIControlStateNormal];
        self.codeBtn.userInteractionEnabled = NO;
        
    }
}

#pragma mark ====展示view
- (void)showLoginView
{
    if (self.bgView) {
        return;
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    self.bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.bgView.userInteractionEnabled = YES;
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.6;
    
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
    [window addSubview:self.closeButton];
    
}

-(void)closeBtnAction:(UIButton *)sender
{
    [self closeLoginView];
}

- (void)closeLoginView
{
    [self.bgView removeFromSuperview];
    self.bgView = nil;
    self.closeButton.hidden = YES;
    [self removeFromSuperview];
}

- (void)textFieldRightBtnTouchDown:(UIButton *)rightBtn
{
    self.txtPassWord.secureTextEntry = NO;
    [self.txtPassWord becomeFirstResponder];
    self.txtPassWord.font = nil;
}

- (void)textFieldRightBtnTouchUpInside:(UITextField *)textField
{
    self.txtPassWord.secureTextEntry = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.txtPassWord endEditing:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *allStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (textField.isSecureTextEntry == YES) {
        textField.text = allStr;
        return NO;
    }
    return YES;
}


//弹出框调用消失
- (void)dismiss:(id)sender {
    [SVProgressHUD dismiss];
}

@end
