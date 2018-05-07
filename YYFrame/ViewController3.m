//
//  ViewController3.m
//  YYFrame
//
//  Created by admin on 2017/3/17.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ViewController3.h"
#import "iCarousel.h"

@interface ViewController3 ()<iCarouselDataSource, iCarouselDelegate>

@property (nonatomic,strong) iCarousel *carousel;
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
//    self.shadowAnimation = [JTSlideShadowAnimation new];
//    
//    self.shadowAnimation.animatedView = self.btn;
//    
//    self.shadowAnimation.shadowWidth = 40.;
//    
//    [self.shadowAnimation start];
    
    self.carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 220*kScreenWidth/375)];
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    [self.view addSubview:self.carousel];
    
    /** 添加图片到数组中*/
    [self setUp];
    
    /** 协议代理方法*/
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    
    /** 样式*/
    self.carousel.type = 1;//iCarouselTypeCoverFlow2;
    
    /** 加载图片时间稍晚,需要刷新才会显示*/
    [self.carousel reloadData];

    
}

- (void)setUp
{
    self.items = [NSMutableArray array];
    for (int i = 0; i < 10; i++)
    {
        [self.items addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]]];
    }
}


#pragma mark - **************** 数据源

/** 共有多少个*/
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return (NSInteger)[self.items count];
}

/** 每个显示的类容(自定义)*/
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIImageView *imageView = nil;
    
    if (view == nil)
    {
        /** 创建视图,然后放上图片展示*/
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 240.0f, 200.0f)];
        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
        view.contentMode = UIViewContentModeCenter;
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:view.bounds];
        imageView.image = self.items[index];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.tag = 1;
        [view addSubview:imageView];
        
    }
    else
    {
        imageView = (UIImageView *)[view viewWithTag:1];
    }
    
    
    return view;
    
}

/** 此方法主要用于网路请求时加载图片完成之前的默认图片(类似于输入文本框的默认提示)*/

/*
 - (NSInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel{
 
 }
 - (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSInteger)index reusingView:(UIView *)view{
 
 }
 */


- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"%ld",index);
}
- (CATransform3D)carousel:(__unused iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    
    /** 效果*/
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * self.carousel.itemWidth);
}

- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            /** 1: 包围样式 0:第一张开始*/
            return 1;
        }
        case iCarouselOptionSpacing:
        {
            /** 间隔*/
            return value * 1.05f;//1.05
        }
        case iCarouselOptionFadeMax:
        {
            if (self.carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;//0.00
            }
            return value;
        }
        case iCarouselOptionShowBackfaces:
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionFadeMin:
        case iCarouselOptionFadeMinAlpha:
        case iCarouselOptionFadeRange:
        case iCarouselOptionOffsetMultiplier:
        case iCarouselOptionVisibleItems:
        {
            return value;
        }
    }
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
