//
//  WYButton.m
//  LearningEducation
//
//  Created by Apple on 2017/7/14.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "WYButton.h"
#import <AudioToolbox/AudioToolbox.h>
#import <objc/runtime.h>
@implementation WYButton
{
    SystemSoundID soundFileObject;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //得到音效文件的地址
        
        NSString*soundFilePath =[[NSBundle mainBundle]pathForResource:@"buttonPush" ofType:@"wav"];
        
        //将地址字符串转换成url
        
        NSURL*soundURL = [NSURL fileURLWithPath:soundFilePath];
        
        //生成系统音效id
        
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &soundFileObject);
    }
    return self;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent*)event

{
    [self playSound];
    
    [super touchesBegan:touches withEvent:event];
    
}
- (void)playSound
{
    //播放系统音效
    
    AudioServicesPlaySystemSound(soundFileObject);
    
}

@end
