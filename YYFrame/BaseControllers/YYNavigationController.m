//
//  YYNavigationController.m
//  YYFrame
//
//  Created by admin on 2017/3/17.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "YYNavigationController.h"

@interface YYNavigationController ()

@end

@implementation YYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.translucent = NO;
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
    
    // 设置导航默认标题的颜色及字体大小
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor darkGrayColor],
                                               NSFontAttributeName : [UIFont fontWithName:@"Arial" size:17]};
    
    
    self.navigationBar.backIndicatorImage = [[UIImage imageNamed:@"nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"nav_back"];
}

#pragma mark - 重写push方法,使推出的控制器隐藏tabbar
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        
        //隐藏标签栏
        viewController.hidesBottomBarWhenPushed = YES;
        
        //[self resetBackButtonWhenPushed:viewController];
    }
    
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    [super pushViewController:viewController animated:animated];
}

@end
