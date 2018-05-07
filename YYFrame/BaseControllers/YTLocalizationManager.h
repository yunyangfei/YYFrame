//
//  YTLocalizationManager.h
//  YYFrame
//
//  Created by 云飞扬 on 2018/4/20.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 国际化管理者 */

@interface YTLocalizationManager : NSObject

/// 获取当前资源文件
+ (NSBundle *)bundle;
/// 初始化语言文件
+ (void)initUserLanguage;
/// 获取应用当前语言
+ (NSString *)userLanguage;
/// 设置当前语言
+ (void)setUserlanguage:(NSString *)language;
/// 通过Key获得对应的string
+ (NSString *)getStringByKey:(NSString *)key;

@end
