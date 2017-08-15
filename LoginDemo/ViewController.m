//
//  ViewController.m
//  LoginDemo
//
//  Created by Apple on 2017/7/31.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "RegisterView.h"
#import "LoginView.h"
#import "ForgetPsWdView.h"
#import "HelpView.h"

#import "ControlEncapsTool.h"

#import "FCUUID.h"


@interface ViewController ()<RegisterViewSalertViewdelegate,LoginSalertViewdelegate,ForgetPsWdViewAlertViewdelegate,HelpViewAlertViewdelegate>

@property(nonatomic,strong)RegisterView *registerAlertView;

@property(nonatomic,strong)LoginView *loginAlertView;

@property(nonatomic,strong)ForgetPsWdView *forgetPsWdAlertView;

@property(nonatomic,strong)HelpView *helpAlertView;
@end

@implementation ViewController

-(void)viewDidLoad{
    
     [super viewDidLoad];
    
    
    
    
    NSLog(@"\n-uuid:   %@\n -uuidForSession:   %@\n -uuidForInstallation:   %@\n -uuidForVendor:  %@\n -uuidForDevice:   %@\n",[FCUUID uuid],[FCUUID uuidForSession],[FCUUID uuidForInstallation],[FCUUID uuidForVendor],[FCUUID uuidForDevice]);
    
    
    
    
    
    UIButton *buttonnn = [ControlEncapsTool buttonWithFrame:CGRectMake(100, 100, 100, 100) title:@"button" titleColor:@"#dbdbdb" titleFont:[UIFont systemFontOfSize:22] setImage:nil setHighlightImage:nil Target:self Action:@selector(buttonClicked)];
    [self.view addSubview:buttonnn];
    
    
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    button.center = self.view.center;
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor yellowColor]];
    
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:button.bounds.size.width/2]; //设置矩形四个圆角半径
    //边框宽度
    [button.layer setBorderWidth:4.0];
    //设置边框颜色有两种方法：第一种如下:
    //        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 1 });
    //        [btn.layer setBorderColor:colorref];//边框颜色
    //第二种方法如下:
    button.layer.borderColor=[UIColor redColor].CGColor;
    
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

//注册页面
- (RegisterView *)registerAlertView
{
    if (!_registerAlertView) {
        self.registerAlertView = [[RegisterView alloc] initWithFrame:CGRectMake(0, 0, 570, 399)];
        self.registerAlertView.delegate = self;
        self.registerAlertView.center = self.view.center;
    }
    return _registerAlertView;
}
- (void)registerRequestEventAction:(UIButton *)button
{
    //注册页消失
    [self.registerAlertView closeRegisterView];
    //登陆页显示
    [self.loginAlertView showLoginView];
}


//登陆页面
- (LoginView *)loginAlertView
{
    if (!_loginAlertView) {
        self.loginAlertView = [[LoginView alloc] initWithFrame:CGRectMake(0, 0, 570, 399)];
        self.loginAlertView.delegate = self;
        self.loginAlertView.center = self.view.center;
    }
    return _loginAlertView;
}

#pragma mark -------------LoginSalertViewdelegate
-(void)loginRequestEventAction1:(NSString *)phone passWord1:(NSString *)passWord{
//    
//    NSMutableDictionary *params =[NSMutableDictionary dictionary];
//    NSDictionary *dic = @{@"contactPhone":phone,
//                          @"studentPwd":passWord
//                          };
//    params[@"data"] = dic;
//    params[@"source"] =  @"IOS";
//    
//    NSString *url = student_loginByAccountAndPassword;
//    [TPHttpTool requestWithMethod:@"post" url:url params:params inView:self success:^(NSDictionary  *responseObj) {
//        
//        NSDictionary *result = responseObj[@"result"];
//        
//        NSLog(@"------用户密码登录-------%@",result);
//        
//        [self.loginAlertView closeLoginView];
//        
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
    
}

-(void)loginRequestEventAction2:(NSString *)phone passWord2:(NSString *)passWord{
    
//    NSMutableDictionary *params =[NSMutableDictionary dictionary];
//    NSDictionary *dic = @{@"contactPhone":phone};
//    params[@"data"] = dic;
//    params[@"source"] =  @"IOS";
//    
//    NSString *url = student_loginByAccount;
//    [TPHttpTool requestWithMethod:@"post" url:url params:params inView:self success:^(NSDictionary  *responseObj) {
//        
//        NSDictionary *result = responseObj[@"result"];
//        
//        NSLog(@"------用户手机快速登录-------%@",result);
//        
//        [self.loginAlertView closeLoginView];
//        
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
    
}
-(void)loginRequestRegisterViewEventAction:(UIButton *)button{
    [self.loginAlertView closeLoginView];
    [self.registerAlertView showRegisterView];
}
-(void)loginRequestForgetPassWordViewEventAction:(UIButton *)button{
    [self.loginAlertView closeLoginView];
    [self.forgetPsWdAlertView showForgetPsWdView];
}
-(void)loginRequestHelpViewEventAction:(UIButton *)button{
    [self.loginAlertView closeLoginView];
    [self.helpAlertView showHelpView];
}

//忘记密码
- (ForgetPsWdView *)forgetPsWdAlertView
{
    if (!_forgetPsWdAlertView) {
        self.forgetPsWdAlertView = [[ForgetPsWdView alloc] initWithFrame:CGRectMake(0, 0, 570, 399)];
        self.forgetPsWdAlertView.delegate = self;
        self.forgetPsWdAlertView.center = self.view.center;
    }
    return _forgetPsWdAlertView;
}

-(void)ForgetPsWdRequestEventAction:(UIButton *)button{
    //忘记密码页消失
    [self.forgetPsWdAlertView closeForgetPsWdView];
    //登陆页显示
    [self.loginAlertView showLoginView];
    
}
//帮助页面
- (HelpView *)helpAlertView
{
    if (!_helpAlertView) {
        self.helpAlertView = [[HelpView alloc] initWithFrame:CGRectMake(0, 0, 570, 399)];
        self.helpAlertView.delegate = self;
        self.helpAlertView.center = self.view.center;
    }
    return _helpAlertView;
}

-(void)helpRequestEventAction:(UIButton *)button{
    [self.helpAlertView closeHelpView];
    [self.loginAlertView showLoginView];
}


-(void)buttonClicked{
//注册
    
//    [self.registerAlertView showRegisterView];
    
//登陆
    [self.loginAlertView showLoginView];
    
//忘记密码
//    [self.forgetPsWdAlertView showForgetPsWdView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
