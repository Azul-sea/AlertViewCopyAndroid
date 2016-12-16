//
//  ViewController.m
//  AndroidAlertView
//
//  Created by 四季游玩 on 2016/12/8.
//  Copyright © 2016年 wk. All rights reserved.
//

#import "ViewController.h"
#import "ShowAlertView.h"

//#define Screen_Width                    [[UIScreen mainScreen] bounds].size.width
//#define Screen_Height                   [[UIScreen mainScreen] bounds].size.height
#define ColorOfOrange                   [UIColor colorWithRed:1.00f green:0.61f blue:0.00f alpha:1.00f]

@interface ViewController ()

@end

@implementation ViewController
#pragma mark - Click Event
- (void)showAlert:(UIButton *)btn
{
    NSString *message = nil;
    switch (btn.tag) {
        case 0:
        {
            message = @"alert view like android!!!";
        }
            break;
        case 1:
        {
            message = @"alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!";
        }
            break;
        case 2:
        {
            message = @"alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!alert view like android!!!";
        }
            break;
        default:
            break;
    }
    ShowAlertView *alertView = [ShowAlertView initializeAlertViewWithFrame:CGRectMake(0, 0, Screen_Width/2, 10) Message:message customType:1 Class:nil];
    [alertView addAlertView];
}
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUIConfig];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - initialize
- (void)setupUIConfig
{
    for (NSInteger i = 0; i<3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(30, CGRectGetHeight(self.view.frame)-200+i*50, CGRectGetWidth(self.view.frame)-30*2, 40);
        btn.backgroundColor = ColorOfOrange;
        btn.tag = i;
        [btn setTitle:[NSString stringWithFormat:@"弹窗%ld",i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(showAlert:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
    }
}

@end
