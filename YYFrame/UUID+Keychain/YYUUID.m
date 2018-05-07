//
//  YYUUID.m
//  YYFrame
//
//  Created by 云飞扬 on 2018/5/3.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "YYUUID.h"
#import "YYKeyChain.h"

#define  KEY_UUID @"com.yitoubao.UUID"
//#define  KEY_USERNAME @"com.yitoubao.username"
//#define  KEY_PASSWORD @"com.yitoubao.password"

@implementation YYUUID

+(NSString *)getUUID
{
    NSString * strUUID = (NSString *)[YYKeyChain load:KEY_UUID];
    
    //首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""] || !strUUID)
    {
        //生成一个uuid的方法
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        
        //将该uuid保存到keychain
        [YYKeyChain save:KEY_UUID data:strUUID];
        
    }
    return strUUID;
}

@end
