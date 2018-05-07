//
//  ViewController4.m
//  YYFrame
//
//  Created by admin on 2017/3/17.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ViewController4.h"
#import "ViewController5.h"
#import <HealthKit/HealthKit.h>

@interface ViewController4 ()
{
    UITextField *_writStepsTF;
}

@end

@implementation ViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap)];
    [self.view addGestureRecognizer:tap];
    
    [self creatUI];
}

-(void)clickTap
{
    if (_writStepsTF.isFirstResponder)
    {
        [_writStepsTF resignFirstResponder];
    }
    else
    {
        ViewController5 *ctn = [[ViewController5 alloc] init];
        [self.navigationController pushViewController:ctn animated:YES];
    }
}

-(void)creatUI
{
    _writStepsTF = [[UITextField alloc] initWithFrame:CGRectMake(40, 40, kScreenWidth-80, 30)];
    _writStepsTF.borderStyle = UITextBorderStyleRoundedRect;
    _writStepsTF.placeholder = @"请输入要添加的步数";
    _writStepsTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_writStepsTF];
    
    UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    completeBtn.frame = CGRectMake((kScreenWidth-140)/2, CGRectGetMaxY(_writStepsTF.frame)+30, 140, 36);
    completeBtn.backgroundColor = [UIColor greenColor];
    [completeBtn setTitle:@"确认添加" forState:UIControlStateNormal];
    [completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    completeBtn.clipsToBounds = YES;
    completeBtn.layer.cornerRadius = 7;
    [completeBtn addTarget:self action:@selector(clickCompleteBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:completeBtn];
    
}

-(void)clickCompleteBtn
{
    //获取权限
    HKHealthStore *healthStore = [[HKHealthStore alloc] init];
    
    HKQuantityType *stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSSet *writeDataTypes = [NSSet setWithObjects:stepCountType, nil];
    [healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:nil completion:^(BOOL success, NSError * _Nullable error) {
    }];
    //修改步数
    HKQuantityType * quantityTypeIdentifier = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantity *quantity = [HKQuantity quantityWithUnit:[HKUnit countUnit] doubleValue:_writStepsTF.text.doubleValue];
    HKQuantitySample *temperatureSample = [HKQuantitySample quantitySampleWithType:quantityTypeIdentifier quantity:quantity startDate:[NSDate date] endDate:[NSDate date] metadata:nil];
    
    [healthStore saveObject:temperatureSample withCompletion:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [WSProgressHUD showSuccessWithStatus:@"添加成功"];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@">>>>error == %@",error);
                [WSProgressHUD showErrorWithStatus:@"添加失败"];
            });
        }
    }];
}





@end



