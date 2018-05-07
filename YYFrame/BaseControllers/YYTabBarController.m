//
//  YYTabBarController.m
//  YYFrame
//
//  Created by admin on 2017/3/17.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "YYTabBarController.h"

@interface YYTabBarController ()

@end

@implementation YYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBar.translucent = NO;
    
    [self setupViewControllers];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"])
    {
        [self showGuideViewForFirstUseage];
    }
}

#pragma mark - 初次使用APP显示引导页
- (void)showGuideViewForFirstUseage
{
    YYGuideView *guideView = [[YYGuideView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:guideView];
}

- (void)setupViewControllers
{
    YYNavigationController *firstVC = [self navigationControllerWithController:[ViewController1 new] tabBarTitle:@"我是红色" normalImage:[UIImage imageNamed:@"first_normal"] selectedImage:[UIImage imageNamed:@"first_selected"]];
    
    YYNavigationController *secondVC = [self navigationControllerWithController:[ViewController2 new] tabBarTitle:@"我是绿色" normalImage:[UIImage imageNamed:@"second_normal"] selectedImage:[UIImage imageNamed:@"second_selected"]];
    
    YYNavigationController *thirdVC = [self navigationControllerWithController:[ViewController3 new] tabBarTitle:@"我是黄色" normalImage:[UIImage imageNamed:@"third_normal"] selectedImage:[UIImage imageNamed:@"third_selected"]];
    
    YYNavigationController *fourthVC = [self navigationControllerWithController:[ViewController4 new] tabBarTitle:@"我是橙色" normalImage:[UIImage imageNamed:@"five_normal"] selectedImage:[UIImage imageNamed:@"five_selected"]];
    
    /**
     *  设置tabbar的字体颜色
     */
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:57/255.0 green:57/255.0 blue:57/255.0 alpha:1], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor greenColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    self.viewControllers = @[firstVC, secondVC, thirdVC, fourthVC];
    
}


- (YYNavigationController *)navigationControllerWithController:(UIViewController *)controller tabBarTitle:(NSString *)tabBarTitle normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage
{
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:tabBarTitle image:[normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    item.titlePositionAdjustment = UIOffsetMake(0, -3);
    controller.tabBarItem = item;
    controller.title = tabBarTitle;
    
    YYNavigationController *nav = [[YYNavigationController alloc] initWithRootViewController:controller];

    
    return nav;
}









@end





