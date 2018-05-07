//
//  ViewController1.m
//  YYFrame
//
//  Created by admin on 2017/3/17.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ViewController1.h"
#import "YYTabBarController.h"
#import "ViewController5.h"
#import "NSBundle+Language.h"
#import "YTLocalizationManager.h"
#import "LanguageController.h"
#import "YYUUID.h"
//#import <CoreNFC/CoreNFC.h>

//获取手机型号需要导入
#import "sys/utsname.h"
//获取运行商需要导入
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap)];
    [self.view addGestureRecognizer:tap];
    
    for (int i=0;i<5;i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake((kScreenWidth-100)/2, 100+i*50, 100, 30);
        button.backgroundColor = [UIColor yellowColor];
        [button setTitle:[NSString stringWithFormat:@"%@%d",NSLocalizedString(@"MyIsBottom", nil), i] forState:UIControlStateNormal];
        button.tag = 20+i;
        [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    imgView.image = [UIImage imageNamed:NSLocalizedString(@"icon_logo", nil)];
    [self.view addSubview:imgView];
    
    [self phoneMessage];
    
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"中文" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"切换语言" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    //    NSArray *langArr1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"AppleLanguages"];
    //    NSString *language1 = langArr1.firstObject;
    //    NSLog(@"模拟器语言切换之前：%@",language1);
}

- (void)leftAction
{
    //    [[NSUserDefaults standardUserDefaults] setObject:@[@"zh-Hans"] forKey:@"AppleLanguages"];
    //    [[NSUserDefaults standardUserDefaults] synchronize];
    //
    //    YYTabBarController *tab = [[YYTabBarController alloc] init];
    //    [UIApplication sharedApplication].delegate.window.rootViewController = tab;
    
    
    //[self changeLanguageTo:@"zh-Hans"];
}
- (void)rightAction
{
    //[self changeLanguageTo:@"en"];
    LanguageController *lanageVC = [[LanguageController alloc] init];
    [self.navigationController pushViewController:lanageVC animated:YES];
}

- (void)changeLanguageTo:(NSString *)language {
    
    // 设置语言
    [NSBundle setLanguage:language];
    
    // 然后将设置好的语言存储好，下次进来直接加载
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:@"YTLanguage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 我们要把系统windown的rootViewController替换掉
    YYTabBarController *tab = [[YYTabBarController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tab;
}


-(void)clickBtn:(UIButton *)button
{
    switch (button.tag)
    {
        case 20:
        {
            [WSProgressHUD showImage:[UIImage imageNamed:@"YunFeiYang"] status:@"看我头像帅不帅" maskType:WSProgressHUDMaskTypeGradient];
            [self autoDismiss];
        }
            break;
        case 21:
        {
            [WSProgressHUD showWithStatus:@"我是一只小小小🐦" maskType:WSProgressHUDMaskTypeBlack];
            [self autoDismiss];
        }
            break;
        case 22:
        {
            [WSProgressHUD showSuccessWithStatus:@"打开方式正确✅"];
            [self autoDismiss];
        }
            break;
        case 23:
        {
            [WSProgressHUD showShimmeringString:@"闪闪发光的" maskType:WSProgressHUDMaskTypeBlack];
            [self autoDismiss];
        }
            break;
        case 24:
        {
            [WSProgressHUD showWithMaskType:WSProgressHUDMaskTypeClear];
            [self autoDismiss];
            //            NSString *link = @"weixin://app/wx037976b327fec810/pay/?nonceStr=mEB9KRVx8N2zDcuF&package=Sign%3DWXPay&partnerId=1351481601&prepayId=wx20170720134731b34f4ddbd50441049429&timeStamp=1500529651&sign=B134CA473837605CB59975613B9818C1&signType=SHA1";
            //            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
        }
            break;
    }
}


- (void)autoDismiss
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [WSProgressHUD dismiss];
    });
    
}

-(void)clickTap
{
    ViewController5 *ctn = [[ViewController5 alloc] init];
    [self.navigationController pushViewController:ctn animated:YES];
}


-(void)phoneMessage
{
    //设备唯一标识符
    NSString *identifierStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSLog(@"设备唯一标识符:%@",identifierStr);
    NSLog(@">>>>>>>>%@", [YYUUID getUUID]);
    NSString *uuid = [[NSUUID UUID] UUIDString];
    NSLog(@"UUID>>>>%@", uuid);
    //手机别名： 用户定义的名称
    NSString* userPhoneName = [[UIDevice currentDevice] name];
    NSLog(@"手机别名: %@", userPhoneName);
    //设备名称
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    NSLog(@"设备名称: %@",deviceName );
    //手机系统版本
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    NSLog(@"手机系统版本: %@", phoneVersion);
    //手机型号
    NSString * phoneModel =  [self deviceVersion];
    NSLog(@"手机型号:%@",phoneModel);
    //地方型号  （国际化区域名称）
    NSString* localPhoneModel = [[UIDevice currentDevice] localizedModel];
    NSLog(@"国际化区域名称: %@",localPhoneModel );
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 当前应用软件版本  比如：1.0.1
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前应用软件版本:%@",appCurVersion);
    // 当前应用版本号码   int类型
    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSLog(@"当前应用版本号码：%@",appCurVersionNum);
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    NSLog(@"物理尺寸:%.0f × %.0f",width,height);
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    NSLog(@"分辨率是:%.0f × %.0f",width*scale_screen ,height*scale_screen);
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = info.subscriberCellularProvider;
    NSLog(@"运营商:%@", carrier.carrierName);
}

- (NSString*)deviceVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    
    return deviceString;
}



@end
