//
//  ViewController.m
//  TipsView
//
//  Created by Johnson on 1/12/16.
//  Copyright © 2016 Johnson. All rights reserved.
//

#import "ViewController.h"
#import "TipsView.h"
#import "TipsView-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)showCenter:(id)sender {
    [TipsView showCenterTitle:@"亲, 您的手机网络似乎不顺畅哦~"];
}

- (IBAction)showCenter3s:(id)sender {
    [TipsView showCenterTitle:@"亲, 您的手机网络似乎不顺畅哦~" duration:3 completion:nil];
}

- (IBAction)showCenter3sBlock:(id)sender {
    [TipsView showCenterTitle:@"亲, 您的手机网络似乎不顺畅哦~" duration:3 completion:^{
        NSLog(@"居中显示3s 执行回调.");
    }];
}

- (IBAction)showBottom:(id)sender {
    [TipsView showBottomTitle:@"网路视乎不顺畅哦"];
}

- (IBAction)showBottom3s:(id)sender {
    [TipsView showBottomTitle:@"网路视乎不顺畅哦"duration:3 completion:nil];
}

- (IBAction)showBottom3sBlock:(id)sender {
    [TipsView showBottomTitle:@"网路视乎不顺畅哦"duration:3 completion:^{
        NSLog(@"底部显示3s 执行回调.");
    }];
}


- (IBAction)dismiss:(id)sender {
    [TipsView dismiss];
}




- (IBAction)clickShowHUDInWindow:(id)sender {
    
    [JProgressHUD showInAppdelegateWindow:@"正在加载..."];
    [self performSelector:@selector(clickDismissHud:) withObject:nil afterDelay:2];
}

- (IBAction)clickShowHUDInView:(id)sender {

    [JProgressHUD showInView:self.view text:@"加载中"];
    [self performSelector:@selector(clickDismissHud:) withObject:nil afterDelay:2];
}

- (IBAction)clickShowHUDInViewWithShadow:(id)sender {
    [JProgressHUD showInView:self.view text:@"Shadow" shadow:YES];
    [self performSelector:@selector(clickDismissHud:) withObject:nil afterDelay:2];
}

- (IBAction)clickShowHUDInViewCanTouch:(id)sender {
    
    [JProgressHUD showInView:self.view text:@"Loading" canTouch:YES];
}

- (IBAction)clickDismissHud:(id)sender {
    [JProgressHUD dismissForScale];
}


@end
