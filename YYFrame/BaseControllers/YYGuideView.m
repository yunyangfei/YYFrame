//
//  YYGuideView.m
//  YYFrame
//
//  Created by admin on 2017/3/18.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "YYGuideView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation YYGuideView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _imageArr = [NSMutableArray arrayWithObjects:@"YunFeiYang",@"YunFeiYang",@"YunFeiYang",@"YunFeiYang", nil];
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        scrollView.contentSize = CGSizeMake((_imageArr.count+1)*kScreenWidth, kScreenHeight);
        scrollView.backgroundColor = [UIColor whiteColor];// colorWithAlphaComponent:0.3];
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
    
        for (int i=0;i<_imageArr.count;i++)
        {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
            imgView.center = CGPointMake(self.center.x+kScreenWidth*i, self.center.y-20);
            NSString *path = [[NSBundle mainBundle] pathForResource:@"YunFeiYang" ofType:@"png"];
            imgView.image = [UIImage imageWithContentsOfFile:path];
//            imgView.image = [UIImage imageNamed:_imageArr[i]];
            [scrollView addSubview:imgView];
            
            UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(imgView.frame.origin.x, CGRectGetMaxY(imgView.frame)+10, 200, 20)];
            titleLab.text = [NSString stringWithFormat:@"我是第%d引导页",i];
            titleLab.textColor = [UIColor blackColor];
            titleLab.textAlignment = NSTextAlignmentCenter;
            titleLab.font = [UIFont systemFontOfSize:20];
            [scrollView addSubview:titleLab];
            
            _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.bounds.size.width/2, self.bounds.size.height-60, 0, 40)];
            _pageControl.numberOfPages = _imageArr.count;
            _pageControl.backgroundColor = [UIColor clearColor];
            _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
            _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:85/255.0 green:185/255.0 blue:201/255.0 alpha:1.0];
            [self addSubview:_pageControl];
            
            //添加手势
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView)];
            [scrollView addGestureRecognizer:tapGes];
        }
    
    }
    return self;
}

//点击最后一页
-(void)clickView
{
    if (_pageControl.currentPage == _imageArr.count-1)
    {
        self.hidden = YES;
        [self removeFromSuperview];
    }
}

#pragma mark - UIScrollViewDelegate
//停止减速时调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat page = scrollView.contentOffset.x/kScreenWidth;
    _pageControl.currentPage = page;
    if (page == _imageArr.count)
    {
        self.hidden = YES;
        [self removeFromSuperview];
    }
}

-(void)dealloc
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@">>>>引导页销毁了");
}














@end
