//
//  GuidePageViewController.m
//  LoginDemo
//
//  Created by 沈增光 on 2017/8/7.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "GuidePageViewController.h"

#define s_w [UIScreen mainScreen].bounds.size.width
#define s_h [UIScreen mainScreen].bounds.size.height
#define VERSION_INFO_CURRENT @"currentversion"


@interface GuidePageViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation GuidePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)guidePageControllerWithImages:(NSArray *)images
{
    UIScrollView *guidePageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, s_w, s_h)];
    guidePageScrollView.delegate = self;
    guidePageScrollView.pagingEnabled = YES;
    guidePageScrollView.showsHorizontalScrollIndicator = NO;
    guidePageScrollView.showsVerticalScrollIndicator = NO;

    guidePageScrollView.bounces = NO;
    for (NSInteger i = 0; i < images.count; i ++) {
        
        
        self.btnEnter = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnEnter.frame = CGRectMake(s_w * i, 0, s_w, s_h);
        [self.btnEnter setBackgroundImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [guidePageScrollView addSubview:self.btnEnter];

        
        
        if (i == images.count - 1) {
            UIButton *enterBtn = [[UIButton alloc] init];
            enterBtn.frame = CGRectMake(s_w * i, s_h - 50, 100, 30);
            enterBtn.center = CGPointMake(s_w / 2, s_h - 60);
            enterBtn.layer.cornerRadius = 4;
            enterBtn.clipsToBounds = YES;
            enterBtn.backgroundColor = [UIColor lightGrayColor];
            [enterBtn addTarget:self action:@selector(clickEnter) forControlEvents:UIControlEventTouchUpInside];
            [self.btnEnter addSubview:enterBtn];
        }
    }
    guidePageScrollView.contentSize = CGSizeMake(s_w * images.count, 0);
    [self.view addSubview:guidePageScrollView];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, s_w / 2, 30)];
    self.pageControl.center = CGPointMake(s_w / 2, s_h - 95);
    [self.view addSubview:self.pageControl];
    self.pageControl.numberOfPages = images.count;
}
- (void)clickEnter
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(clickEnter)]) {
        [self.delegate clickEnter];
    }
}
+ (BOOL)isShow
{
    // 读取版本信息
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *localVersion = [user objectForKey:VERSION_INFO_CURRENT];
    NSString *currentVersion =[[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    if (localVersion == nil || ![currentVersion isEqualToString:localVersion]) {
        [GuidePageViewController saveCurrentVersion];
        return YES;
    }else
    {
        return NO;
    }
}
// 保存版本信息
+ (void)saveCurrentVersion
{
    NSString *version =[[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:version forKey:VERSION_INFO_CURRENT];
    [user synchronize];
}
#pragma mark - ScrollerView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = scrollView.contentOffset.x / s_w;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
