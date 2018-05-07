//
//  YYViewController.h
//  YYFrame
//
//  Created by admin on 2017/3/17.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "YYGuideView.h"
#import "WSProgressHUD.h"

typedef void (^cancelBlock) (void);
typedef void (^okBlock) (void);

@interface YYViewController : UIViewController

@property (nonatomic, strong)NSURLSessionTask *sessionTask;

@property (nonatomic, strong)WSProgressHUD *hud;

@property (nonatomic, strong) AppDelegate *appDelegate;

/*
- (void)showHUDOnlyString:(NSString *)string
               afterDelay:(NSTimeInterval)delay;

- (void)showHUDWithImage:(UIImage *)image
                   title:(NSString *)title
            showAnimated:(BOOL)showAnimated
            hideAnimated:(BOOL)hideAnimated
              afterDelay:(NSTimeInterval)delay;

- (void)showHUDStatus:(NSString *)title
             autoHide:(BOOL)autoHide ;
 */

- (void)showHudWithIndicatiorStyle:(WSProgressHUDIndicatorStyle)style;
- (void)hideHud;

-(void)YYAlertViewTitle:(NSString *)title message:(NSString *)message isCancel:(BOOL)isCancel andCancel:(cancelBlock)cancelBlock andOk:(okBlock)okBlock;

@end
