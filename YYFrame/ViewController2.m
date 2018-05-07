//
//  ViewController2.m
//  YYFrame
//
//  Created by admin on 2017/3/17.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ViewController2.h"
#import "YYViewController.h"
#import "JSDropDownMenu.h"

@interface ViewController2 ()<JSDropDownMenuDelegate,JSDropDownMenuDataSource>
{
    JSDropDownMenu *_menu;
    NSMutableArray *_data1, *_data2, *_data3;
    NSInteger _currentData1Index,_currentData2Index,_currentData3Index;
    
    UILabel *_titleLabel;
}

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor greenColor];
    
    NSArray *food = @[@"全部美食", @"火锅", @"川菜", @"西餐", @"自助餐"];
    NSArray *travel = @[@"全部旅游", @"周边游", @"景点门票", @"国内游", @"境外游"];
    NSArray *hero = @[@"全部英雄",@"德玛西亚之力",@"寒冰射手",@"蛮族之王",@"剑圣",@"德邦总管",@"诺克萨斯之手",@"麦林小炮",@"光辉女郎"];
    
    _data1 = [NSMutableArray arrayWithObjects:@{@"title":@"美食", @"data":food}, @{@"title":@"旅游", @"data":travel},@{@"title":@"英雄",@"data":hero}, nil];
    _data2 = [NSMutableArray arrayWithObjects:@"智能排序", @"离我最近", @"评价最高", @"最新发布", @"人气最高", @"价格最低", @"价格最高", @"我最喜欢", nil];
    _data3 = [NSMutableArray arrayWithObjects:@"不限人数", @"单人餐", @"双人餐", @"3~4人餐",@"召唤师峡谷",@"水晶之痕",@"艾欧尼亚",@"裁决之地",@"班德尔城",@"黑色玫瑰",@"守望之海",@"皮城警备",@"东方半岛", nil];
    
    _menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:45];
    _menu.indicatorColor = [UIColor redColor];//三角形颜色
    _menu.separatorColor = [UIColor blackColor];//分割线颜色
    _menu.textColor = [UIColor orangeColor];//文字颜色
    _menu.delegate = self;
    _menu.dataSource = self;
    [self.view addSubview:_menu];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kScreenHeight/2-60, kScreenWidth-20, 60)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:30];
    _titleLabel.textColor = [UIColor redColor];
    [self.view addSubview:_titleLabel];
}

#pragma mark - JSDropDownMenuDataSource
//有多少个下拉菜单
-(NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu
{
    return 3;
}
//是否显示表视图
-(BOOL)displayByCollectionViewInColumn:(NSInteger)column
{
    if (column==2)
    {
        return YES;
    }
    return NO;
}
//是否显示2个表视图
-(BOOL)haveRightTableViewInColumn:(NSInteger)column
{
    if (column==0)
    {
        return YES;
    }
    return NO;
}
//返回左边表视图的比
-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column
{
    if (column==0)
    {
        return 0.3;
    }
    return 1;
}
//左边默认选中
-(NSInteger)currentLeftSelectedRow:(NSInteger)column
{
    if (column==0)
    {
        return _currentData1Index;
    }
    else if (column==1)
    {
        return _currentData2Index;
    }
    else
    {
        return _currentData3Index;
    }
}
//设置默认打钩的数据
-(NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column
{
    switch (column)
    {
        case 0:
            return _data1[_currentData1Index][@"data"][0];
            break;
        case 1:
            return _data2[_currentData2Index];
            break;
        case 2:
            return _data3[_currentData3Index];
            break;
        default:
            return nil;
            break;
    }
}
//返回列表个数
-(NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow
{
    if (column==0)
    {
        if (leftOrRight==0)
        {
            return _data1.count;
        }
        else
        {
            return [_data1[leftRow][@"data"] count];
        }
    }
    else if (column==1)
    {
        return _data2.count;
    }
    else if (column==2)
    {
        return _data3.count;
    }
    return 0;
}
//上数据,返回数据
-(NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath
{
    if (indexPath.column==0)
    {
        if (indexPath.leftOrRight==0)
        {
            return _data1[indexPath.row][@"title"];
        }
        else
        {
            return _data1[indexPath.leftRow][@"data"][indexPath.row];
        }
    }
    else if (indexPath.column==1)
    {
        return _data2[indexPath.row];
    }
    else if (indexPath.column==2)
    {
        return _data3[indexPath.row];
    }
    return nil;
}
//点击时调用
-(void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath
{
    if (indexPath.column==0)
    {
        if (indexPath.leftOrRight==0)
        {
            _currentData1Index = indexPath.row;
            _titleLabel.text = [NSString stringWithFormat:@"%@>",_data1[indexPath.row][@"title"]];
        }
        else
        {
            _titleLabel.text = [NSString stringWithFormat:@"%@>%@",_data1[indexPath.leftRow][@"title"],_data1[indexPath.leftRow][@"data"][indexPath.row]];
        }
    }
    else if (indexPath.column==1)
    {
        _currentData2Index = indexPath.row;
        _titleLabel.text = _data2[indexPath.row];
    }
    else
    {
        _currentData3Index = indexPath.row;
        _titleLabel.text = _data3[indexPath.row];
    }
}







@end






