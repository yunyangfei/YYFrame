//
//  YYViewController.m
//  YYFrame
//
//  Created by admin on 2017/3/17.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "YYViewController.h"

@interface YYViewController ()

@end

@implementation YYViewController

- (WSProgressHUD *)hud
{
    if (!_hud) {
        _hud = [[WSProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_hud];
    }
    return _hud;
}

- (AppDelegate *)appDelegate {
    if (!_appDelegate) {
        _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return _appDelegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}



/*
- (void)showHUDWithImage:(UIImage *)image title:(NSString *)title showAnimated:(BOOL)showAnimated hideAnimated:(BOOL)hideAnimated afterDelay:(NSTimeInterval)delay {
    self.hud.mode = MBProgressHUDModeCustomView;
    self.hud.customView = [[UIImageView alloc] initWithImage:image];
    self.hud.label.text = title;
    [self.hud showAnimated:showAnimated];
    [self.hud hideAnimated:hideAnimated afterDelay:delay];
}

- (void)showHUDOnlyString:(NSString *)string afterDelay:(NSTimeInterval)delay {
    self.hud.mode = MBProgressHUDModeText;
    self.hud.label.text = string;
    [self.hud showAnimated:YES];
    [self.hud hideAnimated:YES afterDelay:delay];
}

- (void)showHUDStatus:(NSString *)title autoHide:(BOOL)autoHide {
    self.hud.label.text = title;
    [self.hud showAnimated:YES];
    if (autoHide) {
        [self.hud hideAnimated:autoHide];
    }
}
 */

- (void)showHudWithIndicatiorStyle:(WSProgressHUDIndicatorStyle)style
{
    [self.hud setProgressHUDIndicatorStyle:style];
    [self.hud showWithMaskType:WSProgressHUDMaskTypeClear];
}

- (void)hideHud
{
    [self.hud dismiss];
    [self.hud removeFromSuperview];
    self.hud = nil;
}

#pragma mark - 弹框
-(void)YYAlertViewTitle:(NSString *)title message:(NSString *)message isCancel:(BOOL)isCancel andCancel:(cancelBlock)cancelBlock andOk:(okBlock)okBlock
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message    preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAct = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        okBlock();
    }];
    [alert addAction:okAct];
    if (isCancel)
    {
        UIAlertAction *cancelAct = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            cancelBlock();
        }];
        [alert addAction:cancelAct];
    }
    [self presentViewController:alert animated:YES completion:nil];
}





@end





