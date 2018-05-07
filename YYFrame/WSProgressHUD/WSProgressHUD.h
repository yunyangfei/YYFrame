//
//  WSProgressHUD.h
//  WSProgressHUD
//
//  Created by Wilson-Yuan on 15/7/17.
//  Copyright (c) 2015年 wilson-yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WSProgressHUDMaskType) {
    WSProgressHUDMaskTypeDefault, //allow user touch when hud display.允许用户触摸时HUD显示
    WSProgressHUDMaskTypeClear, //dont allowed user touch.不允许用户触摸
    WSProgressHUDMaskTypeBlack, //dont allowed user touch.~~~~,并且背景色是黑色
    WSProgressHUDMaskTypeGradient //dont allowed user touch.~~~~,并且背景色是渐变的
};

typedef NS_ENUM(NSInteger, WSProgressHUDMaskWithoutType) { //
    WSProgressHUDMaskWithoutDefault, // default mask all.默认屏蔽所有
    WSProgressHUDMaskWithoutNavigation, //show mask without navigation.没有导航显示
    WSProgressHUDMaskWithoutTabbar, //show mask without tabbar.没有TabBar显示
    WSProgressHUDMaskWithoutNavAndTabbar, //show mask without tabbar and navigation.没有导航栏和tabbar
};

typedef NS_ENUM(NSInteger, WSProgressHUDIndicatorStyle) {
    WSProgressHUDIndicatorCustom,
    WSProgressHUDIndicatorMMSpinner,
    WSProgressHUDIndicatorSmallLight,
    WSProgressHUDIndicatorGray,
    WSProgressHUDIndicatorBigGray,
};


@interface WSProgressHUD : UIView

/*----------------------Show On the Window------------------------------*/
+ (void)show;
+ (void)showWithMaskType: (WSProgressHUDMaskType)maskType;
+ (void)showWithMaskType: (WSProgressHUDMaskType)maskType maskWithout: (WSProgressHUDMaskWithoutType)withoutType;


+ (void)showWithStatus: (NSString *)string;
+ (void)showWithStatus: (NSString *)string maskType: (WSProgressHUDMaskType)maskType;
+ (void)showWithStatus: (NSString *)string maskType: (WSProgressHUDMaskType)maskType maskWithout: (WSProgressHUDMaskWithoutType)withoutType;


+ (void)showShimmeringString: (NSString *)string;
+ (void)showShimmeringString: (NSString *)string maskType: (WSProgressHUDMaskType)maskType;
+ (void)showShimmeringString: (NSString *)string maskType: (WSProgressHUDMaskType)maskType maskWithout: (WSProgressHUDMaskWithoutType)withoutType;

+ (void)showProgress:(CGFloat)progress;
+ (void)showProgress:(CGFloat)progress maskType:(WSProgressHUDMaskType)maskType;
+ (void)showProgress:(CGFloat)progress maskType:(WSProgressHUDMaskType)maskType maskWithout: (WSProgressHUDMaskWithoutType)withoutType;

+ (void)showProgress:(CGFloat)progress status:(NSString*)string;
+ (void)showProgress:(CGFloat)progress status:(NSString*)string maskType:(WSProgressHUDMaskType)maskType;
+ (void)showProgress:(CGFloat)progress status:(NSString*)string maskType:(WSProgressHUDMaskType)maskType maskWithout: (WSProgressHUDMaskWithoutType)withoutType;

//imageSize is 28*28
+ (void)showImage:(UIImage *)image status:(NSString *)title;
+ (void)showImage:(UIImage *)image status:(NSString *)title maskType: (WSProgressHUDMaskType)maskType;
+ (void)showImage:(UIImage *)image status:(NSString *)title maskType: (WSProgressHUDMaskType)maskType maskWithout: (WSProgressHUDMaskWithoutType)withoutType;

+ (void)showSuccessWithStatus: (NSString *)string;
+ (void)showErrorWithStatus: (NSString *)string;
+ (void)dismiss;

/*----------------------------Custom---------------------------------*/

+ (void)setProgressHUDIndicatorStyle: (WSProgressHUDIndicatorStyle)style;

/// if you set WSProgressHUDIndicatorBigGray style you should set second prority indicator Style
+ (void)setSecondProrityIndicatorStyle: (WSProgressHUDIndicatorStyle)style; //Default is small SmallLight

+ (void)setProgressHUDFont: (UIFont *)font;

/*----------------------Show On the view------------------------------*/

- (instancetype)initWithView: (UIView *)view;
- (instancetype)initWithFrame:(CGRect)frame;

- (void)show;
- (void)showWithMaskType: (WSProgressHUDMaskType)maskType;

- (void)showWithString: (NSString *)string;
- (void)showWithString: (NSString *)string maskType: (WSProgressHUDMaskType)maskType;


- (void)showShimmeringString: (NSString *)string;
- (void)showShimmeringString: (NSString *)string maskType: (WSProgressHUDMaskType)maskType;

- (void)showProgress:(CGFloat)progress;
- (void)showProgress:(CGFloat)progress maskType:(WSProgressHUDMaskType)maskType;

- (void)showProgress:(CGFloat)progress status:(NSString*)status;
- (void)showProgress:(CGFloat)progress status:(NSString*)status maskType:(WSProgressHUDMaskType)maskType;



- (void)showImage:(UIImage *)image status:(NSString *)title;
- (void)showImage:(UIImage *)image status:(NSString *)title maskType: (WSProgressHUDMaskType)maskType;

- (void)showYYImage:(UIImage *)image status:(NSString *)title time:(NSTimeInterval)time;

- (void)showSuccessWithString: (NSString *)string;
- (void)showErrorWithString: (NSString *)string;

- (void)dismiss;

/*----------------------------Custom---------------------------------*/
- (void)setProgressHUDIndicatorStyle: (WSProgressHUDIndicatorStyle)style;

/// if you set WSProgressHUDIndicatorBigGray style you should set second prority indicator Style
- (void)setSecondProrityIndicatorStyle: (WSProgressHUDIndicatorStyle)style; //Default is small SmallLight

- (void)setProgressHUDFont: (UIFont *)font;

@end
