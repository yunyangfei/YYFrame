//
//  LanguageController.m
//  YYFrame
//
//  Created by 云飞扬 on 2018/5/2.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "LanguageController.h"
#import "NSBundle+Language.h"
#import "YYTabBarController.h"

@interface LanguageController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic,copy) NSString *systemStr;
@property (nonatomic, assign) NSInteger seletedIndex;

@end

@implementation LanguageController

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithObjects:@{@"title":@"跟随系统", @"value":self.systemStr},
                                                    @{@"title":@"简体中文", @"value":@"zh-Hans"},
                                                    @{@"title":@"English", @"value":@"en"}, nil];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"切换语言";
    
    self.systemStr = [[[NSUserDefaults standardUserDefaults] valueForKey:@"AppleLanguages"] firstObject];
    
    [self creatTableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)creatTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:self.tableView];
}


#pragma mark - TableViewDeletage
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *languageStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"YTLanguage"];
    if ([languageStr isEqualToString:self.dataArr[indexPath.row][@"value"]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.seletedIndex = indexPath.row;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = self.dataArr[indexPath.row][@"title"];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.seletedIndex inSection:0]];
    oldCell.accessoryType = UITableViewCellAccessoryNone;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.seletedIndex = indexPath.row;
    
    NSString *currChoice = [[NSUserDefaults standardUserDefaults] valueForKey:@"YTLanguage"];
    if ([currChoice isEqualToString:self.dataArr[indexPath.row][@"value"] ]) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }else{
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}

- (void)rightItemAction
{
    NSString *language = self.dataArr[self.seletedIndex][@"value"];
    // 设置语言
    [NSBundle setLanguage:language];
    
    // 然后将设置好的语言存储好，下次进来直接加载
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:@"YTLanguage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 我们要把系统windown的rootViewController替换掉
    [self showHudWithIndicatiorStyle:WSProgressHUDIndicatorSmallLight];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideHud];
        YYTabBarController *tab = [[YYTabBarController alloc] init];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [UIView transitionWithView:window duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            //self.view.window.rootViewController = tab;
            window.rootViewController = tab;
        } completion:nil];
    });
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
